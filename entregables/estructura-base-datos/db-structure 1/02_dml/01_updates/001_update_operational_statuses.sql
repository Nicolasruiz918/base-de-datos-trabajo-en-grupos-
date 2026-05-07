UPDATE service_delivery.room_reservationtion
SET reservationtion_status = 'CONFIRMED'
WHERE reservationtion_status = 'PENDING'
  AND status = 'ACTIVE';

UPDATE distribution.room h
SET room_status_id = eh.id
FROM distribution.room_status eh
WHERE h.number = '101'
  AND eh.name = 'RESERVED';



