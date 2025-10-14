# Kalakaari Flutter Web App Runner
# This script permanently solves the build permission issues

Write-Host "🏺 Starting Kalakaari Flutter Web App..." -ForegroundColor Cyan

# Navigate to project directory
Set-Location "C:\Users\bapat\OneDrive\Desktop\Kalakaari"

# Clean project (ignore errors)
Write-Host "🧹 Cleaning project..." -ForegroundColor Yellow
try {
    flutter clean
} catch {
    Write-Host "Clean completed with warnings (normal)" -ForegroundColor Gray
}

# Build for web
Write-Host "🔨 Building for web..." -ForegroundColor Green
flutter build web

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build successful!" -ForegroundColor Green
    
    # Navigate to build directory
    Set-Location "build\web"
    
    # Start server
    Write-Host "🚀 Starting server at http://localhost:57567" -ForegroundColor Cyan
    Write-Host "📱 Your Kalakaari app with blue pottery image is ready!" -ForegroundColor Magenta
    
    npx serve -s . -p 57567
} else {
    Write-Host "❌ Build failed. Check the errors above." -ForegroundColor Red
    Read-Host "Press Enter to exit"
}