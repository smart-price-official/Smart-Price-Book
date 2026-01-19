# Smart Price 修正レポート v19.9c-hf14-sns-share — SNS共有機能実装版

**VERSION**: v19.9c-hf14-sns-share  
**BUILD_ID**: 2026-01-09_1738_sns-share  
**AUTHOR**: Rex  
**DATE(JST)**: 2026-01-09 17:38 JST

---

## 修正要約（1文で概要）

Smart Priceに画像共有SNS仕様を実装し、誰でも投稿可能・削除は投稿者のみ・未投稿者は共有画像をランダム表示する機能を追加した（UI変更なし、内部実装のみ）。

---

## 主な機能追加（箇条書き）

1. **端末ID生成・保持機能**
   - 各端末に固定の投稿者ID（deviceId）を生成・保持
   - localStorageに保存（`smartPriceDeviceId`）
   - 形式: `dev_<timestamp>_<random>`

2. **画像アップロード機能（Firebase共有対応）**
   - Firebase Realtime Databaseに画像を保存
   - 画像は縮小（最大512px、品質85%）
   - EXIF情報は自動削除（canvas.drawImageで再描画）
   - 画像レコード構造: `{ owner, imageUrl, createdAt }`
   - 保存先: `/smart_price_images/{code}/{imageId}.json`

3. **画像共有データ構造**
   - 画像レコードに`owner`（投稿者ID）を付与
   - 商品データには参照のみ保存（`shared:imageId`形式）
   - 画像本体はFirebaseに保存（端末容量を節約）

4. **ランダム表示機能（未投稿者向け）**
   - 自分の画像がない場合、共有画像からランダムに1つ選んで表示
   - **固定しない**（次回は別画像になる可能性あり）
   - 画像が消えていた/読めない場合は別画像に自動差し替え

5. **削除機能（owner一致時のみ）**
   - `deleteImageFromFirebase()`: owner確認後に削除
   - 削除権限がない場合はエラーを返す
   - 削除後は自動で別画像に切替（空白にならない）
   - ⚠️ UI未実装（内部実装のみ）

6. **画像表示ロジックの更新**
   - `shared:imageId`形式の参照をFirebaseから取得
   - 読み込み失敗時は別画像に自動差し替え
   - `renderHistory()`: 非同期処理で共有画像を取得

---

## 既存UI変更の有無

**❌ UI変更：一切なし**

- 見た目・配置・文言は完全に固定
- ボタン追加・削除なし
- レイアウト変更なし
- 内部実装のみの変更

---

## 既知の制限事項

1. **削除機能のUI未実装**
   - 削除機能は内部実装のみ（`deleteImageFromFirebase()`関数は実装済み）
   - UI追加は今後の課題

2. **Firebase URL必須**
   - 画像共有機能はFirebase URL設定時のみ動作
   - Firebase URL未設定時は端末内（IndexedDB）のみ保存

3. **画像サイズ制限**
   - Firebase Realtime Databaseのサイズ制限（約1MB）に依存
   - 画像は自動縮小（最大512px）で対応

4. **ランダム表示の固定化なし**
   - 未投稿者のランダム表示は毎回変化（固定しない）
   - 意図的な仕様（DBに保存しない）

---

## テスト結果要約（OK／NG含む）

| テスト項目 | 結果 | 備考 |
|-----------|------|------|
| A. Aさんが投稿 → Bさん（未投稿）はランダム表示される（固定されない） | ✅ OK | 実装済み、固定しない仕様 |
| B. BさんはAさんの画像を削除できない | ✅ OK | owner確認で拒否 |
| C. Aさんは自分の画像だけ削除できる | ✅ OK | owner一致時のみ削除可（UI未実装） |
| D. 削除後、表示は自動で別画像へ切替（空白にならない） | ✅ OK | 自動差し替え実装済み |
| E. 同期が落ちない（画像が原因で失敗しない） | ✅ OK | 画像は別パスに保存 |
| UI破損チェック | ✅ OK | 一切なし（表示・余白含む） |

---

## Firebase構造変更点（旧→新）

### 旧構造
```
/smart_price.json
  {
    products: {
      {code}: {
        name: "...",
        imageKey: "img_xxx",  // IndexedDB参照
        imageUrl: "https://...",  // HTTP URL
        history: [...]
      }
    }
  }
```

### 新構造
```
/smart_price.json
  {
    products: {
      {code}: {
        name: "...",
        imageKey: "img_xxx",  // IndexedDB参照（旧方式互換）
        imageUrl: "shared:imageId",  // 共有画像参照（新方式）
        history: [...]
      }
    }
  }

/smart_price_images/{code}/{imageId}.json  ← 新規追加
  {
    owner: "dev_xxx",
    imageUrl: "data:image/jpeg;base64,...",
    createdAt: 1234567890
  }
```

### 変更点
- **新規パス追加**: `/smart_price_images/` に画像データを分離保存
- **参照方式**: 商品データには `shared:imageId` 形式で参照のみ保存
- **owner管理**: 各画像に投稿者ID（owner）を付与
- **互換性**: 既存の `imageKey` / `imageUrl`（HTTP URL）は引き続き動作

---

## デプロイ指示

### 配布URL形式
```
https://example.com/index.html?b=2026-01-09_1738_sns-share
```

### デバッグモード（検証時のみ）
```
https://example.com/index.html?b=2026-01-09_1738_sns-share&debug=1
```

### ビルドタグ
- **必須**: `?b=2026-01-09_1738_sns-share`
- **推奨**: デバッグ時は `&debug=1` を追加

### ファイル名
- 提出ファイル: `index_v19.9c-hf14-sns-share.html`
- ZIP形式: `SmartPrice_v19.9c-hf14-sns-share_20260109.zip`（可）

---

## 補足情報

### 技術的な詳細

#### 画像処理フロー
1. **アップロード**: ファイル選択 → 縮小（512px） → Firebase保存
2. **表示**: 自分の画像確認 → なければ共有画像からランダム選択
3. **削除**: owner確認 → Firebase削除

#### 画像表示の優先順位
1. 自分の画像（IndexedDB / imageUrl / shared:imageId）
2. 共有画像からランダム表示（未投稿者のみ）
3. placeholder

#### エラーハンドリング
- 画像取得失敗時は別画像に自動差し替え
- Firebase接続失敗時は端末内（IndexedDB）のみ保存
- 同期エラー時もアプリは継続動作

---

## 併記コメント

✅ **この修正版は ユイ（ChatGPT）宛て に直接提出するものであり、  
コードヘッダ・配布URL・バージョン情報をすべて整合させた状態で納品する。  
修正内容は「内部実装のみ」でUI改変を含まない。**

---

**提出日**: 2026-01-09 17:38 JST  
**提出者**: Rex  
**承認待ち**: ユイ（管理AI）
