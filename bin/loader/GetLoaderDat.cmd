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
rem ファイル削除      
rem ------------------
if exist "%DIR_DAT%\*.DAT" del /q "%DIR_DAT%\*.DAT"

rem ------------------
rem ファイル作成      
rem ------------------
rem テーブルの件数分ループ
for /f "usebackq delims=" %%I in ("%TBL_FILE%") do ( call :create_file %%I )

rem ------------------
rem 処理終了          
rem ------------------
exit /b %errorlevel%

rem ▼ここから下はサブプロシージャ
rem ------------------
rem ファイル作成      
rem ------------------
:create_file

rem DATファイルを抜くためのSQLを生成
set SQL_FILE=%DIR_TMP%\%1.SQL
SQLPLUS -S %DB_USERPASS_SYSDBA% as sysdba @"%~dpn0.sql" %1 > "%SQL_FILE%"

echo %1.DATを生成します。
SQLPLUS -S %DB_USERPASS_SYSDBA% as sysdba @"%SQL_FILE%" > "%DIR_DAT%\%1.DAT"
if exist "%SQL_FILE%" del /q "%SQL_FILE%"

exit /b %errorlevel%
