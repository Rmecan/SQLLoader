/**
 * �I���N���V�[�P���X�̌��ݒl��ڕW�l�ōX�V����
 *
 * Parameter
 * ------------------------
 * &1 varchar2(100)
 *     �V�[�P���X��
 * &2 number
 *     �ڕW�l(�V�[�P���X�̌��ݒl�����̒l�ɂ���)
 */
SET SERVEROUTPUT ON;
DECLARE
  WK_MESSAGE        VARCHAR2(32767) := '';
  WK_SEQ_NAME       VARCHAR2(  100) := '&1';
  WK_SEQ_NOW        NUMBER := -1;
  WK_SEQ_TARGET     NUMBER := &2;
  WK_USER_SEQUENCES USER_SEQUENCES%ROWTYPE;
BEGIN
  -- �V�[�P���X��`���擾
  BEGIN
    SELECT * INTO WK_USER_SEQUENCES
    FROM   USER_SEQUENCES
    WHERE UPPER(SEQUENCE_NAME) = UPPER(WK_SEQ_NAME);
  EXCEPTION
    WHEN OTHERS THEN
      WK_MESSAGE := '�V�[�P���X��`�̎擾�Ɏ��s���܂����B';
      WK_MESSAGE := WK_MESSAGE || ' �V�[�P���X���F' || TO_CHAR(WK_USER_SEQUENCES.MIN_VALUE);
      GOTO END_PROC;
  END;
  
  -- �͈͊O�̖ڕW�l�͖�������
  IF WK_SEQ_TARGET < WK_USER_SEQUENCES.MIN_VALUE OR WK_USER_SEQUENCES.MAX_VALUE < WK_SEQ_TARGET THEN
    WK_MESSAGE := '�ڕW�l�ɔ͈͊O�̒l���Z�b�g����܂����B';
    WK_MESSAGE := WK_MESSAGE || ' �K���͈́F' || TO_CHAR(WK_USER_SEQUENCES.MIN_VALUE) || ' �` ' || TO_CHAR(WK_USER_SEQUENCES.MAX_VALUE);
    WK_MESSAGE := WK_MESSAGE || ' ���ۂ̒l�F' || TO_CHAR(WK_SEQ_TARGET);
    GOTO END_PROC;
  END IF;
  
/*
  -- ���ݒl��m�邽�߂ɂƂ肠�����V�[�P���X�i�߂�
  SELECT "&1".NEXTVAL INTO WK_SEQ_NOW FROM DUAL;

  IF WK_SEQ_TARGET = WK_SEQ_NOW THEN
    -- ���܂��ܖڕW�l�ɓ��B�����炷�邱�ƂȂ��̂ł����܂�
    GOTO NORMAL_END;
  END IF;

  -- �u�ڕW�l - ���ݒl�v���C���N�������g�ɃZ�b�g
  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || WK_SEQ_NAME || ' INCREMENT BY ' || TO_CHAR(WK_SEQ_TARGET - WK_SEQ_NOW);

  -- �ēx�V�[�P���X��i�߂ĖڕW�l�ɓ��B
  SELECT "&1".NEXTVAL INTO WK_SEQ_NOW FROM DUAL;

  -- �C���N�������g�����ɖ߂�
  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || WK_SEQ_NAME || ' INCREMENT BY ' || TO_CHAR(WK_USER_SEQUENCES.INCREMENT_BY);
*/
  -- ��ŉ������Ȃ��ꍇ�A���肨��
  WHILE ( WK_SEQ_NOW <> WK_SEQ_TARGET) LOOP
    SELECT "&1".NEXTVAL INTO WK_SEQ_NOW FROM DUAL;
  END LOOP;

<<NORMAL_END>>
  WK_MESSAGE := WK_SEQ_NAME || '�̌��ݒl��'  || WK_SEQ_NOW || '�ɂ��܂����B';
  WK_MESSAGE := WK_MESSAGE  || ' �ڕW�l�F'   || WK_SEQ_TARGET;
  WK_MESSAGE := WK_MESSAGE  || ' �K���͈́F' || TO_CHAR(WK_USER_SEQUENCES.MIN_VALUE) || ' �` ' || TO_CHAR(WK_USER_SEQUENCES.MAX_VALUE);

<<END_PROC>>
  IF TRIM(WK_MESSAGE) IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE(WK_MESSAGE);
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT('�\�����ʃG���[�̔���');
END;
/
QUIT;
