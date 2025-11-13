# Daily Automation - Quick Reference

## ✅ What's Configured

Your scraper is now set up for **daily automated execution at 4pm AEST**.

## 🚀 How to Deploy

### Step 1: Click "Deploy" Button
1. Go to the Deployments tab in Replit
2. Click the **"Deploy"** button
3. The system is already configured as a "Scheduled" deployment

### Step 2: Set the Schedule
When prompted, enter this cron expression:
```
0 6 * * *
```
This runs daily at **6am UTC = 4pm AEST** (non-DST)

**For Daylight Saving Time (AEDT):** Use `0 5 * * *` (4pm AEDT)

### Step 3: Deploy
Click "Deploy" and the automation will start running daily!

---

## 📋 What Runs Automatically

Every day at 4pm AEST:

1. **Login** → Saves cookies (`login_and_save_cookies_.py`)
2. **Scrape** → All 5,229 products (`scrape_products_with_cookies.py`)
3. **Save** → Data to `eastern_scraped_data.csv`

**Duration:** 5-6 hours (completes around 10pm AEST)

**Features:**
- ✅ Cookies auto-refresh every 10 minutes
- ✅ Auto-recovery if session expires
- ✅ Complete daily product data
- ✅ No manual intervention needed

---

## 📊 How to Monitor

**Check deployment logs:**
- Go to Deployments tab
- Click on the scheduled deployment
- View logs in real-time

**Download daily data:**
- After each run, download `eastern_scraped_data.csv`
- Contains all 5,229 products with fresh data

---

## 🔧 Quick Commands (If Running Manually)

**Test the automation script:**
```bash
python daily_scraper.py
```

**Just login and save cookies:**
```bash
python login_and_save_cookies_.py
```

**Just scrape products:**
```bash
python scrape_products_with_cookies.py full
```

---

## ⏰ Schedule Options

Change the deployment schedule to run at different times:

| Time (AEST) | Cron Expression |
|-------------|-----------------|
| 4pm daily   | `0 6 * * *`     |
| 6pm daily   | `0 8 * * *`     |
| 2pm daily   | `0 4 * * *`     |
| 8am daily   | `0 22 * * *`    |
| Weekdays only | `0 6 * * 1-5`  |

---

## 🎯 That's It!

Just deploy and let it run automatically every day! 🚀
