@echo off
rem ���͒l���������̕��������ǂ������`�F�b�N���܂�
rem ���� %1 ���͒l
rem      %2 ����

rem ------------------
rem �o�b�`������
rem ------------------
set RESULT=TRUE
set ARG1=%1
set LENGTH=%2
set WK_CHAR=
set WK_COUNT=0

rem ------------------
rem ���C������
rem ------------------
:main_proc

rem �擪1�������o
if "%ARG1%" EQU "" goto normal_end_proc
set WK_CHAR=%ARG1:~0,1%
set ARG1=%ARG1:~1%

rem �������J�E���g�A�b�v
set /a WK_COUNT=%WK_COUNT%+1

rem �`�F�b�N����
if "%WK_CHAR%" NEQ "" goto main_proc

goto error_end_proc

rem ------------------
rem ���폈���I��
rem ------------------
:normal_end_proc
if %WK_COUNT% == %LENGTH% (
    set RESULT=TRUE
    exit /b 0
)
set RESULT=FALSE
exit /b 1

rem ------------------
rem �ُ폈���I��
rem ------------------
:error_end_proc
set RESULT=FALSE
exit /b 1
