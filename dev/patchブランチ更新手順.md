# patchブランチのindex.html更新手順

## 📋 目的
`patch` ブランチの `index.html` を最新版（v19.9.17）に更新し、差分をユイに渡す

## 🔍 現在の状況
- **ローカル**: `Smart-Price-Book/dev/index.html` = v19.9.17（最新版）
- **patchブランチ**: `index.html` = 旧バージョン（要更新）

## 📝 更新手順

### Step 1: patchブランチのindex.htmlを開く
以下のURLをブラウザで開く：
```
https://github.com/smart-price-official/Smart-Price-Book/blob/patch/index.html
```

### Step 2: ファイルを編集
1. 右上の「**Edit this file**」（鉛筆アイコン）をクリック
2. Cursorで開いている `Smart-Price-Book/dev/index.html` の内容をすべてコピー（`Ctrl + A` → `Ctrl + C`）
3. GitHubの編集画面に貼り付け（`Ctrl + V`）

### Step 3: コミット
1. 画面下部の「**Commit changes**」をクリック
2. コミットメッセージに以下を入力：
   ```
   v19.9.17: 商品DBの優先順位確定（Yahoo→楽天→OFF）＋自動整形の精度アップ
   ```
3. 「**Commit changes**」ボタンをクリック

## 🔗 差分URLの取得方法

### Step 1: コミット一覧を開く
```
https://github.com/smart-price-official/Smart-Price-Book/commits/patch
```

### Step 2: 最新のコミットをクリック
一番上に表示されているコミット（「v19.9.17: 商品DBの優先順位確定...」）をクリック

### Step 3: 差分URLをコピー
開いたページのURLが**Commit差分URL**です。形式：
```
https://github.com/smart-price-official/Smart-Price-Book/commit/[自動生成されたハッシュ]
```

## 📤 ユイへの報告例

```
TO: ユイ（監督）
FROM: なべさん経由

patchブランチのindex.htmlをv19.9.17に更新しました。

【差分URL】
https://github.com/smart-price-official/Smart-Price-Book/commit/[ここにURLを貼る]

【変更内容】
- 優先順位を変更（Yahoo最優先→楽天第2→OFF第3）
- Yahoo側の強化（信頼度スコア付き、packCount/isCase保持）
- メーカー名/販売店名混入の正規化関数を汎用化
- 国内DB（楽天）の導入
- OFFの使い方ルール実装
- カメラのピント問題対応

【検証URL】
https://smart-price-official.github.io/Smart-Price-Book/?b=2026-01-15_1400_yahoo-rakuten-off&debug=1
```
