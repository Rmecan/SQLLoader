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
set DIR_LOG=%DIR_LOG%\%~n0
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem 一覧取得SQLの実行
set LIST_FILE=%DIR_LOG%\ListSequence.txt
if exist "%LIST_FILE%" del /q "%LIST_FILE%" 
SQLPLUS -S %DB_USERPASS% @"%DIR_BIN%\dbsource\GetDBSourceSequenceList.sql" > "%LIST_FILE%"

rem リストの件数分ループ
for /f "usebackq delims=" %%I in ("%LIST_FILE%") do (call :create_file %%I)

rem ------------------
rem 処理終了          
rem ------------------
echo 処理を終了しました。
exit /b %errorlevel%

rem ------------------
rem ファイル作成      
rem ------------------
:create_file

rem ソース取得SQLの実行
echo %1の目標値（現在値として設定する値）を入力してください。
set /p TARGET=skipを入力すると飛ばせます＞
if /i "%TARGET%" == "skip" exit /b %errorlevel%
call "%DIR_BIN%\util\IsNumeric.cmd" %TARGET%
if not %errorlevel% == 0 (
  echo 数字以外が入力されたのでやり直し
  goto create_file
)
SQLPLUS -S %DB_USERPASS% @"%DIR_BIN%\sequences\SetSequence.sql" %1 %TARGET% > %DIR_LOG%\%1.txt
type %DIR_LOG%\%1.txt
exit /b %errorlevel%
