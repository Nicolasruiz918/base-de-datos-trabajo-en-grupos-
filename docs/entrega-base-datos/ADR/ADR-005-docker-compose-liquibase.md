# ADR-005 - Implementacion del ambiente con Docker Compose y Liquibase

## Estado

Aceptado

## Contexto

La entrega debe poder ejecutarse de forma repetible por cualquier integrante del equipo o por el instructor. Para evitar diferencias entre instalaciones locales de PostgreSQL, se usa Docker Compose para levantar la base y Liquibase para aplicar los cambios versionados.

La base no se debe cargar manualmente archivo por archivo, porque eso aumenta el riesgo de omitir scripts, ejecutar en desorden o dejar cambios sin registrar.

## Problema

Sin un ambiente controlado pueden aparecer fallos como:

- Versiones diferentes de PostgreSQL entre equipos.
- Changelogs ejecutados parcialmente.
- Datos cargados antes de crear tablas o foreign keys.
- Falta de evidencia sobre que scripts se ejecutaron.
- Dificultad para reiniciar la base desde cero.

## Decision

Se implementa un ambiente con Docker Compose que levanta dos servicios:

| Servicio | Imagen | Responsabilidad |
|----------|--------|-----------------|
| `postgres` | `postgres:16` | Crear y exponer la base `hotel_management`. |
| `liquibase` | `liquibase/liquibase:4.25` | Ejecutar `database/changelog-master.yaml` contra PostgreSQL. |

La configuracion de Liquibase queda centralizada en `liquibase.properties`.

## Configuracion definida

| Elemento | Valor |
|----------|-------|
| Base de datos | `hotel_management` |
| Usuario administrador | `admin` |
| Password administrador | `admin123` |
| Puerto local | `25432` |
| Driver | `org.postgresql.Driver` |
| Changelog maestro | `database/changelog-master.yaml` |
| Contenedor PostgreSQL | `hotel_management_postgres` |
| Contenedor Liquibase | `hotel_management_liquibase` |

El servicio `liquibase` depende del healthcheck de `postgres`. Esto evita que Liquibase intente conectarse antes de que PostgreSQL este listo.

## Implementacion

La decision se refleja en:

- `database/docker-compose.yml`
- `liquibase.properties`
- `database/changelog-master.yaml`
- Changelogs maestros de `01_ddl`, `02_dml`, `03_dcl` y `04_tcl`
- `scripts/smoke-test.sql`

Comandos principales:

```bash
docker-compose down -v
docker-compose up --abort-on-container-exit liquibase
docker-compose exec postgres psql -U admin -d hotel_management
```

## Alternativas evaluadas

| Alternativa | Resultado |
|-------------|-----------|
| Ejecutar SQL manualmente con `psql` | Rechazado como camino principal porque depende demasiado del orden manual. |
| Usar solo Docker sin Liquibase | Rechazado porque no deja trazabilidad de changeSets. |
| Usar Liquibase instalado localmente | Permitido como alternativa, pero no como camino principal de la entrega. |
| Docker Compose con PostgreSQL y Liquibase | Aceptado por reproducibilidad, orden y evidencia de ejecucion. |

## Consecuencias

- La base se puede reconstruir desde cero con `docker-compose down -v`.
- Liquibase registra los changeSets aplicados en `databasechangelog`.
- El orden de ejecucion queda versionado.
- El instructor puede validar con los mismos comandos.
- El equipo debe modificar changelogs cuando agregue nuevos archivos SQL.
- Si Docker Desktop no esta iniciado, primero debe abrirse antes de ejecutar la entrega.

## Reglas de validacion

Para aceptar esta decision:

- `docker-compose up --abort-on-container-exit liquibase` debe terminar con codigo 0.
- Liquibase debe ejecutar todos los changeSets.
- El smoke test debe ejecutarse contra `hotel_management`.
- Las rutas montadas en Docker deben coincidir con la estructura real.
- `liquibase.properties` debe apuntar al changelog maestro YAML.

## Resultado de validacion

La ejecucion validada dejo:

- 52 changeSets ejecutados.
- 51 tablas creadas.
- 8 schemas creados.
- 55 foreign keys registradas.
- 0 foreign keys sin validar.
- Usuario `ariel5253` cargado en `security.user_account`.

