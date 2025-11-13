# Ubuntu Quick Start - 5 Minute Setup

Get the Eastern Distributors scraper running on your Ubuntu PC in 5 minutes.

---

## ⚡ Fast Track Setup

### 1️⃣ Run Setup Script (1 minute)

```bash
cd /path/to/scraper
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

Enter your password when prompted. This installs everything you need.

---

### 2️⃣ Add Your Credentials (1 minute)

```bash
cp .env.example .env
nano .env
```

Update with your details:
```
EASTERN_USERNAME=sales@petfoodandwire.com.au
EASTERN_PASSWORD=your_password_here
```

Save: `Ctrl+X`, `Y`, `Enter`

---

### 3️⃣ Test It Works (2 minutes)

```bash
chmod +x run_scraper.sh
./run_scraper.sh
```

This will run the login and start scraping. You can press `Ctrl+C` to stop after verifying it works.

---

### 4️⃣ Setup Daily Automation (1 minute)

```bash
crontab -e
```

Add this line at the end (replace `/path/to/scraper` with your actual path):

```
0 16 * * * /path/to/scraper/run_scraper.sh >> /path/to/scraper/scraper.log 2>&1
```

**To get your path:**
```bash
pwd
```

Save and exit: `Ctrl+X`, `Y`, `Enter`

---

## ✅ Done!

Your scraper will now run automatically every day at **4pm AEST**.

**What it does:**
- Logs into Eastern Distributors
- Scrapes all 5,229 products (takes 5-6 hours)
- Saves to `eastern_scraped_data.csv`
- Finishes around 10pm with fresh data
- Runs completely automatically every day

---

## 📊 Check Status Anytime

```bash
python3 check_scraper_status.py
```

---

## 🔍 View Logs

```bash
tail -f scraper.log
```

---

## 📥 Get Your Data

After each run (around 10pm daily):

```bash
# View the CSV
cat eastern_scraped_data.csv

# Copy to another location
cp eastern_scraped_data.csv /path/to/backup/

# Check how many products
wc -l eastern_scraped_data.csv
```

---

**That's it! Fully automated daily scraping.** 🎉

For detailed documentation, see [UBUNTU_SETUP_GUIDE.md](UBUNTU_SETUP_GUIDE.md)
