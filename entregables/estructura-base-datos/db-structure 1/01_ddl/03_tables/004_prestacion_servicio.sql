SET search_path TO prestacion_servicio, public;

CREATE TABLE IF NOT EXISTS reserva_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID NOT NULL,
  habitacion_id UUID NOT NULL,
  fecha_inicio TIMESTAMPTZ NOT NULL,
  fecha_fin TIMESTAMPTZ NOT NULL,
  cantidad_persona SMALLINT NOT NULL,
  estado_reserva prestacion_servicio.estado_reserva NOT NULL DEFAULT 'PENDIENTE',
  valor_estimado NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_reserva_fechas CHECK (fecha_fin > fecha_inicio),
  CONSTRAINT ck_reserva_personas CHECK (cantidad_persona > 0),
  CONSTRAINT ck_reserva_valor CHECK (valor_estimado >= 0),
  CONSTRAINT fk_reserva_cliente FOREIGN KEY (cliente_id) REFERENCES parametrizacion.cliente(id),
  CONSTRAINT fk_reserva_habitacion FOREIGN KEY (habitacion_id) REFERENCES distribucion.habitacion(id)
);

CREATE TABLE IF NOT EXISTS cancelacion_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reserva_habitacion_id UUID NOT NULL,
  motivo VARCHAR(255) NOT NULL,
  fecha_cancelacion TIMESTAMPTZ NOT NULL DEFAULT now(),
  aplica_penalidad BOOLEAN NOT NULL DEFAULT false,
  valor_penalidad NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_cancelacion_penalidad CHECK (valor_penalidad >= 0),
  CONSTRAINT fk_cancelacion_reserva FOREIGN KEY (reserva_habitacion_id) REFERENCES prestacion_servicio.reserva_habitacion(id)
);

CREATE TABLE IF NOT EXISTS estadia (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reserva_habitacion_id UUID NOT NULL,
  cliente_id UUID NOT NULL,
  habitacion_id UUID NOT NULL,
  fecha_inicio TIMESTAMPTZ NOT NULL,
  fecha_fin TIMESTAMPTZ,
  estado_estadia prestacion_servicio.estado_estadia NOT NULL DEFAULT 'ACTIVA',
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_estadia_fechas CHECK (fecha_fin IS NULL OR fecha_fin > fecha_inicio),
  CONSTRAINT fk_estadia_reserva FOREIGN KEY (reserva_habitacion_id) REFERENCES prestacion_servicio.reserva_habitacion(id),
  CONSTRAINT fk_estadia_cliente FOREIGN KEY (cliente_id) REFERENCES parametrizacion.cliente(id),
  CONSTRAINT fk_estadia_habitacion FOREIGN KEY (habitacion_id) REFERENCES distribucion.habitacion(id)
);

CREATE TABLE IF NOT EXISTS check_in (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reserva_habitacion_id UUID NOT NULL,
  empleado_id UUID NOT NULL,
  fecha_hora TIMESTAMPTZ NOT NULL DEFAULT now(),
  observacion TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_check_in_reserva FOREIGN KEY (reserva_habitacion_id) REFERENCES prestacion_servicio.reserva_habitacion(id),
  CONSTRAINT fk_check_in_empleado FOREIGN KEY (empleado_id) REFERENCES parametrizacion.empleado(id)
);

CREATE TABLE IF NOT EXISTS check_out (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  estadia_id UUID NOT NULL,
  empleado_id UUID NOT NULL,
  fecha_hora TIMESTAMPTZ NOT NULL DEFAULT now(),
  observacion TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_check_out_estadia FOREIGN KEY (estadia_id) REFERENCES prestacion_servicio.estadia(id),
  CONSTRAINT fk_check_out_empleado FOREIGN KEY (empleado_id) REFERENCES parametrizacion.empleado(id)
);

