DELETE FROM distribution.room_catalog;
DELETE FROM distribution.room WHERE number IN ('101', '201');
DELETE FROM distribution.site WHERE name = 'Main Site';
DELETE FROM distribution.room_status WHERE name IN ('AVAILABLE', 'RESERVED', 'OCCUPIED', 'CLEANING', 'BLOCKED', 'MAINTENANCE');
DELETE FROM distribution.room_type WHERE name IN ('SINGLE', 'DOUBLE', 'SUITE');


