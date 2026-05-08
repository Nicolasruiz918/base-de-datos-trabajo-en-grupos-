# Historias de Usuario - Sistema de Gestion Hotelera

## Base de datos - PostgreSQL - UUID - Ingles

---

## Consideraciones transversales

- Base de datos objetivo en **PostgreSQL**.
- Identificadores tipo **UUID** con `gen_random_uuid()`.
- Nombres tecnicos de tablas, columnas, constraints, functions, procedures, triggers e indexes definidos con convencion en ingles cuando se creen o ajusten objetos.
- Documentacion del proyecto en espanol.
- Eliminacion logica mediante `deleted_at` y `deleted_by`.
- Campos de auditoria esperados en tablas de negocio: `id`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`, `status`.
- `created_at` debe tener valor por defecto `NOW()`.
- `id` debe ser llave primaria de tipo UUID.
- `status` debe tener valor controlado y documentado por modulo.
- Codigo SQL versionado por carpetas DDL, DML, DCL, TCL y rollbacks.
- Conventional commits en ingles: `feat`, `fix`, `docs`, `chore`.
- La data canonica y de prueba debe cargarse en orden controlado por Liquibase; los procesos operativos se encapsulan mediante stored procedures cuando aplique.
- El usuario de BD `ariel5253` solo puede tener permisos DDL/DML controlados y no permisos DCL.
- No deben existir datos huerfanos; todas las relaciones importantes deben estar protegidas con foreign keys.
- Cada historia que toque SQL debe incluir changelog y rollback cuando aplique.

---

## Resumen de historias

| HU    | Titulo                                                       | Bloque              | Prioridad   |
| ----- | ------------------------------------------------------------ | ------------------- | ----------- |
| HU-01 | Estructuracion del repositorio y ramas                       | Repositorio         | Must have   |
| HU-02 | Plan de trabajo y seguimiento del sprint                     | Documentacion       | Must have   |
| HU-03 | Analisis de dominios del sistema hotelero                    | Analisis            | Must have   |
| HU-04 | ADRs de decisiones tecnicas                                  | Arquitectura        | Must have   |
| HU-05 | Estructura de automatizacion GitHub Actions                  | Automatizacion      | Should have |
| HU-06 | Configuracion de Docker Compose y PostgreSQL                 | Ambiente            | Must have   |
| HU-07 | Configuracion de Liquibase                                   | Migraciones         | Must have   |
| HU-08 | Estructura base DDL: extensiones, schemas, types y auditoria | DDL base            | Must have   |
| HU-09 | DDL de parametrizacion y seguridad                           | DDL tablas          | Must have   |
| HU-10 | DDL de distribucion y prestacion de servicio                 | DDL tablas          | Must have   |
| HU-11 | DDL de inventario y facturacion                              | DDL tablas          | Must have   |
| HU-12 | DDL de notificacion y mantenimiento                          | DDL tablas          | Should have |
| HU-13 | Views, materialized views y functions                        | Objetos de consulta | Must have   |
| HU-14 | Procedures, triggers e indexes                               | Objetos de proceso  | Must have   |
| HU-15 | DML de parametrizacion y seguridad                           | DML                 | Must have   |
| HU-16 | DML de distribucion y prestacion de servicio                 | DML                 | Must have   |
| HU-17 | DML de inventario y facturacion                              | DML                 | Must have   |
| HU-18 | DML de notificacion y mantenimiento                          | DML                 | Should have |
| HU-19 | DCL de roles                                                 | DCL                 | Must have   |
| HU-20 | DCL de grants                                                | DCL                 | Must have   |
| HU-21 | DCL de policies                                              | DCL                 | Should have |
| HU-22 | TCL y recuperacion manual                                    | TCL                 | Should have |
| HU-23 | Validacion final y cierre de entrega                         | Validacion          | Must have   |

---

## HU-01 - Estructuracion del repositorio y ramas

**Como** equipo de desarrollo, **quiero** crear el repositorio Git con ramas `main`, `qa` y `dev`, **para** trabajar de forma ordenada desde desarrollo hasta entrega estable.

**Descripcion**

El proyecto debe iniciar con una estructura de control de versiones clara. La rama `dev` concentra el trabajo de desarrollo, `qa` recibe lo que sera validado por calidad y `main` conserva la version estable aprobada.

**Entregables**

- Repositorio GitHub creado.
- Ramas `main`, `qa` y `dev` configuradas.
- README inicial con alcance del proyecto.
- Convencion de ramas y commits documentada.

**Criterios de aceptacion**

- Existe el repositorio en GitHub.
- Existen las ramas `main`, `qa` y `dev`.
- La rama `dev` se usa para integrar historias de usuario.
- La rama `qa` se usa para validacion.
- La rama `main` queda reservada para la entrega estable.
- Los commits siguen Conventional Commits en ingles: `feat`, `fix`, `docs`, `chore`.

**Checklist**

- [ ] Crear repositorio en GitHub.
- [ ] Crear rama `dev` desde `main`.
- [ ] Crear rama `qa` desde `dev`.
- [ ] Configurar proteccion basica de `main` si aplica.
- [ ] Invitar colaboradores.
- [ ] Documentar flujo de trabajo en `flujo_git_por_historias.md`.

**Responsable sugerido:** Nicolas Estid Ruiz Sastoque

**Priorizacion MoSCoW:** Must have

---

## HU-02 - Plan de trabajo y seguimiento del sprint

**Como** equipo de desarrollo, **quiero** documentar el plan y seguimiento del sprint, **para** saber que se hara, quien lo hara y que evidencia se subira al repositorio.

**Descripcion**

La entrega debe ejecutarse en una semana. El plan define actividades por dia, responsables, entregables, evidencias y estado de avance. El seguimiento permite registrar bloqueos y decisiones durante el trabajo.

**Entregables**

- `docs/entrega-base-datos/plan_trabajo_inicial.md`.
- `docs/entrega-base-datos/seguimientos.md`.
- `docs/entrega-base-datos/gestion_equipo.md`.

**Criterios de aceptacion**

- El plan cubre la semana de trabajo completa.
- Las actividades quedan asociadas a HU tecnicas.
- Cada responsable tiene tareas definidas.
- El documento de seguimiento permite registrar avances, bloqueos y cierre.
- La documentacion no depende de `docs/planning` ni de `docs/architecture`.

**Checklist**

- [ ] Definir cronograma de una semana.
- [ ] Asignar responsables por bloque.
- [ ] Registrar evidencias esperadas por HU.
- [ ] Actualizar seguimiento diario.
- [ ] Revisar consistencia con el tablero de responsabilidades.

**Responsable sugerido:** Emily Sharith Amezquita Saavedra

**Priorizacion MoSCoW:** Must have

---

## HU-03 - Analisis de dominios del sistema hotelero

**Como** equipo de desarrollo, **quiero** documentar los dominios oficiales del sistema hotelero, **para** organizar la base de datos segun responsabilidades funcionales reales.

**Descripcion**

Se identifican los 8 dominios oficiales del sistema: parametrizacion, seguridad, distribucion, prestacion de servicio, inventario, facturacion, notificacion y mantenimiento. Cada dominio debe explicar su alcance, tablas relacionadas y dependencias con otros dominios.

**Entregables**

- `docs/entrega-base-datos/analisis_dominios.md`.
- `docs/entrega-base-datos/matriz_trazabilidad_hu.md`.

**Criterios de aceptacion**

- El documento muestra exactamente 8 dominios.
- No se separan dominios duplicados de parametrizacion.
- Cada dominio lista las tablas que le corresponden.
- Las relaciones entre dominios quedan explicadas.
- El lenguaje es tecnico y claro.

**Checklist**

- [ ] Revisar documentos base del sistema hotelero.
- [ ] Listar los 8 dominios oficiales.
- [ ] Asociar tablas por dominio.
- [ ] Documentar relaciones entre dominios.
- [ ] Validar que no existan dominios adicionales sin justificacion.

**Responsable sugerido:** Nicolas Estid Ruiz Sastoque

**Priorizacion MoSCoW:** Must have

---

## HU-04 - ADRs de decisiones tecnicas

**Como** equipo de desarrollo, **quiero** documentar las decisiones tecnicas mediante ADR, **para** dejar trazabilidad de por que se eligio PostgreSQL, UUID, auditoria, eliminacion logica e idioma tecnico.

**Descripcion**

Los ADR registran contexto, decision, alternativas evaluadas y consecuencias. En esta entrega justifican la migracion desde MySQL hacia PostgreSQL, el uso de UUID, los valores de estado, la auditoria, la politica de eliminacion, el idioma tecnico de la base, la separacion por dominios, el ambiente Docker con Liquibase y el uso de schemas por dominio.

**Entregables**

- `docs/entrega-base-datos/ADR/ADR-001-migracion-postgresql.md`.
- `docs/entrega-base-datos/ADR/ADR-002-identificadores-estados-auditoria-eliminacion.md`.
- `docs/entrega-base-datos/ADR/ADR-003-cambio-idioma-base-datos-ingles.md`.
- `docs/entrega-base-datos/ADR/ADR-004-separacion-base-datos-por-dominios.md`.
- `docs/entrega-base-datos/ADR/ADR-005-docker-compose-liquibase.md`.
- `docs/entrega-base-datos/ADR/ADR-006-uso-schemas-por-dominio.md`.

**Criterios de aceptacion**

- Cada ADR tiene contexto, decision y consecuencias.
- La decision PostgreSQL vs MySQL queda justificada.
- El uso de UUID queda explicado.
- La politica de eliminacion logica queda documentada.
- La decision de idioma tecnico en ingles queda registrada.
- La separacion de la base por dominios queda registrada.
- La implementacion con Docker Compose y Liquibase queda registrada.
- El uso de schemas PostgreSQL por dominio queda registrado.
- Los documentos estan en espanol.

**Checklist**

- [ ] Revisar decisiones tecnicas vigentes.
- [ ] Actualizar ADR de PostgreSQL.
- [ ] Actualizar ADR de UUID, status, auditoria y eliminacion.
- [ ] Actualizar ADR de idioma tecnico.
- [ ] Crear ADR de separacion por dominios.
- [ ] Crear ADR de Docker Compose con Liquibase.
- [ ] Crear ADR de schemas por dominio.
- [ ] Verificar que los ADR no contradigan la estructura real.

**Responsable sugerido:** Nicolas Estid Ruiz Sastoque

**Priorizacion MoSCoW:** Must have

---

## HU-05 - Estructura de automatizacion GitHub Actions

**Como** equipo de desarrollo, **quiero** preparar la estructura de automatizacion del repositorio, **para** que las validaciones puedan ejecutarse desde el flujo de integracion.

**Descripcion**

La historia define la ruta para integrar validaciones automaticas. Aunque la entrega principal es de base de datos, debe existir una convencion para ejecutar validaciones SQL, revision documental o pruebas futuras desde GitHub Actions si el instructor lo solicita.

**Entregables**

- Carpeta `.github/workflows` si aplica.
- Documento de flujo Git por historias.
- Convencion de validacion previa al Pull Request.

**Criterios de aceptacion**

- Existe una ruta definida para CI/CD.
- El flujo no rompe la ejecucion local con Docker y Liquibase.
- Las validaciones obligatorias quedan descritas aunque el workflow no se active todavia.
- La automatizacion se integra al flujo `dev -> qa -> main`.

**Checklist**

- [ ] Definir workflow base si aplica.
- [ ] Documentar validaciones minimas.
- [ ] Revisar que los comandos funcionen localmente.
- [ ] Relacionar la validacion con Pull Requests.

**Responsable sugerido:** Nicolas Estid Ruiz Sastoque

**Priorizacion MoSCoW:** Must have

---

## HU-06 - Configuracion de Docker Compose y PostgreSQL

**Como** equipo de desarrollo, **quiero** configurar PostgreSQL con Docker Compose, **para** ejecutar la base de datos de forma reproducible en el equipo.

**Descripcion**

El ambiente debe levantar una base PostgreSQL para `hotel_management`, con healthcheck, red, volumen persistente y conexion disponible para Liquibase. Esto evita diferencias entre equipos al ejecutar la entrega.

**Entregables**

- `entregables/estructura-base-datos/db-structure 1/docker/docker-compose.yml`.
- `entregables/estructura-base-datos/db-structure 1/liquibase.properties`.
- `docs/entrega-base-datos/guia_tecnica_ejecucion.md`.

**Criterios de aceptacion**

- PostgreSQL levanta con Docker.
- La base `hotel_management` queda disponible.
- El puerto local `25432` queda documentado.
- El healthcheck confirma que PostgreSQL esta listo.
- Liquibase puede conectarse al servicio `postgres`.

**Checklist**

- [ ] Configurar servicio `postgres`.
- [ ] Configurar volumen persistente.
- [ ] Configurar red Docker.
- [ ] Agregar healthcheck.
- [ ] Probar levantamiento del contenedor.
- [ ] Documentar comandos de ejecucion.

**Responsable sugerido:** Nicolas Estid Ruiz Sastoque

**Priorizacion MoSCoW:** Must have

---

## HU-07 - Configuracion de Liquibase

**Como** equipo de desarrollo, **quiero** configurar Liquibase, **para** ejecutar cambios DDL, DML, DCL, TCL y rollbacks en orden controlado.

**Descripcion**

Liquibase debe usar un changelog maestro global y changelogs maestros por bloque. La ejecucion debe respetar dependencias: extensiones, schemas, types, tablas, objetos avanzados, datos, permisos y transacciones.

**Entregables**

- `entregables/estructura-base-datos/db-structure 1/changelog/changelog-master.yaml`.
- `entregables/estructura-base-datos/db-structure 1/01_ddl/changelog-master.yaml`.
- `entregables/estructura-base-datos/db-structure 1/02_dml/changelog-master.yaml`.
- `entregables/estructura-base-datos/db-structure 1/03_dcl/changelog-master.yaml`.
- `entregables/estructura-base-datos/db-structure 1/04_tcl/changelog-master.yaml`.
- `entregables/estructura-base-datos/db-structure 1/liquibase.properties`.

**Criterios de aceptacion**

- Existe changelog maestro global.
- Existen changelogs maestros por DDL, DML, DCL y TCL.
- Cada changeSet referencia su SQL y rollback cuando aplica.
- Liquibase ejecuta en una base limpia sin errores.
- El orden de ejecucion evita fallos por foreign keys.

**Checklist**

- [ ] Configurar `liquibase.properties`.
- [ ] Crear changelog maestro global.
- [ ] Crear maestros por bloque.
- [ ] Referenciar changelogs de carpetas hijas.
- [ ] Validar rutas relativas.
- [ ] Probar ejecucion con Docker.

**Responsable sugerido:** Nicolas Estid Ruiz Sastoque

**Priorizacion MoSCoW:** Must have

---

## HU-08 - Estructura base DDL: extensiones, schemas, types y auditoria

**Como** equipo de desarrollo, **quiero** separar extensiones, schemas, types y reglas base de auditoria, **para** que todas las tablas se creen con una base tecnica consistente.

**Descripcion**

Antes de crear tablas de negocio se deben habilitar extensiones necesarias, crear los 8 schemas oficiales y definir tipos de dominio. Tambien se documenta la regla transversal de auditoria para todas las tablas: `id`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at` y `status`.

**Entregables**

- `01_ddl/00_extensions/001_extensions.sql`.
- `01_ddl/01_schemas/001_schemas.sql`.
- `01_ddl/02_types/001_domain_types.sql`.
- Rollbacks equivalentes en `05_rollbacks/01_ddl`.

**Criterios de aceptacion**

- La extension `pgcrypto` queda habilitada para `gen_random_uuid()`.
- La extension `citext` queda habilitada si se usa correo o username insensible a mayusculas.
- Existen 8 schemas oficiales.
- Los tipos de dominio se crean antes de tablas.
- Las tablas usan UUID como identificador.
- La eliminacion logica se soporta con `deleted_at` y `deleted_by`.

**Checklist**

- [ ] Crear extension `pgcrypto`.
- [ ] Crear extension `citext`.
- [ ] Crear schemas oficiales.
- [ ] Crear types/enums necesarios.
- [ ] Documentar campos de auditoria.
- [ ] Crear rollbacks para extensions, schemas y types.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-09 - DDL de parametrizacion y seguridad

**Como** equipo de desarrollo, **quiero** crear las tablas de parametrizacion y seguridad, **para** soportar configuracion base, clientes, personas, usuarios, roles, permisos y accesos.

**Descripcion**

Esta historia agrupa los dominios de parametrizacion y seguridad. Parametrizacion contiene entidades base como cliente, empresa, persona, empleado, tipo de dia, metodo de pago y precio. Seguridad contiene usuario, rol, permiso, modulo, vista y tablas intermedias de relacion.

**Entregables**

- `01_ddl/03_tables/001_configuration.sql`.
- `01_ddl/03_tables/002_security.sql`.
- `01_ddl/03_tables/changelog.yaml`.
- Rollbacks de parametrizacion y seguridad.

**Criterios de aceptacion**

- Las tablas tienen UUID como PK.
- Todas las tablas tienen campos de auditoria.
- Las FKs quedan declaradas de forma explicita.
- No existen datos huerfanos posibles por falta de constraint.
- `usuario` o `system_user` almacena hash de password, no password plano.
- Las tablas intermedias tienen constraints de unicidad.

**Checklist**

- [ ] Crear tablas de parametrizacion.
- [ ] Crear tablas de seguridad.
- [ ] Agregar PK UUID.
- [ ] Agregar FKs explicitas.
- [ ] Agregar constraints unicos.
- [ ] Agregar campos de auditoria.
- [ ] Registrar changeSet y rollback.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-10 - DDL de distribucion y prestacion de servicio

**Como** equipo de desarrollo, **quiero** crear las tablas de distribucion y prestacion de servicio, **para** representar habitaciones, disponibilidad, reservas, estadias, check in y check out.

**Descripcion**

Distribucion representa la estructura fisica del hotel: sedes, habitaciones, tipos y estados. Prestacion de servicio representa el flujo principal del negocio desde la reserva hasta el cierre de la estadia.

**Entregables**

- `01_ddl/03_tables/003_distribution.sql`.
- `01_ddl/03_tables/004_service_delivery.sql`.
- `01_ddl/03_tables/changelog.yaml`.
- Rollbacks de distribucion y prestacion de servicio.

**Criterios de aceptacion**

- `room` o `habitacion` referencia sede, tipo y estado.
- La reserva referencia cliente y habitacion.
- La estadia referencia reserva, cliente y habitacion.
- Check in y check out referencian estadia y empleado.
- Las fechas tienen validaciones basicas.
- No se crean relaciones sin FK.

**Checklist**

- [ ] Crear tablas de distribucion.
- [ ] Crear tablas de prestacion de servicio.
- [ ] Validar FKs hacia parametrizacion.
- [ ] Validar FKs hacia distribucion.
- [ ] Agregar constraints de fechas y estados.
- [ ] Registrar changeSet y rollback.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-11 - DDL de inventario y facturacion

**Como** equipo de desarrollo, **quiero** crear las tablas de inventario y facturacion, **para** controlar productos, servicios, consumos, prefacturas, facturas y pagos.

**Descripcion**

Inventario gestiona proveedores, productos, servicios, stock y disponibilidad. Facturacion consolida valores generados por estadia, pagos parciales, factura final y detalle de compra.

**Entregables**

- `01_ddl/03_tables/005_inventory.sql`.
- `01_ddl/03_tables/006_billing.sql`.
- `01_ddl/03_tables/changelog.yaml`.
- Rollbacks de inventario y facturacion.

**Criterios de aceptacion**

- Los productos pueden referenciar proveedor.
- Los movimientos de inventario referencian producto.
- La facturacion referencia cliente, estadia, reserva y metodo de pago cuando aplica.
- Los valores monetarios usan `NUMERIC(12,2)` o precision equivalente.
- El detalle de compra evita referencias huerfanas.
- Las FKs funcionan en ejecucion limpia.

**Checklist**

- [ ] Crear tablas de inventario.
- [ ] Crear tablas de facturacion.
- [ ] Agregar FKs hacia prestacion de servicio.
- [ ] Agregar FKs hacia parametrizacion.
- [ ] Agregar constraints monetarios.
- [ ] Registrar changeSet y rollback.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-12 - DDL de notificacion y mantenimiento

**Como** equipo de desarrollo, **quiero** crear las tablas de notificacion y mantenimiento, **para** registrar comunicaciones, fidelizacion, terminos, alertas e intervenciones operativas de habitaciones.

**Descripcion**

Notificacion conserva promociones, alertas, terminos y fidelizacion. Mantenimiento registra habitaciones fuera de servicio, actividades de uso, remodelacion y tableros operativos por sede.

**Entregables**

- `01_ddl/03_tables/007_notification.sql`.
- `01_ddl/03_tables/008_maintenance.sql`.
- `01_ddl/03_tables/changelog.yaml`.
- Rollbacks de notificacion y mantenimiento.

**Criterios de aceptacion**

- Las alertas pueden referenciar cliente y opcionalmente reserva.
- La fidelizacion referencia cliente.
- El mantenimiento referencia habitacion, sede o responsable segun corresponda.
- Una habitacion en mantenimiento puede identificarse para no operar como disponible.
- Todas las tablas tienen auditoria.
- Las FKs quedan alineadas con dominios previos.

**Checklist**

- [ ] Crear tablas de notificacion.
- [ ] Crear tablas de mantenimiento.
- [ ] Validar relaciones con cliente, reserva, sede y habitacion.
- [ ] Agregar constraints de estado.
- [ ] Registrar changeSet y rollback.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-13 - Views, materialized views y functions

**Como** equipo de desarrollo, **quiero** crear vistas, vistas materializadas y funciones, **para** consultar informacion consolidada y calcular procesos sin duplicar logica.

**Descripcion**

Los objetos de consulta se crean despues de las tablas. Cada view, materialized view y function debe estar en archivo separado, con nombre claro, schema correspondiente y rollback individual.

**Entregables**

- `01_ddl/04_views`.
- `01_ddl/05_materialized_views`.
- `01_ddl/06_functions`.
- Changelogs y rollbacks de cada carpeta.

**Criterios de aceptacion**

- Cada objeto tiene un archivo propio.
- Las views compilan despues de las tablas requeridas.
- Las materialized views tienen refresh documentado cuando aplica.
- Las functions calculan procesos como noches, precio, stock o disponibilidad.
- No existen referencias a tablas inexistentes.
- Los rollbacks eliminan objetos en orden seguro.

**Checklist**

- [ ] Crear views por necesidad de consulta.
- [ ] Crear materialized views para reportes.
- [ ] Crear functions de calculo.
- [ ] Agregar changeSet por objeto.
- [ ] Agregar rollback por objeto.
- [ ] Validar compilacion con Liquibase.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-14 - Procedures, triggers e indexes

**Como** equipo de desarrollo, **quiero** crear stored procedures, triggers e indices, **para** ejecutar procesos controlados, disparar validaciones y optimizar consultas.

**Descripcion**

Los procedures encapsulan procesos como crear reserva, emitir factura, cerrar mantenimiento o registrar movimientos. Los triggers validan reglas criticas y los indices soportan busquedas, unicidad y `ON CONFLICT`.

**Entregables**

- `01_ddl/07_procedures`.
- `01_ddl/08_triggers`.
- `01_ddl/09_indexes`.
- Changelogs y rollbacks de cada carpeta.

**Criterios de aceptacion**

- Cada procedure esta en archivo separado.
- Cada trigger esta en archivo separado.
- Los triggers validan reglas de integridad antes o despues de operaciones criticas.
- Los indices necesarios para constraints, busquedas y upserts existen.
- Los objetos compilan con Liquibase.
- Las pruebas evitan reservas solapadas o estados inconsistentes cuando aplica.

**Checklist**

- [ ] Crear procedures de procesos principales.
- [ ] Crear triggers de validacion.
- [ ] Crear indices por FK, busqueda y unicidad.
- [ ] Agregar changeSet por objeto.
- [ ] Agregar rollback por objeto.
- [ ] Validar ejecucion en base limpia.

**Responsable sugerido:** Brayan Perdomo

**Priorizacion MoSCoW:** Must have

---

## HU-15 - DML de parametrizacion y seguridad

**Como** equipo de desarrollo, **quiero** cargar datos base de parametrizacion y seguridad, **para** que la base tenga catalogos minimos, cliente/persona de prueba, roles y usuario inicial.

**Descripcion**

La carga debe respetar foreign keys y no generar datos huerfanos. Los datos canonicos deben quedar versionados en DML controlado por Liquibase y los procesos operativos deben quedar soportados por stored procedures cuando aplique.

**Entregables**

- `02_dml/00_inserts/001_configuration.sql`.
- `02_dml/00_inserts/002_security.sql`.
- `02_dml/00_inserts/changelog.yaml`.
- Rollbacks de DML correspondientes.

**Criterios de aceptacion**

- Los catalogos base se cargan en orden correcto.
- El usuario `ariel5253` queda disponible como dato/control de seguridad segun alcance.
- Los inserts o procedimientos no dejan datos huerfanos.
- Los datos usan `ON CONFLICT` o controles equivalentes cuando aplica.
- La carga se puede repetir sin romper por duplicados controlados.

**Checklist**

- [ ] Cargar empresa, persona, cliente y catalogos base.
- [ ] Cargar roles, permisos y modulos.
- [ ] Cargar usuario inicial.
- [ ] Validar FKs.
- [ ] Agregar rollback.
- [ ] Probar Liquibase desde base limpia.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-16 - DML de distribucion y prestacion de servicio

**Como** equipo de desarrollo, **quiero** cargar datos de distribucion y prestacion de servicio, **para** validar habitaciones, disponibilidad, reservas y estadias iniciales.

**Descripcion**

Los datos de distribucion dependen de empresa y catalogos previos. Los datos de reserva y estadia dependen de cliente, habitacion y estado. La carga debe seguir el orden padre-hijo para proteger las foreign keys.

**Entregables**

- `02_dml/00_inserts/003_distribution.sql`.
- `02_dml/00_inserts/004_service_delivery.sql`.
- `02_dml/00_inserts/changelog.yaml`.
- Rollbacks de DML correspondientes.

**Criterios de aceptacion**

- Tipos y estados de habitacion se cargan antes de habitaciones.
- Sedes se cargan despues de empresa.
- Habitaciones se cargan despues de sede, tipo y estado.
- Reservas se cargan despues de cliente y habitacion.
- Estadias se cargan despues de reserva.
- No hay datos huerfanos.

**Checklist**

- [ ] Cargar tipos de habitacion.
- [ ] Cargar estados de habitacion.
- [ ] Cargar sedes.
- [ ] Cargar habitaciones.
- [ ] Cargar reserva demo si aplica.
- [ ] Cargar estadia demo si aplica.
- [ ] Ejecutar validacion de FK.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-17 - DML de inventario y facturacion

**Como** equipo de desarrollo, **quiero** cargar datos de inventario y facturacion, **para** validar consumos, productos, servicios, prefacturas, pagos y facturas.

**Descripcion**

La carga de inventario debe ocurrir antes de consumos o facturacion. La facturacion depende de estadia, cliente, reserva y metodos de pago previamente cargados.

**Entregables**

- `02_dml/00_inserts/005_inventory.sql`.
- `02_dml/00_inserts/006_billing.sql`.
- `02_dml/00_inserts/changelog.yaml`.
- Rollbacks de DML correspondientes.

**Criterios de aceptacion**

- Proveedor se carga antes de producto.
- Producto y servicio se cargan antes de ventas o detalles.
- Prefactura referencia estadia, reserva y cliente existentes.
- Pago referencia metodo de pago existente.
- Factura y detalle no generan datos huerfanos.
- Los valores monetarios son positivos.

**Checklist**

- [ ] Cargar proveedores.
- [ ] Cargar productos y servicios.
- [ ] Cargar disponibilidad de inventario.
- [ ] Cargar prefactura si aplica.
- [ ] Cargar pago parcial si aplica.
- [ ] Validar relaciones de facturacion.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-18 - DML de notificacion y mantenimiento

**Como** equipo de desarrollo, **quiero** cargar datos de notificacion y mantenimiento, **para** validar terminos, fidelizacion, alertas y tablero operativo de habitaciones.

**Descripcion**

Los datos de notificacion dependen de clientes o reservas existentes cuando haya relacion. Los datos de mantenimiento dependen de sedes, habitaciones y responsables cargados previamente.

**Entregables**

- `02_dml/00_inserts/007_notification.sql`.
- `02_dml/00_inserts/008_maintenance.sql`.
- `02_dml/00_inserts/changelog.yaml`.
- Rollbacks de DML correspondientes.

**Criterios de aceptacion**

- Terminos y condiciones se cargan con version y vigencia.
- Fidelizacion referencia cliente existente.
- Alertas no quedan asociadas a clientes o reservas inexistentes.
- Dashboard o mantenimiento referencia sede/habitacion valida.
- No existen datos huerfanos.
- La carga respeta el orden de dependencias.

**Checklist**

- [ ] Cargar terminos y condiciones.
- [ ] Cargar fidelizacion.
- [ ] Cargar alertas si aplica.
- [ ] Cargar dashboard o registros de mantenimiento.
- [ ] Validar FKs.
- [ ] Agregar rollback.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-19 - DCL de roles

**Como** equipo de desarrollo, **quiero** crear roles controlados de base de datos, **para** separar administracion, desarrollo, QA y usuario de ejecucion.

**Descripcion**

La seguridad debe diferenciar roles de base y usuario controlado. El usuario `ariel5253` debe poder autenticarse con password `ariel5253`, pero no debe tener capacidad DCL ni crear administradores.

**Entregables**

- `03_dcl/00_roles/001_roles.sql`.
- `03_dcl/00_roles/changelog.yaml`.
- Rollback de roles.

**Criterios de aceptacion**

- Existen roles definidos para administracion, desarrollo, QA y usuario controlado segun alcance.
- Existe el usuario `ariel5253` con password `ariel5253`.
- `ariel5253` no hereda permisos de administrador.
- No tiene `GRANT OPTION`.
- No puede crear nuevos administradores.

**Checklist**

- [ ] Crear roles base.
- [ ] Crear usuario `ariel5253`.
- [ ] Asignar rol controlado.
- [ ] Evitar herencia de administrador.
- [ ] Agregar rollback.
- [ ] Documentar permisos esperados.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-20 - DCL de grants

**Como** equipo de desarrollo, **quiero** asignar permisos controlados, **para** que cada rol pueda ejecutar solo las operaciones necesarias sobre schemas y tablas.

**Descripcion**

Los grants deben permitir DDL y DML donde corresponda, sin habilitar operaciones DCL para el usuario controlado. La asignacion se realiza despues de que schemas y tablas existen.

**Entregables**

- `03_dcl/01_grants/001_grants.sql`.
- `03_dcl/01_grants/changelog.yaml`.
- Rollback de grants.

**Criterios de aceptacion**

- Los roles tienen permisos sobre schemas necesarios.
- Los roles tienen permisos DML sobre tablas necesarias.
- Los permisos DDL quedan controlados segun el alcance.
- `ariel5253` no puede ejecutar `GRANT` ni `REVOKE`.
- Los permisos se pueden revertir con rollback.

**Checklist**

- [ ] Otorgar USAGE/CREATE segun schema.
- [ ] Otorgar SELECT/INSERT/UPDATE/DELETE segun rol.
- [ ] Evitar `WITH GRANT OPTION`.
- [ ] Probar permisos basicos.
- [ ] Agregar rollback.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-21 - DCL de policies

**Como** equipo de desarrollo, **quiero** preparar policies de seguridad sobre tablas sensibles, **para** controlar lectura y escritura segun roles autorizados.

**Descripcion**

Las policies permiten dejar una base para Row Level Security o reglas de acceso controlado en tablas sensibles. Deben crearse despues de roles, grants y tablas.

**Entregables**

- `03_dcl/02_policies/001_rls_policies.sql`.
- `03_dcl/02_policies/changelog.yaml`.
- Rollback de policies.

**Criterios de aceptacion**

- Las policies se crean sobre tablas existentes.
- Las policies referencian roles existentes.
- Las tablas sensibles quedan identificadas.
- El script no rompe ejecucion si se corre en orden Liquibase.
- Existe rollback para deshabilitar o eliminar policies.

**Checklist**

- [ ] Identificar tablas sensibles.
- [ ] Habilitar RLS cuando aplique.
- [ ] Crear policies por rol.
- [ ] Probar ejecucion de script.
- [ ] Agregar rollback.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-22 - TCL y recuperacion manual

**Como** equipo de desarrollo, **quiero** documentar y crear scripts transaccionales, **para** ejecutar operaciones controladas y tener rutas de recuperacion manual.

**Descripcion**

Los scripts TCL agrupan operaciones que deben comportarse como una unidad. Tambien se documenta la recuperacion manual o refresh de vistas materializadas cuando aplique.

**Entregables**

- `04_tcl/00_transaction_blocks`.
- `04_tcl/01_manual_recovery`.
- `04_tcl/changelog-master.yaml`.
- Rollbacks de TCL si aplican.

**Criterios de aceptacion**

- Los bloques transaccionales usan `BEGIN`, `COMMIT` y `ROLLBACK` donde corresponde.
- Las operaciones respetan FKs y orden de datos.
- Las recuperaciones manuales estan documentadas.
- El refresh de materialized views queda explicado si aplica.
- El changelog TCL se integra al maestro global.

**Checklist**

- [ ] Crear bloque transaccional principal.
- [ ] Crear script de recuperacion manual.
- [ ] Documentar cuando ejecutar cada script.
- [ ] Referenciar en changelog.
- [ ] Validar que no rompa ejecucion completa.

**Responsable sugerido:** Frenier Steven Cardona Perez

**Priorizacion MoSCoW:** Must have

---

## HU-23 - Validacion final y cierre de entrega

**Como** QA del proyecto, **quiero** validar la ejecucion completa de la base de datos y la documentacion, **para** confirmar que la entrega queda lista y estable en `main`.

**Descripcion**

La validacion final ejecuta Docker, Liquibase y smoke test sobre una base limpia. Tambien revisa que documentos, changelogs, rollbacks, DDL, DML, DCL y TCL esten alineados.

**Entregables**

- `entregables/estructura-base-datos/db-structure 1/scripts/smoke-test.sql`.
- `docs/entrega-base-datos/guia_tecnica_ejecucion.md`.
- Evidencia de ejecucion de Liquibase y smoke test.

**Criterios de aceptacion**

- Docker Compose levanta PostgreSQL.
- Liquibase ejecuta todos los changeSets sin errores.
- El smoke test retorna conteos esperados.
- Las foreign keys existen y no permiten datos huerfanos.
- La documentacion no contradice la estructura del entregable.
- La rama `main` queda como version estable.

**Checklist**

- [ ] Ejecutar `docker-compose down -v`.
- [ ] Ejecutar Liquibase desde base limpia.
- [ ] Ejecutar smoke test.
- [ ] Validar cantidad de schemas y tablas.
- [ ] Validar foreign keys.
- [ ] Revisar README, HU, ADR y guia de ejecucion.
- [ ] Preparar PR final hacia `main`.

**Responsable sugerido:** Emily Sharith Amezquita Saavedra

**Priorizacion MoSCoW:** Must have

---



