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
rem ログ削除          
rem ------------------
if exist "%DIR_LOG%\*.LOG" del /q "%DIR_LOG%\*.LOG"
if exist "%DIR_LOG%\*.BAD" del /q "%DIR_LOG%\*.BAD"
if exist "%DIR_LOG%\*.DSC" del /q "%DIR_LOG%\*.DSC"

rem ------------------
rem 実行確認
rem ------------------
set LOADER_ANS=
set /p LOADER_ANS="ローダーを実行します。よろしいですか？（y/N）＞"
if /i not "%LOADER_ANS%" EQU "y" goto negative

rem ------------------
rem ローダー実行      
rem ------------------
rem テーブルの件数分ループ
for /f "usebackq delims=" %%I in ("%TBL_FILE%") do ( call :do_start %%I )
goto sub_end

:negative
echo 処理を中止しました。
goto sub_end

rem ------------------
rem 処理終了          
rem ------------------
:sub_end
exit /b %errorlevel%

rem ▼ここから下はサブプロシージャ
rem ------------------
rem ローダー実行      
rem ------------------
:do_start

set CTL_FILE="%DIR_CTL%\%1.CTL"
set DAT_FILE="%DIR_DAT%\%1.DAT"
set LOG_FILE="%DIR_LOG%\%1.LOG"
set BAD_FILE="%DIR_LOG%\%1.BAD"
set DSC_FILE="%DIR_LOG%\%1.DSC"
cd "%DIR_DAT%"
echo %1をロードします。
SQLLDR USERID=%DB_USERPASS% SILENT=HEADER,FEEDBACK CONTROL=%CTL_FILE% DATA=%DAT_FILE% LOG=%LOG_FILE% BAD=%BAD_FILE% DISCARD=%DSC_FILE%


rem ログ出力
if %errorlevel% == 0 (set RESULT=成功) else (set RESULT=失敗)
echo %1のロードに%RESULT%しました。 >> "%DIR_LOG%\SQLLDR_REVIEW.LOG"

exit /b %errorlevel%
