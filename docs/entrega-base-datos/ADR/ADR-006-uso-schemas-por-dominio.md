# ADR-006 - Uso de schemas PostgreSQL por dominio

## Estado

Aceptado

## Contexto

PostgreSQL permite organizar objetos mediante schemas. En esta entrega, los schemas se usan para representar los dominios funcionales definidos en el analisis de negocio. Esto permite que el nombre del schema indique el modulo y que el nombre de la tabla indique solamente la entidad.

Como la base fue estandarizada en ingles, los schemas tecnicos tambien quedan en ingles, aunque la documentacion funcional se mantenga en espanol.

## Problema

Si todos los objetos viven en `public`, la base queda mas dificil de leer y mantener. Tambien se corre el riesgo de repetir el nombre del dominio dentro de cada tabla, por ejemplo `configuration_customer` o `security_user`, lo cual genera nombres largos y redundantes.

Ademas, los permisos DCL son mas faciles de administrar cuando los objetos estan agrupados por schema.

## Decision

Se usa un schema PostgreSQL por dominio:

| Schema | Dominio funcional |
|--------|-------------------|
| `configuration` | Parametrizacion |
| `security` | Seguridad |
| `distribution` | Distribucion |
| `service_delivery` | Prestacion de servicio |
| `inventory` | Inventario |
| `billing` | Facturacion |
| `notification` | Notificacion |
| `maintenance` | Mantenimiento |

Las tablas no repiten el nombre del dominio. Por ejemplo:

```sql
configuration.customer
security.user_account
distribution.room
service_delivery.room_reservation
billing.invoice
```

Se evita usar nombres como:

```sql
configuration.configuration_customer
security.security_user_account
distribution.distribution_room
```

## Implementacion

Los schemas se crean en:

- `01_ddl/01_schemas/001_schemas.sql`

Las tablas se crean dentro del schema correspondiente usando `SET search_path` al inicio de cada archivo DDL de dominio.

Las referencias entre dominios se hacen con nombres calificados:

```sql
REFERENCES configuration.customer(id)
REFERENCES distribution.room(id)
REFERENCES service_delivery.room_reservation(id)
```

Los grants se aplican por schema en:

- `03_dcl/01_grants/001_grants.sql`

## Alternativas evaluadas

| Alternativa | Resultado |
|-------------|-----------|
| Usar solo `public` | Rechazado porque mezcla todos los dominios. |
| Usar prefijos en nombres de tabla | Rechazado porque duplica informacion que ya entrega el schema. |
| Crear schema tecnico `common` | Rechazado porque crea un noveno dominio. |
| Usar schemas por dominio | Aceptado por orden, permisos y trazabilidad. |

## Consecuencias

- El modelo queda mas legible.
- Los permisos se pueden entregar por grupo de schemas.
- Las foreign keys entre dominios deben usar nombre calificado.
- Los changelogs deben crear schemas antes de types, tablas y objetos dependientes.
- Los DML deben respetar el orden de dominios para no romper foreign keys.
- Al agregar una tabla nueva, primero se debe definir a que dominio pertenece.

## Reglas de validacion

Para aceptar esta decision:

- Deben existir los 8 schemas definidos.
- No debe existir un schema adicional para `common`, `shared` o configuracion tecnica.
- Las tablas deben estar ubicadas en su schema funcional.
- Los DCL deben otorgar permisos sobre schemas y objetos.
- El smoke test debe contar los 8 schemas.
- La consulta de foreign keys no debe mostrar restricciones sin validar.

## Relacion con la documentacion

Esta decision complementa:

- `analisis_dominios.md`, porque explica la separacion funcional.
- `ADR-004`, porque formaliza la separacion por dominios.
- `ADR-003`, porque los schemas tecnicos quedan en ingles.
- `guia_tecnica_ejecucion.md`, porque describe como ejecutar y validar la estructura.
