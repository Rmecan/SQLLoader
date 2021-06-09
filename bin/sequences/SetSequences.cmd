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
set CREATE_SEQUENSES_PATH=%DIR_LOG%\GetSequences\CreateSequenses.sql

rem ------------------
rem ログ出力先を変える
rem ------------------
set DIR_LOG=%DIR_LOG%\%~n0
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem ------------------
rem ファイル作成      
rem ------------------
SQLPLUS -S %DB_USERPASS% @"%CREATE_SEQUENSES_PATH%" > "%DIR_LOG%\CreateSequenses実行ログ.txt"

rem ------------------
rem 処理終了          
rem ------------------
exit /b %errorlevel%
