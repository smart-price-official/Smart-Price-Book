/**
 * APP: Smart Price
 * FILE: sw.js
 * VERSION: v19.9c-hf13-pwa2-imgflow1
 * DATE(JST): 2026-01-03 21:55 JST
 * BUILD: 2026-01-03_2155_imgflow1
 */
const BUILD = "2026-01-03_2155_imgflow1";
const CACHE = "smart-price-" + BUILD;

const PRECACHE = [
  "./",
  "./index.html",
  "./manifest.json",
  "./icon-192.png",
  "./icon-512.png"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE).then((cache) => cache.addAll(PRECACHE)).then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    (async ()=>{
      const keys = await caches.keys();
      await Promise.all(keys.map(k => (k !== CACHE) ? caches.delete(k) : Promise.resolve()));
      await self.clients.claim();
    })()
  );
});

self.addEventListener("fetch", (event) => {
  const req = event.request;
  const url = new URL(req.url);

  // Firebase等のAPIは触らない（ネットワーク優先）
  if (req.method !== "GET") return;

  // 同一オリジンの静的だけキャッシュ
  if (url.origin === location.origin) {
    event.respondWith((async ()=>{
      const cache = await caches.open(CACHE);
      const hit = await cache.match(req, { ignoreSearch: true });
      if (hit) return hit;
      const res = await fetch(req);
      // 成功したものだけキャッシュ
      if (res && res.ok) cache.put(req, res.clone());
      return res;
    })());
  }
});
