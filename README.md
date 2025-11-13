# Eastern Distributors Automated Product Scraper

Automated daily web scraping system for Eastern Distributors (pronto.eastdist.com) - Runs directly on Ubuntu PC.

---

## 🎯 Overview

This system automatically scrapes all **5,229 products** from Eastern Distributors every day at **4pm AEST**, delivering fresh product data in CSV format by 10pm.

**Key Features:**
- ✅ Fully automated daily execution
- ✅ Scrapes all 5,229 products (5-6 hour runtime)
- ✅ Auto-refreshes session cookies every 10 minutes
- ✅ Saves comprehensive data: SKU, name, price, description, brand, images, etc.
- ✅ Zero manual intervention required
- ✅ Complete error recovery and logging

---

## 🚀 Quick Start (Ubuntu)

### 1. Run Setup Script
```bash
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

### 2. Configure Credentials
```bash
cp .env.example .env
nano .env  # Add your username and password
```

### 3. Verify Setup
```bash
chmod +x verify_setup.sh
./verify_setup.sh
```

### 4. Setup Daily Automation
```bash
crontab -e
# Add: 0 16 * * * /full/path/to/run_scraper.sh >> /full/path/to/scraper.log 2>&1
```

**Done!** Your scraper runs automatically every day at 4pm AEST.

---

## 📚 Documentation

### For Ubuntu PC Users:
- **[UBUNTU_QUICK_START.md](UBUNTU_QUICK_START.md)** ⭐ Start here - 5-minute setup
- **[UBUNTU_SETUP_GUIDE.md](UBUNTU_SETUP_GUIDE.md)** - Complete guide with troubleshooting
- **[README_UBUNTU.md](README_UBUNTU.md)** - Ubuntu-specific documentation

### General Documentation:
- **[DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)** - Replit deployment info (reference only)
- **[DAILY_AUTOMATION_QUICK_GUIDE.md](DAILY_AUTOMATION_QUICK_GUIDE.md)** - Automation overview

---

## 📁 Project Structure

```
eastern-scraper/
├── README.md                          # This file
├── UBUNTU_QUICK_START.md             # ⭐ 5-minute Ubuntu setup
├── UBUNTU_SETUP_GUIDE.md             # Complete Ubuntu documentation
├── README_UBUNTU.md                   # Ubuntu reference guide
│
├── .env.example                       # Credentials template
├── .env                               # Your credentials (create this)
├── requirements.txt                   # Python dependencies
│
├── setup_ubuntu.sh                    # ⭐ Ubuntu setup script
├── run_scraper.sh                     # ⭐ Main script (called by cron)
├── verify_setup.sh                    # Setup verification tool
│
├── daily_scraper.py                   # Master automation wrapper
├── login_and_save_cookies_.py         # Authentication script
├── scrape_products_with_cookies.py    # Main scraping engine
├── check_scraper_status.py            # Status checker
│
├── eastern_scraped_data.csv           # Output data (generated)
├── pronto_cookies.json                # Session cookies (generated)
├── scraper.log                        # Execution logs (generated)
│
└── attached_assets/
    └── Eastern_sku_matchedd_rows_*.csv  # Input CSV with product URLs
```

---

## 🔧 Common Commands

### Setup & Verification
```bash
./setup_ubuntu.sh          # Initial setup (run once)
./verify_setup.sh          # Verify everything is configured
```

### Running the Scraper
```bash
./run_scraper.sh           # Run full scraper manually
python3 check_scraper_status.py  # Check status
```

### Monitoring
```bash
tail -f scraper.log        # Watch logs in real-time
wc -l eastern_scraped_data.csv  # Count products scraped
```

### Cron Management
```bash
crontab -e                 # Edit cron schedule
crontab -l                 # View current schedule
grep CRON /var/log/syslog  # Check cron execution history
```

---

## ⏰ Schedule

**Default:** Every day at 4pm AEST

**Cron Expression:** `0 16 * * *`

**To change:**
```bash
crontab -e
# Examples:
# 0 18 * * *     = 6pm daily
# 0 14 * * *     = 2pm daily  
# 0 16 * * 1-5   = 4pm weekdays only
```

---

## 📊 Scraped Data

Each product includes 11 fields:

| Field | Description |
|-------|-------------|
| `url` | Product page URL |
| `sku` | Product SKU code |
| `product_name` | Full product name |
| `price` | Price (Ex GST) |
| `description` | Product description |
| `stock_status` | Availability status |
| `brand` | Product brand |
| `image_url` | Product image URL |
| `pack_weight` | Weight/volume |
| `available_in` | Additional info |
| `scraped_at` | Scrape timestamp |

**Output:** `eastern_scraped_data.csv` (CSV format)

---

## 🔐 Security

- Credentials stored in `.env` file (git-ignored)
- Never commit secrets to version control
- Session cookies auto-refresh every 10 minutes
- All sensitive files excluded via `.gitignore`

**Secure your credentials:**
```bash
chmod 600 .env
```

---

## ✅ System Requirements

- **OS:** Ubuntu 20.04+ (or Debian-based Linux)
- **Python:** 3.8 or higher
- **RAM:** 2GB minimum
- **Disk:** 500MB free space
- **Network:** Stable internet connection

---

## 🐛 Troubleshooting

**Setup issues?**
```bash
./verify_setup.sh  # Checks everything
```

**Scraper not running?**
```bash
./run_scraper.sh   # Run manually to see errors
tail -50 scraper.log  # Check logs
```

**Cron not working?**
```bash
crontab -l         # Verify cron is configured
grep CRON /var/log/syslog | tail -20  # Check execution
```

**Missing dependencies?**
```bash
./setup_ubuntu.sh  # Reinstall everything
```

For detailed troubleshooting, see [UBUNTU_SETUP_GUIDE.md](UBUNTU_SETUP_GUIDE.md)

---

## 💡 How It Works

### Daily Automation Flow

```
4:00 PM AEST - Cron triggers run_scraper.sh
    ↓
Step 1: Login (30 seconds)
    ├─ Runs login_and_save_cookies_.py
    ├─ Authenticates with Eastern Distributors
    └─ Saves cookies to pronto_cookies.json
    ↓
Step 2: Scrape Products (5-6 hours)
    ├─ Runs scrape_products_with_cookies.py
    ├─ Loads cookies and starts scraping
    ├─ Auto-refreshes cookies every 10 minutes
    ├─ Saves progress in real-time
    └─ Writes to eastern_scraped_data.csv
    ↓
10:00 PM AEST - Complete
    ├─ All 5,229 products scraped
    ├─ Fresh CSV data available
    └─ Logs saved to scraper.log
```

### Cookie Management

- **Initial login:** Saves session cookies
- **Auto-refresh:** Every 10 minutes during scraping
- **Session recovery:** Re-authenticates if cookies expire
- **Duration:** Supports 5-6 hour scrape sessions

---

## 📈 Features

| Feature | Description |
|---------|-------------|
| **Automated Execution** | Runs daily via cron, no manual work |
| **Cookie Management** | Auto-refreshes every 10 minutes |
| **Error Recovery** | Re-authenticates if session expires |
| **Progress Tracking** | Real-time status updates |
| **Comprehensive Logging** | Full execution logs |
| **Ubuntu Optimized** | Uses system Chromium/ChromeDriver |
| **Secure Credentials** | Environment variable based |
| **CSV Output** | Industry-standard data format |

---

## 🎓 Support

### Documentation
- Quick start: [UBUNTU_QUICK_START.md](UBUNTU_QUICK_START.md)
- Full guide: [UBUNTU_SETUP_GUIDE.md](UBUNTU_SETUP_GUIDE.md)
- Ubuntu info: [README_UBUNTU.md](README_UBUNTU.md)

### Self-Help
- Run verification: `./verify_setup.sh`
- Check logs: `tail -f scraper.log`
- Test manually: `./run_scraper.sh`

---

## 📝 License & Credits

This scraper is designed for authorized use with Eastern Distributors product data.

**Components:**
- Python 3 + Selenium for web automation
- Chromium browser for rendering
- Cron for scheduling
- CSV for data export

---

**Ready to automate your product scraping? Start with [UBUNTU_QUICK_START.md](UBUNTU_QUICK_START.md)!** 🚀
