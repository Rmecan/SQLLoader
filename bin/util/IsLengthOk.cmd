@echo off
rem 入力値が桁数分の文字数かどうかをチェックします
rem 引数 %1 入力値
rem      %2 桁数

rem ------------------
rem バッチ初期化
rem ------------------
set RESULT=TRUE
set ARG1=%1
set LENGTH=%2
set WK_CHAR=
set WK_COUNT=0

rem ------------------
rem メイン処理
rem ------------------
:main_proc

rem 先頭1文字抽出
if "%ARG1%" EQU "" goto normal_end_proc
set WK_CHAR=%ARG1:~0,1%
set ARG1=%ARG1:~1%

rem 文字数カウントアップ
set /a WK_COUNT=%WK_COUNT%+1

rem チェック処理
if "%WK_CHAR%" NEQ "" goto main_proc

goto error_end_proc

rem ------------------
rem 正常処理終了
rem ------------------
:normal_end_proc
if %WK_COUNT% == %LENGTH% (
    set RESULT=TRUE
    exit /b 0
)
set RESULT=FALSE
exit /b 1

rem ------------------
rem 異常処理終了
rem ------------------
:error_end_proc
set RESULT=FALSE
exit /b 1
