@echo off
rem ���͒l�����l���ǂ������`�F�b�N���܂�
rem ���� %1 ���͒l

rem ------------------
rem �o�b�`������
rem ------------------
set RESULT=TRUE
set ARG1=%1
set WK_CHAR=

rem ------------------
rem ���C������
rem ------------------
:main_proc

rem �擪1�������o
if "%ARG1%" EQU "" goto normal_end_proc
set WK_CHAR=%ARG1:~0,1%
set ARG1=%ARG1:~1%

rem �`�F�b�N����
if "%WK_CHAR%" EQU "" goto normal_end_proc
if "%WK_CHAR%" EQU "0" goto main_proc
if "%WK_CHAR%" EQU "1" goto main_proc
if "%WK_CHAR%" EQU "2" goto main_proc
if "%WK_CHAR%" EQU "3" goto main_proc
if "%WK_CHAR%" EQU "4" goto main_proc
if "%WK_CHAR%" EQU "5" goto main_proc
if "%WK_CHAR%" EQU "6" goto main_proc
if "%WK_CHAR%" EQU "7" goto main_proc
if "%WK_CHAR%" EQU "8" goto main_proc
if "%WK_CHAR%" EQU "9" goto main_proc
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
