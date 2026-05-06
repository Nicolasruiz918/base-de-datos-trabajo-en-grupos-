SET search_path TO distribucion, public;

CREATE TABLE IF NOT EXISTS sede (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  empresa_id UUID NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  ciudad VARCHAR(120) NOT NULL,
  telefono VARCHAR(40),
  correo CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_sede_empresa FOREIGN KEY (empresa_id) REFERENCES parametrizacion.empresa(id)
);

CREATE TABLE IF NOT EXISTS tipo_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(255),
  capacidad_base SMALLINT NOT NULL,
  capacidad_maxima SMALLINT NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_tipo_habitacion_capacidad CHECK (capacidad_base > 0 AND capacidad_maxima >= capacidad_base)
);

CREATE TABLE IF NOT EXISTS estado_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(255),
  permite_reserva BOOLEAN NOT NULL DEFAULT false,
  permite_check_in BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sede_id UUID NOT NULL,
  tipo_habitacion_id UUID NOT NULL,
  estado_habitacion_id UUID NOT NULL,
  numero VARCHAR(20) NOT NULL,
  piso SMALLINT,
  capacidad SMALLINT NOT NULL,
  descripcion VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_habitacion_capacidad CHECK (capacidad > 0),
  CONSTRAINT fk_habitacion_sede FOREIGN KEY (sede_id) REFERENCES distribucion.sede(id),
  CONSTRAINT fk_habitacion_tipo_habitacion FOREIGN KEY (tipo_habitacion_id) REFERENCES distribucion.tipo_habitacion(id),
  CONSTRAINT fk_habitacion_estado_habitacion FOREIGN KEY (estado_habitacion_id) REFERENCES distribucion.estado_habitacion(id)
);

CREATE TABLE IF NOT EXISTS disponibilidad_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  habitacion_id UUID NOT NULL,
  fecha_inicio TIMESTAMPTZ NOT NULL,
  fecha_fin TIMESTAMPTZ NOT NULL,
  disponible BOOLEAN NOT NULL DEFAULT true,
  motivo_no_disponible VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_disponibilidad_fechas CHECK (fecha_fin > fecha_inicio),
  CONSTRAINT fk_disponibilidad_habitacion_habitacion FOREIGN KEY (habitacion_id) REFERENCES distribucion.habitacion(id)
);

CREATE TABLE IF NOT EXISTS catalogo_habitacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  habitacion_id UUID NOT NULL,
  titulo VARCHAR(160) NOT NULL,
  descripcion TEXT,
  precio_base NUMERIC(12,2) NOT NULL DEFAULT 0,
  visible BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_catalogo_precio CHECK (precio_base >= 0),
  CONSTRAINT fk_catalogo_habitacion_habitacion FOREIGN KEY (habitacion_id) REFERENCES distribucion.habitacion(id)
);

ALTER TABLE parametrizacion.precio
  ADD CONSTRAINT fk_precio_tipo_habitacion
  FOREIGN KEY (tipo_habitacion_id) REFERENCES distribucion.tipo_habitacion(id);


