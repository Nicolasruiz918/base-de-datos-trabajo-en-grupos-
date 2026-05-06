INSERT INTO notificacion.termino_condicion (titulo, contenido, version, fecha_vigencia, obligatorio)
VALUES ('Terminos base de reserva', 'Condiciones iniciales pendientes de aprobacion legal.', 'v1.0.0', DATE '2026-01-01', true)
ON CONFLICT (version) DO UPDATE
SET contenido = EXCLUDED.contenido,
    fecha_vigencia = EXCLUDED.fecha_vigencia,
    obligatorio = EXCLUDED.obligatorio;

INSERT INTO notificacion.fidelizacion_cliente (cliente_id, nivel, puntos, fecha_ultima_interaccion, observacion)
SELECT c.id, 'BASICO', 0, now(), 'Cliente creado como dato de referencia'
FROM parametrizacion.cliente c
WHERE c.numero_documento = '100000001'
ON CONFLICT (cliente_id) DO UPDATE
SET nivel = EXCLUDED.nivel,
    puntos = EXCLUDED.puntos,
    fecha_ultima_interaccion = EXCLUDED.fecha_ultima_interaccion,
    observacion = EXCLUDED.observacion;
