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
if exist "%DIR_DAT%\*.DAT" del /q "%DIR_DAT%\*.DAT"

rem ------------------
rem �t�@�C���쐬      
rem ------------------
rem �e�[�u���̌��������[�v
for /f "usebackq delims=" %%I in ("%TBL_FILE%") do ( call :create_file %%I )

rem ------------------
rem �����I��          
rem ------------------
exit /b %errorlevel%

rem ���������牺�̓T�u�v���V�[�W��
rem ------------------
rem �t�@�C���쐬      
rem ------------------
:create_file

rem DAT�t�@�C���𔲂����߂�SQL�𐶐�
set SQL_FILE=%DIR_TMP%\%1.SQL
SQLPLUS -S %DB_USERPASS_SYSDBA% as sysdba @"%~dpn0.sql" %1 > "%SQL_FILE%"

echo %1.DAT�𐶐����܂��B
SQLPLUS -S %DB_USERPASS_SYSDBA% as sysdba @"%SQL_FILE%" > "%DIR_DAT%\%1.DAT"
if exist "%SQL_FILE%" del /q "%SQL_FILE%"

exit /b %errorlevel%
