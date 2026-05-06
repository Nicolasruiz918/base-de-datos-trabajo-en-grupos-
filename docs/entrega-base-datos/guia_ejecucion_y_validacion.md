# Guia de ejecucion y validacion

## Objetivo

Validar que el ambiente PostgreSQL quede estable con DDL, DML, DCL, TCL y rollbacks organizados.

## Opcion recomendada: Docker Compose + Liquibase

1. Abrir una terminal en:

```bash
entregables/estructura-base-datos/db-structure 1/docker
```

2. Levantar PostgreSQL y ejecutar Liquibase:

```bash
docker compose up liquibase
```

3. Ejecutar smoke test:

```bash
docker compose exec postgres psql -U admin -d sistema_hotelero -f /scripts/smoke-test.sql
```

4. Validar login PostgreSQL de Ariel:

```bash
docker compose exec -e PGPASSWORD=ariel5253 postgres psql -U ariel5253 -d sistema_hotelero -c "SELECT current_user;"
```

5. Detener el ambiente:

```bash
docker compose down
```

## Configuracion Docker

| Elemento | Valor |
|----------|-------|
| Base de datos | `sistema_hotelero` |
| Usuario administrador Docker | `admin` |
| Password administrador Docker | `admin123` |
| Puerto local | `25432` |
| Servicio PostgreSQL | `postgres` |
| Servicio Liquibase | `liquibase` |
| Archivo properties | `liquibase.properties` |

## Opcion alternativa: psql local

Si se tiene `psql` instalado en el equipo:

```bash
createdb -U admin -h localhost -p 25432 sistema_hotelero
```

```bash
psql -h localhost -p 25432 -U admin -d sistema_hotelero -f changelog/changelog-master.sql
```

Tambien se puede usar el script:

```powershell
.\scripts\load-postgres.ps1
```

## Validaciones minimas

```sql
SELECT COUNT(*) AS tablas_creadas
FROM information_schema.tables
WHERE table_schema IN (
  'parametrizacion',
  'distribucion',
  'prestacion_servicio',
  'facturacion',
  'inventario',
  'notificacion',
  'seguridad',
  'mantenimiento'
);

SELECT COUNT(*) AS estados_habitacion FROM distribucion.estado_habitacion;
SELECT COUNT(*) AS tipos_habitacion FROM distribucion.tipo_habitacion;
SELECT COUNT(*) AS modulos FROM seguridad.modulo;
SELECT COUNT(*) AS usuario_ariel FROM seguridad.usuario WHERE username = 'ariel5253';
```

## Resultado esperado

| Validacion | Valor esperado |
|------------|----------------|
| Schemas creados | 8 |
| Tablas creadas | 46 |
| Estados de habitacion | 6 |
| Tipos de habitacion | 3 |
| Modulos | 8 |
| Usuario `ariel5253` | 1 |

## Cierre de main estable

Antes de cerrar la entrega:

- Confirmar que Liquibase termina sin errores.
- Confirmar que `scripts/smoke-test.sql` retorna los valores esperados.
- Confirmar que el usuario `ariel5253` puede autenticarse.
- Registrar evidencia en `seguimientos.md`.
- No dejar archivos temporales ni scripts duplicados.
