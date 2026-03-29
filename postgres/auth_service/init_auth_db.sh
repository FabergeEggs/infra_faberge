#!/bin/bash
set -e
 
#Значение команд
#1)Запретить подключение к этой БД всем остальным по умолчанию
#2)Явно выдать права только владельцу + пользователь создан через POSTGRES_USER
#3)Будущие таблицы будут принадлежать POSTGRES_USER

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_AUTH" --dbname "$POSTGRES_DB_AUTH" <<-EOSQL
 
    REVOKE ALL ON DATABASE "$POSTGRES_DB_AUTH" FROM PUBLIC;
    GRANT CONNECT ON DATABASE "$POSTGRES_DB_AUTH" TO "$POSTGRES_USER_AUTH";
    GRANT ALL PRIVILEGES ON SCHEMA public TO "$POSTGRES_USER_AUTH";
 
    ALTER DEFAULT PRIVILEGES FOR ROLE "$POSTGRES_USER_AUTH"
        IN SCHEMA public
        GRANT ALL ON TABLES TO "$POSTGRES_USER_AUTH";
 
    ALTER DEFAULT PRIVILEGES FOR ROLE "$POSTGRES_USER_AUTH"
        IN SCHEMA public
        GRANT ALL ON SEQUENCES TO "$POSTGRES_USER_AUTH";
 
EOSQL
 
echo "Init completed - DB: $POSTGRES_DB_AUTH / user: $POSTGRES_USER_AUTH"