SET HEADING OFF;
SET NEWPAGE NONE;
SET FEEDBACK OFF;
SET PAGESIZE 0;
SET VERIFY OFF;
SET TAB OFF;
SET TRIMSPOOL ON;
SET LINESIZE 32767;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

SELECT text 
FROM   user_source 
WHERE  name = '&1'
ORDER BY line;

EXIT;
