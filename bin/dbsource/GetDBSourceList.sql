SET HEADING OFF;
SET NEWPAGE NONE;
SET FEEDBACK OFF;
SET PAGESIZE 0;
SET VERIFY OFF;
SET TAB OFF;
SET TRIMSPOOL ON;
SET LINESIZE 32767;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

SELECT name 
FROM   user_source 
WHERE  type = UPPER('&1') 
AND    name not like 'BIN$%' -- さすがにゴミ箱にあるやつは要らない
GROUP BY name 
ORDER BY name;

EXIT;
