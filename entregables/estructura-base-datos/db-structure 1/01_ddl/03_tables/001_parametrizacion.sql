SET search_path TO parametrizacion;

CREATE TABLE IF NOT EXISTS cliente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo_documento VARCHAR(30) NOT NULL,
  numero_documento VARCHAR(40) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  telefono VARCHAR(40),
  correo CITEXT,
  direccion VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS persona (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo_documento VARCHAR(30) NOT NULL,
  numero_documento VARCHAR(40) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  telefono VARCHAR(40),
  correo CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS empresa (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(160) NOT NULL,
  nit VARCHAR(40) NOT NULL,
  razon_social VARCHAR(180) NOT NULL,
  telefono VARCHAR(40),
  correo CITEXT,
  direccion VARCHAR(255),
  sitio_web VARCHAR(180),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS tipo_dia (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(255),
  fecha DATE,
  aplica_temporada BOOLEAN NOT NULL DEFAULT false,
  aplica_feriado BOOLEAN NOT NULL DEFAULT false,
  aplica_especial BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS metodo_pago (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(255),
  requiere_referencia BOOLEAN NOT NULL DEFAULT false,
  permite_pago_parcial BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS informacion_legal (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  empresa_id UUID NOT NULL REFERENCES parametrizacion.empresa(id),
  tipo_documento_legal VARCHAR(80) NOT NULL,
  numero_documento_legal VARCHAR(80) NOT NULL,
  descripcion TEXT,
  fecha_expedicion DATE,
  fecha_vencimiento DATE,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS empleado (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  persona_id UUID NOT NULL REFERENCES parametrizacion.persona(id),
  cargo VARCHAR(100) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  telefono_laboral VARCHAR(40),
  correo_laboral CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);


CREATE TABLE IF NOT EXISTS precio (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo_habitacion_id UUID NOT NULL,
  tipo_dia_id UUID NOT NULL REFERENCES parametrizacion.tipo_dia(id),
  valor NUMERIC(12,2) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  condicion VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_precio_valor CHECK (valor >= 0),
  CONSTRAINT ck_precio_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);
