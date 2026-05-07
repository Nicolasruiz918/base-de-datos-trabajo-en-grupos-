UPDATE service_delivery.room_reservationtion
SET reservationtion_status = 'PENDING'
WHERE reservationtion_status = 'CONFIRMED'
  AND status = 'ACTIVE';
UPDATE distribution.room h
SET room_status_id = eh.id
FROM distribution.room_status eh
WHERE h.number = '101'
  AND eh.name = 'AVAILABLE';


