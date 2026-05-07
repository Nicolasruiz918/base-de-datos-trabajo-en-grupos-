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
| Nicolas Estid Ruiz Sastoque | Lider del proyecto y desarrollador | Coordinar la entrega, revisar consistencia documental, validar ramas, apoyar infraestructura y ADR. |
| Frenier Steven Cardona Perez | Desarrollador | Apoyar DML, DCL, datos poblados, rollbacks y validacion de permisos. |
| Brayan Perdomo | Desarrollador | Implementar DDL por dominios, FKs, objetos avanzados y changelogs. |
| Emily Sharith Amezquita Saavedra | QA | Revisar DoR/DoD, smoke test, documentacion, trazabilidad y cierre de calidad. |

## Tablero de responsabilidades

| Bloque | HU | Responsable principal | Apoyo | QA |
|--------|----|----------------------|-------|----|
| Repositorio, plan y ADR | HU-01 a HU-04 | Nicolas | Emily | Emily |
| Ambiente y migraciones | HU-05 a HU-08 | Nicolas | Brayan | Emily |
| DDL por dominios | HU-09 a HU-12 | Brayan | Nicolas | Emily |
| Objetos avanzados | HU-13 a HU-14 | Brayan | Frenier | Emily |
| DML | HU-15 a HU-18 | Frenier | Brayan | Emily |
| DCL y TCL | HU-19 a HU-22 | Frenier | Nicolas | Emily |
| Validacion final | HU-23 | Emily | Nicolas | Emily |

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

