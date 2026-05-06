INSERT INTO parametrizacion.empresa (nombre, nit, razon_social, telefono, correo, direccion, sitio_web)
VALUES ('Hotel Demo', '900000000-1', 'Hotel Demo S.A.S.', '3000000000', 'contacto@hoteldemo.local', 'Direccion principal', 'https://hoteldemo.local')
ON CONFLICT (nit) DO UPDATE
SET nombre = EXCLUDED.nombre,
    razon_social = EXCLUDED.razon_social,
    telefono = EXCLUDED.telefono,
    correo = EXCLUDED.correo,
    direccion = EXCLUDED.direccion,
    sitio_web = EXCLUDED.sitio_web;

INSERT INTO parametrizacion.tipo_dia (nombre, descripcion, aplica_temporada, aplica_feriado, aplica_especial)
SELECT v.nombre, v.descripcion, v.aplica_temporada, v.aplica_feriado, v.aplica_especial
FROM (
  VALUES
    ('ENTRE_SEMANA', 'Dia operativo regular entre semana', false, false, false),
    ('FIN_SEMANA', 'Dia de fin de semana', false, false, false),
    ('FERIADO', 'Dia feriado', false, true, false),
    ('TEMPORADA_ALTA', 'Dia con regla de temporada alta', true, false, false)
) AS v(nombre, descripcion, aplica_temporada, aplica_feriado, aplica_especial)
WHERE NOT EXISTS (
  SELECT 1
  FROM parametrizacion.tipo_dia td
  WHERE td.nombre = v.nombre
    AND td.fecha IS NULL
);

INSERT INTO parametrizacion.metodo_pago (nombre, descripcion, requiere_referencia, permite_pago_parcial)
VALUES
  ('EFECTIVO', 'Pago en efectivo', false, true),
  ('TARJETA', 'Pago con tarjeta debito o credito', true, true),
  ('TRANSFERENCIA', 'Pago por transferencia bancaria', true, true)
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion,
    requiere_referencia = EXCLUDED.requiere_referencia,
    permite_pago_parcial = EXCLUDED.permite_pago_parcial;

INSERT INTO parametrizacion.cliente (tipo_documento, numero_documento, nombre, apellido, telefono, correo, direccion)
VALUES
  ('CC', '100000001', 'Sofia', 'Martinez', '3001112233', 'sofia.martinez@example.local', 'Calle 10 # 1-20'),
  ('CC', '100000002', 'Carlos', 'Rojas', '3002223344', 'carlos.rojas@example.local', 'Carrera 15 # 30-50')
ON CONFLICT (tipo_documento, numero_documento) DO UPDATE
SET nombre = EXCLUDED.nombre,
    apellido = EXCLUDED.apellido,
    telefono = EXCLUDED.telefono,
    correo = EXCLUDED.correo,
    direccion = EXCLUDED.direccion;

INSERT INTO parametrizacion.persona (tipo_documento, numero_documento, nombre, apellido, telefono, correo)
VALUES
  ('CC', '52530001', 'Ariel', 'Administrador', '3005253001', 'ariel5253@example.local'),
  ('CC', '52530002', 'Recepcion', 'Demo', '3005253002', 'recepcion@example.local')
ON CONFLICT (tipo_documento, numero_documento) DO UPDATE
SET nombre = EXCLUDED.nombre,
    apellido = EXCLUDED.apellido,
    telefono = EXCLUDED.telefono,
    correo = EXCLUDED.correo;

INSERT INTO parametrizacion.empleado (persona_id, cargo, fecha_ingreso, telefono_laboral, correo_laboral)
SELECT p.id, 'Administrador', DATE '2026-01-01', '3005253001', 'ariel5253@hotel.local'
FROM parametrizacion.persona p
WHERE p.numero_documento = '52530001'
ON CONFLICT (persona_id) DO UPDATE
SET cargo = EXCLUDED.cargo,
    telefono_laboral = EXCLUDED.telefono_laboral,
    correo_laboral = EXCLUDED.correo_laboral;

