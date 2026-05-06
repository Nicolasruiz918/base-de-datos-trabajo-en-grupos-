UPDATE prestacion_servicio.reserva_habitacion
SET estado_reserva = 'CONFIRMADA'
WHERE estado_reserva = 'PENDIENTE'
  AND status = 'ACTIVE';

UPDATE distribucion.habitacion h
SET estado_habitacion_id = eh.id
FROM distribucion.estado_habitacion eh
WHERE h.numero = '101'
  AND eh.nombre = 'RESERVADA';

