GRANT CONNECT ON DATABASE sistema_hotelero TO administrador, desarrollador, qa, ariel5253;

GRANT USAGE ON SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento TO administrador, desarrollador, qa;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento TO administrador;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento TO administrador;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA parametrizacion, prestacion_servicio, facturacion, inventario, distribucion, mantenimiento, seguridad TO administrador;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento TO desarrollador;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento TO desarrollador;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA parametrizacion, prestacion_servicio, facturacion, inventario, distribucion, mantenimiento, seguridad TO desarrollador;

GRANT SELECT ON ALL TABLES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento TO qa;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA parametrizacion, prestacion_servicio, facturacion, inventario, distribucion, mantenimiento, seguridad TO qa;

ALTER DEFAULT PRIVILEGES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento
GRANT ALL PRIVILEGES ON TABLES TO administrador;

ALTER DEFAULT PRIVILEGES IN SCHEMA parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad, mantenimiento
GRANT SELECT ON TABLES TO qa;
