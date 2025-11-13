#!/bin/bash

echo "============================================================"
echo "Eastern Distributors Scraper - Setup Verification"
echo "============================================================"
echo ""

ERROR=0

# Check Python
echo "🐍 Checking Python..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo "✓ Python installed: $PYTHON_VERSION"
else
    echo "✗ Python3 not found"
    ERROR=1
fi

# Check pip
echo ""
echo "📦 Checking pip..."
if command -v pip3 &> /dev/null; then
    PIP_VERSION=$(pip3 --version)
    echo "✓ pip installed: $PIP_VERSION"
else
    echo "✗ pip3 not found"
    ERROR=1
fi

# Check Chromium
echo ""
echo "🌐 Checking Chromium..."
if command -v chromium-browser &> /dev/null; then
    CHROMIUM_VERSION=$(chromium-browser --version)
    echo "✓ Chromium installed: $CHROMIUM_VERSION"
elif command -v chromium &> /dev/null; then
    CHROMIUM_VERSION=$(chromium --version)
    echo "✓ Chromium installed: $CHROMIUM_VERSION"
else
    echo "✗ Chromium not found"
    ERROR=1
fi

# Check ChromeDriver
echo ""
echo "🚗 Checking ChromeDriver..."
if command -v chromedriver &> /dev/null; then
    DRIVER_VERSION=$(chromedriver --version 2>&1 | head -n1)
    echo "✓ ChromeDriver installed: $DRIVER_VERSION"
else
    echo "✗ ChromeDriver not found"
    ERROR=1
fi

# Check Virtual Environment
echo ""
echo "📦 Checking Virtual Environment..."
if [ -d "venv" ]; then
    echo "✓ Virtual environment exists"
    
    # Check if packages are installed
    if [ -f "venv/bin/pip" ]; then
        source venv/bin/activate
        echo ""
        echo "  Checking Python packages..."
        
        if python -c "import selenium" 2>/dev/null; then
            echo "  ✓ selenium installed"
        else
            echo "  ✗ selenium not installed"
            ERROR=1
        fi
        
        if python -c "import requests" 2>/dev/null; then
            echo "  ✓ requests installed"
        else
            echo "  ✗ requests not installed"
            ERROR=1
        fi
        
        if python -c "import dotenv" 2>/dev/null; then
            echo "  ✓ python-dotenv installed"
        else
            echo "  ✗ python-dotenv not installed"
            ERROR=1
        fi
        
        deactivate
    fi
else
    echo "✗ Virtual environment not found"
    ERROR=1
fi

# Check .env file
echo ""
echo "🔐 Checking credentials..."
if [ -f ".env" ]; then
    echo "✓ .env file exists"
    
    # Check if credentials are set
    if grep -q "EASTERN_USERNAME=" .env && grep -q "EASTERN_PASSWORD=" .env; then
        if grep -q "your_password_here" .env; then
            echo "⚠ Warning: .env file contains placeholder password"
            echo "  Please update .env with your actual credentials"
            ERROR=1
        else
            echo "✓ Credentials configured"
        fi
    else
        echo "✗ Credentials not properly configured in .env"
        ERROR=1
    fi
else
    echo "✗ .env file not found"
    echo "  Run: cp .env.example .env"
    ERROR=1
fi

# Check scripts are executable
echo ""
echo "📜 Checking scripts..."
if [ -x "run_scraper.sh" ]; then
    echo "✓ run_scraper.sh is executable"
else
    echo "✗ run_scraper.sh is not executable"
    echo "  Run: chmod +x run_scraper.sh"
    ERROR=1
fi

if [ -x "setup_ubuntu.sh" ]; then
    echo "✓ setup_ubuntu.sh is executable"
else
    echo "⚠ setup_ubuntu.sh is not executable (only needed for first-time setup)"
fi

# Check input CSV
echo ""
echo "📄 Checking input files..."
CSV_COUNT=$(find attached_assets -name "*.csv" 2>/dev/null | wc -l)
if [ $CSV_COUNT -gt 0 ]; then
    echo "✓ Found $CSV_COUNT CSV file(s) in attached_assets/"
else
    echo "✗ No CSV files found in attached_assets/"
    ERROR=1
fi

echo ""
echo "============================================================"
if [ $ERROR -eq 0 ]; then
    echo "✅ ALL CHECKS PASSED - Ready to run!"
    echo "============================================================"
    echo ""
    echo "Next steps:"
    echo "1. Test the scraper: ./run_scraper.sh"
    echo "2. Setup cron job: crontab -e"
    echo "   Add: 0 16 * * * $(pwd)/run_scraper.sh >> $(pwd)/scraper.log 2>&1"
    echo ""
else
    echo "❌ SETUP INCOMPLETE - Please fix the errors above"
    echo "============================================================"
    echo ""
    echo "To fix issues:"
    echo "1. Run setup script: ./setup_ubuntu.sh"
    echo "2. Configure credentials: cp .env.example .env && nano .env"
    echo "3. Make scripts executable: chmod +x run_scraper.sh"
    echo ""
fi

exit $ERROR
