# Planning de base de datos - Estructura PostgreSQL para sistema hotelero

## 1. Resumen ejecutivo

| Campo           | Definicion                                                                                            |
| --------------- | ----------------------------------------------------------------------------------------------------- |
| Proyecto        | Sistema de gestion hotelera                                                                           |
| Entrega         | Estructura funcional de base de datos                                                                 |
| Motor objetivo  | PostgreSQL                                                                                            |
| Base objetivo   | `sistema_hotelero`                                                                                  |
| Fuente inicial  | `docs/architecture/model-data/es`                                                                   |
| Fuente ajustada | Documentacion revisada en `docs/entrega-base-datos`                                                 |
| Objetivo        | Dejar una base organizada, documentada, ejecutable por changelog y alineada con 8 dominios oficiales. |

Este documento es la version Markdown del planning de trabajo para la entrega de base de datos. A diferencia del HTML ubicado en `docs/planning/index.html`, este archivo no describe solo el alcance general desde architecture: consolida lo que se reviso y corrigio para la estructura PostgreSQL.

## 2. Alcance confirmado

La entrega cubre la organizacion tecnica de la base de datos, la documentacion de planeacion y la trazabilidad de HU.

| Incluido      | Resultado esperado                                                                                         |
| ------------- | ---------------------------------------------------------------------------------------------------------- |
| DDL           | Extensiones, schemas, types, tablas, views, materialized views, functions, procedures, triggers e indexes. |
| DML           | Inserts, updates, deletes, upserts y patches separados por carpeta.                                        |
| DCL           | Roles, grants y policies.                                                                                  |
| TCL           | Bloques transaccionales y recuperaciones manuales.                                                         |
| Rollbacks     | Misma estructura espejo de DDL, DML, DCL y TCL.                                                            |
| Documentacion | HU, DoR/DoD, ADR, roles, tablero, orden de carga y guia de validacion.                                     |

Fuera de alcance para esta entrega:

- Crear un noveno dominio tecnico.
- Mantener una carpeta `01_ddl/10_configuration`.
- Separar parametrizacion en `parametrizacion_core` y `parametrizacion_precio`.
- Unir notificacion y mantenimiento en un solo dominio.

## 3. Dominios oficiales

La base queda organizada en 8 dominios. Estos dominios deben coincidir entre schemas, tablas, DML, HU y documentacion.

| Dominio                | Schema PostgreSQL       | Proposito                                                                        |
| ---------------------- | ----------------------- | -------------------------------------------------------------------------------- |
| Parametrizacion        | `parametrizacion`     | Clientes, personas, empresa, empleados, metodos de pago, tipos de dia y precios. |
| Distribucion           | `distribucion`        | Sedes, habitaciones, tipos, estados, catalogo y disponibilidad.                  |
| Prestacion de servicio | `prestacion_servicio` | Reservas, cancelaciones, estadias, check in y check out.                         |
| Facturacion            | `facturacion`         | Pre factura, factura, pagos parciales y detalle de compra.                       |
| Inventario             | `inventario`          | Proveedores, productos, servicios, ventas, seguimiento y disponibilidad.         |
| Notificacion           | `notificacion`        | Promociones, alertas, terminos, condiciones y fidelizacion.                      |
| Seguridad              | `seguridad`           | Usuarios, roles, permisos, modulos y relaciones de acceso.                       |
| Mantenimiento          | `mantenimiento`       | Mantenimiento de habitacion, uso, remodelacion y dashboard operativo.            |

## 4. Decision tecnica principal

| Decision                                | Resultado                                                                                 |
| --------------------------------------- | ----------------------------------------------------------------------------------------- |
| Migrar el enfoque de MySQL a PostgreSQL | Se creo ADR-001 y la estructura queda preparada para PostgreSQL.                          |
| Usar solo 8 schemas funcionales         | No se crea schema `common` ni dominio tecnico adicional.                                |
| Separar objetos avanzados por archivo   | Cada view, materialized view, function, procedure y trigger tiene su propio `.sql`.     |
| Separar DML por tipo de operacion       | Inserts, updates, deletes, upserts y patches viven en carpetas distintas.                 |
| Controlar acceso de Ariel               | `ariel5253` puede autenticarse con permisos controlados, sin heredar `administrador`. |
| Crear rollback espejo                   | `05_rollbacks` replica la estructura de DDL, DML, DCL y TCL.                            |

## 5. Equipo y responsabilidades

| Persona                          | Rol                                | Responsabilidades principales                                                                         |
| -------------------------------- | ---------------------------------- | ----------------------------------------------------------------------------------------------------- |
| Nicolas Estid Ruiz Sastoque      | Lider del proyecto / Desarrollador | Priorizar HU, coordinar tablero, validar alcance, apoyar infraestructura y aprobar cierre documental. |
| Emily Sharith Amezquita Saavedra | QA                                 | Validar criterios de aceptacion, revisar evidencias, smoke test y cierre DoD.                         |
| Brayan Perdomo                   | Desarrollador                      | Implementar modelo DDL, tablas por dominio, procedures, triggers, indexes y DCL.                      |
| Frenier Steven Cardona Perez     | Desarrollador                      | Implementar DML, apoyar carga de datos, TCL y ajustes de documentacion tecnica.                       |

## 6. DoR y DoD

### Definition of Ready

Una HU puede iniciar cuando cumple:

- Tiene objetivo claro.
- Tiene responsable.
- Tiene dependencias identificadas.
- Tiene entregable esperado.
- Tiene criterio de aceptacion verificable.

### Definition of Done

Una HU queda terminada cuando cumple:

- El archivo o carpeta comprometida existe.
- El cambio respeta los 8 dominios oficiales.
- Los objetos avanzados se encuentran en archivo individual.
- El changelog maestro referencia los archivos actuales.
- La documentacion y el tablero quedan actualizados.

### DoD final de la entrega

- `changelog/changelog-master.sql` actualizado.
- DDL, DML, DCL, TCL y rollbacks organizados.
- Usuario `ariel5253` documentado con permisos controlados.
- ADR de migracion a PostgreSQL creado.
- Smoke test o guia de validacion documentada.

## 7. Priorizacion MoSCoW

| Prioridad   | HU                                    | Justificacion                                                                            |
| ----------- | ------------------------------------- | ---------------------------------------------------------------------------------------- |
| Must Have   | HU-1, HU-2, HU-3, HU-4                | Repositorio, base documental, dominios y ADR para iniciar el trabajo.                    |
| Must Have   | HU-6, HU-8, HU-9, HU-10, HU-11, HU-12 | Estructura PostgreSQL, dominios oficiales y tablas por parejas de dominios.              |
| Must Have   | HU-13, HU-14                          | Objetos avanzados necesarios para reportes, calculos y validaciones.                     |
| Must Have   | HU-15, HU-16, HU-17, HU-18            | Datos poblados por parejas de dominios para pruebas iniciales.                           |
| Must Have   | HU-19, HU-20, HU-21                   | Seguridad, roles, grants y policies.                                                     |
| Must Have   | HU-23                                 | Validacion final de estructura y documentacion.                                          |
| Should Have | HU-5, HU-7, HU-22                     | Automatizacion, Liquibase y TCL fortalecen la entrega, pero dependen del cierre tecnico. |

## 8. Backlog organizado

### Planificacion e infraestructura

| HU   | Historia                                                            | Responsable                      | Estado  |
| ---- | ------------------------------------------------------------------- | -------------------------------- | ------- |
| HU-1 | Crear repositorio Git con ramas `main`, `qa` y `dev`.         | Nicolas Estid Ruiz Sastoque      | Ready   |
| HU-2 | Crear plan de trabajo y documento de seguimiento.                   | Emily Sharith Amezquita Saavedra | Ready   |
| HU-3 | Identificar dominios.                                               | Nicolas Estid Ruiz Sastoque      | Ready   |
| HU-4 | Crear ADRs.                                                         | Nicolas Estid Ruiz Sastoque      | Ready   |
| HU-5 | Estructura GitHub Actions.                                          | Nicolas Estid Ruiz Sastoque      | Backlog |
| HU-6 | Agregar Docker Compose y PostgreSQL.                                | Nicolas Estid Ruiz Sastoque      | Ready   |
| HU-7 | Agregar Liquibase.                                                  | Nicolas Estid Ruiz Sastoque      | Backlog |
| HU-8 | Separacion de DDL e implementacion de extensiones, schemas y types. | Brayan Perdomo                   | Ready   |

### Modelo de datos

| HU    | Historia                                                                  | Responsable                 | Estado |
| ----- | ------------------------------------------------------------------------- | --------------------------- | ------ |
| HU-9  | Implementacion de tablas dominio: parametrizacion y seguridad.            | Brayan Perdomo              | Ready  |
| HU-10 | Implementacion de tablas dominio: distribucion y prestacion de servicios. | Brayan Perdomo              | Ready  |
| HU-11 | Implementacion de tablas dominio: inventario y facturacion.               | Brayan Perdomo              | Ready  |
| HU-12 | Implementacion de tablas dominio: notificacion y mantenimiento.           | Brayan Perdomo              | Ready  |
| HU-13 | Crear views, materialized views y functions.                              | Nicolas Estid Ruiz Sastoque | Ready  |
| HU-14 | Crear procedures, triggers e indices.                                     | Brayan Perdomo              | Ready  |

### Carga de datos y seguridad

| HU    | Historia                                                  | Responsable                  | Estado |
| ----- | --------------------------------------------------------- | ---------------------------- | ------ |
| HU-15 | Crear DML insert: parametrizacion y seguridad.            | Frenier Steven Cardona Perez | Ready  |
| HU-16 | Crear DML insert: distribucion y prestacion de servicios. | Frenier Steven Cardona Perez | Ready  |
| HU-17 | Crear DML insert: inventario y facturacion.               | Frenier Steven Cardona Perez | Ready  |
| HU-18 | Crear DML insert: notificacion y mantenimiento.           | Frenier Steven Cardona Perez | Ready  |
| HU-19 | Crear DCL roles con permisos controlados para Ariel.      | Brayan Perdomo               | Ready  |
| HU-20 | DCL grants.                                               | Brayan Perdomo               | Ready  |
| HU-21 | DCL policies.                                             | Brayan Perdomo               | Ready  |
| HU-22 | Crear TCL.                                                | Nicolas Estid Ruiz Sastoque  | Ready  |

### Validacion final

| HU    | Historia                                                   | Responsable                      | Estado  |
| ----- | ---------------------------------------------------------- | -------------------------------- | ------- |
| HU-23 | Verificar que todo este funcional y revisar documentacion. | Emily Sharith Amezquita Saavedra | Backlog |

## 9. Tablero tipo Azure, Trello o ClickUp

Columnas sugeridas:

1. Backlog
2. Ready
3. In Progress
4. Review
5. QA / Validacion
6. Done
7. Blocked

| Bloque                          | HU            | Responsable principal | Evidencia                                                             |
| ------------------------------- | ------------- | --------------------- | --------------------------------------------------------------------- |
| Planificacion e infraestructura | HU-1 a HU-8   | Nicolas / Emily       | Documentos base, ADR, Docker, PostgreSQL y estructura inicial.        |
| Modelo de datos                 | HU-9 a HU-14  | Brayan / Nicolas      | DDL separado por parejas de dominios y objetos avanzados por archivo. |
| Carga de datos y seguridad      | HU-15 a HU-22 | Frenier / Brayan      | DML, DCL, TCL y permisos controlados.                                 |
| Validacion final                | HU-23         | Emily                 | Smoke test, revision documental y evidencias de cierre.               |

## 10. Cronograma de una semana

La entrega completa se organiza para ejecutarse en una sola semana de trabajo.

| Dia   | HU            | Actividades                                                                                           | Entregable                           |
| ----- | ------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------ |
| Dia 1 | HU-1 a HU-4   | Repositorio Git, planeacion, seguimiento, dominios y ADR.                                             | Documentacion inicial aprobada.      |
| Dia 2 | HU-5 a HU-8   | Infraestructura, PostgreSQL, Liquibase y base DDL.                                                    | Estructura base de proyecto.         |
| Dia 3 | HU-9 a HU-14  | Tablas por parejas de dominios, views, materialized views, functions, procedures, triggers e indexes. | Modelo de datos organizado.          |
| Dia 4 | HU-15 a HU-22 | Datos poblados, roles, grants, policies y TCL.                                                        | Base con datos y seguridad inicial.  |
| Dia 5 | HU-23         | Validacion final, revision cruzada y cierre documental.                                               | Main estabilizado con documentacion. |

## 11. Estructura de base de datos

```text
01_ddl/
  00_extensions/
  01_schemas/
  02_types/
  03_tables/
  04_views/
  05_materialized_views/
  06_functions/
  07_procedures/
  08_triggers/
  09_indexes/
02_dml/
  00_inserts/
  01_updates/
  02_deletes/
  03_upserts/
  04_patches/
03_dcl/
  00_roles/
  01_grants/
  02_policies/
04_tcl/
  00_transaction_blocks/
  01_manual_recoveries/
05_rollbacks/
  01_ddl/
  02_dml/
  03_dcl/
  04_tcl/
changelog/
docker/
scripts/
```

## 12. Objetos implementados

| Tipo                           | Cantidad | Regla de organizacion             |
| ------------------------------ | -------- | --------------------------------- |
| Archivos de tablas por dominio | 8        | Un archivo por dominio oficial.   |
| Views                          | 5        | Un archivo por view.              |
| Materialized views             | 2        | Un archivo por materialized view. |
| Functions                      | 5        | Un archivo por function.          |
| Procedures                     | 5        | Un archivo por procedure.         |
| Triggers                       | 6        | Un archivo por trigger.           |
| DML inserts                    | 8        | Un archivo por dominio oficial.   |

Orden final de inserts:

1. `001_parametrizacion.sql`
2. `002_seguridad.sql`
3. `003_distribucion.sql`
4. `004_prestacion_servicio.sql`
5. `005_inventario.sql`
6. `006_facturacion.sql`
7. `007_notificacion.sql`
8. `008_mantenimiento.sql`

## 13. Seguridad y autenticacion

| Elemento          | Definicion                                                               |
| ----------------- | ------------------------------------------------------------------------ |
| Rol administrador | Rol con permisos amplios para administracion controlada.                 |
| Rol desarrollador | Rol con permisos operativos sobre DDL/DML segun grants definidos.        |
| Rol QA            | Rol orientado a validacion y consulta.                                   |
| Usuario Ariel     | `ariel5253`                                                            |
| Password Ariel    | `ariel5253`                                                            |
| Restriccion       | Ariel no debe heredar `administrador` ni crear nuevos administradores. |

## 14. Rollback

La carpeta `05_rollbacks` debe mantener la misma logica de organizacion de la estructura principal:

| Bloque | Rollback                                                                                                                     |
| ------ | ---------------------------------------------------------------------------------------------------------------------------- |
| DDL    | Drop/reversas para extensions, schemas, types, tables, views, materialized views, functions, procedures, triggers e indexes. |
| DML    | Reversas para inserts, updates, deletes, upserts y patches.                                                                  |
| DCL    | Reversas para roles, grants y policies.                                                                                      |
| TCL    | Notas y bloques para recuperacion transaccional.                                                                             |

## 15. Validacion final

Checklist de cierre:

- Las HU deben permanecer en 21 historias.
- Los schemas deben permanecer en 8 dominios oficiales.
- No deben existir referencias a `parametrizacion_core` o `parametrizacion_precio`.
- No debe existir carpeta `01_ddl/10_configuration`.
- El changelog maestro debe referenciar archivos existentes.
- Notificacion y mantenimiento deben conservarse como dominios separados.
- DML y rollback deben mantener estructura espejo y trazable.
- La autenticacion de `ariel5253` debe quedar documentada con permisos controlados.

## 16. Riesgos y recomendaciones

| Riesgo                                                              | Mitigacion                                                       |
| ------------------------------------------------------------------- | ---------------------------------------------------------------- |
| Cambiar nombres de dominios rompe HU, DML y rollbacks.              | Mantener la lista oficial de 8 dominios como referencia.         |
| Agregar configuracion tecnica como dominio genera un noveno schema. | Usar types dentro de dominios existentes y evitar `common`.    |
| Mezclar notificacion y mantenimiento confunde el alcance.           | Mantener archivos y schemas separados para ambos dominios.       |
| No tener PostgreSQL local impide prueba real con `psql`.          | Instalar PostgreSQL o ejecutar en Docker antes del cierre final. |
| Permisos excesivos para Ariel generan riesgo de seguridad.          | Conservar grants controlados y no asignar `administrador`.     |

## 17. Referencias internas

- `docs/entrega-base-datos/Historias de usuario.md`
- `docs/entrega-base-datos/dor_dod.md`
- `docs/entrega-base-datos/roles_equipo.md`
- `docs/entrega-base-datos/tablero_azure_trello_clickup.csv`
- `docs/entrega-base-datos/ADR/ADR-001-migracion-postgresql.md`
- `entregables/estructura-base-datos/db-structure 1/changelog/changelog-master.sql`
