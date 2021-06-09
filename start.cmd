@echo off 

rem ------------------
rem バッチ初期化
rem ------------------
:init_proc
set MIN_PAGE=1
set MAX_PAGE=1
set MAIN_PAGE=1

rem ------------------
rem メイン処理
rem ------------------
:main_proc

rem 変数初期化
set BAT_TITLE=メインメニュー
title %BAT_TITLE%
call "%~dp0\bin\SetConfig.cmd"
cd %~dp0
set USER_ANS=""

rem メインメニュー表示
call :show_main_%MAIN_PAGE%
goto main_proc

rem --------------
rem 処理終了      
rem --------------
:normal_end_proc
exit

rem ------------------
rem ページ送り(前へ)
rem ------------------
:show_pager_prev
set /a MAIN_PAGE=%MAIN_PAGE%-1
if %MAIN_PAGE% lss %MIN_PAGE% set MAIN_PAGE=%MIN_PAGE%
exit /b %errorlevel%

rem ------------------
rem ページ送り(次へ)
rem ------------------
:show_pager_next
set /a MAIN_PAGE=%MAIN_PAGE%+1
if %MAIN_PAGE% gtr %MAX_PAGE% set MAIN_PAGE=%MAX_PAGE%
exit /b %errorlevel%

rem ------------------
rem メイン処理(P1)
rem ------------------
:show_main_1
cls
echo /* %BAT_TITLE%  (%MAIN_PAGE%/%MAX_PAGE%) */
echo -----------------------------------------------------------------
echo Tips:
echo   現在のDB接続詞は[%DB_USERPASS%]です。
echo   不適合の場合は「bin\SetConfig.cmd」を修正してください。
echo.
echo 実行したい機能を選択してください
echo   1.Step1(Tebles.txt作成)
echo   2.Step2(*.CTL作成)　※予め、Step1を実行してください
echo   3.Step3(*.DAT作成)　※予め、Step1を実行してください
echo   4.Step4(LOADER実行) ※予め、Step1～3を実行してください
echo   5.シーケンス合せ
echo   6.テーブル毎の件数取得
echo   7.DBエクスポート
echo   8.DBソース取得 ※時間かかる
echo   9.
echo   0.
echo   h.ヘルプ
echo   e.Exit
echo -----------------------------------------------------------------
set /p USER_ANS="入力 >"

rem --------------
rem 処理分岐      
rem --------------
if /i "%USER_ANS%" EQU "1" call "%DIR_BIN%\tables\GetUserTables.cmd" && pause
if /i "%USER_ANS%" EQU "2" call "%DIR_BIN%\loader\GetLoaderCtl.cmd" && pause
if /i "%USER_ANS%" EQU "3" call "%DIR_BIN%\loader\GetLoaderDat.cmd" && pause
if /i "%USER_ANS%" EQU "4" call "%DIR_BIN%\loader\StartLoader.cmd" && pause
if /i "%USER_ANS%" EQU "5" call "%DIR_BIN%\sequences\SetSequence.cmd" && pause
if /i "%USER_ANS%" EQU "6" call "%DIR_BIN%\tables\CountRowsByTables.cmd" && pause
if /i "%USER_ANS%" EQU "7" call "%DIR_BIN%\dbsource\ExportDmp.cmd" && pause
if /i "%USER_ANS%" EQU "8" call "%DIR_BIN%\dbsource\GetDBSource.cmd" && pause
if /i "%USER_ANS%" EQU "9" echo>NUL
if /i "%USER_ANS%" EQU "0" echo>NUL
if /i "%USER_ANS%" EQU "e" goto normal_end_proc
if /i "%USER_ANS%" EQU "h" more < "%DIR_HOME%\help.txt" && pause
if /i "%USER_ANS%" EQU ">" call :show_pager_next
if /i "%USER_ANS%" EQU "<" call :show_pager_prev

exit /b %errorlevel%
