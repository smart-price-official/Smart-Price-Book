@echo off
echo.
echo ========================================
echo Smart Price - GitHub自動push (簡易版)
echo ========================================
echo.
pause

cd /d "g:\マイドライブ\Cursor\Smart Price"
if errorlevel 1 (
    echo エラー: フォルダに移動できませんでした
    pause
    exit /b 1
)
echo OK: フォルダに移動しました
echo.
pause

echo Gitの確認中...
where git >nul 2>&1
if errorlevel 1 (
    echo エラー: Gitがインストールされていません
    pause
    exit /b 1
)
echo OK: Gitが見つかりました
echo.
pause

echo Gitリポジトリの確認中...
git status >nul 2>&1
if errorlevel 1 (
    echo エラー: Gitリポジトリが見つかりません
    echo 現在のフォルダ: %CD%
    pause
    exit /b 1
)
echo OK: Gitリポジトリが見つかりました
git status
echo.
pause

echo ファイルをステージング中...
git add Smart-Price-Book/dev/index.html
git add Smart-Price-Book/dev/修正報告書_*.md
git add Smart-Price-Book/dev/ユイ宛_*.md
git add Smart-Price-Book/dev/ユイ宛_*.html
git add README.md
echo 完了
echo.
pause

echo コミット中...
git commit -m "v19.9.17: 商品DBの優先順位確定（Yahoo→楽天→OFF）＋自動整形の精度アップ"
if errorlevel 1 (
    echo 警告: コミットに失敗しました（変更がない可能性があります）
)
echo 完了
echo.
pause

echo GitHubにpush中...
git push origin main
if errorlevel 1 (
    echo エラー: pushに失敗しました
    pause
    exit /b 1
)
echo 完了
echo.
pause

echo ========================================
echo push完了！
echo ========================================
echo.
echo 差分を確認するURL:
echo https://github.com/smart-price-official/Smart-Price-Book/commits/main
echo.
pause
