# ADR-007 - Separacion de documentacion y base de datos en repositorios diferentes

## Estado

Aceptado

## Contexto

La entrega contiene dos grupos de artefactos con ciclos de trabajo diferentes:

- La documentacion del proyecto: historias de usuario, ADR, plan de trabajo, seguimiento, DoR/DoD, matriz de trazabilidad, tablero y guia tecnica.
- El paquete ejecutable de base de datos: DDL, DML, DCL, TCL, rollbacks, changelogs, Docker, Liquibase y scripts de validacion.

Aunque durante la preparacion local pueden convivir en una misma carpeta de trabajo, la decision formal es que deben quedar listos para administrarse como repositorios separados. Esto permite que la documentacion evolucione sin mezclarse con los scripts SQL ejecutables, y que la base de datos pueda versionarse, probarse y desplegarse como un artefacto tecnico independiente.

## Problema

Si documentacion y base de datos quedan mezcladas en un solo entregable sin frontera clara, aparecen problemas como:

- Pull Requests con documentos y scripts SQL mezclados sin necesidad.
- Dificultad para saber que se debe subir en una HU documental y que se debe subir en una HU tecnica de base de datos.
- Rutas largas o confusas para ejecutar Docker, Liquibase y smoke test.
- Riesgo de incluir documentos dentro del paquete ejecutable de base de datos.
- Mayor dificultad para validar responsabilidades entre lider, desarrolladores y QA.

## Decision

Se define una separacion objetivo en dos repositorios:

| Repositorio objetivo | Contenido | Responsable de mantenimiento |
|----------------------|-----------|------------------------------|
| Repositorio de documentacion | `docs/entrega-base-datos`, ADR, HU, plan, seguimiento, tablero, matriz y guias. | Equipo de documentacion y QA. |
| Repositorio de base de datos | `database` con DDL, DML, DCL, TCL, rollbacks, changelogs, Docker, Liquibase y scripts. | Equipo de desarrollo de base de datos. |

La carpeta local queda organizada con `docs/` y `database/` para facilitar la separacion posterior. Al momento de subir a GitHub, cada bloque puede llevarse a su repositorio correspondiente:

```text
repositorio-documentacion/
|-- docs/
`-- README.md

repositorio-base-datos/
|-- database/
`-- README.md
```

La documentacion existente en `docs/planning` y `docs/architecture` no se modifica dentro de esta decision; solo se mantiene como referencia documental cuando aplique.

## Alternativas evaluadas

| Alternativa | Resultado |
|-------------|-----------|
| Mantener todo mezclado en un unico repositorio sin frontera | Rechazado porque dificulta revisiones por HU y separacion de responsabilidades. |
| Dejar documentacion dentro del paquete de base de datos | Rechazado porque mezcla evidencia documental con artefactos ejecutables. |
| Separar fisicamente en carpetas `docs` y `database`, preparadas para repositorios diferentes | Aceptado porque simplifica rutas y permite dividir la entrega por repositorio. |

## Consecuencias

- Las HU documentales apuntan al repositorio de documentacion.
- Las HU tecnicas de SQL apuntan al repositorio de base de datos.
- El plan de subida por HU debe indicar rutas `docs/...` o `database/...` segun corresponda.
- La validacion final debe revisar que ambos repositorios esten alineados.
- Docker y Liquibase se ejecutan desde el paquete de base de datos.
- Los ADR permanecen en el repositorio de documentacion porque explican decisiones, no son scripts ejecutables.

## Reglas de validacion

Para aceptar esta decision:

- La documentacion debe estar ubicada bajo `docs/`.
- El paquete ejecutable de base de datos debe estar ubicado bajo `database/`.
- No deben existir documentos de entrega dentro de `database/`.
- El README debe explicar la separacion por repositorios.
- El plan de subida por HU debe diferenciar lo documental de lo ejecutable.
- La validacion final debe confirmar que la base sigue ejecutando con Liquibase y que los documentos apuntan a rutas correctas.

## Relacion con otras decisiones

- ADR-004 define la separacion por dominios funcionales.
- ADR-005 define la ejecucion con Docker Compose y Liquibase.
- ADR-006 define el uso de schemas por dominio.
- Este ADR define la separacion de documentacion y base de datos como repositorios diferentes.
