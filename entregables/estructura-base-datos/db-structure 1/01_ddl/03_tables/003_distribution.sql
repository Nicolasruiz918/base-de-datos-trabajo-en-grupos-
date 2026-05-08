SET search_path TO distribution, public;

CREATE TABLE IF NOT EXISTS site (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL,
  name VARCHAR(160) NOT NULL,
  address VARCHAR(255) NOT NULL,
  city VARCHAR(120) NOT NULL,
  phone VARCHAR(40),
  email CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_site_company FOREIGN KEY (company_id) REFERENCES configuration.company(id)
);

CREATE TABLE IF NOT EXISTS room_type (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  base_capacity SMALLINT NOT NULL,
  max_capacity SMALLINT NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_room_type_capacity CHECK (base_capacity > 0 AND max_capacity >= base_capacity)
);

CREATE TABLE IF NOT EXISTS room_status (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  allows_reservation BOOLEAN NOT NULL DEFAULT false,
  allows_check_in BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS room (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  site_id UUID NOT NULL,
  room_type_id UUID NOT NULL,
  room_status_id UUID NOT NULL,
  number VARCHAR(20) NOT NULL,
  floor SMALLINT,
  capacity SMALLINT NOT NULL,
  description VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_room_capacity CHECK (capacity > 0),
  CONSTRAINT fk_room_site FOREIGN KEY (site_id) REFERENCES distribution.site(id),
  CONSTRAINT fk_room_room_type FOREIGN KEY (room_type_id) REFERENCES distribution.room_type(id),
  CONSTRAINT fk_room_room_status FOREIGN KEY (room_status_id) REFERENCES distribution.room_status(id)
);

CREATE TABLE IF NOT EXISTS room_availability (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  available BOOLEAN NOT NULL DEFAULT true,
  unavailability_reason VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_availability_dates CHECK (end_date > start_date),
  CONSTRAINT fk_room_availability_room FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

CREATE TABLE IF NOT EXISTS room_catalog (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID NOT NULL,
  title VARCHAR(160) NOT NULL,
  description TEXT,
  base_price NUMERIC(12,2) NOT NULL DEFAULT 0,
  visible BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_catalog_price CHECK (base_price >= 0),
  CONSTRAINT fk_room_catalog_room FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

ALTER TABLE configuration.price
  ADD CONSTRAINT fk_price_room_type
  FOREIGN KEY (room_type_id) REFERENCES distribution.room_type(id);




