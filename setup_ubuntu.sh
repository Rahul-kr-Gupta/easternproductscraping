#!/bin/bash

echo "============================================================"
echo "Eastern Distributors Scraper - Amazon Linux Setup Script"
echo "============================================================"
echo ""

# Check if running on Amazon Linux
if ! grep -q "Amazon Linux" /etc/os-release 2>/dev/null; then
    echo "⚠ Warning: This script is designed for Amazon Linux (yum). You may need to adapt it for other distros."
    echo ""
fi

# Update package list
echo "📦 Updating package list..."
sudo yum update -y

# Install core tools, Python3, and pip if not already installed
echo ""
echo "🐍 Installing Python3, pip, and helper utilities..."
sudo yum install -y python3 python3-pip curl wget unzip

# Install Google Chrome for Selenium
echo ""
echo "🌐 Installing Google Chrome..."
if ! command -v google-chrome >/dev/null 2>&1; then
    TEMP_CHROME="/tmp/google-chrome.rpm"
    curl -L "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm" -o "$TEMP_CHROME"
    sudo yum install -y "$TEMP_CHROME"
    rm -f "$TEMP_CHROME"
else
    echo "✓ Google Chrome already installed"
fi

# Install matching ChromeDriver
echo ""
echo "🚗 Installing ChromeDriver..."
if ! command -v chromedriver >/dev/null 2>&1; then
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}')
    CHROME_MAJOR=${CHROME_VERSION%%.*}
    DRIVER_VERSION=$(curl -sSL "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR}")
    DRIVER_ZIP="/tmp/chromedriver_linux64.zip"
    curl -sSL "https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip" -o "$DRIVER_ZIP"
    unzip -q -o "$DRIVER_ZIP" -d /tmp
    sudo mv /tmp/chromedriver /usr/local/bin/chromedriver
    sudo chmod +x /usr/local/bin/chromedriver
    rm -f "$DRIVER_ZIP"
else
    echo "✓ ChromeDriver already installed"
fi

# Create virtual environment (optional but recommended)
echo ""
echo "📦 Setting up Python virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "✓ Virtual environment created"
else
    echo "✓ Virtual environment already exists"
fi

# Activate virtual environment and install requirements
echo ""
echo "📦 Installing Python packages..."
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo ""
echo "============================================================"
echo "✓ Setup Complete!"
echo "============================================================"
echo ""
echo "Next steps:"
echo "1. Copy .env.example to .env:"
echo "   cp .env.example .env"
echo ""
echo "2. Edit .env and add your credentials:"
echo "   nano .env"
echo ""
echo "3. Test the scraper:"
echo "   source venv/bin/activate"
echo "   python daily_scraper.py"
echo ""
echo "4. Setup daily cron job (see UBUNTU_SETUP_GUIDE.md)"
echo ""
echo "============================================================"
