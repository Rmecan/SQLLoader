@echo off
title %~n0

if not %errorlevel% == 0 (
    echo �L�����Z���������G���[���������Ă��邽�߁A%~n0�����s�ł��܂���ł����B
    echo �ڍׂ̓��O���Q�Ƃ��Ă��������B
    exit /b %errorlevel%
)

rem ------------------
rem ���ϐ��Z�b�g    
rem ------------------
call "%SETCONFIG%"

rem ------------------
rem ���O�o�͐��ς���
rem ------------------
set DIR_LOG=%DIR_LOG%\%~n0
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem ------------------
rem ���O�폜          
rem ------------------
if exist "%DIR_LOG%\*.LOG" del /q "%DIR_LOG%\*.LOG"
if exist "%DIR_LOG%\*.BAD" del /q "%DIR_LOG%\*.BAD"
if exist "%DIR_LOG%\*.DSC" del /q "%DIR_LOG%\*.DSC"

rem ------------------
rem ���s�m�F
rem ------------------
set LOADER_ANS=
set /p LOADER_ANS="���[�_�[�����s���܂��B��낵���ł����H�iy/N�j��"
if /i not "%LOADER_ANS%" EQU "y" goto negative

rem ------------------
rem ���[�_�[���s      
rem ------------------
rem �e�[�u���̌��������[�v
for /f "usebackq delims=" %%I in ("%TBL_FILE%") do ( call :do_start %%I )
goto sub_end

:negative
echo �����𒆎~���܂����B
goto sub_end

rem ------------------
rem �����I��          
rem ------------------
:sub_end
exit /b %errorlevel%

rem ���������牺�̓T�u�v���V�[�W��
rem ------------------
rem ���[�_�[���s      
rem ------------------
:do_start

set CTL_FILE="%DIR_CTL%\%1.CTL"
set DAT_FILE="%DIR_DAT%\%1.DAT"
set LOG_FILE="%DIR_LOG%\%1.LOG"
set BAD_FILE="%DIR_LOG%\%1.BAD"
set DSC_FILE="%DIR_LOG%\%1.DSC"
cd "%DIR_DAT%"
echo %1�����[�h���܂��B
SQLLDR USERID=%DB_USERPASS% SILENT=HEADER,FEEDBACK CONTROL=%CTL_FILE% DATA=%DAT_FILE% LOG=%LOG_FILE% BAD=%BAD_FILE% DISCARD=%DSC_FILE%


rem ���O�o��
if %errorlevel% == 0 (set RESULT=����) else (set RESULT=���s)
echo %1�̃��[�h��%RESULT%���܂����B >> "%DIR_LOG%\SQLLDR_REVIEW.LOG"

exit /b %errorlevel%
