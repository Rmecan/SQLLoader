@echo off
rem 入力値が半角英字かどうかをチェックします
rem 引数 %1 入力値

rem ------------------
rem バッチ初期化
rem ------------------
set RESULT=TRUE
set ARG1=%1
set WK_CHAR=

rem ------------------
rem メイン処理
rem ------------------
:main_proc

rem 先頭1文字抽出
if "%ARG1%" EQU "" goto normal_end_proc
set WK_CHAR=%ARG1:~0,1%
set ARG1=%ARG1:~1%

rem チェック処理
if "%WK_CHAR%" EQU "" goto normal_end_proc
if /i "%WK_CHAR%" EQU "a" goto main_proc
if /i "%WK_CHAR%" EQU "b" goto main_proc
if /i "%WK_CHAR%" EQU "c" goto main_proc
if /i "%WK_CHAR%" EQU "d" goto main_proc
if /i "%WK_CHAR%" EQU "e" goto main_proc
if /i "%WK_CHAR%" EQU "f" goto main_proc
if /i "%WK_CHAR%" EQU "g" goto main_proc
if /i "%WK_CHAR%" EQU "h" goto main_proc
if /i "%WK_CHAR%" EQU "i" goto main_proc
if /i "%WK_CHAR%" EQU "j" goto main_proc
if /i "%WK_CHAR%" EQU "k" goto main_proc
if /i "%WK_CHAR%" EQU "l" goto main_proc
if /i "%WK_CHAR%" EQU "m" goto main_proc
if /i "%WK_CHAR%" EQU "n" goto main_proc
if /i "%WK_CHAR%" EQU "o" goto main_proc
if /i "%WK_CHAR%" EQU "p" goto main_proc
if /i "%WK_CHAR%" EQU "q" goto main_proc
if /i "%WK_CHAR%" EQU "r" goto main_proc
if /i "%WK_CHAR%" EQU "s" goto main_proc
if /i "%WK_CHAR%" EQU "t" goto main_proc
if /i "%WK_CHAR%" EQU "u" goto main_proc
if /i "%WK_CHAR%" EQU "v" goto main_proc
if /i "%WK_CHAR%" EQU "w" goto main_proc
if /i "%WK_CHAR%" EQU "x" goto main_proc
if /i "%WK_CHAR%" EQU "w" goto main_proc
if /i "%WK_CHAR%" EQU "z" goto main_proc

goto error_end_proc

rem ------------------
rem 正常処理終了
rem ------------------
:normal_end_proc
set RESULT=TRUE
exit /b 0

rem ------------------
rem 異常処理終了
rem ------------------
:error_end_proc
set RESULT=FALSE
exit /b 1
