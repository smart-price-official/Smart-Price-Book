@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0.."
git add Smart-Price-Book/dev/index.html
git add Smart-Price-Book/dev/修正報告書_*.md
git commit -m "v19.9.17: 商品DBの優先順位確定（Yahoo→楽天→OFF）＋自動整形の精度アップ"
git push origin main
echo.
echo 完了しました！
echo.
echo 差分を確認: https://github.com/smart-price-official/Smart-Price-Book/commits/main
echo.
pause
