# ADR-001 - Migracion y estandarizacion de la base de datos en PostgreSQL

## Estado

Aceptado

## Contexto

La estructura inicial de base de datos venia orientada a MySQL, pero la entrega requiere trabajar con PostgreSQL. El cambio de motor no es solo un cambio de sintaxis: tambien afecta tipos de datos, extensiones, manejo de schemas, funciones, procedures, triggers, materialized views y estrategia de ejecucion con changelogs.

La entrega debe quedar organizada para que pueda ejecutarse, validarse y mantenerse en PostgreSQL sin crear dominios tecnicos adicionales.

## Problema

Si se mezcla sintaxis o convenciones de MySQL con PostgreSQL, pueden aparecer errores como:

- Tipos no nativos para PostgreSQL.
- Scripts dificiles de ejecutar con `psql` o Liquibase.
- Objetos avanzados mal separados.
- Falta de extensiones necesarias.
- Confusion entre dominios funcionales y configuracion tecnica.
- Rollbacks incompletos o sin trazabilidad.

Por eso se decide formalmente que el motor objetivo de la entrega es PostgreSQL.

## Decision

La base de datos se trabaja en PostgreSQL y se organiza en 8 dominios oficiales:

1. Parametrizacion
2. Distribucion
3. Prestacion de servicio
4. Facturacion
5. Inventario
6. Notificacion
7. Seguridad
8. Mantenimiento

La entrega no crea un noveno dominio tecnico. La configuracion compartida debe resolverse dentro de los dominios oficiales o mediante carpetas tecnicas de DDL, DML, DCL, TCL y rollbacks.

## Alternativas evaluadas

| Alternativa | Resultado |
|-------------|-----------|
| Mantener MySQL | Rechazado porque la entrega solicita PostgreSQL y se necesitan capacidades propias de este motor. |
| Convertir parcialmente a PostgreSQL | Rechazado porque deja riesgos de sintaxis y ejecucion mezclada. |
| Crear un schema tecnico `common` o `configuration` | Rechazado porque generaria un noveno dominio no solicitado. |
| Organizar PostgreSQL por 8 schemas funcionales | Aceptado porque respeta la documentacion y mantiene separacion clara por dominio. |

## Decisiones tecnicas asociadas

| Tema | Decision |
|------|----------|
| Motor | PostgreSQL 16 para ambiente Docker. |
| Extensiones | `pgcrypto` para `gen_random_uuid()` y `citext` para correos case-insensitive. |
| Schemas | Un schema por dominio funcional. |
| Changelogs | Maestro global y maestros por DDL, DML, DCL y TCL. |
| Ejecucion local | `docker compose up liquibase` como camino recomendado. |
| Ejecucion alternativa | `psql` usando `database/changelog-master.sql`. |
| Rollbacks | Estructura espejo en `05_rollbacks`. |

## Consecuencias

- No se usa carpeta `01_ddl/10_configuration`.
- Los types compartidos se ubican dentro de los dominios existentes.
- Cada view vive en archivo separado.
- Cada materialized view vive en archivo separado.
- Cada function vive en archivo separado.
- Cada procedure vive en archivo separado.
- Cada trigger vive en archivo separado.
- Liquibase debe apuntar a `database/changelog-master.yaml`.
- `psql` puede ejecutar `database/changelog-master.sql`.
- El usuario `ariel5253` puede autenticarse, pero no hereda `administrador`.

## Reglas de validacion

Para considerar cumplida esta decision:

- Deben existir exactamente 8 schemas funcionales.
- No debe existir schema tecnico adicional para configuracion.
- No debe existir `01_ddl/10_configuration`.
- Docker Compose debe levantar PostgreSQL y Liquibase.
- Los changelogs YAML deben apuntar a archivos existentes.
- Los rollbacks deben conservar estructura espejo.
- El smoke test debe validar schemas, tablas y datos base.

## Impacto en la entrega

Esta decision afecta:

- `01_ddl/00_extensions`
- `01_ddl/01_schemas`
- `01_ddl/02_types`
- `01_ddl/03_tables`
- `02_dml`
- `03_dcl`
- `04_tcl`
- `05_rollbacks`
- `database/docker-compose.yml`
- `liquibase.properties`
- `docs/entrega-base-datos`

