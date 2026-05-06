SET search_path TO mantenimiento;

CREATE TABLE IF NOT EXISTS mantenimiento_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  habitacion_id UUID NOT NULL REFERENCES distribucion.habitacion(id),
  empleado_id UUID REFERENCES parametrizacion.empleado(id),
  tipo_mantenimiento VARCHAR(60) NOT NULL,
  fecha_inicio TIMESTAMPTZ NOT NULL,
  fecha_fin TIMESTAMPTZ,
  estado_mantenimiento mantenimiento.estado_mantenimiento NOT NULL DEFAULT 'PENDIENTE',
  observacion TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_mantenimiento_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE IF NOT EXISTS mantenimiento_uso (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mantenimiento_habitacion_id UUID NOT NULL REFERENCES mantenimiento.mantenimiento_habitacion(id),
  motivo_uso VARCHAR(160) NOT NULL,
  detalle_actividad TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS mantenimiento_remodelacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mantenimiento_habitacion_id UUID NOT NULL REFERENCES mantenimiento.mantenimiento_habitacion(id),
  descripcion_remodelacion TEXT NOT NULL,
  presupuesto_estimado NUMERIC(12,2),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_mantenimiento_presupuesto CHECK (presupuesto_estimado IS NULL OR presupuesto_estimado >= 0)
);

CREATE TABLE IF NOT EXISTS dashboard_mantenimiento (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sede_id UUID NOT NULL REFERENCES distribucion.sede(id),
  total_habitacion INTEGER NOT NULL DEFAULT 0,
  habitacion_disponible INTEGER NOT NULL DEFAULT 0,
  habitacion_ocupada INTEGER NOT NULL DEFAULT 0,
  habitacion_mantenimiento INTEGER NOT NULL DEFAULT 0,
  fecha_corte TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_dashboard_mantenimiento_valores CHECK (
    total_habitacion >= 0
    AND habitacion_disponible >= 0
    AND habitacion_ocupada >= 0
    AND habitacion_mantenimiento >= 0
  )
);
