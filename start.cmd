@echo off 

rem ------------------
rem �o�b�`������
rem ------------------
:init_proc
set MIN_PAGE=1
set MAX_PAGE=1
set MAIN_PAGE=1

rem ------------------
rem ���C������
rem ------------------
:main_proc

rem �ϐ�������
set BAT_TITLE=���C�����j���[
title %BAT_TITLE%
call "%~dp0\bin\SetConfig.cmd"
cd %~dp0
set USER_ANS=""

rem ���C�����j���[�\��
call :show_main_%MAIN_PAGE%
goto main_proc

rem --------------
rem �����I��      
rem --------------
:normal_end_proc
exit

rem ------------------
rem �y�[�W����(�O��)
rem ------------------
:show_pager_prev
set /a MAIN_PAGE=%MAIN_PAGE%-1
if %MAIN_PAGE% lss %MIN_PAGE% set MAIN_PAGE=%MIN_PAGE%
exit /b %errorlevel%

rem ------------------
rem �y�[�W����(����)
rem ------------------
:show_pager_next
set /a MAIN_PAGE=%MAIN_PAGE%+1
if %MAIN_PAGE% gtr %MAX_PAGE% set MAIN_PAGE=%MAX_PAGE%
exit /b %errorlevel%

rem ------------------
rem ���C������(P1)
rem ------------------
:show_main_1
cls
echo /* %BAT_TITLE%  (%MAIN_PAGE%/%MAX_PAGE%) */
echo -----------------------------------------------------------------
echo Tips:
echo   ���݂�DB�ڑ�����[%DB_USERPASS%]�ł��B
echo   �s�K���̏ꍇ�́ubin\SetConfig.cmd�v���C�����Ă��������B
echo.
echo ���s�������@�\��I�����Ă�������
echo   1.Step1(Tebles.txt�쐬)
echo   2.Step2(*.CTL�쐬)�@���\�߁AStep1�����s���Ă�������
echo   3.Step3(*.DAT�쐬)�@���\�߁AStep1�����s���Ă�������
echo   4.Step4(LOADER���s) ���\�߁AStep1�`3�����s���Ă�������
echo   5.�V�[�P���X����
echo   6.�e�[�u�����̌����擾
echo   7.DB�G�N�X�|�[�g
echo   8.DB�\�[�X�擾 �����Ԃ�����
echo   9.
echo   0.
echo   h.�w���v
echo   e.Exit
echo -----------------------------------------------------------------
set /p USER_ANS="���� >"

rem --------------
rem ��������      
rem --------------
if /i "%USER_ANS%" EQU "1" call "%DIR_BIN%\tables\GetUserTables.cmd" && pause
if /i "%USER_ANS%" EQU "2" call "%DIR_BIN%\loader\GetLoaderCtl.cmd" && pause
if /i "%USER_ANS%" EQU "3" call "%DIR_BIN%\loader\GetLoaderDat.cmd" && pause
if /i "%USER_ANS%" EQU "4" call "%DIR_BIN%\loader\StartLoader.cmd" && pause
if /i "%USER_ANS%" EQU "5" call "%DIR_BIN%\sequences\SetSequence.cmd" && pause
if /i "%USER_ANS%" EQU "6" call "%DIR_BIN%\tables\CountRowsByTables.cmd" && pause
if /i "%USER_ANS%" EQU "7" call "%DIR_BIN%\dbsource\ExportDmp.cmd" && pause
if /i "%USER_ANS%" EQU "8" call "%DIR_BIN%\dbsource\GetDBSource.cmd" && pause
if /i "%USER_ANS%" EQU "9" echo>NUL
if /i "%USER_ANS%" EQU "0" echo>NUL
if /i "%USER_ANS%" EQU "e" goto normal_end_proc
if /i "%USER_ANS%" EQU "h" more < "%DIR_HOME%\help.txt" && pause
if /i "%USER_ANS%" EQU ">" call :show_pager_next
if /i "%USER_ANS%" EQU "<" call :show_pager_prev

exit /b %errorlevel%
