INSERT INTO service_delivery.room_reservation (
  customer_id,
  room_id,
  start_date,
  end_date,
  guest_count,
  reservation_status,
  estimated_value
)
SELECT c.id, h.id, TIMESTAMPTZ '2026-05-10 15:00:00-05', TIMESTAMPTZ '2026-05-12 12:00:00-05', 1, 'CONFIRMED', 240000
FROM configuration.customer c
JOIN distribution.room h ON h.number = '101'
WHERE c.document_number = '100000001'
  AND NOT EXISTS (
    SELECT 1
    FROM service_delivery.room_reservation r
    WHERE r.customer_id = c.id
      AND r.room_id = h.id
      AND r.start_date = TIMESTAMPTZ '2026-05-10 15:00:00-05'
  );

INSERT INTO service_delivery.stay (
  room_reservation_id,
  customer_id,
  room_id,
  start_date,
  stay_status
)
SELECT r.id, r.customer_id, r.room_id, r.start_date, 'ACTIVE'
FROM service_delivery.room_reservation r
WHERE r.start_date = TIMESTAMPTZ '2026-05-10 15:00:00-05'
  AND NOT EXISTS (
    SELECT 1
    FROM service_delivery.stay e
    WHERE e.room_reservation_id = r.id
  );



