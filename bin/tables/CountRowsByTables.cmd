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
rem COUNT���s         
rem ------------------
call :count_tables

rem ------------------
rem �����I��          
rem ------------------
exit /b %errorlevel%

rem ���������牺�̓T�u�v���V�[�W��
rem ------------------
rem COUNT���s         
rem ------------------
:count_tables
rem COUNT���邽�߂�SQL�𐶐�
set SQL_FILE=%DIR_TMP%\SELECT_COUNT_FROM_TABLE.SQL
SQLPLUS -S %DB_USERPASS% @"%~dpn0.sql" > "%SQL_FILE%"

rem �f���o���t�@�C�����𐶐�
set DST_FILE=%SYSDATE14%_CountTable.txt

rem SQL�����s
SQLPLUS -S %DB_USERPASS% @"%SQL_FILE%" > "%DIR_LOG%\%DST_FILE%"
if exist "%SQL_FILE%" del /q "%SQL_FILE%"
echo �ulog\%~n0\%DST_FILE%�v�ɏ����o���܂����B

exit /b %errorlevel%
