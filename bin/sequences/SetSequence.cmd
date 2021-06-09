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
set DIR_LOG=%DIR_LOG%\%~n0
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem �ꗗ�擾SQL�̎��s
set LIST_FILE=%DIR_LOG%\ListSequence.txt
if exist "%LIST_FILE%" del /q "%LIST_FILE%" 
SQLPLUS -S %DB_USERPASS% @"%DIR_BIN%\dbsource\GetDBSourceSequenceList.sql" > "%LIST_FILE%"

rem ���X�g�̌��������[�v
for /f "usebackq delims=" %%I in ("%LIST_FILE%") do (call :create_file %%I)

rem ------------------
rem �����I��          
rem ------------------
echo �������I�����܂����B
exit /b %errorlevel%

rem ------------------
rem �t�@�C���쐬      
rem ------------------
:create_file

rem �\�[�X�擾SQL�̎��s
echo %1�̖ڕW�l�i���ݒl�Ƃ��Đݒ肷��l�j����͂��Ă��������B
set /p TARGET=skip����͂���Ɣ�΂��܂���
if /i "%TARGET%" == "skip" exit /b %errorlevel%
call "%DIR_BIN%\util\IsNumeric.cmd" %TARGET%
if not %errorlevel% == 0 (
  echo �����ȊO�����͂��ꂽ�̂ł�蒼��
  goto create_file
)
SQLPLUS -S %DB_USERPASS% @"%DIR_BIN%\sequences\SetSequence.sql" %1 %TARGET% > %DIR_LOG%\%1.txt
type %DIR_LOG%\%1.txt
exit /b %errorlevel%
