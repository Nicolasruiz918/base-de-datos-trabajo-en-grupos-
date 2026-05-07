-- La HU de deletes usa eliminacion logica por procedimiento.
-- La reversa puntual debe reactiver el registro afectado cuando se conozca schema, tabla e id.
-- Ejemplo:
-- UPDATE notification.alert SET status = 'ACTIVE', deleted_at = NULL, deleted_by = NULL WHERE id = 1;


