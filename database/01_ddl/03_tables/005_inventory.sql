SET search_path TO inventory, public;

CREATE TABLE IF NOT EXISTS supplier (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(160) NOT NULL,
  nit VARCHAR(40) NOT NULL,
  phone VARCHAR(40),
  email CITEXT,
  address VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS product (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_id UUID,
  name VARCHAR(160) NOT NULL,
  description VARCHAR(255),
  sale_value NUMERIC(12,2) NOT NULL DEFAULT 0,
  current_stock INTEGER NOT NULL DEFAULT 0,
  minimum_stock INTEGER NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_product_values CHECK (sale_value >= 0 AND current_stock >= 0 AND minimum_stock >= 0),
  CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES inventory.supplier(id)
);

CREATE TABLE IF NOT EXISTS service (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(160) NOT NULL,
  description VARCHAR(255),
  sale_value NUMERIC(12,2) NOT NULL DEFAULT 0,
  available BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_service_value CHECK (sale_value >= 0)
);

CREATE TABLE IF NOT EXISTS product_sale (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  product_id UUID NOT NULL,
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
  CONSTRAINT ck_product_sale_values CHECK (quantity > 0 AND unit_value >= 0 AND total_value >= 0),
  CONSTRAINT fk_product_sale_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_product_sale_product FOREIGN KEY (product_id) REFERENCES inventory.product(id)
);

CREATE TABLE IF NOT EXISTS service_sale (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  service_id UUID NOT NULL,
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
  CONSTRAINT ck_service_sale_values CHECK (quantity > 0 AND unit_value >= 0 AND total_value >= 0),
  CONSTRAINT fk_service_sale_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_service_sale_service FOREIGN KEY (service_id) REFERENCES inventory.service(id)
);

CREATE TABLE IF NOT EXISTS product_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL,
  movement_type inventory.inventory_movement_type NOT NULL,
  quantity INTEGER NOT NULL,
  movement_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_seguimiento_quantity CHECK (quantity > 0),
  CONSTRAINT fk_product_tracking_product FOREIGN KEY (product_id) REFERENCES inventory.product(id)
);

CREATE TABLE IF NOT EXISTS inventory_availability (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID,
  service_id UUID,
  available_quantity INTEGER NOT NULL DEFAULT 0,
  available BOOLEAN NOT NULL DEFAULT true,
  notes VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_availability_inv_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL),
  CONSTRAINT ck_availability_inv_quantity CHECK (available_quantity >= 0),
  CONSTRAINT fk_inventory_availability_product FOREIGN KEY (product_id) REFERENCES inventory.product(id),
  CONSTRAINT fk_inventory_availability_service FOREIGN KEY (service_id) REFERENCES inventory.service(id)
);



