# Matriz de trazabilidad - HU tecnicas

## Proposito

Esta matriz relaciona las historias de usuario tecnicas con dominios, entregables y dependencias. La entrega se trabajara unicamente por HU tecnicas para mantener el orden de dependencias.

## Lectura rapida

- `HU-01` a `HU-04`: preparan repositorio, documentacion, dominios y decisiones.
- `HU-05` a `HU-08`: preparan automatizacion, Docker, Liquibase y DDL base.
- `HU-09` a `HU-12`: crean tablas por dominios.
- `HU-13` a `HU-14`: crean objetos avanzados.
- `HU-15` a `HU-18`: cargan datos en orden seguro.
- `HU-19` a `HU-22`: crean permisos, policies y transacciones.
- `HU-23`: separa documentacion y base de datos para repositorios diferentes.
- `HU-24`: valida la ejecucion completa y cierre documental.

## Trazabilidad por bloque

| Bloque | HU | Entregables principales | Dependencia clave |
|--------|----|-------------------------|-------------------|
| Repositorio | HU-01 | Repositorio, ramas `main`, `qa`, `dev` | Ninguna |
| Documentacion | HU-02 | Plan, seguimiento, planning, roles | HU-01 |
| Analisis | HU-03 | `analisis_dominios.md`, matriz de trazabilidad | HU-02 |
| ADR | HU-04 | ADR PostgreSQL, UUID/auditoria, idioma tecnico, dominios, Docker/Liquibase y schemas | HU-03 |
| Automatizacion | HU-05 | `.github/workflows` si aplica | HU-01 |
| Ambiente | HU-06 | Docker Compose, PostgreSQL, Liquibase properties | HU-01 |
| Liquibase | HU-07 | Changelog maestro global y por bloques | HU-06 |
| DDL base | HU-08 | Extensions, schemas, types | HU-07 |
| Tablas | HU-09 | Parametrizacion y seguridad | HU-08 |
| Tablas | HU-10 | Distribucion y prestacion de servicio | HU-09 |
| Tablas | HU-11 | Inventario y facturacion | HU-10 |
| Tablas | HU-12 | Notificacion y mantenimiento | HU-10 |
| Objetos consulta | HU-13 | Views, materialized views, functions | HU-09 a HU-12 |
| Objetos proceso | HU-14 | Procedures, triggers, indexes | HU-13 |
| DML | HU-15 | Datos parametrizacion y seguridad | HU-09 |
| DML | HU-16 | Datos distribucion y prestacion | HU-10, HU-15 |
| DML | HU-17 | Datos inventario y facturacion | HU-11, HU-16 |
| DML | HU-18 | Datos notificacion y mantenimiento | HU-12, HU-16 |
| DCL | HU-19 | Roles | HU-08 |
| DCL | HU-20 | Grants | HU-19, HU-09 |
| DCL | HU-21 | Policies | HU-20 |
| TCL | HU-22 | Bloques transaccionales y recuperacion | HU-15 a HU-18 |
| Estructura | HU-23 | Separacion `docs/` y `database/` para repositorios diferentes, ADR-007, README actualizado | HU-22 |
| Validacion | HU-24 | Smoke test, Liquibase, FKs y cierre documental | HU-01 a HU-23 |

## Regla de foreign keys

Las foreign keys no se rompen por subir archivos al repositorio. Se rompen si se ejecutan changelogs o inserts antes de sus dependencias. Por eso el orden de ejecucion debe ser:

1. Extensions.
2. Schemas.
3. Types.
4. Tables.
5. Functions, procedures, triggers, views e indexes.
6. DML en orden padre-hijo.
7. DCL.
8. TCL.
9. Separacion documental/base de datos.
10. Smoke test.

## Documentos de apoyo

- `Historias de usuario.md`
- `flujo_git_por_historias.md`
- `plan_subida_hu_tecnicas.csv`
- `guia_tecnica_ejecucion.md`
