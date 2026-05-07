CREATE OR REPLACE VIEW security.v_user_roles AS
SELECT
  u.id AS user_id,
  u.username,
  p.name || ' ' || p.last_name AS person,
  r.name AS role,
  u.blocked,
  u.status
FROM security.user_account u
JOIN configuration.person p ON p.id = u.person_id
LEFT JOIN security.user_rolee ur ON ur.user_id = u.id
LEFT JOIN security.role r ON r.id = ur.rolee_id;


