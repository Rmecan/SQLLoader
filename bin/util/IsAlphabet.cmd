@echo off
rem ���͒l�����p�p�����ǂ������`�F�b�N���܂�
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
