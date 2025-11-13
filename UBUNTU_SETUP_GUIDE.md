# Ubuntu PC Setup Guide - Eastern Distributors Scraper

Complete guide to set up and run the automated daily scraper on your Ubuntu PC.

---

## 📋 Table of Contents

1. [Quick Start](#quick-start)
2. [Detailed Setup Instructions](#detailed-setup-instructions)
3. [Setting Up Daily Automation (Cron)](#setting-up-daily-automation-cron)
4. [Manual Testing](#manual-testing)
5. [Monitoring & Troubleshooting](#monitoring--troubleshooting)

---

## 🚀 Quick Start

If you're familiar with Ubuntu, here's the quick version:

```bash
# 1. Clone/download the project to your Ubuntu PC
cd /path/to/scraper

# 2. Run the setup script
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh

# 3. Configure credentials
cp .env.example .env
nano .env  # Add your username and password

# 4. Test it
chmod +x run_scraper.sh
./run_scraper.sh

# 5. Setup daily cron job for 4pm AEST
crontab -e
# Add: 0 16 * * * /path/to/scraper/run_scraper.sh >> /path/to/scraper/scraper.log 2>&1
```

---

## 🔧 Detailed Setup Instructions

### Step 1: System Requirements

**Minimum Requirements:**
- Ubuntu 20.04 or later (also works on Debian-based distros)
- Python 3.8 or higher
- 2GB RAM
- 500MB disk space
- Internet connection

**Check your Python version:**
```bash
python3 --version
```

### Step 2: Download the Project

Download or clone the project to your Ubuntu PC. For example:

```bash
# Option 1: If you have git
git clone <your-repo-url>
cd eastern-scraper

# Option 2: Download and extract manually
# Download the project files and extract to a folder like:
mkdir -p ~/eastern-scraper
cd ~/eastern-scraper
# Copy all project files here
```

### Step 3: Run Automated Setup

The setup script will install all required dependencies:

```bash
# Make the setup script executable
chmod +x setup_ubuntu.sh

# Run the setup (will ask for sudo password)
./setup_ubuntu.sh
```

**What this installs:**
- Python3 and pip
- Chromium browser
- ChromeDriver (for Selenium)
- Python virtual environment
- Required Python packages: requests, selenium, webdriver-manager, python-dotenv

### Step 4: Configure Your Credentials

Create your credentials file:

```bash
# Copy the example file
cp .env.example .env

# Edit with your credentials
nano .env
```

**Add your credentials to .env:**
```
EASTERN_USERNAME=sales@petfoodandwire.com.au
EASTERN_PASSWORD=your_actual_password_here
```

**Save and exit:** Press `Ctrl+X`, then `Y`, then `Enter`

**Important:** The `.env` file is in `.gitignore` so your credentials won't be committed to git.

### Step 5: Make Run Script Executable

```bash
chmod +x run_scraper.sh
```

---

## ⏰ Setting Up Daily Automation (Cron)

### Understanding the Schedule

- **4pm AEST** = 16:00 in 24-hour format
- The scraper runs for 5-6 hours, finishing around 10pm AEST

### Option 1: Using Crontab (Recommended)

**1. Open crontab editor:**
```bash
crontab -e
```

If this is your first time, select your preferred editor (nano is easiest for beginners).

**2. Add this line at the end:**
```
# Run Eastern Distributors scraper daily at 4pm AEST
0 16 * * * /home/YOUR_USERNAME/eastern-scraper/run_scraper.sh >> /home/YOUR_USERNAME/eastern-scraper/scraper.log 2>&1
```

**Important:** Replace `/home/YOUR_USERNAME/eastern-scraper/` with your actual path!

**To find your path:**
```bash
cd ~/eastern-scraper
pwd
# Copy the output and use it in the cron line
```

**3. Save and exit:**
- In nano: `Ctrl+X`, then `Y`, then `Enter`

**4. Verify crontab was added:**
```bash
crontab -l
```

### Understanding the Cron Expression

```
0 16 * * *
│ │  │ │ │
│ │  │ │ └─── Day of week (0-7, both 0 and 7 are Sunday)
│ │  │ └───── Month (1-12)
│ │  └─────── Day of month (1-31)
│ └───────── Hour (16 = 4pm)
└─────────── Minute (0 = on the hour)
```

### Alternative Schedules

Edit the cron expression for different times:

| Schedule | Cron Expression |
|----------|----------------|
| 4pm daily | `0 16 * * *` |
| 6pm daily | `0 18 * * *` |
| 2pm daily | `0 14 * * *` |
| 8am daily | `0 8 * * *` |
| Weekdays only (Mon-Fri) | `0 16 * * 1-5` |
| Twice daily (8am & 8pm) | `0 8,20 * * *` |

### Option 2: Using Systemd Timer (Advanced)

For more control, you can create a systemd service and timer. See the end of this document for instructions.

---

## 🧪 Manual Testing

### Test the Full Scraper

Run the complete scraper manually:

```bash
cd ~/eastern-scraper
./run_scraper.sh
```

This will:
1. Login and save cookies (~30 seconds)
2. Scrape all 5,229 products (~5-6 hours)
3. Save to `eastern_scraped_data.csv`

### Test Just the Login

```bash
source venv/bin/activate
python3 login_and_save_cookies_.py
```

### Test with Limited Products (Quick Test)

```bash
source venv/bin/activate
python3 scrape_products_with_cookies.py test 10
```

This will scrape only the first 10 products for testing.

### Check Scraper Status

```bash
python3 check_scraper_status.py
```

---

## 📊 Monitoring & Troubleshooting

### View Logs

**Check the main log file:**
```bash
tail -f ~/eastern-scraper/scraper.log
```

**Check recent scraper output:**
```bash
tail -100 ~/eastern-scraper/scraper.log | less
```

**Check if cron job ran:**
```bash
grep CRON /var/log/syslog | tail -20
```

### Check Output Files

**Check if CSV was created:**
```bash
ls -lh ~/eastern-scraper/eastern_scraped_data.csv
```

**Check number of products scraped:**
```bash
wc -l ~/eastern-scraper/eastern_scraped_data.csv
```

**View latest products scraped:**
```bash
tail -10 ~/eastern-scraper/eastern_scraped_data.csv
```

### Common Issues

#### Issue: "Permission denied" when running scripts

**Solution:**
```bash
chmod +x setup_ubuntu.sh run_scraper.sh
```

#### Issue: "chromium-browser: command not found"

**Solution:**
```bash
sudo apt update
sudo apt install chromium-browser chromium-chromedriver
```

#### Issue: "No module named 'selenium'"

**Solution:**
```bash
source venv/bin/activate
pip install requests selenium webdriver-manager python-dotenv
```

#### Issue: Cron job doesn't run

**Check crontab is set:**
```bash
crontab -l
```

**Check system logs:**
```bash
grep CRON /var/log/syslog | tail -20
```

**Make sure script has full path:**
```bash
# In crontab, use full paths:
0 16 * * * /home/username/eastern-scraper/run_scraper.sh
# NOT just:
0 16 * * * ./run_scraper.sh
```

#### Issue: Script runs but no data

**Check if .env file exists:**
```bash
cat .env
```

**Make sure credentials are correct in .env**

**Run manually to see errors:**
```bash
./run_scraper.sh
```

---

## 📁 File Structure

```
eastern-scraper/
├── .env                              # Your credentials (create from .env.example)
├── .env.example                      # Template for credentials
├── .gitignore                        # Git ignore file
├── setup_ubuntu.sh                   # Ubuntu setup script
├── run_scraper.sh                    # Main script to run (called by cron)
├── daily_scraper.py                  # Python wrapper for daily automation
├── login_and_save_cookies_.py        # Login and save session cookies
├── scrape_products_with_cookies.py   # Main scraping logic
├── check_scraper_status.py           # Status checker
├── eastern_scraped_data.csv          # Output data (5,229 products)
├── pronto_cookies.json               # Session cookies (auto-generated)
├── scraper.log                       # Log file (created by cron)
├── venv/                             # Python virtual environment
└── attached_assets/
    └── Eastern_sku_matchedd_rows_*.csv  # Input CSV with product URLs
```

---

## 🔐 Security Best Practices

1. **Protect your .env file:**
   ```bash
   chmod 600 .env
   ```

2. **Never commit .env to git** (already in .gitignore)

3. **Keep your system updated:**
   ```bash
   sudo apt update && sudo apt upgrade
   ```

4. **Review logs regularly** to ensure no errors

---

## 📈 Advanced: Systemd Timer Setup (Alternative to Cron)

If you prefer systemd over cron:

**1. Create service file:**
```bash
sudo nano /etc/systemd/system/eastern-scraper.service
```

**Add:**
```ini
[Unit]
Description=Eastern Distributors Product Scraper
After=network.target

[Service]
Type=oneshot
User=YOUR_USERNAME
WorkingDirectory=/home/YOUR_USERNAME/eastern-scraper
ExecStart=/home/YOUR_USERNAME/eastern-scraper/run_scraper.sh
StandardOutput=append:/home/YOUR_USERNAME/eastern-scraper/scraper.log
StandardError=append:/home/YOUR_USERNAME/eastern-scraper/scraper.log

[Install]
WantedBy=multi-user.target
```

**2. Create timer file:**
```bash
sudo nano /etc/systemd/system/eastern-scraper.timer
```

**Add:**
```ini
[Unit]
Description=Run Eastern Scraper daily at 4pm
Requires=eastern-scraper.service

[Timer]
OnCalendar=*-*-* 16:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

**3. Enable and start:**
```bash
sudo systemctl enable eastern-scraper.timer
sudo systemctl start eastern-scraper.timer
```

**4. Check status:**
```bash
sudo systemctl status eastern-scraper.timer
sudo systemctl list-timers eastern-scraper.timer
```

---

## ✅ Verification Checklist

- [ ] Python 3.8+ installed
- [ ] Chromium and ChromeDriver installed
- [ ] Virtual environment created
- [ ] All Python packages installed
- [ ] `.env` file created with credentials
- [ ] Scripts are executable (`chmod +x`)
- [ ] Manual test successful
- [ ] Cron job configured
- [ ] Logs working properly

---

## 🎯 Summary

**After setup, your system will:**
- ✅ Run automatically every day at 4pm AEST
- ✅ Login and refresh cookies
- ✅ Scrape all 5,229 products (5-6 hours)
- ✅ Save data to `eastern_scraped_data.csv`
- ✅ Auto-refresh cookies every 10 minutes during scraping
- ✅ Log all output to `scraper.log`
- ✅ Complete around 10pm AEST with fresh data

**No manual intervention required!**

---

## 📞 Need Help?

Check the log files first:
```bash
tail -100 scraper.log
```

Run manually to see errors in real-time:
```bash
./run_scraper.sh
```

---

**Your Ubuntu scraper is ready! Set it and forget it.** 🚀
