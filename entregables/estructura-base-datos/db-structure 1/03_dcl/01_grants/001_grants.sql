GRANT CONNECT ON DATABASE hotel_management TO administrator, developer, qa, ariel5253;

GRANT USAGE ON SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance TO administrator, developer, qa;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance TO administrator;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance TO administrator;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA configuration, service_delivery, billing, inventory, distribution, maintenance, security TO administrator;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance TO developer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance TO developer;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA configuration, service_delivery, billing, inventory, distribution, maintenance, security TO developer;

GRANT SELECT ON ALL TABLES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance TO qa;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA configuration, service_delivery, billing, inventory, distribution, maintenance, security TO qa;

ALTER DEFAULT PRIVILEGES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance
GRANT ALL PRIVILEGES ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance
GRANT SELECT ON TABLES TO qa;


