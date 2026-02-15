@echo off
echo ========================================
echo   Starting STUDTRACK Backend Server
echo ========================================
echo.

REM Check if virtual environment exists
if not exist "venv\Scripts\activate.bat" (
    echo Error: Virtual environment not found!
    echo Please create it first with: python -m venv venv
    pause
    exit /b 1
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Check if .env file exists
if not exist ".env" (
    echo Warning: .env file not found!
    echo Make sure DATABASE_URL is configured.
    echo.
)

REM Check if requirements are installed (basic check)
python -c "import fastapi" 2>nul
if errorlevel 1 (
    echo Installing dependencies...
    pip install -r requirements.txt
    echo.
)

echo Starting FastAPI server...
echo Server will be available at: http://localhost:8000
echo API Documentation: http://localhost:8000/docs
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

REM Run the server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

pause
