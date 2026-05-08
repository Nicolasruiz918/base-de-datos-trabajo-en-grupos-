SET search_path TO notification, public;

CREATE TABLE IF NOT EXISTS promotion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(160) NOT NULL,
  description TEXT,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ,
  channel notification.notification_channel NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_promotion_dates CHECK (end_date IS NULL OR end_date >= start_date)
);

CREATE TABLE IF NOT EXISTS alert (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID,
  room_reservation_id UUID,
  title VARCHAR(160) NOT NULL,
  mensaje TEXT NOT NULL,
  channel notification.notification_channel NOT NULL,
  sent_at TIMESTAMPTZ,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_alert_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_alert_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id)
);

CREATE TABLE IF NOT EXISTS term_condition (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(160) NOT NULL,
  content TEXT NOT NULL,
  version VARCHAR(40) NOT NULL,
  effective_date DATE NOT NULL,
  mandatory BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS customer_loyalty (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL,
  level VARCHAR(60) NOT NULL DEFAULT 'BASIC',
  points INTEGER NOT NULL DEFAULT 0,
  last_interaction_date TIMESTAMPTZ,
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_loyalty_points CHECK (points >= 0),
  CONSTRAINT fk_customer_loyalty FOREIGN KEY (customer_id) REFERENCES configuration.customer(id)
);



