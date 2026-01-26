# Nablarch AI Context

AIによるNablarch実装支援用技術仕様集。コード生成に必要な最小限情報を集約。

## 構成

### 1_common - 共通機能
- **[1.1 オブジェクト変換](1_common/1.1_object_conversion.md)** - EntityUtil/BeanUtil使い分け、型変換ルール
- **[1.2 BeanUtil詳細](1_common/1.2_bean_util.md)** - 特殊パターン、ネスト・検索・REST・バッチ変換
- **[1.3 入力値検証](1_common/1.3_validation.md)** - Bean Validation、ドメイン・相関バリデーション
- **[1.4 DB アクセス](1_common/1.4_database_access.md)** - UniversalDAO、SQLファイル管理
- **[1.5 データバインド](1_common/1.5_data_bind.md)** - CSV/固定長変換、ファイル処理
- **[1.6 ファイルパス](1_common/1.6_file_path_management.md)** - 論理名管理、環境設定
- **[1.7 日付ユーティリティ](1_common/1.7_date_util.md)** - BusinessDateUtil、DateUtil
- **[1.8 メッセージ](1_common/1.8_message.md)** - 定義・国際化・エラー制御

### 2_rest - REST API
- **[2.1 Action](2_rest/2.1_action.md)** - JAX-RS、レスポンス制御
- **[2.2 Form](2_rest/2.2_form.md)** - JSON変換、バリデーション
- **[2.3 エラーハンドリング](2_rest/2.3_error_handling.md)** - ステータスコード、例外処理
- **[2.4 Service](2_rest/2.4_service.md)** - 依存関係、テスト対応

### 3_batch - バッチ処理
- **[3.1 Form/DTO](3_batch/3.1_form_dto.md)** - CSV/固定長定義
- **[3.2 DataReader](3_batch/3.2_reader.md)** - DB/ファイル読込み
- **[3.3 BatchAction](3_batch/3.3_action.md)** - エラー制御、処理パターン
- **[3.4 DB入力パターン](3_batch/3.4_input_db_patterns.md)** - DB読込み処理
- **[3.5 ファイル入力パターン](3_batch/3.5_input_file_patterns.md)** - ファイル読込み処理
- **[3.6 DB出力パターン](3_batch/3.6_output_db_patterns.md)** - DB書込み処理
- **[3.7 ファイル出力パターン](3_batch/3.7_output_file_patterns.md)** - ファイル書込み処理
- **[3.8 @ValidateData](3_batch/3.8_validatedata_implementation.md)** - バリデーション制御

### 4_web - Web アプリケーション
- **[4.1 Action](4_web/4.1_action.md)** - 業務アクションクラス、URLルーティング、画面遷移
- **[4.2 Form](4_web/4.2_form.md)** - 入力値受け取り、バリデーション、パスパラメータ
- **[4.3 JSP](4_web/4.3_jsp.md)** - カスタムタグ、画面表示、確認画面パターン
- **[4.4 Service](4_web/4.4_service.md)** - ビジネスロジック、DB アクセス、トランザクション

### 5_test - テスティングフレームワーク
バッチ関連のみ先行して作成。

- **[5.0 テストの基礎](5_test/5.0_test_basics.md)** - Excel配置・記法・データタイプ・特殊記法・リクエスト単体テスト基本形
- **5.1 リクエスト単体テスト（Web）** - HttpRequestTestSupport、画面遷移、セッション管理
- **5.2 リクエスト単体テスト（REST）** - RestTestSupport、HTTPメソッド、ステータスコード検証
- **[5.3 リクエスト単体テスト（Batch）](5_test/5.3_batch_request_test.md)** - BatchRequestTestSupport、testShotsカラム、execute()、常駐バッチ対応
- **[5.4 データベーステスト](5_test/5.4_database_test.md)** - SETUP_TABLE/EXPECTED_TABLE/EXPECTED_COMPLETE_TABLE、DB初期化・検証、トランザクション制御、グループID管理
- **5.5 クラス単体テスト** - テストクラス基本構造、モック・スタブ、JUnit連携
- **5.6 検証ユーティリティ** - JSON検証、HttpResponse検証、カスタムアサーション
- **[5.7 ファイル処理テスト](5_test/5.7_file_test.md)** - SETUP_FIXED/VARIABLE、EXPECTED_FIXED/VARIABLE、入出力ファイル検証
- **5.8 メッセージングテスト** - 同期応答メッセージング、応答不要メッセージング
- **5.9 高度な機能** - パラメータ化テスト、日時固定化、マスタデータキャッシュ
- **5.10 二重サブミット防止テスト** - トークン検証、UseToken設定
- **5.11 取引単体テスト** - リクエスト単体テストとの使い分け、複数アクション連携