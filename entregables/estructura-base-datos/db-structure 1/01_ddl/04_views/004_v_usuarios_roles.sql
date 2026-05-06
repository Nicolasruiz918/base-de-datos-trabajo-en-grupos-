CREATE OR REPLACE VIEW seguridad.v_usuarios_roles AS
SELECT
  u.id AS usuario_id,
  u.username,
  p.nombre || ' ' || p.apellido AS persona,
  r.nombre AS rol,
  u.bloqueado,
  u.status
FROM seguridad.usuario u
JOIN parametrizacion.persona p ON p.id = u.persona_id
LEFT JOIN seguridad.usuario_rol ur ON ur.usuario_id = u.id
LEFT JOIN seguridad.rol r ON r.id = ur.rol_id;
