INSERT INTO inventory.supplier (name, nit, phone, email, address)
VALUES ('Proveedor Demo', '800000000-1', '3003334455', 'supplier@demo.local', 'Zona industrial')
ON CONFLICT (nit) DO UPDATE
SET name = EXCLUDED.name,
    phone = EXCLUDED.phone,
    email = EXCLUDED.email,
    address = EXCLUDED.address;

INSERT INTO inventory.product (supplier_id, name, description, sale_value, current_stock, minimum_stock)
SELECT p.id, 'Agua mineral', 'Botella de agua 600ml', 5000, 30, 5
FROM inventory.supplier p
WHERE p.nit = '800000000-1'
ON CONFLICT (name) DO UPDATE
SET supplier_id = EXCLUDED.supplier_id,
    description = EXCLUDED.description,
    sale_value = EXCLUDED.sale_value,
    current_stock = EXCLUDED.current_stock,
    minimum_stock = EXCLUDED.minimum_stock;

INSERT INTO inventory.service (name, description, sale_value, available)
VALUES
  ('Lavanderia', 'Servicio de lavanderia por prenda', 12000, true),
  ('Desayuno', 'Desayuno adicional por person', 18000, true)
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description,
    sale_value = EXCLUDED.sale_value,
    available = EXCLUDED.available;

INSERT INTO inventory.inventory_availability (product_id, available_quantity, available, notes)
SELECT p.id, p.current_stock, true, 'Disponibilidad inicial'
FROM inventory.product p
WHERE p.name = 'Agua mineral'
  AND NOT EXISTS (
    SELECT 1
    FROM inventory.inventory_availability di
    WHERE di.product_id = p.id
  );



