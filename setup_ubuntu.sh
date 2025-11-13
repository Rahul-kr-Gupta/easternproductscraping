#!/bin/bash

echo "============================================================"
echo "Eastern Distributors Scraper - Ubuntu Setup Script"
echo "============================================================"
echo ""

# Check if running on Ubuntu
if ! grep -q "Ubuntu" /etc/os-release 2>/dev/null; then
    echo "⚠ Warning: This script is designed for Ubuntu. You may need to adapt it for other distros."
    echo ""
fi

# Update package list
echo "📦 Updating package list..."
sudo apt update

# Install Python3 and pip if not already installed
echo ""
echo "🐍 Installing Python3 and pip..."
sudo apt install -y python3 python3-pip

# Install Chrome/Chromium for Selenium
echo ""
echo "🌐 Installing Chromium browser..."
sudo apt install -y chromium-browser

# Install ChromeDriver
echo ""
echo "🚗 Installing ChromeDriver..."
sudo apt install -y chromium-chromedriver

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
