INSERT INTO billing.pre_invoice (
  stay_id,
  room_reservation_id,
  customer_id,
  subtotal,
  tax,
  discount
)
SELECT e.id, e.room_reservation_id, e.customer_id, 240000, 45600, 0
FROM service_delivery.stay e
WHERE NOT EXISTS (
  SELECT 1
  FROM billing.pre_invoice pf
  WHERE pf.stay_id = e.id
);

INSERT INTO billing.partial_payment (room_reservation_id, payment_method_id, value, payment_reference)
SELECT r.id, mp.id, 100000, 'ABONO-DEMO-001'
FROM service_delivery.room_reservation r
JOIN configuration.payment_method mp ON mp.name = 'BANK_TRANSFER'
WHERE r.start_date = TIMESTAMPTZ '2026-05-10 15:00:00-05'
  AND NOT EXISTS (
    SELECT 1
    FROM billing.partial_payment pp
    WHERE pp.room_reservation_id = r.id
      AND pp.payment_reference = 'ABONO-DEMO-001'
  );



