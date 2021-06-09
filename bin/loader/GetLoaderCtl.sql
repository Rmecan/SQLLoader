SET HEADING OFF;
SET NEWPAGE NONE;
SET FEEDBACK OFF;
SET PAGESIZE 0;
SET VERIFY OFF;
SET TAB OFF;
SET TRIMSPOOL ON;
SET LINESIZE 32767;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

-- ŒÅ’è’l
SELECT 'LOAD DATA' FROM dual;
SELECT 'INFILE ''&1' || '.DAT''' FROM dual;
SELECT 'TRUNCATE' FROM dual;
SELECT 'PRESERVE BLANKS' FROM dual;
SELECT 'INTO TABLE &1' FROM dual;
SELECT 'FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY ''"''' FROM dual;
SELECT 'TRAILING NULLCOLS' FROM dual;
SELECT '(' FROM dual;
-- •s‰Â•Ï•”•ª(—ñ–¼‚ð—ñ‹“)
SELECT (CASE column_id WHEN 1 THEN ' ' ELSE ',' END)
    || '"' || column_name || '"' 
    || (CASE data_type 
        WHEN 'DATE' THEN ' DATE(19) "YYYY/MM/DD HH24:Mi:SS"'
        ELSE ''
        END)
  FROM dba_tab_columns 
 WHERE owner || '.' || table_name = UPPER('&1')
 ORDER BY column_id;
-- ŒÅ’è’l
SELECT ')' FROM dual;

EXIT;
