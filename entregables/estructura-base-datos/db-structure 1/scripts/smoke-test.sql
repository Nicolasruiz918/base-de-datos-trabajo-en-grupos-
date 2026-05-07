SELECT 'tables_created' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema IN (
  'configuration',
  'distribution',
  'service_delivery',
  'billing',
  'inventory',
  'notification',
  'security',
  'maintenance'
);

SELECT 'schemas_created' AS check_name, COUNT(*) AS value
FROM information_schema.schemata
WHERE schema_name IN (
  'configuration',
  'distribution',
  'service_delivery',
  'billing',
  'inventory',
  'notification',
  'security',
  'maintenance'
);

SELECT 'estados_room' AS check_name, COUNT(*) AS value FROM distribution.room_status;
SELECT 'tipos_room' AS check_name, COUNT(*) AS value FROM distribution.room_type;
SELECT 'modules' AS check_name, COUNT(*) AS value FROM security.module;
SELECT 'user_account_ariel' AS check_name, COUNT(*) AS value FROM security.user_account WHERE username = 'ariel5253';


