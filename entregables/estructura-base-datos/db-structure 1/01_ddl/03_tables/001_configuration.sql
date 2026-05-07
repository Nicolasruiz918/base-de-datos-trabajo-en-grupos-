SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS customer (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  document_type VARCHAR(30) NOT NULL,
  document_number VARCHAR(40) NOT NULL,
  name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
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

CREATE TABLE IF NOT EXISTS person (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  document_type VARCHAR(30) NOT NULL,
  document_number VARCHAR(40) NOT NULL,
  name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone VARCHAR(40),
  email CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS company (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(160) NOT NULL,
  nit VARCHAR(40) NOT NULL,
  legal_name VARCHAR(180) NOT NULL,
  phone VARCHAR(40),
  email CITEXT,
  address VARCHAR(255),
  website VARCHAR(180),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS day_type (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  date DATE,
  applies_season BOOLEAN NOT NULL DEFAULT false,
  applies_holiday BOOLEAN NOT NULL DEFAULT false,
  applies_special BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS payment_method (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  requires_reference BOOLEAN NOT NULL DEFAULT false,
  allows_partial_payment BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS legal_information (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL,
  legal_document_type VARCHAR(80) NOT NULL,
  legal_document_number VARCHAR(80) NOT NULL,
  description TEXT,
  issue_date DATE,
  expiration_date DATE,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_legal_information_company FOREIGN KEY (company_id) REFERENCES configuration.company(id)
);

CREATE TABLE IF NOT EXISTS employee (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  person_id UUID NOT NULL,
  position VARCHAR(100) NOT NULL,
  hire_date DATE NOT NULL,
  work_phone VARCHAR(40),
  work_email CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_employee_person FOREIGN KEY (person_id) REFERENCES configuration.person(id)
);

CREATE TABLE IF NOT EXISTS price (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_type_id UUID NOT NULL,
  day_type_id UUID NOT NULL,
  value NUMERIC(12,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  condition VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_price_value CHECK (value >= 0),
  CONSTRAINT ck_price_dates CHECK (end_date IS NULL OR end_date >= start_date),
  CONSTRAINT fk_price_day_type FOREIGN KEY (day_type_id) REFERENCES configuration.day_type(id)
);



