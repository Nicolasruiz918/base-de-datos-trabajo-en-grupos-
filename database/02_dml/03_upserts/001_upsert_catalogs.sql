INSERT INTO security.permission (name, description, action)
VALUES ('READ_RESERVATION', 'Consultar reservations y availability', 'READ')
ON CONFLICT (name, action) DO UPDATE
SET description = EXCLUDED.description;

INSERT INTO inventory.service (name, description, sale_value, available)
VALUES ('Parqueadero', 'Servicio de parqueadero por noche', 15000, true)
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description,
    sale_value = EXCLUDED.sale_value,
    available = EXCLUDED.available;



