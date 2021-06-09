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
set DIR_LOG_BASE=%DIR_LOG%\%~n0
if not exist "%DIR_LOG_BASE%" mkdir "%DIR_LOG_BASE%"

rem ------------------
rem �e�\�[�X���擾    
rem NOTE:
rem   "Package Body"����Type�ɃX�y�[�X������DOS��������Ȃ��̂�
rem   �����Ƃ��ă��e�����������n��if�Ŕ��f������
rem ------------------
echo �ulog\%~n0\�v��
echo Table View Index Sequence Procedure Function Package PackageBody Trigger
echo �̒�`�t�@�C���������o���܂��B
echo �Ԃ����Ⴏ�߂��Ⴍ���᎞�Ԃ�����܂��B���΂����҂���
for %%a in (Table View Index Sequence Procedure Function Package PackageBody Trigger) do (
  call :get_source %%a
)

rem ------------------
rem �����I��          
rem ------------------
echo �o�͏������I�����܂����B
exit /b %errorlevel%

rem ���������牺�̓T�u�v���V�[�W��
rem ------------------
rem �\�[�X�擾        
rem ------------------
:get_source

rem �ꗗ�̏o�͐��ς���
set LIST_FILE=%DIR_LOG_BASE%\List%1.txt
if exist "%LIST_FILE%" del /q "%LIST_FILE%" 

rem �ꗗ�擾SQL�̎��s
cd "%DIR_BIN%\dbsource"
if /i "Table" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceTableList.sql" > "%LIST_FILE%")
if /i "View" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceViewList.sql" > "%LIST_FILE%")
if /i "Index" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceIndexList.sql" > "%LIST_FILE%")
if /i "Sequence" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceSequenceList.sql" > "%LIST_FILE%")
if /i "Procedure" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceList.sql" "Procedure" > "%LIST_FILE%")
if /i "Function" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceList.sql" "Function" > "%LIST_FILE%")
if /i "Package" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceList.sql" "Package" > "%LIST_FILE%")
if /i "PackageBody" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceList.sql" "Package Body" > "%LIST_FILE%")
if /i "Trigger" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceList.sql" "Trigger" > "%LIST_FILE%")

rem �e�[�u���̌��������[�v
for /f "usebackq delims=" %%I in ("%LIST_FILE%") do (call :create_file %1 %%I)

exit /b %errorlevel%

rem ------------------
rem �t�@�C���쐬      
rem ------------------
:create_file

rem ���O�o�͐��ς���
set DIR_LOG=%DIR_LOG_BASE%\%1
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem ���\�������d���̂Ői���\��
echo %date% %time: =0% [%1] %2���o�͂��Ă��܂��B

rem �\�[�X�擾SQL�̎��s
cd "%DIR_BIN%\dbsource"
if /i "Table" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceTableData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "View" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceViewData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "Index" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceIndexData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "Sequence" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceSequenceData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "Procedure" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "Function" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "Package" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "PackageBody" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceData.sql" "%2" > "%DIR_LOG%\%2.txt")
if /i "Trigger" == "%1" (SQLPLUS -S %DB_USERPASS% @"GetDBSourceData.sql" "%2" > "%DIR_LOG%\%2.txt")

exit /b %errorlevel%
