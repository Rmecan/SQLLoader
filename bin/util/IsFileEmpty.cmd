@echo off
rem 入力値が半角英字かどうかをチェックします
rem 引数 %1 入力値

rem ------------------
rem バッチ初期化
rem ------------------
set RESULT=TRUE
set ARG1=%1
set ARG1=%ARG1:"=%

rem ------------------
rem メイン処理
rem ------------------
:main_proc

if not exist "%ARG1%" goto error_end_proc
for %%F in ("%ARG1%") do (
    if %%~zF == 0  goto normal_end_proc
)
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
