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
rem ファイル作成      
rem ------------------
echo シーケンス作成スクリプトを「log\CreateSequenses.sql」に書き出します。
SQLPLUS -S %DB_USERPASS% @"%~dpn0.sql" > "%DIR_LOG%\CreateSequenses.sql"

rem ------------------
rem 処理終了          
rem ------------------
exit /b %errorlevel%
