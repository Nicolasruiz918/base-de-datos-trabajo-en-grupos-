INSERT INTO distribucion.tipo_habitacion (nombre, descripcion, capacidad_base, capacidad_maxima)
VALUES
  ('SENCILLA', 'Habitacion para una persona', 1, 1),
  ('DOBLE', 'Habitacion para dos personas', 2, 2),
  ('SUITE', 'Habitacion premium con mayor capacidad y comodidades', 2, 4)
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion,
    capacidad_base = EXCLUDED.capacidad_base,
    capacidad_maxima = EXCLUDED.capacidad_maxima;

INSERT INTO distribucion.estado_habitacion (nombre, descripcion, permite_reserva, permite_check_in)
VALUES
  ('DISPONIBLE', 'Disponible para reserva y check in', true, true),
  ('RESERVADA', 'Reservada para un cliente', false, true),
  ('OCUPADA', 'Actualmente ocupada', false, false),
  ('LIMPIEZA', 'Pendiente o en proceso de limpieza', false, false),
  ('BLOQUEADA', 'Bloqueada por decision operativa', false, false),
  ('MANTENIMIENTO', 'No disponible por mantenimiento', false, false)
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion,
    permite_reserva = EXCLUDED.permite_reserva,
    permite_check_in = EXCLUDED.permite_check_in;

INSERT INTO distribucion.sede (empresa_id, nombre, direccion, ciudad, telefono, correo)
SELECT e.id, 'Sede Principal', 'Direccion principal', 'Bogota', '3000000000', 'sede.principal@hoteldemo.local'
FROM parametrizacion.empresa e
WHERE e.nit = '900000000-1'
ON CONFLICT (empresa_id, nombre) DO UPDATE
SET direccion = EXCLUDED.direccion,
    ciudad = EXCLUDED.ciudad,
    telefono = EXCLUDED.telefono,
    correo = EXCLUDED.correo;

INSERT INTO distribucion.habitacion (sede_id, tipo_habitacion_id, estado_habitacion_id, numero, piso, capacidad, descripcion)
SELECT s.id, th.id, eh.id, '101', 1, 1, 'Habitacion sencilla de referencia'
FROM distribucion.sede s
JOIN parametrizacion.empresa e ON e.id = s.empresa_id
JOIN distribucion.tipo_habitacion th ON th.nombre = 'SENCILLA'
JOIN distribucion.estado_habitacion eh ON eh.nombre = 'DISPONIBLE'
WHERE e.nit = '900000000-1'
ON CONFLICT (sede_id, numero) DO UPDATE
SET tipo_habitacion_id = EXCLUDED.tipo_habitacion_id,
    estado_habitacion_id = EXCLUDED.estado_habitacion_id,
    piso = EXCLUDED.piso,
    capacidad = EXCLUDED.capacidad,
    descripcion = EXCLUDED.descripcion;

INSERT INTO distribucion.habitacion (sede_id, tipo_habitacion_id, estado_habitacion_id, numero, piso, capacidad, descripcion)
SELECT s.id, th.id, eh.id, '201', 2, 2, 'Habitacion doble de referencia'
FROM distribucion.sede s
JOIN parametrizacion.empresa e ON e.id = s.empresa_id
JOIN distribucion.tipo_habitacion th ON th.nombre = 'DOBLE'
JOIN distribucion.estado_habitacion eh ON eh.nombre = 'DISPONIBLE'
WHERE e.nit = '900000000-1'
ON CONFLICT (sede_id, numero) DO UPDATE
SET tipo_habitacion_id = EXCLUDED.tipo_habitacion_id,
    estado_habitacion_id = EXCLUDED.estado_habitacion_id,
    piso = EXCLUDED.piso,
    capacidad = EXCLUDED.capacidad,
    descripcion = EXCLUDED.descripcion;

INSERT INTO distribucion.catalogo_habitacion (habitacion_id, titulo, descripcion, precio_base, visible)
SELECT h.id, 'Habitacion ' || h.numero, h.descripcion, CASE h.numero WHEN '101' THEN 120000 ELSE 180000 END, true
FROM distribucion.habitacion h
WHERE h.numero IN ('101', '201')
ON CONFLICT (habitacion_id) DO UPDATE
SET titulo = EXCLUDED.titulo,
    descripcion = EXCLUDED.descripcion,
    precio_base = EXCLUDED.precio_base,
    visible = EXCLUDED.visible;


-- Carga de precios del dominio parametrizacion.
-- Se ejecuta aqui porque depende de tipos de habitacion cargados en distribucion.
INSERT INTO parametrizacion.precio (tipo_habitacion_id, tipo_dia_id, valor, fecha_inicio, fecha_fin, condicion)
SELECT th.id, td.id,
  CASE th.nombre
    WHEN 'SENCILLA' THEN 120000
    WHEN 'DOBLE' THEN 180000
    ELSE 320000
  END,
  DATE '2026-01-01',
  NULL,
  'Precio base inicial pendiente de reglas dinamicas definitivas'
FROM distribucion.tipo_habitacion th
CROSS JOIN parametrizacion.tipo_dia td
WHERE td.nombre = 'ENTRE_SEMANA'
ON CONFLICT (tipo_habitacion_id, tipo_dia_id, fecha_inicio) DO UPDATE
SET valor = EXCLUDED.valor,
    condicion = EXCLUDED.condicion;


