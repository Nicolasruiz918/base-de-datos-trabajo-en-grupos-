SET search_path TO notificacion, public;

CREATE TABLE IF NOT EXISTS promocion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo VARCHAR(160) NOT NULL,
  descripcion TEXT,
  fecha_inicio TIMESTAMPTZ NOT NULL,
  fecha_fin TIMESTAMPTZ,
  canal notificacion.canal_notificacion NOT NULL,
  activa BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_promocion_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE IF NOT EXISTS alerta (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID,
  reserva_habitacion_id UUID,
  titulo VARCHAR(160) NOT NULL,
  mensaje TEXT NOT NULL,
  canal notificacion.canal_notificacion NOT NULL,
  fecha_envio TIMESTAMPTZ,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_alerta_cliente FOREIGN KEY (cliente_id) REFERENCES parametrizacion.cliente(id),
  CONSTRAINT fk_alerta_reserva FOREIGN KEY (reserva_habitacion_id) REFERENCES prestacion_servicio.reserva_habitacion(id)
);

CREATE TABLE IF NOT EXISTS termino_condicion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo VARCHAR(160) NOT NULL,
  contenido TEXT NOT NULL,
  version VARCHAR(40) NOT NULL,
  fecha_vigencia DATE NOT NULL,
  obligatorio BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS fidelizacion_cliente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID NOT NULL,
  nivel VARCHAR(60) NOT NULL DEFAULT 'BASICO',
  puntos INTEGER NOT NULL DEFAULT 0,
  fecha_ultima_interaccion TIMESTAMPTZ,
  observacion TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_fidelizacion_puntos CHECK (puntos >= 0),
  CONSTRAINT fk_fidelizacion_cliente FOREIGN KEY (cliente_id) REFERENCES parametrizacion.cliente(id)
);

