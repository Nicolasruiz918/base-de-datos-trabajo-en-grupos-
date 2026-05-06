BEGIN;

-- Bloque transaccional para cambios operativos controlados.
-- Agregar aqui llamadas CALL o DML sensible cuando se requiera atomicidad.
-- Ejemplo:
-- CALL inventario.sp_registrar_entrada_producto(1, 10, 'Reposicion manual controlada');

COMMIT;

