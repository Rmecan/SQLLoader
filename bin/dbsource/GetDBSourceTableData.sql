SET HEADING OFF;
SET NEWPAGE NONE;
SET FEEDBACK OFF;
SET PAGESIZE 0;
SET VERIFY OFF;
SET TAB OFF;
SET TRIMSPOOL ON;
SET LINESIZE 32767;
SET LONG 100000;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

SELECT dbms_metadata.get_ddl('TABLE', all_tables.table_name, all_tables.owner)
FROM   all_tables, user_tables 
WHERE  all_tables.table_name = user_tables.table_name
AND    UPPER(all_tables.table_name) = UPPER('&1');

EXIT;
