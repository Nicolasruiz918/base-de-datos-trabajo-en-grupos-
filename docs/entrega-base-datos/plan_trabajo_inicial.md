# Plan de trabajo inicial

**Proyecto:** Sistema de gestion hotelera
**Meta:** dejar una base PostgreSQL organizada, documentada y validable.

## Fases

| Fase                            | HU            | Objetivo                                                                                  | Responsable principal                         |
| ------------------------------- | ------------- | ----------------------------------------------------------------------------------------- | --------------------------------------------- |
| Planificacion e infraestructura | HU-1 a HU-8   | Plan, seguimiento, dominios, ADRs, Docker, PostgreSQL, Liquibase y base DDL inicial.      | Brayan / Nicolas / Emily                      |
| Modelo de datos                 | HU-9 a HU-14  | Tablas por parejas de dominios, views, materialized views, functions, procedures, triggers e indices. | Nicolas / Brayan / Frenier / Emily            |
| Carga de datos y seguridad      | HU-15 a HU-22 | DML, DCL roles, grants, policies y TCL.                                                   | Frenier / Brayan / Nicolas                    |
| Validacion final                | HU-23         | Verificar ejecucion, autenticacion y documentacion.                                       | Emily Sharith Amezquita Saavedra              |


## Asignacion por historias

| Responsable | HU asignadas |
|-------------|--------------|
| Nicolas Estid Ruiz Sastoque | HU-04, HU-06, HU-07, HU-09, HU-19, HU-20, HU-22 |
| Frenier Steven Cardona Perez | HU-11, HU-12, HU-15, HU-17, HU-18, HU-21 |
| Brayan Perdomo | HU-01, HU-02, HU-03, HU-10, HU-16 |
| Emily Sharith Amezquita Saavedra | HU-05, HU-08, HU-13, HU-14, HU-23 |
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


