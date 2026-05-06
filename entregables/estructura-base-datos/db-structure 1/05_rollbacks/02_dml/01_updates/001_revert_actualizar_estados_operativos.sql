UPDATE prestacion_servicio.reserva_habitacion
SET estado_reserva = 'PENDIENTE'
WHERE estado_reserva = 'CONFIRMADA'
  AND status = 'ACTIVE';

UPDATE distribucion.habitacion h
SET estado_habitacion_id = eh.id
FROM distribucion.estado_habitacion eh
WHERE h.numero = '101'
  AND eh.nombre = 'DISPONIBLE';
