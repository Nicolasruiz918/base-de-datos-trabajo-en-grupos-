# Analisis de dominios - Sistema hotelero

## Objetivo

Definir los dominios funcionales que organizan la base de datos del sistema hotelero en PostgreSQL. Este analisis sirve como referencia para mantener consistencia entre schemas, tablas, DML, DCL, HU, changelogs y documentacion.

La entrega conserva 8 dominios oficiales. No se crea un dominio tecnico adicional ni se separa parametrizacion en varios dominios.

## Criterios usados para definir dominios

| Criterio | Aplicacion en la entrega |
|----------|--------------------------|
| Responsabilidad funcional | Cada dominio agrupa entidades que cumplen una funcion clara dentro de la operacion hotelera. |
| Cohesion de datos | Las tablas de un dominio comparten reglas de negocio y relaciones cercanas. |
| Trazabilidad con HU | Las historias HU-9 a HU-18 se organizan alrededor de estos dominios, en parejas para evitar historias con tres dominios mezclados. |
| Separacion tecnica | DDL, DML, DCL, TCL y rollbacks respetan la misma division. |
| Evitar dominios artificiales | No se crea `common`, `configuration`, `parametrizacion_core` ni `parametrizacion_precio`. |

## Dominios oficiales

| # | Dominio | Schema PostgreSQL | Archivo DDL | Proposito |
|---|---------|-------------------|-------------|-----------|
| 1 | Parametrizacion | `configuration` | `01_ddl/03_tables/001_configuration.sql` | Centraliza datos maestros: clientes, personas, empresa, empleados, metodos de pago, tipos de dia y precios. |
| 2 | Seguridad | `security` | `01_ddl/03_tables/002_security.sql` | Gestiona usuarios, roles, permisos, modulos, vistas y relaciones de acceso. |
| 3 | Distribucion | `distribution` | `01_ddl/03_tables/003_distribution.sql` | Organiza sedes, habitaciones, tipos, estados, catalogo y disponibilidad. |
| 4 | Prestacion de servicio | `service_delivery` | `01_ddl/03_tables/004_service_delivery.sql` | Controla reservas, cancelaciones, estadias, check in y check out. |
| 5 | Inventario | `inventory` | `01_ddl/03_tables/005_inventory.sql` | Administra proveedores, productos, servicios, ventas, seguimiento y disponibilidad de inventario. |
| 6 | Facturacion | `billing` | `01_ddl/03_tables/006_billing.sql` | Maneja pre factura, factura, pagos parciales y detalle de compra. |
| 7 | Notificacion | `notification` | `01_ddl/03_tables/007_notification.sql` | Agrupa promociones, alertas, terminos, condiciones y fidelizacion. |
| 8 | Mantenimiento | `maintenance` | `01_ddl/03_tables/008_maintenance.sql` | Registra mantenimiento de habitacion, uso, remodelacion y dashboard operativo. |

## Tablas relacionadas por dominio

Esta seccion conecta cada dominio con sus tablas reales en DDL. En total, el modelo tiene 46 tablas distribuidas en los 8 schemas oficiales.

### Parametrizacion

| Tabla | Relacion funcional |
|-------|--------------------|
| `cliente` | Registra clientes del hotel y datos de contacto para reservas, facturacion y notificacion. |
| `persona` | Centraliza informacion personal usada por empleados, usuarios y procesos internos. |
| `empresa` | Define la empresa hotelera que agrupa sedes y configuracion legal. |
| `tipo_dia` | Clasifica dias normales, fines de semana, feriados o temporadas para reglas de precio. |
| `metodo_pago` | Define medios de pago usados en pagos parciales y facturacion. |
| `informacion_legal` | Conserva informacion legal asociada a la empresa. |
| `empleado` | Registra empleados que participan en recepcion, inventario, mantenimiento y operacion. |
| `precio` | Define valores por tipo de habitacion y tipo de dia para calcular reservas. |

### Seguridad

| Tabla | Relacion funcional |
|-------|--------------------|
| `rol` | Define perfiles de acceso como administrador, desarrollador o QA. |
| `permiso` | Registra acciones permitidas dentro del sistema. |
| `modulo` | Agrupa funcionalidades principales del sistema hotelero. |
| `vista` | Representa pantallas o vistas asociadas a modulos. |
| `usuario` | Registra usuarios de autenticacion, incluido `ariel5253`. |
| `usuario_rol` | Relaciona usuarios con roles. |
| `rol_permiso` | Relaciona roles con permisos. |
| `modulo_vista` | Relaciona modulos con vistas para control de acceso. |

### Distribucion

| Tabla | Relacion funcional |
|-------|--------------------|
| `sede` | Registra sedes o ubicaciones del hotel. |
| `tipo_habitacion` | Define categorias de habitacion como sencilla, doble o suite. |
| `estado_habitacion` | Define estados operativos de habitaciones. |
| `habitacion` | Registra habitaciones fisicas por sede, tipo y estado. |
| `disponibilidad_habitacion` | Controla disponibilidad por habitacion y rango de fechas. |
| `catalogo_habitacion` | Relaciona habitaciones con precios y datos comerciales del catalogo. |

### Prestacion de servicio

| Tabla | Relacion funcional |
|-------|--------------------|
| `reserva_habitacion` | Registra reservas de clientes sobre habitaciones y fechas. |
| `cancelacion_habitacion` | Registra cancelaciones y motivos asociados a una reserva. |
| `estadia` | Controla la estadia activa o finalizada del cliente. |
| `check_in` | Registra ingreso del cliente y cambio operativo inicial. |
| `check_out` | Registra salida del cliente y cierre de la estadia. |

### Inventario

| Tabla | Relacion funcional |
|-------|--------------------|
| `proveedor` | Registra proveedores de productos y servicios. |
| `producto` | Define productos disponibles para venta o consumo. |
| `servicio` | Define servicios adicionales ofrecidos al cliente. |
| `venta_producto` | Registra venta o consumo de productos durante una estadia. |
| `venta_servicio` | Registra venta o consumo de servicios durante una estadia. |
| `seguimiento_producto` | Lleva trazabilidad de movimientos de inventario. |
| `disponibilidad_inventario` | Controla disponibilidad actual de productos o servicios. |

### Facturacion

| Tabla | Relacion funcional |
|-------|--------------------|
| `pre_factura` | Calcula valores previos a la factura final de una estadia. |
| `factura` | Registra la factura emitida y su estado. |
| `pago_parcial` | Registra abonos o pagos parciales asociados a reservas. |
| `detalle_compra` | Detalla productos y servicios cobrados en la factura. |

### Notificacion

| Tabla | Relacion funcional |
|-------|--------------------|
| `promocion` | Registra promociones asociadas a la operacion comercial. |
| `alerta` | Registra alertas operativas relacionadas con clientes o reservas. |
| `termino_condicion` | Versiona terminos y condiciones aplicables. |
| `fidelizacion_cliente` | Registra informacion de fidelizacion y relacion con clientes. |

### Mantenimiento

| Tabla | Relacion funcional |
|-------|--------------------|
| `mantenimiento_habitacion` | Registra mantenimientos asociados a habitaciones. |
| `mantenimiento_uso` | Controla uso o afectacion operativa durante mantenimiento. |
| `mantenimiento_remodelacion` | Registra remodelaciones o intervenciones mayores. |
| `dashboard_mantenimiento` | Consolida informacion para seguimiento operativo de mantenimiento. |

## Relacion entre dominios

| Relacion | Descripcion |
|----------|-------------|
| Parametrizacion -> Distribucion | La empresa y los datos maestros soportan la creacion de sedes, habitaciones y catalogos. |
| Parametrizacion -> Prestacion de servicio | Clientes y precios se usan para reservas y calculos de valor estimado. |
| Distribucion -> Prestacion de servicio | Las reservas dependen de habitaciones disponibles y sus estados operativos. |
| Prestacion de servicio -> Facturacion | Las estadias y reservas alimentan pre facturas, pagos y facturas. |
| Inventario -> Facturacion | Productos y servicios consumidos durante la estadia generan detalles de compra. |
| Prestacion de servicio -> Notificacion | Reservas y clientes permiten generar alertas o comunicaciones operativas. |
| Distribucion -> Mantenimiento | Las habitaciones pueden bloquearse o marcarse por mantenimiento. |
| Seguridad -> Todos los dominios | Usuarios, roles y permisos controlan acceso a modulos y vistas del sistema. |

## Alcance por HU

| HU | Dominios relacionados | Entregable |
|----|-----------------------|------------|
| HU-9 | Parametrizacion y seguridad | Primer grupo de tablas de dominio. |
| HU-10 | Distribucion y prestacion de servicios | Segundo grupo de tablas de dominio. |
| HU-11 | Inventario y facturacion | Tercer grupo de tablas de dominio. |
| HU-12 | Notificacion y mantenimiento | Cuarto grupo de tablas de dominio. |
| HU-15 | Parametrizacion y seguridad | Inserts de datos base para esos dominios. |
| HU-16 | Distribucion y prestacion de servicios | Inserts de habitaciones, reservas y estadias. |
| HU-17 | Inventario y facturacion | Inserts de inventario, ventas, prefacturas, facturas y pagos. |
| HU-18 | Notificacion y mantenimiento | Inserts de promociones, alertas, fidelizacion y mantenimiento. |

## Decisiones de separacion

### Parametrizacion

Parametrizacion se mantiene como un solo dominio porque agrupa datos maestros transversales. Separarlo en `parametrizacion_core` y `parametrizacion_precio` agregaria un noveno dominio innecesario y romperia la consistencia de HU, DML y documentacion.

### Notificacion y mantenimiento

Notificacion y mantenimiento se mantienen separados porque responden a responsabilidades distintas:

- Notificacion comunica eventos, promociones, alertas, terminos y fidelizacion.
- Mantenimiento controla estados operativos de habitaciones, remodelaciones, uso y tablero operativo.

### Configuracion tecnica

No se crea `01_ddl/10_configuration` ni schema `common`. Los tipos y elementos compartidos se ubican dentro de los dominios oficiales, principalmente en `configuration` cuando aplican a datos maestros.

## Reglas de consistencia

- Los schemas oficiales deben ser exactamente 8.
- Cada dominio debe tener archivo DDL e insert DML separado.
- Las HU y el tablero no deben mencionar 9 dominios.
- Los changelogs deben seguir la misma estructura por DDL, DML, DCL y TCL.
- Los rollbacks deben conservar estructura espejo.
- Cualquier cambio de dominio debe actualizar documentacion, HU, changelog y smoke test.

## Validaciones sugeridas

```sql
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN (
  'parametrizacion',
  'distribucion',
  'prestacion_servicio',
  'facturacion',
  'inventario',
  'notificacion',
  'seguridad',
  'mantenimiento'
)
ORDER BY schema_name;
```

```sql
SELECT COUNT(*) AS schemas_oficiales
FROM information_schema.schemata
WHERE schema_name IN (
  'parametrizacion',
  'distribucion',
  'prestacion_servicio',
  'facturacion',
  'inventario',
  'notificacion',
  'seguridad',
  'mantenimiento'
);
```

El resultado esperado para `schemas_oficiales` es `8`.


