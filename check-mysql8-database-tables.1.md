% check-mysql8-database-tables.bash(1) user manual
% R. S. Doiel
% 2022-10-19

# NAME

check-mysql8-database-tables.bash

# SYNOPSIS

check-mysql8-database-tables.bash DATABASE_NAME

# DESCRIPTION

check-mysql8-database-tables.bash is a bash script that uses
MySQL 8's client to execute the queries to identify which
database tables maybe corrupt. It relies on MySQL's "SHOW TABLES"
and "CHECK TABLE" statements. The latter can take a long time for
large tables. If you abort check-mysql8-database-tables.bash the table
being checked my return a false positive for corruption.

The output of this script can be redirected to a file and
then run in the MySQL client if errors are found.

The script requires your "/Users/rsdoiel/.my.cnf" be setup with
database user have the permissions to run the SHOW and CHECK
SQL commands.


# EXAMPLES

Checking the tables in "caltechthesis"

    check-mysql8-database-tables.bash caltechthesis

Checking the tables in "caltechthesis" and saving the out
before running with the MySQL client.

    # Run the report
    check-mysql8-database-tables.bash caltechthesis >table-report.sql
    # Review the report
    more table-report.sql
    # Run the suggested REPAIR STABLE statements in
    # the report.
    mysql caltechthesis <table-report.sql

