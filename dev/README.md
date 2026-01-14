# Smart Price プロジェクト

## 📋 プロジェクト概要

Smart Priceは、バーコードスキャンで商品価格を比較・管理できるPWAアプリです。

**最新バージョン**: v19.9.12-hf22-feedback3  
**更新日**: 2026-01-14 12:42 JST

## 📁 フォルダ構成

```
Smart Price/
├── Smart Price.code-workspace  # ワークスペース設定ファイル
├── Smart-Price-Book/          # メインプロジェクトフォルダ
│   ├── index.html              # 本番用
│   ├── dev/                    # 開発用（★デプロイ先）
│   │   ├── index.html          # 最新版（v19.9.12-hf22-feedback3）
│   │   ├── manifest.json       # PWA設定
│   │   ├── config.json         # Yahoo Proxy設定
│   │   └── 修正報告書_v19.9.12-hf22-feedback3.md
│   ├── manifest.json
│   ├── sw.js
│   └── README.md
├── docs/                       # 過去バージョン（参照用）
│   └── yahoo-lab/
└── README.md                   # このファイル
```

## 🚀 デプロイURL

### 開発版（dev）

**通常URL**:
```
https://takecwatanabe-dev.github.io/Smart-Price-Book/dev/?b=2026-01-14_1242_feedback3
```

**デバッグURL**:
```
https://takecwatanabe-dev.github.io/Smart-Price-Book/dev/?b=2026-01-14_1242_feedback3&debug=1
```

## 📝 最新の変更内容

**v19.9.12-hf22-feedback3** (2026-01-14 12:42 JST)

- `processBarcodeData()`にdirtyフラグ保護を追加（ユーザー入力中の欄は上書きしない）
- `lookupYahooByJan()`にAbortController+12秒タイムアウトを追加
- `renderHistory()`に二重起動防止ロック（`renderHistoryInFlight`）を追加
- `beforeinstallprompt`対応：`webModal`内にPWAインストールボタンを追加
- UI変更なし（既存枠内で改善・UI_FREEZE厳守）

詳細: [`Smart-Price-Book/dev/修正報告書_v19.9.12-hf22-feedback3.md`](Smart-Price-Book/dev/修正報告書_v19.9.12-hf22-feedback3.md)

## 🔧 修正履歴

| バージョン | 日付 | 内容 | 報告書 |
|-----------|------|------|--------|
| v19.9.12-hf22 | 2026-01-14 | dirty保護・render二重防止・PWA対応 | [修正報告書](Smart-Price-Book/dev/修正報告書_v19.9.12-hf22-feedback3.md) |
| v19.9.11-hf21 | 2026-01-14 | ホーム重複解消・ラグ対策・PWA導線 | [修正報告書](Smart-Price-Book/dev/修正報告書_v19.9.11-hf21-feedback2.md) |
| v19.9.10-hf20 | 2026-01-14 | stores機能の安全化 | [修正報告書](Smart-Price-Book/dev/修正報告書_v19.9.10-hf20-feedback1.md) |

## 🎯 使い方

1. Cursorで `Smart Price.code-workspace` を開く
2. 開発版を編集する場合は `Smart-Price-Book/dev/index.html` を編集
3. バージョン情報は必ず更新すること（VERSION, FULL_VERSION, BUILD_ID）
4. 修正報告書を作成し、ユイへ提出

## 📝 メモ

- **開発版（dev）が現在のデプロイ先です**
- UI変更は原則禁止（UI_FREEZE）
- 修正時は必ず修正報告書を作成
- なべさんの実機検証が必須
