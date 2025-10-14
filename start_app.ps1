# Kalakaari Flutter Web App Runner - Permanent Solution
Write-Host "🏺 Starting Kalakaari Flutter Web App..." -ForegroundColor Cyan

# Navigate to project directory
Set-Location "C:\Users\bapat\OneDrive\Desktop\Kalakaari"

# Clean project
Write-Host "🧹 Cleaning project..." -ForegroundColor Yellow
flutter clean

# Build for web
Write-Host "🔨 Building for web..." -ForegroundColor Green
flutter build web

# Navigate to build directory and start server
Write-Host "🚀 Starting server at http://localhost:57567" -ForegroundColor Cyan
Set-Location "build\web"
Write-Host "📱 Your Kalakaari app with blue pottery image is ready!" -ForegroundColor Magenta

npx serve -s . -p 57567