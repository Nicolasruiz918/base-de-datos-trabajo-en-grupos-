# Flujo Git por historias de usuario

## Objetivo

Este documento explica como subir el trabajo por historias de usuario tecnicas sin romper la base de datos, respetando el flujo `dev -> qa -> main` y dejando evidencia clara para el instructor.

La idea es que cada cambio tenga una HU asociada, una rama, archivos concretos, una validacion y una promocion controlada entre ambientes.

## Ramas principales

| Rama | Uso | Quien la valida |
|------|-----|-----------------|
| `main` | Version estable y entregable final. Solo recibe cambios ya validados. | Lider del proyecto. |
| `qa` | Version candidata para pruebas. Recibe cambios desde `dev`. | QA. |
| `dev` | Integracion del equipo. Recibe historias terminadas desde ramas `hu/*`. | Desarrolladores y lider. |
| `hu/HU-xx-descripcion` | Rama de una historia tecnica. | Responsable de la HU. |

## Flujo recomendado

1. Crear o actualizar `dev` desde `main`.
2. Crear una rama por historia desde `dev`.
3. Subir solo los archivos que pertenecen a esa historia.
4. Abrir Pull Request de la rama de historia hacia `dev`.
5. Revisar que el changelog y los archivos relacionados esten completos.
6. Ejecutar validacion local con Docker y Liquibase cuando la historia toque base de datos.
7. Mezclar la historia en `dev`.
8. Cuando un grupo de historias este listo, abrir Pull Request de `dev` hacia `qa`.
9. QA valida ejecucion, datos, permisos, documentacion y smoke test.
10. Si QA aprueba, abrir Pull Request de `qa` hacia `main`.
11. `main` queda como entrega estable.

## Si el instructor pide ramas de QA y Main por historia

La forma mas limpia sigue siendo trabajar la historia en `hu/*` y promoverla por PR. Si te piden ver ramas intermedias, usa estas ramas solo como evidencia de promocion:

| Paso | Rama origen | Rama destino | Uso |
|------|-------------|--------------|-----|
| Desarrollo | `hu/HU-xx-descripcion` | `dev` | Subir implementacion de la historia. |
| QA | `dev` | `qa/HU-xx-descripcion` | Congelar lo que QA va a revisar. |
| Aprobacion QA | `qa/HU-xx-descripcion` | `qa` | Integrar lo aprobado por QA. |
| Pre-main | `qa` | `main/HU-xx-descripcion` | Preparar version que ira a main. |
| Main | `main/HU-xx-descripcion` | `main` | Dejar estable la historia. |

No hagas cambios nuevos en `qa/*` ni en `main/*`. Esas ramas solo deben servir para mover lo que ya fue desarrollado y validado.

## Pregunta de las foreign keys

Las foreign keys no se rompen por subir archivos al repositorio. Git solo guarda archivos. Se rompen cuando se ejecuta la base de datos en un orden incorrecto.

Para que no fallen:

- Primero deben existir las extensiones, schemas y types.
- Una tabla hija no debe crearse o poblarse antes que la tabla padre exista.
- Un insert que referencia otra tabla debe ejecutarse despues del insert padre.
- Una view, function, procedure o trigger debe crearse despues de las tablas que usa.
- Un rollback debe ejecutarse en orden inverso al de creacion.
- El changelog maestro debe mantener el orden real de dependencias.
- Cada PR que toque SQL debe probarse en una base limpia con Liquibase.

## Regla para trabajar por partes

Una historia se puede subir sola cuando cumple estas condiciones:

- Incluye su SQL principal.
- Incluye su `changelog.yaml` o actualiza el changelog que la llama.
- Incluye rollback cuando aplica.
- No depende de archivos que todavia no existen en `dev`.
- Si depende de otra HU, esa HU ya debe estar mezclada en `dev`.

Si una historia depende de otra que no ha sido subida, no se debe ejecutar todavia. Primero se sube la historia padre y luego la hija.

## Orden seguro para base de datos

| Orden | Bloque | Historias | Por que va aqui |
|-------|--------|-----------|-----------------|
| 1 | Repositorio y documentacion inicial | HU-01 a HU-04 | No tiene dependencias SQL. |
| 2 | Docker, Liquibase y base DDL | HU-05 a HU-08 | Prepara el ambiente antes de crear tablas. |
| 3 | Tablas con FKs por dominios | HU-09 a HU-12 | Crea la estructura y las foreign keys. |
| 4 | Views, materialized views, functions, procedures, triggers e indexes | HU-13 a HU-14 | Dependen de tablas ya creadas. |
| 5 | DML | HU-15 a HU-18 | Depende de tablas y FKs existentes. |
| 6 | DCL y TCL | HU-19 a HU-22 | Dependen de schemas, tablas y datos base. |
| 7 | Validacion final | HU-23 | Comprueba toda la entrega. |

## Comandos base

Crear rama de historia:

```bash
git checkout dev
git pull origin dev
git checkout -b hu/HU-09-parametrizacion-seguridad
```

Subir cambios:

```bash
git status
git add docs/entrega-base-datos entregables/estructura-base-datos
git commit -m "feat: implement hu-09 parametrizacion and security"
git push origin hu/HU-09-parametrizacion-seguridad
```

Validar base de datos antes del PR:

```bash
cd "entregables/estructura-base-datos/db-structure 1/docker"
docker-compose down -v
docker-compose up --abort-on-container-exit liquibase
docker-compose exec postgres psql -U admin -d hotel_management -f /scripts/smoke-test.sql
```

## Plantilla de descripcion de PR

```md
## Historia

HU-XX - Nombre de la historia

## Que se hizo

-

## Que se sube

-

## Como se valido

- [ ] Changelog actualizado
- [ ] Rollback incluido cuando aplica
- [ ] Docker Compose ejecuta
- [ ] Liquibase ejecuta
- [ ] Smoke test ejecuta cuando aplica
- [ ] Documentacion actualizada

## Riesgos o dependencias

- Depende de HU-XX
```

## Recomendacion final

Para esta entrega, el orden mas seguro es usar las HU tecnicas como unidad de subida al repositorio. Asi se mantiene el orden de dependencias y no se rompe la ejecucion de foreign keys.
