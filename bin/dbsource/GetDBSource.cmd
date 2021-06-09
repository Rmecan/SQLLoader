@echo off
title %~n0

if not %errorlevel% == 0 (
    echo キャンセルしたかエラーが発生しているため、%~n0を実行できませんでした。
    echo 詳細はログを参照してください。
    exit /b %errorlevel%
)

rem ------------------
rem 環境変数セット    
rem ------------------
call "%SETCONFIG%"
set DIR_LOG_BASE=%DIR_LOG%\%~n0
if not exist "%DIR_LOG_BASE%" mkdir "%DIR_LOG_BASE%"

rem ------------------
rem 各ソースを取得    
rem NOTE:
rem   "Package Body"だけTypeにスペースがありDOS向きじゃないので
rem   引数としてリテラル文字列を渡しifで判断させる
rem ------------------
echo 「log\%~n0\」に
echo Table View Index Sequence Procedure Function Package PackageBody Trigger
echo の定義ファイルを書き出します。
echo ぶっちゃけめちゃくちゃ時間かかります。しばしお待ちを
for %%a in (Table View Index Sequence Procedure Function Package PackageBody Trigger) do (
  call :get_source %%a
)

rem ------------------
rem 処理終了          
rem ------------------
echo 出力処理を終了しました。
exit /b %errorlevel%

rem ▼ここから下はサブプロシージャ
rem ------------------
rem ソース取得        
rem ------------------
:get_source

rem 一覧の出力先を変える
set LIST_FILE=%DIR_LOG_BASE%\List%1.txt
if exist "%LIST_FILE%" del /q "%LIST_FILE%" 

rem 一覧取得SQLの実行
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

rem テーブルの件数分ループ
for /f "usebackq delims=" %%I in ("%LIST_FILE%") do (call :create_file %1 %%I)

exit /b %errorlevel%

rem ------------------
rem ファイル作成      
rem ------------------
:create_file

rem ログ出力先を変える
set DIR_LOG=%DIR_LOG_BASE%\%1
if not exist "%DIR_LOG%" mkdir "%DIR_LOG%"

rem 結構処理が重いので進捗表示
echo %date% %time: =0% [%1] %2を出力しています。

rem ソース取得SQLの実行
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
