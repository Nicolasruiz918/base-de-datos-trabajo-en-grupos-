SET search_path TO maintenance, public;

CREATE TABLE IF NOT EXISTS room_maintenance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID NOT NULL,
  employee_id UUID,
  maintenance_type VARCHAR(60) NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ,
  maintenance_status maintenance.maintenance_status NOT NULL DEFAULT 'PENDING',
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_maintenance_dates CHECK (end_date IS NULL OR end_date >= start_date),
  CONSTRAINT fk_room_maintenance_room FOREIGN KEY (room_id) REFERENCES distribution.room(id),
  CONSTRAINT fk_room_maintenance_employee FOREIGN KEY (employee_id) REFERENCES configuration.employee(id)
);

CREATE TABLE IF NOT EXISTS usage_maintenance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_maintenance_id UUID NOT NULL,
  usage_reason VARCHAR(160) NOT NULL,
  activity_detail TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_usage_maintenance_maintenance FOREIGN KEY (room_maintenance_id) REFERENCES maintenance.room_maintenance(id)
);

CREATE TABLE IF NOT EXISTS renovation_maintenance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_maintenance_id UUID NOT NULL,
  renovation_description TEXT NOT NULL,
  estimated_budget NUMERIC(12,2),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_maintenance_budget CHECK (estimated_budget IS NULL OR estimated_budget >= 0),
  CONSTRAINT fk_renovation_maintenance_maintenance FOREIGN KEY (room_maintenance_id) REFERENCES maintenance.room_maintenance(id)
);

CREATE TABLE IF NOT EXISTS maintenance_dashboard (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  site_id UUID NOT NULL,
  total_rooms INTEGER NOT NULL DEFAULT 0,
  available_rooms INTEGER NOT NULL DEFAULT 0,
  occupied_rooms INTEGER NOT NULL DEFAULT 0,
  rooms_in_maintenance INTEGER NOT NULL DEFAULT 0,
  report_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_maintenance_dashboard_values CHECK (
    total_rooms >= 0
    AND available_rooms >= 0
    AND occupied_rooms >= 0
    AND rooms_in_maintenance >= 0
  ),
  CONSTRAINT fk_maintenance_dashboard_site FOREIGN KEY (site_id) REFERENCES distribution.site(id)
);



