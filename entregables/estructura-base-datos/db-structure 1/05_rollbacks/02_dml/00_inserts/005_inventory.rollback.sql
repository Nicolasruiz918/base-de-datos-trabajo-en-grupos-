DELETE FROM inventory.inventory_availability;
DELETE FROM inventory.service WHERE name IN ('Lavanderia', 'Desayuno', 'Parqueadero');
DELETE FROM inventory.product WHERE name = 'Agua mineral';
DELETE FROM inventory.supplier WHERE nit = '800000000-1';


