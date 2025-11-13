# Eastern Distributors Automated Scraper - Ubuntu PC Edition

Automated daily web scraping system for Eastern Distributors (pronto.eastdist.com) that runs directly on your Ubuntu PC.

---

## 🎯 What This Does

Automatically scrapes product data from Eastern Distributors every day at 4pm AEST:

- **5,229 products** scraped daily
- **5-6 hour runtime** (completes around 10pm)
- **11 data fields** per product: SKU, name, price, description, brand, image URL, etc.
- **Fully automated** with cron - zero manual intervention
- **Auto cookie refresh** every 10 minutes to maintain session
- **Saves to CSV** - fresh data ready every evening

---

## 🚀 Quick Setup (5 Minutes)

### Prerequisites
- Ubuntu 20.04 or later
- Internet connection
- Your Eastern Distributors login credentials

### Installation Steps

**1. Download the project to your Ubuntu PC**

**2. Run the automated setup:**
```bash
cd /path/to/eastern-scraper
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

**3. Configure your credentials:**
```bash
cp .env.example .env
nano .env
# Add your username and password, then save (Ctrl+X, Y, Enter)
```

**4. Test it works:**
```bash
chmod +x run_scraper.sh
./run_scraper.sh
# Press Ctrl+C after verifying it starts successfully
```

**5. Setup daily automation:**
```bash
crontab -e
# Add this line (replace /path/to/ with your actual path):
# 0 16 * * * /path/to/eastern-scraper/run_scraper.sh >> /path/to/eastern-scraper/scraper.log 2>&1
```

**Done!** Your scraper will now run automatically every day at 4pm.

---

## 📖 Documentation

- **[UBUNTU_QUICK_START.md](UBUNTU_QUICK_START.md)** - 5-minute setup guide
- **[UBUNTU_SETUP_GUIDE.md](UBUNTU_SETUP_GUIDE.md)** - Complete documentation with troubleshooting
- **[DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)** - Original Replit deployment guide

---

## 📁 Key Files

### Scripts You Run
- `setup_ubuntu.sh` - One-time setup (installs dependencies)
- `run_scraper.sh` - Main script called by cron daily
- `check_scraper_status.py` - Check scraping status anytime

### Python Scripts (Auto-run)
- `daily_scraper.py` - Master automation wrapper
- `login_and_save_cookies_.py` - Authentication
- `scrape_products_with_cookies.py` - Main scraper

### Configuration
- `.env` - Your credentials (create from .env.example)
- `requirements.txt` - Python dependencies

### Output Files
- `eastern_scraped_data.csv` - Scraped product data (updated daily)
- `pronto_cookies.json` - Session cookies (auto-refreshed)
- `scraper.log` - Execution logs

---

## 🔧 Common Commands

**Check scraper status:**
```bash
python3 check_scraper_status.py
```

**View logs in real-time:**
```bash
tail -f scraper.log
```

**Run scraper manually:**
```bash
./run_scraper.sh
```

**Test with 10 products only:**
```bash
source venv/bin/activate
python3 scrape_products_with_cookies.py test 10
```

**Check cron schedule:**
```bash
crontab -l
```

**View recent cron executions:**
```bash
grep CRON /var/log/syslog | tail -20
```

---

## ⏰ Automation Schedule

**Default:** Runs daily at 4pm AEST

**Cron Expression:** `0 16 * * *`

**To change schedule:**
```bash
crontab -e
# Modify the hour in the cron expression:
# 0 18 * * * = 6pm daily
# 0 14 * * * = 2pm daily
# 0 16 * * 1-5 = 4pm weekdays only
```

---

## 📊 What Gets Scraped

Each of the 5,229 products includes:

1. **URL** - Product page URL
2. **SKU** - Product code
3. **Product Name** - Full product name
4. **Price** - Ex GST price
5. **Description** - Product description
6. **Stock Status** - Availability
7. **Brand** - Product brand
8. **Image URL** - Product image link
9. **Pack Weight** - Weight/volume
10. **Available In** - Additional info
11. **Scraped At** - Timestamp

**Output Format:** CSV file (`eastern_scraped_data.csv`)

---

## 🔐 Security

- Credentials stored in `.env` file (never committed to git)
- `.env` already in `.gitignore`
- Session cookies auto-refresh every 10 minutes
- All sensitive files excluded from version control

**Protect your .env file:**
```bash
chmod 600 .env
```

---

## 🐛 Troubleshooting

### Scraper doesn't run

**Check cron is configured:**
```bash
crontab -l
```

**Check logs for errors:**
```bash
tail -50 scraper.log
```

**Run manually to see errors:**
```bash
./run_scraper.sh
```

### Missing dependencies

**Reinstall everything:**
```bash
./setup_ubuntu.sh
```

### Chromium/ChromeDriver issues

```bash
sudo apt update
sudo apt install chromium-browser chromium-chromedriver
```

### Python packages missing

```bash
source venv/bin/activate
pip install -r requirements.txt
```

---

## 📈 Features

✅ **Fully automated** - Set it and forget it  
✅ **Daily execution** - Fresh data every evening  
✅ **Cookie auto-refresh** - Maintains session during long scrapes  
✅ **Error recovery** - Re-authenticates if session expires  
✅ **Progress tracking** - Real-time status updates  
✅ **Comprehensive logging** - Track all executions  
✅ **Ubuntu optimized** - Uses system Chromium and ChromeDriver  

---

## 💡 Tips

**Save historical data:**
```bash
# Copy CSV with date stamp before each run
cp eastern_scraped_data.csv backups/data_$(date +%Y%m%d).csv
```

**Monitor during execution:**
```bash
# Watch progress in real-time
watch -n 30 'wc -l eastern_scraped_data.csv'
```

**Archive old logs:**
```bash
# Keep logs from growing too large
gzip scraper.log
mv scraper.log.gz logs/scraper_$(date +%Y%m%d).log.gz
```

---

## 📞 Support

For detailed setup instructions and advanced troubleshooting, see:
- [UBUNTU_SETUP_GUIDE.md](UBUNTU_SETUP_GUIDE.md)

---

## ✅ System Requirements

- **OS:** Ubuntu 20.04+ (or Debian-based Linux)
- **Python:** 3.8 or higher
- **RAM:** 2GB minimum
- **Disk:** 500MB free space
- **Network:** Stable internet connection

---

**Your automated scraper is ready to run on Ubuntu!** 🚀
