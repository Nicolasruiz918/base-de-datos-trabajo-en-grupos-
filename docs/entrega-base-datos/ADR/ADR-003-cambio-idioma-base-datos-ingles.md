# ADR-003 - Cambio de idioma tecnico de la base de datos a ingles

## Estado

Aceptado

## Contexto

La documentacion del proyecto se mantiene en espanol porque las HU, el tablero, el DoR/DoD y las explicaciones funcionales se presentan al equipo en ese idioma.

La base de datos, en cambio, necesita una regla tecnica clara para que los objetos SQL queden preparados para mantenimiento, lectura por herramientas, integraciones y buenas practicas de desarrollo. Por eso se define que los nombres tecnicos de la base de datos deben estandarizarse en ingles.

Esta decision no significa traducir los documentos. Los documentos siguen en espanol; el cambio aplica a nombres tecnicos de base de datos.

## Problema

Sin una decision explicita sobre idioma pueden aparecer inconsistencias como:

- Schemas en espanol y tablas en ingles.
- Tablas en espanol y columnas en ingles.
- DML, rollbacks o functions apuntando a nombres distintos.
- Changelogs dificiles de revisar.
- Dudas sobre si el dominio forma parte del nombre de la tabla.

Tambien se habia detectado que declarar tablas con `schema.tabla` dentro de archivos de dominio podia verse como si el dominio hiciera parte del nombre de la entidad. Por eso se mantiene la regla de no repetir el dominio dentro del nombre de la tabla.

## Decision

La documentacion queda en espanol.

La base de datos adopta ingles como idioma tecnico objetivo para schemas, tablas, columnas, views, materialized views, functions, procedures, triggers, indexes y constraints.

La conversion debe hacerse de forma integral, no por partes sueltas. Cuando se renombre un objeto SQL tambien deben actualizarse sus referencias en:

- DDL.
- DML.
- DCL.
- TCL.
- Rollbacks.
- Changelogs.
- Smoke tests.
- Documentacion tecnica de estructura.

## Mapa tecnico de dominios

| Dominio funcional en documentacion | Schema tecnico objetivo en base de datos |
|------------------------------------|------------------------------------------|
| Parametrizacion | `configuration` |
| Seguridad | `security` |
| Distribucion | `distribution` |
| Prestacion de servicio | `service_delivery` |
| Inventario | `inventory` |
| Facturacion | `billing` |
| Notificacion | `notification` |
| Mantenimiento | `maintenance` |

Se mantienen 8 dominios. El cambio de idioma no autoriza crear un noveno dominio tecnico ni unir dominios que tienen responsabilidades diferentes.

## Regla para tablas

La tabla debe llamarse por la entidad, sin repetir el dominio.

Ejemplo aceptado en un archivo de tablas:

```sql
SET search_path TO configuration;

CREATE TABLE IF NOT EXISTS customer (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);
```

Ejemplo que se evita:

```sql
CREATE TABLE IF NOT EXISTS configuration.configuration_customer (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);
```

El schema indica el dominio. La tabla indica la entidad.

## Traduccion recomendada de entidades principales

| Entidad funcional | Nombre tecnico objetivo |
|-------------------|-------------------------|
| cliente | `customer` |
| persona | `person` |
| empresa | `company` |
| empleado | `employee` |
| precio | `price` |
| rol | `role` |
| permiso | `permission` |
| usuario | `user_account` |
| sede | `site` |
| habitacion | `room` |
| reserva_habitacion | `room_reservation` |
| estadia | `stay` |
| producto | `product` |
| servicio | `service` |
| factura | `invoice` |
| promocion | `promotion` |
| alerta | `alert` |
| mantenimiento_habitacion | `room_maintenance` |

## Consecuencias

- La documentacion sigue en espanol para que sea clara para el equipo.
- La base de datos queda convertida al idioma tecnico ingles.
- No se deben mezclar nombres antiguos y nuevos dentro de una misma ejecucion.
- El cambio fisico de nombres debe aplicarse como refactor integral para no romper ejecucion.
- Las HU y documentos deben indicar los dominios funcionales en espanol, aunque el schema tecnico pueda quedar en ingles.

## Reglas de validacion

Para considerar cumplida esta decision en una version ya convertida:

- Los schemas tecnicos deben usar ingles.
- Las tablas no deben repetir el nombre del schema.
- Los DDL, DML, rollbacks y changelogs deben referenciar los mismos nombres.
- No deben existir referencias mezcladas al mismo objeto en espanol e ingles.
- Las pruebas de smoke test deben ejecutarse contra los nombres definitivos.

## Impacto en la entrega

Este ADR documenta y respalda la decision de idioma tecnico. La entrega aplica la conversion integral: DDL, DML, DCL, TCL, rollbacks, changelogs y smoke test usan los nombres tecnicos en ingles.

La decision queda registrada para que el equipo sepa que el objetivo tecnico de la base es ingles y que la documentacion puede seguir escrita en espanol.

