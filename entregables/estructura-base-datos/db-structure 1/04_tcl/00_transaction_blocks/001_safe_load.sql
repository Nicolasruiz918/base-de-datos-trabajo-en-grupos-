BEGIN;

-- Bloque transactional para cambios operativos controleados.
-- Agregar aqui llamadas CALL o DML sensible cuando se requiera atomicidad.
-- Ejemplo:
-- CALL inventory.sp_register_product_entry(1, 10, 'Reposicion manual controleada');

COMMIT;



