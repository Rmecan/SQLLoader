@echo off

rem ------------------
rem ���ϐ��Z�b�g    
rem ------------------
rem ���Ȓ�`
set SETCONFIG=%~dpnx0

rem DB�ڑ���
set DB_USERPASS=scott/tiger@scott
set DB_USERPASS_SYSDBA=scott/tiger@scott

rem �V�X�e�������iyyyymmddHHmmss�j
set SYSDATE14=%date:~-10,4%%date:~-5,2%%date:~-2,2%%time:~-11,2%%time:~-8,2%%time:~-5,2%
set SYSDATE14=%SYSDATE14: =0%



rem ------------------
rem �K�v��DIR����     
rem ------------------
set DIR_HOME=%~dp0..\
set DIR_BIN=%DIR_HOME%bin
set DIR_CTL=%DIR_HOME%dat
set DIR_DAT=%DIR_HOME%dat
set DIR_TMP=%DIR_HOME%tmp
set DIR_LOG=%DIR_HOME%log
if not exist "%DIR_CTL%" mkdir "%DIR_CTL%"
if not exist "%DIR_DAT%" mkdir "%DIR_DAT%"
if not exist "%DIR_TMP%" mkdir "%DIR_TMP%"
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"


rem ------------------
rem �K�v�Ȓ萔        
rem ------------------
rem �e�[�u����`
set TBL_FILE=%DIR_TMP%\Tables.txt

exit /b %errorlevel%
