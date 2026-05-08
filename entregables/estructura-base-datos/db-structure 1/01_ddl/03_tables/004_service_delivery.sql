SET search_path TO service_delivery, public;

CREATE TABLE IF NOT EXISTS room_reservation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL,
  room_id UUID NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  guest_count SMALLINT NOT NULL,
  reservation_status service_delivery.reservation_status NOT NULL DEFAULT 'PENDING',
  estimated_value NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_reservation_dates CHECK (end_date > start_date),
  CONSTRAINT ck_reservation_guest_count CHECK (guest_count > 0),
  CONSTRAINT ck_reservation_value CHECK (estimated_value >= 0),
  CONSTRAINT fk_reservation_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_room_reservation FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

CREATE TABLE IF NOT EXISTS reservation_cancellation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID NOT NULL,
  reason VARCHAR(255) NOT NULL,
  cancellation_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  applies_penalty BOOLEAN NOT NULL DEFAULT false,
  penalty_value NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_cancellation_penalidad CHECK (penalty_value >= 0),
  CONSTRAINT fk_cancellation_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id)
);

CREATE TABLE IF NOT EXISTS stay (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID NOT NULL,
  customer_id UUID NOT NULL,
  room_id UUID NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ,
  stay_status service_delivery.stay_status NOT NULL DEFAULT 'ACTIVE',
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_stay_dates CHECK (end_date IS NULL OR end_date > start_date),
  CONSTRAINT fk_stay_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_stay_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_stay_room FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

CREATE TABLE IF NOT EXISTS check_in (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID NOT NULL,
  employee_id UUID NOT NULL,
  event_datetime TIMESTAMPTZ NOT NULL DEFAULT now(),
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_check_in_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_check_in_employee FOREIGN KEY (employee_id) REFERENCES configuration.employee(id)
);

CREATE TABLE IF NOT EXISTS check_out (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  employee_id UUID NOT NULL,
  event_datetime TIMESTAMPTZ NOT NULL DEFAULT now(),
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_check_out_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_check_out_employee FOREIGN KEY (employee_id) REFERENCES configuration.employee(id)
);



