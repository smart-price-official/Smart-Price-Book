// REX Dev Tool Service Worker
// キャッシュ戦略: Network First, Fallback to Cache

const CACHE_NAME = 'rex-dev-tool-v1.0.0';
const STATIC_CACHE_NAME = 'rex-dev-tool-static-v1.0.0';

// キャッシュするリソース
const STATIC_RESOURCES = [
  './index.html',
  './manifest.json',
  './icon-192.png',
  './icon-512.png'
];

// インストール時にキャッシュを生成
self.addEventListener('install', (event) => {
  console.log('[Service Worker] Installing...');
  event.waitUntil(
    caches.open(STATIC_CACHE_NAME).then((cache) => {
      console.log('[Service Worker] Caching static resources');
      return cache.addAll(STATIC_RESOURCES).catch((err) => {
        console.warn('[Service Worker] Failed to cache some resources:', err);
        // 一部のリソースがキャッシュできなくても続行
        return Promise.resolve();
      });
    })
  );
  // 新しいService Workerを即座にアクティブ化
  self.skipWaiting();
});

// アクティベート時に古いキャッシュを削除
self.addEventListener('activate', (event) => {
  console.log('[Service Worker] Activating...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== STATIC_CACHE_NAME && cacheName !== CACHE_NAME) {
            console.log('[Service Worker] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  // すべてのクライアントを制御
  return self.clients.claim();
});

// フェッチイベント（Network First戦略）
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // 同一オリジンのリソースのみキャッシュ
  if (url.origin !== location.origin) {
    // 外部リソース（GitHub APIなど）は常にネットワークから取得
    return;
  }

  event.respondWith(
    fetch(request)
      .then((response) => {
        // ネットワークから取得成功 → キャッシュに保存
        if (response && response.status === 200) {
          const responseToCache = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(request, responseToCache);
          });
        }
        return response;
      })
      .catch(() => {
        // ネットワークエラー → キャッシュから取得
        return caches.match(request).then((cachedResponse) => {
          if (cachedResponse) {
            return cachedResponse;
          }
          // キャッシュにもない場合、オフラインページを返す
          return new Response('オフラインです。ネットワーク接続を確認してください。', {
            status: 503,
            statusText: 'Service Unavailable',
            headers: new Headers({
              'Content-Type': 'text/plain; charset=utf-8'
            })
          });
        });
      })
  );
});

// メッセージハンドラ（キャッシュクリアなど）
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
  if (event.data && event.data.type === 'CLEAR_CACHE') {
    event.waitUntil(
      caches.keys().then((cacheNames) => {
        return Promise.all(
          cacheNames.map((cacheName) => {
            return caches.delete(cacheName);
          })
        );
      })
    );
  }
});
