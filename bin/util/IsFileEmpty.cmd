@echo off
rem ���͒l�����p�p�����ǂ������`�F�b�N���܂�
rem ���� %1 ���͒l

rem ------------------
rem �o�b�`������
rem ------------------
set RESULT=TRUE
set ARG1=%1
set ARG1=%ARG1:"=%

rem ------------------
rem ���C������
rem ------------------
:main_proc

if not exist "%ARG1%" goto error_end_proc
for %%F in ("%ARG1%") do (
    if %%~zF == 0  goto normal_end_proc
)
goto error_end_proc

rem ------------------
rem ���폈���I��
rem ------------------
:normal_end_proc
set RESULT=TRUE
exit /b 0

rem ------------------
rem �ُ폈���I��
rem ------------------
:error_end_proc
set RESULT=FALSE
exit /b 1
