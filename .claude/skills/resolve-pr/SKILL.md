---
name: resolve-pr
description: PRのunresolvedなレビューコメントに対応する。修正→コミット→コミットリンク付きリプライを実行。「PRレビュー対応して」「レビューコメント直して」「PR 123 のフィードバック対応」などで使用。gh CLI必須。
context: fork
allowed-tools: Bash, Read, Edit, Write, AskUserQuestion
---

# PRレビューコメント対応

## 前提条件

gh CLI認証を確認する:
```bash
gh auth status
```
未認証なら `gh auth login` を案内して終了する。

## ワークフロー概要

1. unresolvedなレビュースレッドを取得する
2. 各スレッド: 分析 → 修正 → コミット → プッシュ → リプライ
3. PRリンク付きサマリーを出力する

※ resolveはレビュアーが行う

## Step 1: 入力

`$ARGUMENTS`からPR番号を取得する。空ならユーザーに確認する。

リポジトリ情報を取得する:
```bash
gh repo view --json owner,name -q '.owner.login + "/" + .name'
```

## Step 2: unresolvedスレッド取得

`scripts/get-unresolved-threads.sh`を実行する:
```bash
bash scripts/get-unresolved-threads.sh {owner} {repo} {pr_number}
```

空なら「すべてのレビューコメントが解決済みです」と報告して終了する。

## Step 3: 各スレッドを処理

### 3a. 分析
- コメント本文から指摘内容を理解する
- Readツールで `{path}:{line}` 周辺を確認する

### 3b. 判断

| 状況 | 対応 |
|------|------|
| 修正が必要 | 3c へ |
| 不明点あり | 質問をリプライする |
| 同意できない | ユーザーに確認する |

### 3c. 修正・コミット・プッシュ

1. ファイルを修正する
2. `git add {path}`
3. `git commit -m "fix: {要約}"`
4. `git push`
5. `git rev-parse HEAD` でSHAを取得する

### 3d. リプライ

```bash
gh api --method POST \
  "repos/{owner}/{repo}/pulls/{pr_number}/comments/{comment_db_id}/replies" \
  -f body="修正しました ✅

**コミット**: https://github.com/{owner}/{repo}/commit/{sha}

{修正内容}

---
Co-Authored-By: Claude <noreply@anthropic.com>"
```

質問の場合:
```bash
gh api --method POST \
  "repos/{owner}/{repo}/pulls/{pr_number}/comments/{comment_db_id}/replies" \
  -f body="確認させてください 🤔

{質問内容}

---
Co-Authored-By: Claude <noreply@anthropic.com>"
```

## Step 4: サマリー

全スレッド処理後に出力する:
```
## PR Review対応完了

**PR**: https://github.com/{owner}/{repo}/pull/{pr_number}

### 結果
- ✅ 修正: {n}件
- ❓ 質問: {n}件

再レビューをお願いします 🙏
```

## エラー処理

| エラー | 対応 |
|--------|------|
| gh未認証 | `gh auth login` を案内して終了する |
| PR番号無効 | 正しい番号を確認する |
| プッシュ失敗 | force pushが必要か確認する |
