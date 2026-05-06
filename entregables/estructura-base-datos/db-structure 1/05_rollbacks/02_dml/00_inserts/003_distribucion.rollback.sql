DELETE FROM distribucion.catalogo_habitacion;
DELETE FROM distribucion.habitacion WHERE numero IN ('101', '201');
DELETE FROM distribucion.sede WHERE nombre = 'Sede Principal';
DELETE FROM distribucion.estado_habitacion WHERE nombre IN ('DISPONIBLE', 'RESERVADA', 'OCUPADA', 'LIMPIEZA', 'BLOQUEADA', 'MANTENIMIENTO');
DELETE FROM distribucion.tipo_habitacion WHERE nombre IN ('SENCILLA', 'DOBLE', 'SUITE');
