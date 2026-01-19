@echo off
setlocal

set "LOG_FILE=%~dp0push_log.txt"
set "BAT_DIR=%~dp0"
set "TARGET_DIR=%BAT_DIR%.."

echo ========================================
echo Smart Price - GitHub自動push (ログ版)
echo ========================================
echo.
echo ログファイル: %LOG_FILE%
echo 実行フォルダ: %BAT_DIR%
echo.

cd /d "%TARGET_DIR%"
if errorlevel 1 (
    echo エラー: フォルダに移動できませんでした >"%LOG_FILE%"
    echo パス: %TARGET_DIR% >>"%LOG_FILE%"
    echo 現在のフォルダ: %CD% >>"%LOG_FILE%"
    echo.
    echo エラー: フォルダに移動できませんでした
    echo パス: %TARGET_DIR%
    echo 現在のフォルダ: %CD%
    type "%LOG_FILE%"
    pause
    exit /b 1
)
echo OK: フォルダに移動しました >"%LOG_FILE%"
echo OK: フォルダに移動しました: %CD%
echo.

where git >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo エラー: Gitがインストールされていません >>"%LOG_FILE%"
    echo.
    echo エラー: Gitがインストールされていません
    type "%LOG_FILE%"
    pause
    exit /b 1
)
echo OK: Gitが見つかりました >>"%LOG_FILE%"
echo OK: Gitが見つかりました
echo.

git status >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo エラー: Gitリポジトリが見つかりません >>"%LOG_FILE%"
    echo 現在のフォルダ: %CD% >>"%LOG_FILE%"
    echo.
    echo エラー: Gitリポジトリが見つかりません
    echo 現在のフォルダ: %CD%
    type "%LOG_FILE%"
    pause
    exit /b 1
)
echo OK: Gitリポジトリが見つかりました >>"%LOG_FILE%"
echo OK: Gitリポジトリが見つかりました
git status
echo.

echo ファイルをステージング中...
git add Smart-Price-Book/dev/index.html >>"%LOG_FILE%" 2>&1
git add Smart-Price-Book/dev/修正報告書_*.md >>"%LOG_FILE%" 2>&1
git add Smart-Price-Book/dev/ユイ宛_*.md >>"%LOG_FILE%" 2>&1
git add Smart-Price-Book/dev/ユイ宛_*.html >>"%LOG_FILE%" 2>&1
git add README.md >>"%LOG_FILE%" 2>&1
echo 完了
echo.

echo コミット中...
git commit -m "v19.9.17: 商品DBの優先順位確定（Yahoo→楽天→OFF）＋自動整形の精度アップ" >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo 警告: コミットに失敗しました（変更がない可能性があります） >>"%LOG_FILE%"
    echo 警告: コミットに失敗しました（変更がない可能性があります）
)
echo 完了
echo.

echo GitHubにpush中...
git push origin main >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo エラー: pushに失敗しました >>"%LOG_FILE%"
    echo.
    echo エラー: pushに失敗しました
    type "%LOG_FILE%"
    pause
    exit /b 1
)
echo 完了
echo.

echo ========================================
echo push完了！
echo ========================================
echo.
echo 差分を確認するURL:
echo https://github.com/smart-price-official/Smart-Price-Book/commits/main
echo.
echo ログファイル: %LOG_FILE%
echo.
pause
