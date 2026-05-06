DELETE FROM inventario.disponibilidad_inventario;
DELETE FROM inventario.servicio WHERE nombre IN ('Lavanderia', 'Desayuno', 'Parqueadero');
DELETE FROM inventario.producto WHERE nombre = 'Agua mineral';
DELETE FROM inventario.proveedor WHERE nit = '800000000-1';
