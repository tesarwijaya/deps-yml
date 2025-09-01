#!/bin/bash
# Script to initialize multiple MySQL databases
# Usage: Set MYSQL_MULTIPLE_DATABASES environment variable with comma-separated database names
# Example: MYSQL_MULTIPLE_DATABASES="app1_db,app2_db,test_db"

set -e

echo "Multiple database initialization script started"

if [ -n "$MYSQL_MULTIPLE_DATABASES" ]; then
    echo "Creating multiple databases: $MYSQL_MULTIPLE_DATABASES"
    
    # Split the comma-separated database names
    IFS=',' read -ra DBS <<< "$MYSQL_MULTIPLE_DATABASES"
    
    for db in "${DBS[@]}"; do
        # Trim whitespace
        db=$(echo "$db" | xargs)
        
        if [ -n "$db" ]; then
            echo "Creating database: $db"
            mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$db\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
            
            # Grant privileges to the user if MYSQL_USER is set
            if [ -n "$MYSQL_USER" ]; then
                echo "Granting privileges on $db to user $MYSQL_USER"
                mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$db\`.* TO '$MYSQL_USER'@'%';"
            fi
        fi
    done
    
    # Flush privileges
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
    echo "Multiple databases created successfully"
else
    echo "MYSQL_MULTIPLE_DATABASES not set, skipping multiple database creation"
fi

echo "Multiple database initialization script completed"