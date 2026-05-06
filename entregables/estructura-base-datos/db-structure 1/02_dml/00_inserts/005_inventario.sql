INSERT INTO inventario.proveedor (nombre, nit, telefono, correo, direccion)
VALUES ('Proveedor Demo', '800000000-1', '3003334455', 'proveedor@demo.local', 'Zona industrial')
ON CONFLICT (nit) DO UPDATE
SET nombre = EXCLUDED.nombre,
    telefono = EXCLUDED.telefono,
    correo = EXCLUDED.correo,
    direccion = EXCLUDED.direccion;

INSERT INTO inventario.producto (proveedor_id, nombre, descripcion, valor_venta, stock_actual, stock_minimo)
SELECT p.id, 'Agua mineral', 'Botella de agua 600ml', 5000, 30, 5
FROM inventario.proveedor p
WHERE p.nit = '800000000-1'
ON CONFLICT (nombre) DO UPDATE
SET proveedor_id = EXCLUDED.proveedor_id,
    descripcion = EXCLUDED.descripcion,
    valor_venta = EXCLUDED.valor_venta,
    stock_actual = EXCLUDED.stock_actual,
    stock_minimo = EXCLUDED.stock_minimo;

INSERT INTO inventario.servicio (nombre, descripcion, valor_venta, disponible)
VALUES
  ('Lavanderia', 'Servicio de lavanderia por prenda', 12000, true),
  ('Desayuno', 'Desayuno adicional por persona', 18000, true)
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion,
    valor_venta = EXCLUDED.valor_venta,
    disponible = EXCLUDED.disponible;

INSERT INTO inventario.disponibilidad_inventario (producto_id, cantidad_disponible, disponible, observacion)
SELECT p.id, p.stock_actual, true, 'Disponibilidad inicial'
FROM inventario.producto p
WHERE p.nombre = 'Agua mineral'
  AND NOT EXISTS (
    SELECT 1
    FROM inventario.disponibilidad_inventario di
    WHERE di.producto_id = p.id
  );

