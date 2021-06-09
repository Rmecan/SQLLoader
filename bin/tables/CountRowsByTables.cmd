@echo off
title %~n0

if not %errorlevel% == 0 (
    echo キャンセルしたかエラーが発生しているため、%~n0を実行できませんでした。
    echo 詳細はログを参照してください。
    exit /b %errorlevel%
)

rem ------------------
rem 環境変数セット    
rem ------------------
call "%SETCONFIG%"

rem ------------------
rem ログ出力先を変える
rem ------------------
set DIR_LOG=%DIR_LOG%\%~n0
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem ------------------
rem COUNT実行         
rem ------------------
call :count_tables

rem ------------------
rem 処理終了          
rem ------------------
exit /b %errorlevel%

rem ▼ここから下はサブプロシージャ
rem ------------------
rem COUNT実行         
rem ------------------
:count_tables
rem COUNTするためのSQLを生成
set SQL_FILE=%DIR_TMP%\SELECT_COUNT_FROM_TABLE.SQL
SQLPLUS -S %DB_USERPASS% @"%~dpn0.sql" > "%SQL_FILE%"

rem 吐き出すファイル名を生成
set DST_FILE=%SYSDATE14%_CountTable.txt

rem SQLを実行
SQLPLUS -S %DB_USERPASS% @"%SQL_FILE%" > "%DIR_LOG%\%DST_FILE%"
if exist "%SQL_FILE%" del /q "%SQL_FILE%"
echo 「log\%~n0\%DST_FILE%」に書き出しました。

exit /b %errorlevel%
