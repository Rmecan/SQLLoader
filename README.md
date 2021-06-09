# はじめに
このソフトはOracleデータベース間のデータ移行を簡略化することを目的に作成しています。
完全には信用せず必ず移行前後の整合性を確認してください。


# 問題点
- ネットワーク上で動作できない
- Triggerの定義が取得できない
	> 試していた環境ではすべてのTriggerがゴミ箱にあった（関係あるかは不明）
	> Triggerの定義が欲しいのってA1かA2だけ？
- 拡張されたテーブルに対して縮小する方法がない
	- SQLで`TRUNCATE TABLE [テーブル名] DROP ALL STORAGE;`を叩けば良さそう
		> 上記SQLはOracle11g以降の機能になる

# 本ソフトにおけるバージョン間の互換性について
* SQLLoader4.x
	- SQLLoader4.x 同士は相互互換あり
	- SQLLoader3 以下で生成されたCTLファイルはロード不可
		> SQLLoader4.0 でロードタイプを変更したためロード時に一意制約違反等が発生する
	- SQLLoader3 以下で生成されたDATファイルはロード可能
	
* SQLLoader, SQLLoader2, SQLLoader3
	- SQLLoader3 以下で生成されたCTLファイル,DATファイルは相互互換あり
	- SQLLoader4.0 以降に生成されたCTLファイル,DATファイルとは互換性なし

# 更新履歴
* SQLLoader4.4
	- GitHubに公開できるように内容を刷新
		- プロジェクト特化のスクリプトを破棄
		- 未使用のスクリプトを破棄
		- 具体的なプロジェクト名はイニシャル化
		- プロダクトを想起するような文言/スクリプトを破棄
	- `bin`配下のファイルを再配置。それに伴い`start.cmd`も修正
	- Oracleシーケンスの移行処理を追加
		- あまりスマートなやり方ではないが・・・
		
* SQLLoader4.3
	- `bin\SetConfig.cmd`でDIR_HOMEのパスが誤っていたので修正
		- ログ等は正常に吐き出せるが、explorerでフォルダを開くことができなかった
	- 汎用的な入力チェック処理`IsXXX.cmd`の追加
		- 空ファイル判定処理：`bin\util\IsFileEmpty.cmd`
	- CTLとDATで作業フォルダを別々に管理できるよう環境変数周りを是正
		- `bin\SetConfig.cmd`に環境変数`DIR_CTL`を追加
		- `bin\loader\GetLoaderCtl.cmd`を追加した環境変数に従って修正
		- `bin\loader\StartLoader.cmd`
			- LOGファイルもわざわざ移動する必要性がないので直接logフォルダに落とすよう変更
	- `bin\custom`フォルダを作成、プロジェクト特化のスクリプトはここに格納
		- サンプルとしてN工業（A1標準→A7標準の移行案件）で使用したスクリプトを配置
		- `start.cmd`の3ページ目に該当スクリプトを呼び出す処理を追加
	- ローダー実行時にユーザー確認するように変更
		- `bin\loader\StartLoader.cmd`

* SQLLoader4.2
	- Oracle9iでローダーが機能しない、通常のログインユーザーではdba_tab_columnsをselectできない様子
		> SYSDBA権限を付与する必要がある
			- `bin\SetConfig.cmd`にSYSDBAで接続する用の接続詞を追加
			- `bin\loader\GetLoaderCtl.cmd`でSYSDBAでDB接続するようにした
			- `bin\loader\GetLoaderDat.cmd`でSYSDBAでDB接続するようにした

* SQLLoader4.1
	- SQLLoaderでデータ内に囲み文字（ダブルクォーテーション）が含まれていると正常にロードできない
		> ダブルクォーテーションでエスケープした
	- `bin\unuse\TruncateXXX.bat`で実行するSQLファイルのパスが誤っていたため修正(使ってないけど)

* SQLLoader4.0
	- CHAR型の項目について空白が除去されます。(DB上スペース1桁なのに抽出するとNULLになる。)に対応。
		- CTLに`PRESERVE BLANKS`を追加
	- SQLLoaderのロードタイプを変更：`APPEND` -> `TRUNCATE`
		- `TruncateTables.cmd`系の処理を`bin\unuse`へ移動
	- `SetConfig.cmd`に自己定義を追加、各実行ファイルは環境変数を使用し`SetConfig.cmd`を実行するように変更
	- 実行ファイルが増えてきたので体系的に配置換え、それに伴いパスの見直し
	- メニューにDB接続詞を表示するよう変更
	- 改称：`GenerateLoaderTables.cmd` -> `GetUserTables.cmd`
	- 改称：`GetCountTables.cmd` -> `CountRowsByTables.cmd`
	- 改称：`readme.txt` -> `help.txt`
	- 実行ファイル配置替えに伴い、`help.txt`も改訂
	- DB定義取得処理`GetDBSource.cmd`でTable定義、Index定義を取得するよう改修
	- A4のユーザー管理テーブルのアップコンバーター処理を分割
		- 「テーブル定義＆初期値セット」と「初期値セットのみ」に分割。すでに列が存在する時にこけるため（消せばいいだけの話なんだけどね…）

* SQLLoader3
	- SQLLoader実施時にDATE型の時分秒が切り捨てられてしまう問題の対応

* SQLLoader2
	- メインメニューの整理
	- A4対応
		- ユーザー管理テーブルのアップコンバーターを追加
			- デフォルト区分、セッションタイムの列追加＋デフォルト値の設定
		- 禁止設定を追加（範囲指定、コード指定）
	- 汎用的な入力チェック処理`IsXXX.cmd`の追加
		- 英字判定処理：`IsAlphabet.cmd`
		- 数字判定処理：`IsNumeric.cmd`
		- 英数字判定処理：`IsAlphaNum.cmd`
		- 字数判定処理：`IsLengthOk.cmd`

* SQLLoader
	- 新規作成

# Special Thanks
- SQLLoaderを作るにあたって参考にしたサイト
	- http://oracle.se-free.com/utl/utl.html#sqlloader
