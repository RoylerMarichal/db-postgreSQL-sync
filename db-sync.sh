#!/bin/bash

SOURCE_DB="$1"
TARGET_DB="$2"

if [ -z "$SOURCE_DB" ] || [ -z "$TARGET_DB" ]; then
  echo "Uso:"
  echo "db-sync <source_connection> <target_connection>"
  exit 1
fi

TMP_FILE="/tmp/postgres-sync.dump"

echo "📦 Exportando..."

pg_dump \
  --format=custom \
  --no-owner \
  --no-privileges \
  "$SOURCE_DB" \
  -f "$TMP_FILE"

echo "🧹 Limpiando destino..."

psql "$TARGET_DB" -c "
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
"

echo "📥 Restaurando..."

pg_restore \
  --no-owner \
  --no-privileges \
  -d "$TARGET_DB" \
  "$TMP_FILE"

echo "✅ Sincronización completada"
