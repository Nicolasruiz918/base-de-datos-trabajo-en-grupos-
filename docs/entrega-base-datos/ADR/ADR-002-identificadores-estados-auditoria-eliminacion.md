# ADR-002 - Identificadores, estados, auditoria y politica de eliminacion

## Estado

Aceptado

## Contexto

La base de datos del sistema hotelero necesitaba una decision definitiva sobre cuatro puntos transversales antes de dejar la estructura lista para ejecutar:

- Tipo de dato para `id`.
- Valores oficiales del campo comun `status`.
- Uso de `created_by`, `updated_by` y `deleted_by`.
- Politica de eliminacion fisica o eliminacion logica.

Estos puntos afectan todos los dominios porque las tablas comparten auditoria, estados de ciclo de vida, relaciones entre entidades y procedimientos de eliminacion controlada.

## Problema

Si cada dominio define sus propios identificadores o estados sin una regla comun, aparecen problemas de mantenimiento:

- Llaves primarias inconsistentes entre dominios.
- Foreign keys dificiles de mantener.
- Datos eliminados sin trazabilidad.
- Registros activos, inactivos o eliminados sin una lectura uniforme.
- DML y rollbacks con reglas diferentes para cada modulo.

Por eso se toma una decision transversal para toda la entrega.

## Alternativas evaluadas para `id`

| Alternativa    | Ventajas                                                                                         | Desventajas                                                                                | Decision                   |
| -------------- | ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | -------------------------- |
| `BIGINT`     | Simple, legible y eficiente para bases centralizadas.                                            | Es secuencial, predecible y menos conveniente para integraciones o cargas distribuidas.    | Rechazado.                 |
| `UUID`       | Identificador global, no secuencial, nativo en PostgreSQL y almacenado internamente en 16 bytes. | Menos legible manualmente que un numero secuencial.                                        | Aceptado.                  |
| `CHAR(36)`   | Facil de leer porque guarda el UUID como texto.                                                  | Ocupa mas espacio que `UUID` nativo y es menos eficiente para indices.                   | Rechazado.                 |
| `BINARY(16)` | Compacto en motores como MySQL.                                                                  | No es la opcion nativa para PostgreSQL; en PostgreSQL el equivalente correcto es `UUID`. | Rechazado para PostgreSQL. |

## Decision sobre identificadores

El tipo definitivo para llaves primarias y llaves foraneas es `UUID`.

Cada tabla debe declarar su identificador principal asi:

```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
```

Las columnas de relacion tambien quedan como `UUID`, por ejemplo:

```sql
cliente_id UUID REFERENCES cliente(id)
usuario_id UUID REFERENCES usuario(id)
habitacion_id UUID REFERENCES habitacion(id)
```

## Justificacion

Se escoge `UUID` porque PostgreSQL lo soporta de forma nativa y lo almacena como un valor compacto de 16 bytes. Esto conserva la ventaja de un identificador compacto como `BINARY(16)`, pero sin usar un tipo propio de MySQL.

Tambien evita identificadores secuenciales visibles y facilita posibles integraciones futuras, importaciones de datos o generacion de registros desde diferentes fuentes sin depender de una secuencia central.

## Valores oficiales de `status`

El campo comun `status` representa el ciclo de vida general del registro. Los valores oficiales son:

| Valor        | Significado                                                             | Uso esperado                                                                               |
| ------------ | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `ACTIVE`   | Registro activo y disponible para operacion normal.                     | Consultas funcionales, flujos de reserva, facturacion, inventario y mantenimiento.         |
| `INACTIVE` | Registro deshabilitado, pero conservado para historial o configuracion. | Catalogos, parametros o usuarios que ya no deben usarse temporalmente.                     |
| `DELETED`  | Registro eliminado logicamente.                                         | Registros que no deben participar en operacion normal, pero se conservan por trazabilidad. |

Estos valores se implementan mediante el tipo:

```sql
parametrizacion.record_status
```

## Estados de negocio vs. `status`

El campo `status` no reemplaza estados propios de negocio. Por ejemplo:

- Una reserva puede tener `PENDIENTE`, `CONFIRMADA`, `CANCELADA`, `CHECK_IN` o `FINALIZADA`.
- Una factura puede tener `BORRADOR`, `EMITIDA`, `PAGADA` o `ANULADA`.
- Un mantenimiento puede tener `PENDIENTE`, `EN_PROCESO`, `FINALIZADO` o `CANCELADO`.

Esos estados describen procesos de negocio. En cambio, `status` describe si el registro esta activo, inactivo o eliminado logicamente.

## Auditoria

Las columnas de auditoria definidas para las tablas son:

| Campo          | Tipo            | Proposito                                  |
| -------------- | --------------- | ------------------------------------------ |
| `created_by` | `UUID`        | Usuario que creo el registro.              |
| `created_at` | `TIMESTAMPTZ` | Fecha y hora de creacion.                  |
| `updated_by` | `UUID`        | Usuario que hizo la ultima actualizacion.  |
| `updated_at` | `TIMESTAMPTZ` | Fecha y hora de ultima actualizacion.      |
| `deleted_by` | `UUID`        | Usuario que ejecuto la eliminacion logica. |
| `deleted_at` | `TIMESTAMPTZ` | Fecha y hora de eliminacion logica.        |

## Decision sobre `created_by`, `updated_by` y `deleted_by`

Los campos `created_by`, `updated_by` y `deleted_by` deben apuntar conceptualmente a:

```sql
seguridad.usuario(id)
```

Se dejan como `UUID` y pueden ser nulos porque existen datos iniciales de parametrizacion, seguridad y carga semilla que se insertan antes de que haya un usuario funcional autenticado ejecutando la accion.

En una fase posterior, si se requiere mayor rigidez, se pueden agregar foreign keys explicitas hacia `seguridad.usuario(id)` despues de resolver completamente el orden de carga de usuarios y datos base.

## Politica de eliminacion

La politica principal es eliminacion logica.

La eliminacion logica debe actualizar:

```sql
status = 'DELETED'
deleted_at = now()
deleted_by = <usuario que ejecuta la accion>
```

Esto permite conservar trazabilidad, evitar perdida accidental de informacion y mantener consistencia con auditoria.

## Eliminacion fisica permitida

La eliminacion fisica solo se permite en casos controlados:

| Caso                            | Motivo                                                                    |
| ------------------------------- | ------------------------------------------------------------------------- |
| Rollback                        | Deshacer una carga o cambio tecnico de forma controlada.                  |
| Limpieza de datos demo          | Retirar datos semilla o datos de prueba.                                  |
| Tablas puente temporales        | Cuando no se requiere conservar historial.                                |
| Purga administrativa autorizada | Casos legales, administrativos o de mantenimiento fuera del flujo normal. |

## Impacto sobre el funcionamiento de la base de datos

Esta decision cambia el tipo tecnico de los identificadores, pero no cambia la logica funcional del sistema hotelero. Las reservas, habitaciones, facturas, inventario, notificaciones, seguridad y mantenimiento siguen teniendo el mismo comportamiento de negocio.

El funcionamiento queda estable siempre que el cambio sea consistente en toda la estructura:

- DDL con llaves primarias y foraneas en `UUID`.
- DML con referencias compatibles con `UUID`.
- Functions, procedures, triggers, views e indexes usando los mismos nombres y tipos.
- Rollbacks preparados para los mismos objetos.
- Changelogs apuntando a los archivos actualizados.

En una base nueva, este ADR no genera migracion de datos porque la estructura se crea directamente con `UUID`. En una base ya poblada con `BIGINT`, el cambio si requeriria una migracion controlada antes de ejecutarse en produccion.

## Consecuencias

- `pgcrypto` es obligatorio porque se usa `gen_random_uuid()`.
- Todas las llaves primarias y foraneas quedan como `UUID`.
- Las consultas funcionales deben filtrar registros activos con `status = 'ACTIVE'` cuando aplique.
- La eliminacion normal debe hacerse por procedimiento o actualizacion controlada, no por `DELETE` directo.
- Los rollbacks pueden usar eliminacion fisica porque hacen parte de la recuperacion tecnica.

## Reglas de validacion

Para considerar cumplida esta decision:

- Ninguna tabla principal debe usar `BIGINT GENERATED BY DEFAULT AS IDENTITY`.
- Los campos `created_by`, `updated_by` y `deleted_by` deben ser `UUID`.
- Los campos `*_id` usados como foreign key deben ser `UUID`.
- El tipo `parametrizacion.record_status` debe conservar los valores `ACTIVE`, `INACTIVE` y `DELETED`.
- El procedimiento de eliminacion logica debe actualizar `status`, `deleted_at` y `deleted_by`.

## Impacto en la entrega

Esta decision afecta:

- `01_ddl/02_types/001_domain_types.sql`
- `01_ddl/03_tables`
- `01_ddl/07_procedures/002_sp_soft_delete.sql`
- `02_dml`
- `05_rollbacks`
- Changelogs Liquibase asociados a DDL, DML y rollbacks.
