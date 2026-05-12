SET search_path TO billing, public;

CREATE TABLE IF NOT EXISTS pre_invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  room_reservation_id UUID NOT NULL,
  customer_id UUID NOT NULL,
  subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
  tax NUMERIC(12,2) NOT NULL DEFAULT 0,
  discount NUMERIC(12,2) NOT NULL DEFAULT 0,
  total NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_pre_invoice_values CHECK (subtotal >= 0 AND tax >= 0 AND discount >= 0 AND total >= 0),
  CONSTRAINT fk_pre_invoice_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_pre_invoice_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_pre_invoice_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id)
);

CREATE TABLE IF NOT EXISTS invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL,
  stay_id UUID NOT NULL,
  invoice_number VARCHAR(60) NOT NULL,
  issue_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
  tax NUMERIC(12,2) NOT NULL DEFAULT 0,
  discount NUMERIC(12,2) NOT NULL DEFAULT 0,
  total NUMERIC(12,2) NOT NULL DEFAULT 0,
  invoice_status billing.invoice_status NOT NULL DEFAULT 'ISSUED',
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_invoice_values CHECK (subtotal >= 0 AND tax >= 0 AND discount >= 0 AND total >= 0),
  CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_invoice_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id)
);

CREATE TABLE IF NOT EXISTS partial_payment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID,
  invoice_id UUID,
  payment_method_id UUID NOT NULL,
  value NUMERIC(12,2) NOT NULL,
  payment_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  payment_reference VARCHAR(120),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_payment_value CHECK (value > 0),
  CONSTRAINT ck_payment_source CHECK (room_reservation_id IS NOT NULL OR invoice_id IS NOT NULL),
  CONSTRAINT fk_payment_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES billing.invoice(id),
  CONSTRAINT fk_payment_payment_method FOREIGN KEY (payment_method_id) REFERENCES configuration.payment_method(id)
);

CREATE TABLE IF NOT EXISTS purchase_detail (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id UUID NOT NULL,
  product_id UUID,
  service_id UUID,
  description VARCHAR(255) NOT NULL,
  quantity INTEGER NOT NULL,
  unit_value NUMERIC(12,2) NOT NULL,
  total_value NUMERIC(12,2) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_detail_values CHECK (quantity > 0 AND unit_value >= 0 AND total_value >= 0),
  CONSTRAINT ck_detail_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL),
  CONSTRAINT fk_detail_invoice FOREIGN KEY (invoice_id) REFERENCES billing.invoice(id),
  CONSTRAINT fk_detail_product FOREIGN KEY (product_id) REFERENCES inventory.product(id),
  CONSTRAINT fk_detail_service FOREIGN KEY (service_id) REFERENCES inventory.service(id)
);



