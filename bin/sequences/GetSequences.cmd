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
rem �t�@�C���쐬      
rem ------------------
echo �V�[�P���X�쐬�X�N���v�g���ulog\CreateSequenses.sql�v�ɏ����o���܂��B
SQLPLUS -S %DB_USERPASS% @"%~dpn0.sql" > "%DIR_LOG%\CreateSequenses.sql"

rem ------------------
rem �����I��          
rem ------------------
exit /b %errorlevel%
