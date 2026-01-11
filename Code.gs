/**
 * APP: Yahoo Lab (Smart Price - Yahoo連携 実験プロキシ)
 * FILE: Code.gs
 * VERSION: v0.1.0-yahoo-lab-A
 * DATE(JST): 2026-01-11 22:17 JST
 * TITLE: Yahoo Shopping Web Service V3 itemSearch のGASプロキシ
 * CHANGES:
 * - Webアプリ(doGet)で jan_code / query を受け取り、Yahoo APIへ中継
 * - ブラウザ側がCORSの事前確認（プリフライト）を起こさないよう、GETのみを想定
 * - Yahoo APP ID は Script Properties に保存（公開しない）
 * AUTHOR: Yui
 * BUILD_PARAM: ?b=2026-01-11_2217_yahoo-lab
 * DEBUG_PARAM: &debug=1
 */
const APP_VERSION = "v0.1.0-yahoo-lab-A";
const BUILD_ID = "2026-01-11_2217_yahoo-lab";

// Script Properties に保存するキー名
const PROP_YAHOO_APP_ID = "YAHOO_APP_ID";

// Yahoo 商品検索（v3）エンドポイント
const YAHOO_ENDPOINT = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch";

function doGet(e) {
  const p = (e && e.parameter) ? e.parameter : {};

  const appId = PropertiesService.getScriptProperties().getProperty(PROP_YAHOO_APP_ID);
  if (!appId) {
    return _json({
      ok: false,
      error: "Script Properties に YAHOO_APP_ID が未設定です。",
      howto: "プロジェクトの設定 → スクリプトプロパティ → 追加（キー: YAHOO_APP_ID / 値: あなたのYahoo APP ID）"
    });
  }

  const mode = (p.mode || "jan").toLowerCase();
  const imageSize = _safeInt(p.image_size, 300, 146, 600);
  const results = _safeInt(p.results, 10, 1, 50);

  const url = newUrl_(YAHOO_ENDPOINT);
  url.add("appid", appId);
  url.add("results", String(results));
  url.add("image_size", String(imageSize));

  if (mode === "keyword") {
    const q = (p.query || "").toString().trim();
    if (!q) return _json({ ok:false, error:"query が空です。" });
    url.add("query", q);
  } else {
    const jan = (p.jan || "").toString().trim();
    if (!jan) return _json({ ok:false, error:"jan が空です。" });
    url.add("jan_code", jan);
  }

  const full = url.toString();
  try {
    const res = UrlFetchApp.fetch(full, {
      method: "get",
      muteHttpExceptions: true,
    });

    const status = res.getResponseCode();
    const text = res.getContentText();

    if (status >= 200 && status < 300) {
      // そのまま返す（フロントがYahoo形式で扱える）
      return ContentService.createTextOutput(text)
        .setMimeType(ContentService.MimeType.JSON);
    }

    // Yahoo側エラー
    return _json({
      ok: false,
      error: "Yahoo API error",
      status: status,
      body: text
    });
  } catch (err) {
    return _json({
      ok: false,
      error: String(err),
      url: full
    });
  }
}

function _json(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj))
    .setMimeType(ContentService.MimeType.JSON);
}

function _safeInt(v, def, min, max) {
  const n = parseInt(v, 10);
  if (!isFinite(n)) return def;
  return Math.max(min, Math.min(max, n));
}

// 小さなURLビルダー（エスケープ対応）
function newUrl_(base) {
  const parts = [];
  return {
    add: (k, v) => {
      parts.push(encodeURIComponent(k) + "=" + encodeURIComponent(v));
    },
    toString: () => {
      return base + (parts.length ? ("?" + parts.join("&")) : "");
    }
  };
}
