# db-sync

Bash script to copy a PostgreSQL database from one server to another (full dump + restore).

## Requirements

- `pg_dump` and `pg_restore` installed and in your `$PATH`
- Read access to the source database
- Write access to the target database

## Usage

```bash
./db-sync.sh <source_connection> <target_connection>
```

### Examples

```bash
# Sync production → staging
./db-sync.sh \
  "postgresql://user:pass@prod-host:5432/mydb" \
  "postgresql://user:pass@staging-host:5432/mydb"

# Using environment variables
./db-sync.sh "$DATABASE_URL_PROD" "$DATABASE_URL_STAGING"
```

## How it works

1. Exports the source database with `pg_dump` (custom format, no owners or privileges)
2. Drops and recreates the `public` schema on the target
3. Restores the dump into the target

> **Warning:** the target database is completely replaced. All existing data will be lost.

## Global install (optional)

```bash
chmod +x db-sync.sh
sudo cp db-sync.sh /usr/local/bin/db-sync
```

Then use it from anywhere:

```bash
db-sync "$SOURCE" "$TARGET"
```
