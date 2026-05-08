# Gestion del equipo y planteamiento - Sistema hotelero

## Proposito

Este documento consolida la informacion de apoyo a la gestion del equipo. El plan de trabajo y el seguimiento diario se mantienen separados porque son evidencias directas de historias de usuario.

## Planteamiento del sistema

El proyecto consiste en organizar la base de datos de un sistema de gestion hotelera sobre PostgreSQL. La entrega se enfoca en dejar una estructura ejecutable, documentada y validable, con scripts separados por DDL, DML, DCL, TCL, rollbacks, Liquibase y Docker.

La base de datos debe quedar alineada con estas decisiones:

- Motor objetivo: PostgreSQL.
- Identificadores: UUID con `gen_random_uuid()`.
- Documentacion en espanol.
- Codigo SQL y nombres tecnicos preferiblemente en ingles cuando se creen o ajusten objetos.
- Eliminacion logica mediante `deleted_at` y `deleted_by`.
- Auditoria en tablas de negocio.
- Datos cargados en orden controlado, sin datos huerfanos.
- Usuario `ariel5253` con permisos controlados, sin permisos DCL.

## Dominios oficiales

| Dominio | Proposito |
|---------|-----------|
| Parametrizacion | Datos base como cliente, empresa, persona, empleado, metodos de pago, tipos de dia y precios. |
| Seguridad | Usuarios, roles, permisos, modulos y vistas del sistema. |
| Distribucion | Sedes, habitaciones, tipos de habitacion y estados de habitacion. |
| Prestacion de servicio | Reservas, disponibilidad, estadias, check in y check out. |
| Inventario | Proveedores, productos, servicios, disponibilidad y movimientos. |
| Facturacion | Prefacturas, pagos, facturas y detalles de compra. |
| Notificacion | Promociones, alertas, terminos y fidelizacion. |
| Mantenimiento | Mantenimientos de habitaciones y tableros operativos. |

## Equipo y responsabilidades

| Integrante | Rol | Responsabilidades principales |
|------------|-----|-------------------------------|
| Nicolas Estid Ruiz Sastoque | Lider del proyecto y desarrollador | Liderar decisiones tecnicas, ADR, ambiente, Liquibase, DDL de parametrizacion/seguridad, DCL roles/grants y TCL. |
| Frenier Steven Cardona Perez | Desarrollador | Implementar DDL y DML restantes por dominio, apoyar datos poblados, rollbacks y policies. |
| Brayan Perdomo | Desarrollador | Trabajar repositorio, planeacion, analisis de dominios, DDL de distribucion/prestacion y DML asociado. |
| Emily Sharith Amezquita Saavedra | QA | Cubrir automatizacion, DDL base, objetos avanzados, triggers, indices, smoke test y validacion final. |

## Tablero de responsabilidades

| Bloque | HU | Responsable principal | Apoyo | QA |
|--------|----|----------------------|-------|----|
| Repositorio y documentacion inicial | HU-01 a HU-04 | Brayan / Nicolas | Emily | Emily |
| Ambiente y DDL base | HU-05 a HU-08 | Emily / Nicolas | Brayan | Emily |
| DDL por dominios | HU-09 a HU-12 | Nicolas / Brayan / Frenier | Emily | Emily |
| Objetos avanzados | HU-13 a HU-14 | Emily | Nicolas | Emily |
| DML | HU-15 a HU-18 | Frenier / Brayan | Nicolas | Emily |
| DCL y TCL | HU-19 a HU-22 | Nicolas / Frenier | Emily | Emily |
| Validacion final | HU-23 | Emily | Nicolas | Emily |


## Asignacion final por HU

| Responsable | Historias asignadas |
|-------------|---------------------|
| Nicolas Estid Ruiz Sastoque | HU-04, HU-06, HU-07, HU-09, HU-19, HU-20, HU-22 |
| Frenier Steven Cardona Perez | HU-11, HU-12, HU-15, HU-17, HU-18, HU-21 |
| Brayan Perdomo | HU-01, HU-02, HU-03, HU-10, HU-16 |
| Emily Sharith Amezquita Saavedra | HU-05, HU-08, HU-13, HU-14, HU-23 |
## Evidencias esperadas

| Bloque | Evidencia minima |
|--------|------------------|
| Repositorio | Ramas `main`, `qa` y `dev`; PRs por HU. |
| Documentacion | HU, ADR, DoR/DoD, dominios, plan y seguimiento. |
| Ambiente | Docker Compose ejecutando PostgreSQL y Liquibase. |
| Modelo | Scripts DDL, changelogs, rollbacks y validacion de FKs. |
| Datos | DML ejecutado en orden seguro. |
| Seguridad | Usuario `ariel5253`, roles, grants y policies. |
| Validacion | Smoke test ejecutado y resultado revisado por QA. |

## Documentos que quedan separados

- `plan_trabajo_inicial.md`: se mantiene separado porque corresponde al plan de trabajo de la HU.
- `seguimientos.md`: se mantiene separado porque corresponde al seguimiento diario de la HU.
- `Historias de usuario.md`: se mantiene separado porque es el backlog tecnico principal.
- `analisis_dominios.md`: se mantiene separado porque es evidencia de analisis.
- `ADR/`: se mantiene separado porque contiene decisiones tecnicas formales.


