UPDATE service_delivery.room_reservation
SET reservation_status = 'PENDING'
WHERE reservation_status = 'CONFIRMED'
  AND status = 'ACTIVE';

UPDATE distribution.room h
SET room_status_id = eh.id
FROM distribution.room_status eh
WHERE h.number = '101'
  AND eh.name = 'AVAILABLE';


