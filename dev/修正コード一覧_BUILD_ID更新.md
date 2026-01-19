# 🔧 Smart Price 修正コード一覧（BUILD_ID更新）

**DATE(JST)**: 2026-01-15 23:10 JST  
**VERSION**: v19.9.18-hf28-p0-camera-lag  
**FILE**: `Smart-Price-Book/dev/index.html`  
**BUILD_ID**: `2026-01-15_2310_hf28-devsync`（新規）

---

## 📋 修正箇所一覧

### BUILD_ID更新（5箇所）

#### 1. ヘッダコメント（10行目）

**変更前**:
```
BUILD_ID: 2026-01-15_1400_yahoo-rakuten-off
```

**変更後**:
```
BUILD_ID: 2026-01-15_2310_hf28-devsync
```

---

#### 2. DATE(JST)更新（6行目）

**変更前**:
```
DATE(JST): 2026-01-15 20:00 JST
```

**変更後**:
```
DATE(JST): 2026-01-15 23:10 JST
```

---

#### 3. ヘッダコメント（34行目）

**変更前**:
```
BUILD_ID: 2026-01-15_1400_yahoo-rakuten-off
```

**変更後**:
```
BUILD_ID: 2026-01-15_2310_hf28-devsync
```

---

#### 4. BUILD_PARAM（35行目）

**変更前**:
```
BUILD_PARAM: ?b=2026-01-15_1400_yahoo-rakuten-off
```

**変更後**:
```
BUILD_PARAM: ?b=2026-01-15_2310_hf28-devsync
```

---

#### 5. PWAキャッシュ問題の対処法（40行目）

**変更前**:
```
1. 通常タブで開き直し: ブラウザの通常タブで /dev/?b=2026-01-15_1400_yahoo-rakuten-off を開く
```

**変更後**:
```
1. 通常タブで開き直し: ブラウザの通常タブで /dev/?b=2026-01-15_2310_hf28-devsync を開く
```

---

#### 6. JavaScript内のBUILD_ID定数（285行目）

**変更前**:
```javascript
const BUILD_ID = "2026-01-15_1400_yahoo-rakuten-off"; // ヘッダーと一致させる
```

**変更後**:
```javascript
const BUILD_ID = "2026-01-15_2310_hf28-devsync"; // ヘッダーと一致させる
```

---

## 🔗 GitHub差分URL（コミット後）

GitHubにコミット・プッシュした後、以下のURLで差分を確認できます：

```
https://github.com/smart-price-official/Smart-Price-Book/commit/[COMMIT_HASH]
```

**コミットメッセージ例**:
```
dev: apply hf28 (camera/lag/tax/redframe) sync from root index - BUILD_ID: 2026-01-15_2310_hf28-devsync
```

---

## 📌 反映確認URL

**通常版**:
```
https://smart-price-official.github.io/Smart-Price-Book/dev/?b=2026-01-15_2310_hf28-devsync
```

**デバッグ版**:
```
https://smart-price-official.github.io/Smart-Price-Book/dev/?b=2026-01-15_2310_hf28-devsync&debug=1
```

**確認項目**:
- 画面上部のバージョン表記が `v19.9.18` になっていること
- `debug=1` で `BUILD_ID: 2026-01-15_2310_hf28-devsync` が表示されること

---

**更新完了。BUILD_IDを新しく更新しました。**
