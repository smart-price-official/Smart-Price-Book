@echo off
echo ========================================
echo Smart Price - GitHub自動push
echo ========================================
echo.
echo [開始] スクリプトを実行します...
echo.

cd /d "g:\マイドライブ\Cursor\Smart Price"
if errorlevel 1 (
    echo ❌ エラー: フォルダに移動できませんでした
    echo パス: g:\マイドライブ\Cursor\Smart Price
    echo.
    pause
    exit /b 1
)
echo [OK] フォルダに移動しました: %CD%
echo.

echo [0/5] Gitの確認中...
where git >nul 2>&1
if errorlevel 1 (
    echo.
    echo ========================================
    echo ❌ エラー: Gitがインストールされていません
    echo ========================================
    echo.
    echo Gitをインストールしてください: https://git-scm.com/
    echo.
    echo または、GitHub Desktopを使用してください。
    echo.
    pause
    exit /b 1
)
echo [OK] Gitが見つかりました
echo.

echo [1/5] 変更ファイルを確認中...
git status >nul 2>&1
if errorlevel 1 (
    echo ❌ エラー: Gitリポジトリが見つかりません
    echo このフォルダはGitリポジトリではないようです。
    echo.
    echo 現在のフォルダ: %CD%
    echo.
    echo 解決方法:
    echo 1. 正しいGitリポジトリのフォルダで実行してください
    echo 2. または、このフォルダで git init を実行してください
    echo.
    pause
    exit /b 1
)
git status
echo.

echo [2/5] ファイルをステージング中...
git add Smart-Price-Book/dev/index.html
git add Smart-Price-Book/dev/修正報告書_*.md
git add Smart-Price-Book/dev/ユイ宛_*.md
git add Smart-Price-Book/dev/ユイ宛_*.html
git add README.md
if errorlevel 1 (
    echo ❌ エラー: ファイルのステージングに失敗しました
    pause
    exit /b 1
)
echo 完了！
echo.

echo [3/5] コミット中...
git commit -m "v19.9.17: 商品DBの優先順位確定（Yahoo→楽天→OFF）＋自動整形の精度アップ"
if errorlevel 1 (
    echo ⚠️ 警告: コミットに失敗しました（変更がない可能性があります）
    echo 続行します...
)
echo 完了！
echo.

echo [4/5] GitHubにpush中...
git push origin main
if errorlevel 1 (
    echo.
    echo ❌ エラー: pushに失敗しました
    echo.
    echo 考えられる原因:
    echo 1. リモートリポジトリが設定されていない
    echo 2. 認証情報が正しくない
    echo 3. ネットワークエラー
    echo.
    echo 手動で確認する場合:
    echo git remote -v
    echo git push origin main
    echo.
    pause
    exit /b 1
)
echo 完了！
echo.

echo [5/5] 差分URLを取得中...
echo.
echo ========================================
echo ✅ push完了！
echo ========================================
echo.
echo 差分を確認するURL:
echo https://github.com/smart-price-official/Smart-Price-Book/commits/main
echo.
echo 最新のコミットをクリックすると差分が見れます。
echo.
echo 最新のコミット情報:
git log -1 --oneline
echo.
pause
