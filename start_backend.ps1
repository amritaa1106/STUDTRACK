# PowerShell script to start STUDTRACK Backend Server

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Starting STUDTRACK Backend Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if (-not (Test-Path "venv\Scripts\Activate.ps1")) {
    Write-Host "Error: Virtual environment not found!" -ForegroundColor Red
    Write-Host "Please create it first with: python -m venv venv" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Green
& "venv\Scripts\Activate.ps1"

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host "Warning: .env file not found!" -ForegroundColor Yellow
    Write-Host "Make sure DATABASE_URL is configured." -ForegroundColor Yellow
    Write-Host ""
}

# Check if requirements are installed (basic check)
try {
    python -c "import fastapi" 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Installing dependencies..." -ForegroundColor Yellow
        pip install -r requirements.txt
        Write-Host ""
    }
} catch {
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    pip install -r requirements.txt
    Write-Host ""
}

Write-Host "Starting FastAPI server..." -ForegroundColor Green
Write-Host "Server will be available at: http://localhost:8000" -ForegroundColor Cyan
Write-Host "API Documentation: http://localhost:8000/docs" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Run the server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
