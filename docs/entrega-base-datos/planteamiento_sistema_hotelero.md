# Planteamiento del sistema hotelero

## Vision

El sistema de gestion hotelera busca centralizar la operacion de un hotel, conectando habitaciones, reservas, estadias, pagos, facturacion, inventario, notificaciones, seguridad y mantenimiento.

## Problema a resolver

La operacion hotelera suele depender de registros manuales o herramientas separadas. Esto genera errores en disponibilidad, pagos, estado real de habitaciones, consumos durante la estadia y facturacion final.

## Objetivo del MVP

Construir un repositorio funcional que deje lista la base de datos inicial del sistema hotelero, con estructura versionada, datos de referencia poblados, planning de trabajo y reglas claras de terminacion.

## Alcance inicial

- Crear y organizar la estructura del repositorio.
- Integrar el schema de base de datos del sistema hotelero.
- Integrar datos de referencia para poder probar la base.
- Definir HU, estimacion, tablero y responsabilidades.
- Establecer DoR y DoD del equipo.
- Dejar la rama `main` estable como entrega final.

## Modulos del sistema

| Modulo | Proposito |
|--------|-----------|
| Parametrizacion | Clientes, empleados, empresa, metodos de pago, precios y tipos de dia. |
| Distribucion | Sedes, habitaciones, tipos y estados de habitacion. |
| Prestacion de servicio | Reservas, disponibilidad, check in, estadia y check out. |
| Facturacion | Pre factura, factura, pagos parciales y detalle de compra. |
| Inventario | Productos, servicios, proveedores, disponibilidad y seguimiento. |
| Notificacion | Promociones, alertas, terminos y fidelizacion. |
| Seguridad | Personas, usuarios, roles, permisos, modulos y vistas. |
| Mantenimiento | Bloqueo, uso, remodelacion y dashboard operativo de habitaciones. |

## Fuera de alcance inicial

- Pasarela de pagos real.
- Automatizacion avanzada de CI/CD.
- Frontend completo productivo.
- Reglas fiscales definitivas.
- Canales reales de notificacion como WhatsApp, SMS o email transaccional.

## Resultado esperado

Un repositorio listo para que el equipo pueda trabajar sobre una base estable, con datos minimos cargados y una ruta clara para continuar el desarrollo funcional.
