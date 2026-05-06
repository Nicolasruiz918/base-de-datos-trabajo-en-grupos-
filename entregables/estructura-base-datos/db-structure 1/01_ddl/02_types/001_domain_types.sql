DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'record_status' AND typnamespace = 'parametrizacion'::regnamespace) THEN
    CREATE TYPE parametrizacion.record_status AS ENUM ('ACTIVE', 'INACTIVE', 'DELETED');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_reserva' AND typnamespace = 'prestacion_servicio'::regnamespace) THEN
    CREATE TYPE prestacion_servicio.estado_reserva AS ENUM ('PENDIENTE', 'CONFIRMADA', 'CANCELADA', 'CHECK_IN', 'FINALIZADA');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_estadia' AND typnamespace = 'prestacion_servicio'::regnamespace) THEN
    CREATE TYPE prestacion_servicio.estado_estadia AS ENUM ('ACTIVA', 'FINALIZADA', 'CANCELADA');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_factura' AND typnamespace = 'facturacion'::regnamespace) THEN
    CREATE TYPE facturacion.estado_factura AS ENUM ('BORRADOR', 'EMITIDA', 'PAGADA', 'ANULADA');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'tipo_movimiento_inventario' AND typnamespace = 'inventario'::regnamespace) THEN
    CREATE TYPE inventario.tipo_movimiento_inventario AS ENUM ('ENTRADA', 'SALIDA', 'AJUSTE');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'canal_notificacion' AND typnamespace = 'notificacion'::regnamespace) THEN
    CREATE TYPE notificacion.canal_notificacion AS ENUM ('EMAIL', 'SMS', 'WHATSAPP', 'SISTEMA');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_mantenimiento' AND typnamespace = 'mantenimiento'::regnamespace) THEN
    CREATE TYPE mantenimiento.estado_mantenimiento AS ENUM ('PENDIENTE', 'EN_PROCESO', 'FINALIZADO', 'CANCELADO');
  END IF;
END $$;

