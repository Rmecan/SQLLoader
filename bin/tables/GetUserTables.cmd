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
rem �t�@�C���폜      
rem ------------------
if exist "%TBL_FILE%" del /q "%TBL_FILE%"

rem ------------------
rem �t�@�C���쐬      
rem ------------------
echo �e�[�u���\�����utmp\Tables.txt�v�ɏ����o���܂��B
SQLPLUS -S %DB_USERPASS% @"%~dpn0.sql" > "%TBL_FILE%"

rem ------------------
rem �����I��          
rem ------------------
exit /b %errorlevel%
