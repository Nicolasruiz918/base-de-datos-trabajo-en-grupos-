SET search_path TO inventario;

CREATE TABLE IF NOT EXISTS proveedor (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(160) NOT NULL,
  nit VARCHAR(40) NOT NULL,
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

CREATE TABLE IF NOT EXISTS producto (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proveedor_id UUID REFERENCES inventario.proveedor(id),
  nombre VARCHAR(160) NOT NULL,
  descripcion VARCHAR(255),
  valor_venta NUMERIC(12,2) NOT NULL DEFAULT 0,
  stock_actual INTEGER NOT NULL DEFAULT 0,
  stock_minimo INTEGER NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_producto_valores CHECK (valor_venta >= 0 AND stock_actual >= 0 AND stock_minimo >= 0)
);

CREATE TABLE IF NOT EXISTS servicio (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(160) NOT NULL,
  descripcion VARCHAR(255),
  valor_venta NUMERIC(12,2) NOT NULL DEFAULT 0,
  disponible BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_servicio_valor CHECK (valor_venta >= 0)
);

CREATE TABLE IF NOT EXISTS venta_producto (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  estadia_id UUID NOT NULL REFERENCES prestacion_servicio.estadia(id),
  producto_id UUID NOT NULL REFERENCES inventario.producto(id),
  cantidad INTEGER NOT NULL,
  valor_unitario NUMERIC(12,2) NOT NULL,
  valor_total NUMERIC(12,2) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_venta_producto_valores CHECK (cantidad > 0 AND valor_unitario >= 0 AND valor_total >= 0)
);

CREATE TABLE IF NOT EXISTS venta_servicio (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  estadia_id UUID NOT NULL REFERENCES prestacion_servicio.estadia(id),
  servicio_id UUID NOT NULL REFERENCES inventario.servicio(id),
  cantidad INTEGER NOT NULL,
  valor_unitario NUMERIC(12,2) NOT NULL,
  valor_total NUMERIC(12,2) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_venta_servicio_valores CHECK (cantidad > 0 AND valor_unitario >= 0 AND valor_total >= 0)
);

CREATE TABLE IF NOT EXISTS seguimiento_producto (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  producto_id UUID NOT NULL REFERENCES inventario.producto(id),
  tipo_movimiento inventario.tipo_movimiento_inventario NOT NULL,
  cantidad INTEGER NOT NULL,
  fecha_movimiento TIMESTAMPTZ NOT NULL DEFAULT now(),
  observacion TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_seguimiento_cantidad CHECK (cantidad > 0)
);

CREATE TABLE IF NOT EXISTS disponibilidad_inventario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  producto_id UUID REFERENCES inventario.producto(id),
  servicio_id UUID REFERENCES inventario.servicio(id),
  cantidad_disponible INTEGER NOT NULL DEFAULT 0,
  disponible BOOLEAN NOT NULL DEFAULT true,
  observacion VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_disponibilidad_inv_item CHECK (producto_id IS NOT NULL OR servicio_id IS NOT NULL),
  CONSTRAINT ck_disponibilidad_inv_cantidad CHECK (cantidad_disponible >= 0)
);
