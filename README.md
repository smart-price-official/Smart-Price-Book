# Smart-Price-Book
安定版（stable）の保管と運用ルール【最重要】
目的

現在正常に動作している Smart Price 安定版 を
検証・実使用専用として凍結し、
今後の修正や実験による不具合混入を防ぐためのルールを定める。

📌 安定版の場所（触らない）
/Smart-Price-Book/
 └─ stable/
     └─ index.html   （安定版・検証専用）


stable/ 配下のファイルは 原則として編集禁止

ここにあるものは「動作確認済み・実使用OK」の状態を表す

安定版URL（固定）
https://smart-price-official.github.io/Smart-Price-Book/stable/

📱 PWAについて

PWA登録・ホーム画面追加は stable のURLのみ

dev/ やその他検証用URLを PWAとして登録してはいけない

奥さま・実地検証・日常利用は 必ず stable 版を使用

🔧 修正・開発は別場所で行う
/Smart-Price-Book/
 └─ dev/
     └─ index.html   （修正・実験・開発専用）


新しい修正・機能追加・バグ調査は 必ず dev/ で行う

dev/ 側では不具合が出ても問題なし

キャッシュ回避のため、検証時は ?b=YYYY-MM-DD_xxxx を付与する

例：

https://smart-price-official.github.io/Smart-Price-Book/dev/?b=2026-01-13_test

🚚 昇格ルール（dev → stable）

dev で修正した内容は、以下すべてを満たした場合のみ stable に反映する。

ブラウザ版で正常動作

PWA版で正常動作

初回起動・再起動・再読み込みで問題なし

購入履歴・画像・同期挙動に異常なし

👉 上記確認後のみ
dev の index.html を stable にコピーして更新する

※ stable 上での直接修正は禁止

🚫 禁止事項

stable ディレクトリでの直接デバッグ

stable を修正用として使うこと

stable URL に debug=1 を付けての常用

✅ このルールの狙い

「どれが正しく動いているか分からない」状態を防ぐ

PWA特有の再現しにくい不具合を切り分けやすくする

実使用と開発を完全に分離する
