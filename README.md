# db-sync

Script de bash para copiar una base de datos PostgreSQL de un servidor a otro (dump + restore completo).

## Requisitos

- `pg_dump` y `pg_restore` instalados y en el `$PATH`
- Acceso de lectura a la base de datos origen
- Acceso de escritura a la base de datos destino

## Uso

```bash
./db-sync.sh <source_connection> <target_connection>
```

### Ejemplos

```bash
# Sincronizar producción → staging
./db-sync.sh \
  "postgresql://user:pass@prod-host:5432/mydb" \
  "postgresql://user:pass@staging-host:5432/mydb"

# Usando variables de entorno
./db-sync.sh "$DATABASE_URL_PROD" "$DATABASE_URL_STAGING"
```

## Comportamiento

1. Exporta la base de datos origen con `pg_dump` (formato custom, sin owners ni privilegios)
2. Borra y recrea el esquema `public` en el destino
3. Restaura el dump en el destino

> **Advertencia:** el destino queda completamente reemplazado. Todos los datos existentes se pierden.

## Instalación global (opcional)

```bash
chmod +x db-sync.sh
sudo cp db-sync.sh /usr/local/bin/db-sync
```

Luego puedes usarlo desde cualquier lugar:

```bash
db-sync "$SOURCE" "$TARGET"
```
