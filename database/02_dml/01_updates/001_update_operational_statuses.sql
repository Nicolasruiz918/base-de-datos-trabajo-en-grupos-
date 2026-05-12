UPDATE service_delivery.room_reservation
SET reservation_status = 'CONFIRMED'
WHERE reservation_status = 'PENDING'
  AND status = 'ACTIVE';

UPDATE distribution.room h
SET room_status_id = eh.id
FROM distribution.room_status eh
WHERE h.number = '101'
  AND eh.name = 'RESERVED';



