DELETE FROM parametrizacion.precio;
DELETE FROM parametrizacion.empleado;
DELETE FROM parametrizacion.persona WHERE numero_documento IN ('52530001', '52530002');
DELETE FROM parametrizacion.cliente WHERE numero_documento IN ('100000001', '100000002');
DELETE FROM parametrizacion.metodo_pago WHERE nombre IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA');
DELETE FROM parametrizacion.tipo_dia WHERE nombre IN ('ENTRE_SEMANA', 'FIN_SEMANA', 'FERIADO', 'TEMPORADA_ALTA');
DELETE FROM parametrizacion.empresa WHERE nit = '900000000-1';
