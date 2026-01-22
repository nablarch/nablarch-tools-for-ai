---
name: work
description: Start, resume, pause, or complete long-running tasks using work management files. Use when beginning new work, resuming previous tasks, pausing work to protect progress, or completing work.
argument-hint: [work-file-name]
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Bash, AskUserQuestion
---

# 作業管理（Work Management）

`.work/`ディレクトリの作業管理ファイルを使って、長期タスクや複数セッションにまたがる作業を管理します。

## 用語

- **作業（Work）**: workスキルで管理する単位（.work/*.mdファイル1つ）
- **タスク（Task）**: 作業内の個別チェックリスト項目

詳細は [terminology.md](terminology.md) を参照してください。

## 使用タイミング

1. **作業開始** - 新しい作業を開始する
2. **作業再開** - 既存の作業を再開する
3. **作業中断** - 作業を一時停止し、成果を保護する（Git commit & push）
4. **作業完了** - 作業を終了する（完了確認 & Git commit & push）

## 実行フロー

### 1. 準備

`.work/`ディレクトリを確認し、既存の作業ファイル(`*.md`)を検索します。

### 2. 作業選択

AskUserQuestionツールで以下の選択肢を提示:
- 作業開始
- 作業再開
- 作業中断
- 作業完了

### 3. 選択に応じた処理

各処理の詳細は [workflows.md](workflows.md) を参照:

- **作業開始**: template.md使用 → ファイル作成 → 承認 → ブランチ作成
- **作業再開**: ファイル選択 → ステータス確認 → 次のタスク確認
- **作業中断**: ヒアリング → ファイル更新 → Git commit & push
- **作業完了**: チェックリスト確認 → ファイル更新 → Git commit & push

## 重要な原則

### ステータスセクション優先

作業再開時は必ず**「ステータス」セクション**を確認してください。ここに全ての現在状況が集約されています:
- 最終更新日時・進捗率・フェーズ
- 作業中ファイル
- 課題・懸念事項

### チェックリスト駆動

作業計画のチェックリストに記載されているタスクを優先して実行してください。

### Git保護

作業中断・完了時は必ずGit commit & pushを実行し、成果を保護してください:
- **作業中断**: 未完了の変更も含めてコミット（WIP: Work In Progress）
- **作業完了**: コミット漏れがないか必ず確認

### 進捗記録

作業ログに主要な決定と変更を記録してください。次回再開時や引き継ぎに必要です。

## 作業ファイル規則

| 項目 | 内容 |
|:-----|:-----|
| **配置** | `.work/` |
| **命名** | `YYYY-MM-DD_作業名.md` |
| **日付** | 作業開始日（更新日ではない） |
| **Git管理** | 対象内（履歴追跡のため） |
| **並行作業** | 複数ファイルで並行管理可能 |

## Supporting Files

- [terminology.md](terminology.md) - 用語定義と使い分け
- [workflows.md](workflows.md) - 各処理の詳細手順
- [template.md](template.md) - 作業ファイルのテンプレート
