param(
  [string]$DatabaseName = "sistema_hotelero",
  [string]$User = "admin",
  [string]$Password = "admin123",
  [string]$HostName = "localhost",
  [int]$Port = 25432
)

$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$changelog = Join-Path $root "changelog\changelog-master.sql"

if (-not (Get-Command psql -ErrorAction SilentlyContinue)) {
  throw "No se encontro psql en PATH. Instala PostgreSQL client o ejecuta con Docker Compose y Liquibase."
}

$previousPassword = $env:PGPASSWORD
$env:PGPASSWORD = $Password
try {
  psql -h $HostName -p $Port -U $User -d $DatabaseName -f $changelog
}
finally {
  $env:PGPASSWORD = $previousPassword
}
