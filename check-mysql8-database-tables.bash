#!/bin/bash

function usage() {
    APP_NAME="$(basename "$0")"
    cat <<EOT
% ${APP_NAME}(1) user manual
% R. S. Doiel
% 2022-10-19

# NAME

${APP_NAME}

# SYNOPSIS

${APP_NAME} DATABASE_NAME

# DESCRIPTION

${APP_NAME} is a bash script that uses
MySQL 8's client to execute the queries to identify which
database tables maybe corrupt. It relies on MySQL's "SHOW TABLES"
and "CHECK TABLE" statements. The latter can take a long time for
large tables. If you abort ${APP_NAME} the table
being checked my return a false positive for corruption.

The output of this script can be redirected to a file and
then run in the MySQL client if errors are found.

The script requires your "$HOME/.my.cnf" be setup with
database user have the permissions to run the SHOW and CHECK
SQL commands.


# EXAMPLES

Checking the tables in "caltechthesis"

    ${APP_NAME} caltechthesis

Checking the tables in "caltechthesis" and saving the out
before running with the MySQL client.

    # Run the report
    ${APP_NAME} caltechthesis >table-report.sql
    # Review the report
    more table-report.sql
    # Run the suggested REPAIR STABLE statements in
    # the report.
    mysql caltechthesis <table-report.sql

EOT
}

function run_mysql_query() {
    DB_NAME="$1"
    QUERY="$2"
    mysql "$DB_NAME" --batch --skip-column-names --execute "${QUERY}"
}

function check_table_in_database() {
    DB_NAME="$1"
    TABLE="$2"
    printf '# %s,' "$TABLE"
    RESULT=$(run_mysql_query "$DB_NAME" "CHECK TABLE $TABLE" | grep -v 'OK')
    if [ "$RESULT" = "" ]; then
        printf ' OK\n'
    else
        printf ' %s\n' "$RESULT"
        printf 'REPAIR TABLE %s;\n' "$TABLE"
    fi
}

function check_database() {
    DB_NAME="$1"
    printf "USE %s;\n" "$DB_NAME"
    TABLES=$(run_mysql_query "$DB_NAME" "SHOW TABLES")
    for TABLE in $TABLES; do
        check_table_in_database "${DB_NAME}" "${TABLE}"
    done
}

#
# Main processing
#
case $1 in
-h | -help | --help)
    usage
    exit 0
    ;;
esac
DB_NAME="$1"
if [ "$DB_NAME" = "" ]; then
    usage
    exit 1
fi
check_database "${DB_NAME}"
