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
if exist "%DIR_CTL%\*.CTL" del /q "%DIR_CTL%\*.CTL"

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
echo %1.CTLを生成します。
SQLPLUS -S %DB_USERPASS_SYSDBA% as sysdba @"%~dpn0.sql" %1 > "%DIR_CTL%\%1.CTL"

exit /b %errorlevel%
