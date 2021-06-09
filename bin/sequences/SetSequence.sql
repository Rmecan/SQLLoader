/**
 * オラクルシーケンスの現在値を目標値で更新する
 *
 * Parameter
 * ------------------------
 * &1 varchar2(100)
 *     シーケンス名
 * &2 number
 *     目標値(シーケンスの現在値をこの値にする)
 */
SET SERVEROUTPUT ON;
DECLARE
  WK_MESSAGE        VARCHAR2(32767) := '';
  WK_SEQ_NAME       VARCHAR2(  100) := '&1';
  WK_SEQ_NOW        NUMBER := -1;
  WK_SEQ_TARGET     NUMBER := &2;
  WK_USER_SEQUENCES USER_SEQUENCES%ROWTYPE;
BEGIN
  -- シーケンス定義を取得
  BEGIN
    SELECT * INTO WK_USER_SEQUENCES
    FROM   USER_SEQUENCES
    WHERE UPPER(SEQUENCE_NAME) = UPPER(WK_SEQ_NAME);
  EXCEPTION
    WHEN OTHERS THEN
      WK_MESSAGE := 'シーケンス定義の取得に失敗しました。';
      WK_MESSAGE := WK_MESSAGE || ' シーケンス名：' || TO_CHAR(WK_USER_SEQUENCES.MIN_VALUE);
      GOTO END_PROC;
  END;
  
  -- 範囲外の目標値は無視する
  IF WK_SEQ_TARGET < WK_USER_SEQUENCES.MIN_VALUE OR WK_USER_SEQUENCES.MAX_VALUE < WK_SEQ_TARGET THEN
    WK_MESSAGE := '目標値に範囲外の値がセットされました。';
    WK_MESSAGE := WK_MESSAGE || ' 適正範囲：' || TO_CHAR(WK_USER_SEQUENCES.MIN_VALUE) || ' ～ ' || TO_CHAR(WK_USER_SEQUENCES.MAX_VALUE);
    WK_MESSAGE := WK_MESSAGE || ' 実際の値：' || TO_CHAR(WK_SEQ_TARGET);
    GOTO END_PROC;
  END IF;
  
/*
  -- 現在値を知るためにとりあえずシーケンス進める
  SELECT "&1".NEXTVAL INTO WK_SEQ_NOW FROM DUAL;

  IF WK_SEQ_TARGET = WK_SEQ_NOW THEN
    -- たまたま目標値に到達したらすることないのでおしまい
    GOTO NORMAL_END;
  END IF;

  -- 「目標値 - 現在値」をインクリメントにセット
  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || WK_SEQ_NAME || ' INCREMENT BY ' || TO_CHAR(WK_SEQ_TARGET - WK_SEQ_NOW);

  -- 再度シーケンスを進めて目標値に到達
  SELECT "&1".NEXTVAL INTO WK_SEQ_NOW FROM DUAL;

  -- インクリメントを元に戻す
  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || WK_SEQ_NAME || ' INCREMENT BY ' || TO_CHAR(WK_USER_SEQUENCES.INCREMENT_BY);
*/
  -- 上で解決しない場合、ごりおす
  WHILE ( WK_SEQ_NOW <> WK_SEQ_TARGET) LOOP
    SELECT "&1".NEXTVAL INTO WK_SEQ_NOW FROM DUAL;
  END LOOP;

<<NORMAL_END>>
  WK_MESSAGE := WK_SEQ_NAME || 'の現在値を'  || WK_SEQ_NOW || 'にしました。';
  WK_MESSAGE := WK_MESSAGE  || ' 目標値：'   || WK_SEQ_TARGET;
  WK_MESSAGE := WK_MESSAGE  || ' 適正範囲：' || TO_CHAR(WK_USER_SEQUENCES.MIN_VALUE) || ' ～ ' || TO_CHAR(WK_USER_SEQUENCES.MAX_VALUE);

<<END_PROC>>
  IF TRIM(WK_MESSAGE) IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE(WK_MESSAGE);
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT('予期せぬエラーの発生');
END;
/
QUIT;
