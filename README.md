# Deps yml

> This is a collection of docker compose for generic application dependencies like databases, cache and messaging

### How to use

You have to build the image and run the container at first

```
docker compose -f [service-name].yml up --build
```

after that, you can just up the container

```
docker compose -f [service-name].yml up
```

### MySQL with Multiple Databases

The MySQL service supports creating multiple databases automatically. You can specify additional databases using the `MYSQL_MULTIPLE_DATABASES` environment variable.

#### Usage:

1. **Using environment variable:**
   ```bash
   MYSQL_MULTIPLE_DATABASES="app1_db,app2_db,test_db" docker compose -f mysql.yml up
   ```

2. **Using .env file:**
   Create a `.env` file in the same directory:
   ```
   MYSQL_MULTIPLE_DATABASES=app1_db,app2_db,test_db
   ```
   Then run:
   ```bash
   docker compose -f mysql.yml up
   ```

3. **Copy the example file:**
   ```bash
   cp mysql.env.example .env
   # Edit .env file as needed
   docker compose -f mysql.yml up
   ```

#### Features:
- **Multiple Database Support**: Create multiple databases with a single container
- **Data Persistence**: All data is persisted using Docker volumes
- **User Permissions**: The configured user gets access to all created databases
- **Backward Compatibility**: Works with existing setups (creates `my_db` by default)