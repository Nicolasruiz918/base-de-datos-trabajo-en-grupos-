DROP FUNCTION IF EXISTS billing.fn_normalize_billing_total() CASCADE;
DROP FUNCTION IF EXISTS inventory.fn_validate_product_sale_stock() CASCADE;
DROP FUNCTION IF EXISTS service_delivery.fn_validate_room_reservation() CASCADE;
DROP FUNCTION IF EXISTS distribution.fn_validate_room_capacity() CASCADE;
DROP FUNCTION IF EXISTS inventory.fn_available_stock(UUID);
DROP FUNCTION IF EXISTS configuration.fn_calculate_reservation_price(UUID, TIMESTAMPTZ, TIMESTAMPTZ);
DROP FUNCTION IF EXISTS billing.fn_calculate_total(NUMERIC, NUMERIC, NUMERIC);
DROP FUNCTION IF EXISTS service_delivery.fn_calculate_nights(TIMESTAMPTZ, TIMESTAMPTZ);
DROP FUNCTION IF EXISTS configuration.fn_set_updated_at() CASCADE;


