INSERT INTO notification.term_condition (title, content, version, effective_date, mandatory)
VALUES ('Terminos base de reservation', 'Condiciones iniciales pendientes de aprobacion legal.', 'v1.0.0', DATE '2026-01-01', true)
ON CONFLICT (version) DO UPDATE
SET content = EXCLUDED.content,
    effective_date = EXCLUDED.effective_date,
    mandatory = EXCLUDED.mandatory;

INSERT INTO notification.customer_loyalty (customer_id, level, points, last_interaction_date, notes)
SELECT c.id, 'BASIC', 0, now(), 'Cliente creado como dato de referencia'
FROM configuration.customer c
WHERE c.document_number = '100000001'
ON CONFLICT (customer_id) DO UPDATE
SET level = EXCLUDED.level,
    points = EXCLUDED.points,
    last_interaction_date = EXCLUDED.last_interaction_date,
    notes = EXCLUDED.notes;


