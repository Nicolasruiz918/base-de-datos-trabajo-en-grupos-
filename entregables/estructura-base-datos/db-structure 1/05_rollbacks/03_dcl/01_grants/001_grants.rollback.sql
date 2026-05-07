REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance FROM administrator, developer, qa;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance FROM administrator, developer, qa;
REVOKE USAGE ON SCHEMA configuration, distribution, service_delivery, billing, inventory, notification, security, maintenance FROM administrator, developer, qa;
REVOKE CONNECT ON DATABASE sistema_hotelero FROM administrator, developer, qa, ariel5253;


