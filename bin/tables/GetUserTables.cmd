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
if exist "%TBL_FILE%" del /q "%TBL_FILE%"

rem ------------------
rem ファイル作成      
rem ------------------
echo テーブル構成を「tmp\Tables.txt」に書き出します。
SQLPLUS -S %DB_USERPASS% @"%~dpn0.sql" > "%TBL_FILE%"

rem ------------------
rem 処理終了          
rem ------------------
exit /b %errorlevel%
