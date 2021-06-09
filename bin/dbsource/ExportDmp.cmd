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
echo DBダンプ取得
cd "%DIR_LOG%"
exp %DB_USERPASS% -buffer=4096 -file="%SYSDATE14%.DMP" -log="%SYSDATE14%_EXP.LOG"

exit /b %errorlevel%
