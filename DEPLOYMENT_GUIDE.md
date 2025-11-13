# Daily Automated Scraper - Deployment Guide

## 🚀 Automated Daily Scraping at 4pm AEST

Your scraper is now configured for **daily automated execution** at 4pm AEST.

## 📋 What the Automation Does

Every day at 4pm AEST, the system will automatically:

1. **Login to Pronto website** (`login_and_save_cookies_.py`)
   - Authenticates with your credentials
   - Saves fresh cookies to `pronto_cookies.json`

2. **Scrape all products** (`scrape_products_with_cookies.py`)
   - Loads the saved cookies
   - Scrapes all 5,229 products from the CSV
   - Auto-refreshes cookies every 10 minutes during the 5-6 hour scrape
   - Saves data to `eastern_scraped_data.csv`

3. **Generate daily report**
   - Summary of products scraped
   - Success/failure status
   - Timestamp of completion

## ⚙️ Deployment Configuration

The deployment has been configured as a **scheduled job** with:

- **Script**: `daily_scraper.py` (wrapper that runs both scripts in sequence)
- **Type**: Scheduled deployment
- **Schedule**: Daily at 4pm AEST (6am UTC)
- **Credentials**: Automatically uses your stored secrets (EASTERN_USERNAME, EASTERN_PASSWORD)

## 📅 Setting the Schedule

To complete the deployment and set the 4pm AEST schedule:

1. Click the **"Deploy"** button in Replit
2. Choose **"Scheduled"** deployment type
3. Set the schedule using cron expression: `0 6 * * *`
   - This runs at 6:00 AM UTC = 4:00 PM AEST (non-DST)
   - For AEDT (daylight saving): `0 5 * * *` = 4:00 PM AEDT

### Cron Expression Explained
```
0 6 * * *
│ │ │ │ │
│ │ │ │ └─── Day of week (0-7, both 0 and 7 are Sunday)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of month (1-31)
│ └───────── Hour (0-23) - 6 = 6am UTC = 4pm AEST
└─────────── Minute (0-59) - 0 = on the hour
```

## 🔐 Security Features

✅ **Credentials stored securely** in Replit Secrets
✅ **Never exposed** in code or logs
✅ **Automatic cookie refresh** every 10 minutes
✅ **Session recovery** if authentication expires

## 📊 Monitoring the Daily Run

### View Deployment Logs
In Replit's Deployment section, you can:
- See when each run starts and completes
- View real-time progress
- Check for any errors
- Download the scraped CSV file

### Check Output File
After each run, check `eastern_scraped_data.csv` to see:
- All scraped products
- Updated prices and inventory
- Timestamp of when each product was scraped

## 🔄 What Happens During Each Run

```
4:00 PM AEST - Scheduled job starts
  ↓
Step 1: Login (30 seconds)
  ├─ Opens browser
  ├─ Logs into Pronto website
  └─ Saves cookies to pronto_cookies.json
  ↓
Step 2: Scrape Products (5-6 hours)
  ├─ Loads cookies
  ├─ Scrapes all 5,229 products
  ├─ Auto-refreshes cookies every 10 minutes
  └─ Saves to eastern_scraped_data.csv
  ↓
10:00 PM AEST - Job completes
  ├─ Generates summary report
  └─ Updates deployment logs
```

## 📁 Output Files Generated Daily

1. **`eastern_scraped_data.csv`** - Complete product data
   - All 5,229 products
   - 11 fields per product
   - Fresh pricing and inventory status

2. **`pronto_cookies.json`** - Session cookies
   - Updated daily
   - Valid for 24+ hours
   - Used for authenticated scraping

3. **Deployment Logs** - Execution details
   - Start/end times
   - Success/failure status
   - Error messages (if any)

## 🛠️ Customization Options

### Change Schedule Time
Edit the cron expression in deployment settings:
- `0 8 * * *` = 6pm AEST
- `0 4 * * *` = 2pm AEST
- `0 22 * * 1-5` = 8am AEST, weekdays only

### Change Scope
Edit `daily_scraper.py` line 56:
```python
# Current: Scrapes all products
"python scrape_products_with_cookies.py full"

# Alternative: Scrape first 100 products only
"python scrape_products_with_cookies.py test 100"
```

## ⚡ Built-in Features

✅ **10-minute cookie refresh** - Prevents session timeouts
✅ **Automatic retry** - Re-authenticates if cookies expire
✅ **Resume capability** - Can recover from interruptions
✅ **Progress tracking** - Know exactly how many products scraped
✅ **Error resilience** - Continues even if individual products fail

## 📧 Next Steps

1. **Deploy Now**: Click "Deploy" in Replit
2. **Set Schedule**: Use cron expression `0 6 * * *`
3. **Monitor First Run**: Check logs to ensure it works
4. **Daily Access**: Fresh data available every evening

## 🎯 Benefits of Daily Automation

- **Fresh Data**: Always have up-to-date product information
- **No Manual Work**: Fully automated, no intervention needed
- **Consistent Schedule**: Runs at same time every day
- **Historical Tracking**: Save each day's CSV for trend analysis
- **Reliable**: Auto-recovery from errors and session timeouts

---

**Your daily scraper is ready to deploy! Just click the Deploy button and set the schedule.** 🚀
