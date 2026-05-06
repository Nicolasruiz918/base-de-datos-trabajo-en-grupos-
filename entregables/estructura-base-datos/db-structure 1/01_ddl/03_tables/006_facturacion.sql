SET search_path TO facturacion;

CREATE TABLE IF NOT EXISTS pre_factura (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  estadia_id UUID NOT NULL REFERENCES prestacion_servicio.estadia(id),
  reserva_habitacion_id UUID NOT NULL REFERENCES prestacion_servicio.reserva_habitacion(id),
  cliente_id UUID NOT NULL REFERENCES parametrizacion.cliente(id),
  subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
  impuesto NUMERIC(12,2) NOT NULL DEFAULT 0,
  descuento NUMERIC(12,2) NOT NULL DEFAULT 0,
  total NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_pre_factura_valores CHECK (subtotal >= 0 AND impuesto >= 0 AND descuento >= 0 AND total >= 0)
);

CREATE TABLE IF NOT EXISTS factura (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID NOT NULL REFERENCES parametrizacion.cliente(id),
  estadia_id UUID NOT NULL REFERENCES prestacion_servicio.estadia(id),
  numero_factura VARCHAR(60) NOT NULL,
  fecha_emision TIMESTAMPTZ NOT NULL DEFAULT now(),
  subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
  impuesto NUMERIC(12,2) NOT NULL DEFAULT 0,
  descuento NUMERIC(12,2) NOT NULL DEFAULT 0,
  total NUMERIC(12,2) NOT NULL DEFAULT 0,
  estado_factura facturacion.estado_factura NOT NULL DEFAULT 'EMITIDA',
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_factura_valores CHECK (subtotal >= 0 AND impuesto >= 0 AND descuento >= 0 AND total >= 0)
);

CREATE TABLE IF NOT EXISTS pago_parcial (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reserva_habitacion_id UUID REFERENCES prestacion_servicio.reserva_habitacion(id),
  factura_id UUID REFERENCES facturacion.factura(id),
  metodo_pago_id UUID NOT NULL REFERENCES parametrizacion.metodo_pago(id),
  valor NUMERIC(12,2) NOT NULL,
  fecha_pago TIMESTAMPTZ NOT NULL DEFAULT now(),
  referencia_pago VARCHAR(120),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status parametrizacion.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_pago_valor CHECK (valor > 0),
  CONSTRAINT ck_pago_origen CHECK (reserva_habitacion_id IS NOT NULL OR factura_id IS NOT NULL)
);

CREATE TABLE IF NOT EXISTS detalle_compra (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  factura_id UUID NOT NULL REFERENCES facturacion.factura(id),
  producto_id UUID REFERENCES inventario.producto(id),
  servicio_id UUID REFERENCES inventario.servicio(id),
  descripcion VARCHAR(255) NOT NULL,
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
  CONSTRAINT ck_detalle_valores CHECK (cantidad > 0 AND valor_unitario >= 0 AND valor_total >= 0),
  CONSTRAINT ck_detalle_item CHECK (producto_id IS NOT NULL OR servicio_id IS NOT NULL)
);
