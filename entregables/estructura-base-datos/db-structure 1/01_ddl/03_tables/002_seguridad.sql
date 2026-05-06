SET search_path TO seguridad;

CREATE TABLE IF NOT EXISTS rol (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS permiso (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(120) NOT NULL,
  descripcion VARCHAR(255),
  accion VARCHAR(80) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS modulo (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255),
  ruta_base VARCHAR(160) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS vista (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  modulo_id UUID NOT NULL REFERENCES seguridad.modulo(id),
  nombre VARCHAR(120) NOT NULL,
  descripcion VARCHAR(255),
  ruta VARCHAR(180) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS usuario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  persona_id UUID NOT NULL REFERENCES parametrizacion.persona(id),
  username VARCHAR(80) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  ultimo_acceso TIMESTAMPTZ,
  bloqueado BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS usuario_rol (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES seguridad.usuario(id),
  rol_id UUID NOT NULL REFERENCES seguridad.rol(id),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS rol_permiso (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  rol_id UUID NOT NULL REFERENCES seguridad.rol(id),
  permiso_id UUID NOT NULL REFERENCES seguridad.permiso(id),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS modulo_vista (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  modulo_id UUID NOT NULL REFERENCES seguridad.modulo(id),
  vista_id UUID NOT NULL REFERENCES seguridad.vista(id),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);
