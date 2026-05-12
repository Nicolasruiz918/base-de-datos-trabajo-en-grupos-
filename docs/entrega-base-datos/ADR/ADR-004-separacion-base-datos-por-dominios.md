# ADR-004 - Separacion de la base de datos por dominios funcionales

## Estado

Aceptado

## Contexto

La base de datos del sistema de gestion hotelera contiene entidades de negocio con responsabilidades diferentes: datos maestros, seguridad, estructura fisica del hotel, operacion de reservas y estadias, inventario, facturacion, notificaciones y mantenimiento.

Durante la organizacion de la entrega se detecto el riesgo de mezclar demasiadas tablas en un solo archivo o de crear dominios tecnicos adicionales que no hacian parte del analisis funcional. Tambien se reviso que parametrizacion no debia separarse en varios dominios, porque eso generaba una estructura de 9 dominios y contradecia la documentacion del proyecto.

## Problema

Si la base no se separa por dominios, aparecen problemas de mantenimiento:

- Archivos DDL y DML demasiado grandes.
- Dificultad para saber que tablas pertenecen a cada parte del negocio.
- Historias de usuario con alcance confuso.
- Riesgo de cargar datos en desorden y romper foreign keys.
- Dificultad para asignar responsabilidades al equipo.
- Changelogs y rollbacks mas dificiles de revisar.

## Decision

La base de datos se separa en 8 dominios funcionales oficiales:

| Dominio funcional | Schema tecnico | Archivo principal DDL | Responsabilidad |
|-------------------|----------------|-----------------------|-----------------|
| Parametrizacion | `configuration` | `001_configuration.sql` | Datos maestros y configuracion base del negocio. |
| Seguridad | `security` | `002_security.sql` | Usuarios, roles, permisos, modulos y vistas del sistema. |
| Distribucion | `distribution` | `003_distribution.sql` | Sedes, habitaciones, tipos, estados y catalogo de habitaciones. |
| Prestacion de servicio | `service_delivery` | `004_service_delivery.sql` | Reservas, estadias, check-in, check-out y ventas asociadas. |
| Inventario | `inventory` | `005_inventory.sql` | Productos, servicios, proveedores, stock y disponibilidad. |
| Facturacion | `billing` | `006_billing.sql` | Prefacturas, facturas, pagos y detalle de compra. |
| Notificacion | `notification` | `007_notification.sql` | Promociones, alertas, terminos y fidelizacion. |
| Mantenimiento | `maintenance` | `008_maintenance.sql` | Intervenciones sobre habitaciones y tablero operativo. |

Cada dominio tiene su DDL separado y su DML separado. Los objetos avanzados se ubican por tipo de objeto, pero conservan el schema del dominio al que pertenecen.

## Alternativas evaluadas

| Alternativa | Resultado |
|-------------|-----------|
| Un solo archivo de tablas | Rechazado porque dificulta revision, trazabilidad y trabajo por HU. |
| Separar parametrizacion en core y precios | Rechazado porque crea un dominio adicional no solicitado. |
| Crear dominios tecnicos como `common` o `shared` | Rechazado porque rompe la regla de 8 dominios oficiales. |
| Separar por 8 dominios funcionales | Aceptado porque coincide con el analisis y permite subir la entrega por partes. |

## Implementacion

La decision se implementa en:

- `01_ddl/03_tables`: tablas separadas por dominio.
- `02_dml/00_inserts`: datos iniciales separados por dominio.
- `05_rollbacks`: estructura espejo para revertir cambios.
- `database/changelog-master.yaml`: orden global de ejecucion.
- `docs/entrega-base-datos/analisis_dominios.md`: explicacion funcional y tablas relacionadas.

El orden de carga respeta dependencias. Por ejemplo, `configuration` y `security` se crean antes de dominios que dependen de personas, empleados, usuarios, metodos de pago o datos maestros. Luego se ejecutan `distribution`, `service_delivery`, `inventory`, `billing`, `notification` y `maintenance`.

## Consecuencias

- La entrega puede subirse por historias de usuario sin romper dependencias.
- El equipo puede asignar responsables por dominio.
- Los changelogs quedan mas faciles de revisar.
- Los rollbacks son mas claros porque siguen la misma separacion.
- Las foreign keys entre dominios deben respetar el orden definido por Liquibase.
- Cualquier tabla nueva debe ubicarse en el dominio funcional correcto.

## Reglas de validacion

Para aceptar esta decision:

- Deben existir exactamente 8 dominios.
- Cada tabla debe pertenecer a un dominio funcional real.
- No debe existir un noveno dominio tecnico.
- Los DML deben cargarse en el mismo orden logico de dependencias.
- El smoke test debe confirmar 8 schemas y tablas creadas.
- Las foreign keys deben quedar validadas por PostgreSQL.

## Relacion con otras decisiones

- ADR-001 define PostgreSQL como motor objetivo.
- ADR-003 define que los nombres tecnicos de la base van en ingles.
- ADR-006 define que cada dominio se representa mediante un schema PostgreSQL.

