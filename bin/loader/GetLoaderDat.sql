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
SELECT 'SET HEADING OFF;' FROM dual;
SELECT 'SET NEWPAGE NONE;' FROM dual;
SELECT 'SET HEADING OFF;' FROM dual;
SELECT 'SET FEEDBACK OFF;' FROM dual;
SELECT 'SET PAGESIZE 0;' FROM dual;
SELECT 'SET VERIFY OFF;' FROM dual;
SELECT 'SET TAB OFF;' FROM dual;
SELECT 'SET TRIMSPOOL ON;' FROM dual;
SELECT 'SET LINESIZE 32767;' FROM dual;
-- •s‰Â•Ï•”•ª(—ñ–¼‚ð—ñ‹“)
SELECT (CASE column_id WHEN 1 THEN 'SELECT ' ELSE '    || '','' || ' END) 
    || (CASE data_type 
        WHEN 'NUMBER' THEN '' || column_name || ' '
        WHEN 'DATE' THEN '''"'' || TO_CHAR(' || column_name || ',''YYYY/MM/DD HH24:Mi:SS'') || ''"'''
        ELSE '''"'' || REPLACE(' || column_name || ', ''"'', ''""'') || ''"'''
        END) 
  FROM dba_tab_columns 
 WHERE owner || '.' || table_name = UPPER('&1')
 ORDER BY column_id;
-- ŒÅ’è’l
SELECT '  FROM &1; ' FROM dual;
SELECT 'EXIT;' FROM dual;

EXIT;
