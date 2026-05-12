DELETE FROM configuration.price;
DELETE FROM configuration.employee;
DELETE FROM configuration.person WHERE document_number IN ('52530001', '52530002');
DELETE FROM configuration.customer WHERE document_number IN ('100000001', '100000002');
DELETE FROM configuration.payment_method WHERE name IN ('CASH', 'CARD', 'BANK_TRANSFER');
DELETE FROM configuration.day_type WHERE name IN ('WEEKDAY', 'WEEKEND', 'HOLIDAY', 'HIGH_SEASON');
DELETE FROM configuration.company WHERE nit = '900000000-1';


