ALTER TABLE parametrizacion.cliente ENABLE ROW LEVEL SECURITY;
ALTER TABLE parametrizacion.persona ENABLE ROW LEVEL SECURITY;
ALTER TABLE seguridad.usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE facturacion.factura ENABLE ROW LEVEL SECURITY;
ALTER TABLE facturacion.pago_parcial ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS pol_cliente_admin_all ON parametrizacion.cliente;
CREATE POLICY pol_cliente_admin_all ON parametrizacion.cliente FOR ALL TO administrador USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS pol_persona_admin_all ON parametrizacion.persona;
CREATE POLICY pol_persona_admin_all ON parametrizacion.persona FOR ALL TO administrador USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS pol_usuario_admin_all ON seguridad.usuario;
CREATE POLICY pol_usuario_admin_all ON seguridad.usuario FOR ALL TO administrador USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS pol_factura_admin_all ON facturacion.factura;
CREATE POLICY pol_factura_admin_all ON facturacion.factura FOR ALL TO administrador USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS pol_pago_admin_all ON facturacion.pago_parcial;
CREATE POLICY pol_pago_admin_all ON facturacion.pago_parcial FOR ALL TO administrador USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS pol_cliente_desarrollador_all ON parametrizacion.cliente;
CREATE POLICY pol_cliente_desarrollador_all ON parametrizacion.cliente FOR ALL TO desarrollador USING (status <> 'DELETED') WITH CHECK (status <> 'DELETED');

DROP POLICY IF EXISTS pol_persona_desarrollador_all ON parametrizacion.persona;
CREATE POLICY pol_persona_desarrollador_all ON parametrizacion.persona FOR ALL TO desarrollador USING (status <> 'DELETED') WITH CHECK (status <> 'DELETED');

DROP POLICY IF EXISTS pol_usuario_desarrollador_read ON seguridad.usuario;
CREATE POLICY pol_usuario_desarrollador_read ON seguridad.usuario FOR SELECT TO desarrollador USING (status <> 'DELETED');

DROP POLICY IF EXISTS pol_factura_desarrollador_all ON facturacion.factura;
CREATE POLICY pol_factura_desarrollador_all ON facturacion.factura FOR ALL TO desarrollador USING (status <> 'DELETED') WITH CHECK (status <> 'DELETED');

DROP POLICY IF EXISTS pol_pago_desarrollador_all ON facturacion.pago_parcial;
CREATE POLICY pol_pago_desarrollador_all ON facturacion.pago_parcial FOR ALL TO desarrollador USING (status <> 'DELETED') WITH CHECK (status <> 'DELETED');

DROP POLICY IF EXISTS pol_cliente_qa_read ON parametrizacion.cliente;
CREATE POLICY pol_cliente_qa_read ON parametrizacion.cliente FOR SELECT TO qa USING (status = 'ACTIVE');

DROP POLICY IF EXISTS pol_factura_qa_read ON facturacion.factura;
CREATE POLICY pol_factura_qa_read ON facturacion.factura FOR SELECT TO qa USING (status = 'ACTIVE');
