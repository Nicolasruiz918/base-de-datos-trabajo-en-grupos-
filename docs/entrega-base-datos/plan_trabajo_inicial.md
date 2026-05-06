# Plan de trabajo inicial

**Proyecto:** Sistema de gestion hotelera
**Meta:** dejar una base PostgreSQL organizada, documentada y validable.

## Fases

| Fase                            | HU            | Objetivo                                                                                  | Responsable principal                         |
| ------------------------------- | ------------- | ----------------------------------------------------------------------------------------- | --------------------------------------------- |
| Planificacion e infraestructura | HU-1 a HU-8   | Plan, seguimiento, dominios, ADRs, Docker, PostgreSQL, Liquibase y base DDL inicial.      | Nicolas Estid Ruiz Sastoque                   |
| Modelo de datos                 | HU-9 a HU-14  | Tablas por parejas de dominios, views, materialized views, functions, procedures, triggers e indices. | Brayan Perdomo                                |
| Carga de datos y seguridad      | HU-15 a HU-22 | DML, DCL roles, grants, policies y TCL.                                                   | Frenier Steven Cardona Perez / Brayan Perdomo |
| Validacion final                | HU-23         | Verificar ejecucion, autenticacion y documentacion.                                       | Emily Sharith Amezquita Saavedra              |

## Criterios de cierre

- Cada view, materialized view, function, procedure y trigger esta en archivo propio.
- `ariel5253` autentica con password `ariel5253`.
- `ariel5253` no hereda `administrador` ni puede crear nuevos administradores.

## Cronograma de una semana

| Dia   | HU            | Objetivo                                           |
| ----- | ------------- | -------------------------------------------------- |
| Dia 1 | HU-1 a HU-4   | Repositorio Git, planeacion, seguimiento, dominios y ADR.           |
| Dia 2 | HU-5 a HU-8   | Infraestructura, PostgreSQL, Liquibase y base DDL. |
| Dia 3 | HU-9 a HU-14  | Modelo de datos por parejas de dominios y objetos avanzados.               |
| Dia 4 | HU-15 a HU-22 | DML, DCL, TCL y seguridad.                         |
| Dia 5 | HU-23         | Validacion final y cierre documental.              |

