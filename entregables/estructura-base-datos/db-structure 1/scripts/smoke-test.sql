SELECT 'tables_created' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema IN (
  'parametrizacion',
  'distribucion',
  'prestacion_servicio',
  'facturacion',
  'inventario',
  'notificacion',
  'seguridad',
  'mantenimiento'
);

SELECT 'schemas_created' AS check_name, COUNT(*) AS value
FROM information_schema.schemata
WHERE schema_name IN (
  'parametrizacion',
  'distribucion',
  'prestacion_servicio',
  'facturacion',
  'inventario',
  'notificacion',
  'seguridad',
  'mantenimiento'
);

SELECT 'estados_habitacion' AS check_name, COUNT(*) AS value FROM distribucion.estado_habitacion;
SELECT 'tipos_habitacion' AS check_name, COUNT(*) AS value FROM distribucion.tipo_habitacion;
SELECT 'modulos' AS check_name, COUNT(*) AS value FROM seguridad.modulo;
SELECT 'usuario_ariel' AS check_name, COUNT(*) AS value FROM seguridad.usuario WHERE username = 'ariel5253';
