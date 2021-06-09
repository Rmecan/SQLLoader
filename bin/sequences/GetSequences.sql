SET HEADING OFF;
SET NEWPAGE NONE;
SET FEEDBACK OFF;
SET PAGESIZE 0;
SET VERIFY OFF;
SET TAB OFF;
SET TRIMSPOOL ON;
SET LINESIZE 32767;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

-- �Œ�l
SELECT 'SET HEADING OFF;' FROM dual;
SELECT 'SET NEWPAGE NONE;' FROM dual;
SELECT 'SET HEADING OFF;' FROM dual;
SELECT 'SET FEEDBACK OFF;' FROM dual;
SELECT 'SET PAGESIZE 0;' FROM dual;
SELECT 'SET VERIFY OFF;' FROM dual;
SELECT 'SET TAB OFF;' FROM dual;
SELECT 'SET TRIMSPOOL ON;' FROM dual;
SELECT 'SET LINESIZE 32767;' FROM dual;
SELECT 'WHENEVER SQLERROR EXIT FAILURE ROLLBACK;' FROM dual;
-- �s�ϕ���(�V�[�P���X�����)
SELECT 'DROP SEQUENCE ' || SEQUENCE_NAME || ';' || CHR(10)
    || 'CREATE SEQUENCE ' || SEQUENCE_NAME
    || ' START WITH ' || to_char(LAST_NUMBER)
    || ' INCREMENT BY ' || to_char(INCREMENT_BY)
    || ' MAXVALUE ' || to_char(MAX_VALUE)
    || ' MINVALUE ' || to_char(MIN_VALUE)
    || CASE CYCLE_FLAG WHEN 'N' THEN ' NOCYCLE'  ELSE  ' CYCLE' END
    || CASE ORDER_FLAG WHEN 'N' THEN ' NOORDER'  ELSE ' ORDER' END
    || CASE CACHE_SIZE WHEN 0   THEN ' NOCACHE' ELSE  ' CACHE ' || to_char(CACHE_SIZE) END
    || ';'
FROM user_sequences 
ORDER BY SEQUENCE_NAME;
-- �Œ�l
SELECT 'EXIT;' FROM DUAL;

EXIT;