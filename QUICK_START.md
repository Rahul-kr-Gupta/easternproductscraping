# Quick Start Guide - Product Scraper

## ✅ What's Ready

Your complete scraping system is set up and tested! Here's what you have:

### 1. Login Script
**File**: `login_and_save_cookies_.py`
- Automatically logs into https://pronto.eastdist.com/login
- Saves cookies to `pronto_cookies.json`
- Uses secure environment variables for credentials

### 2. Product Scraper
**File**: `scrape_products_with_cookies.py`
- Scrapes all 5,228 products from your CSV
- **Automatic cookie refresh every 10 minutes**
- Detects expired cookies and re-authenticates automatically
- Saves data to `eastern_scraped_data.csv`

## 🚀 How to Run

### Option 1: Test First (Recommended)
Test with just 5 products to verify everything works:
```bash
python scrape_products_with_cookies.py
```

Test with 20 products:
```bash
python scrape_products_with_cookies.py test 20
```

### Option 2: Run Full Scrape
Scrape ALL 5,229 products:
```bash
python scrape_products_with_cookies.py full
```

## 📊 What Data Gets Scraped

Each product record includes:
- ✓ Product URL
- ✓ SKU (product code)
- ✓ Product Name
- ✓ Price (Ex GST)
- ✓ Description
- ✓ Stock Status
- ✓ Brand
- ✓ Product Image URL
- ✓ Pack Weight
- ✓ Available In (units/formats)
- ✓ Timestamp of when scraped

## ⏱️ Estimated Time

- **Test (10 products)**: ~30 seconds
- **Full scrape (5,229 products)**: ~5-6 hours
  - The scraper processes about 15-20 products per minute
  - Includes automatic cookie refreshes every 10 minutes

## 🔄 Automatic Features

1. **Cookie Auto-Refresh**: Every 10 minutes, cookies are automatically refreshed
2. **Session Recovery**: If redirected to login, automatically re-authenticates
3. **Resume Capability**: Data is saved immediately, so you can stop and resume anytime
4. **Error Resilience**: Continues scraping even if individual products fail

## 📝 Output File

**File**: `eastern_scraped_data.csv`

Example row:
```
A4CEF200,4CYTE CANINE EPIITALIS FORTE GEL 200ML,$83.45 (Ex GST),4CYTE,0.25 kg/lt
```

The file is updated after each product is scraped, so you can:
- Monitor progress by opening it during the scrape
- Resume if interrupted (it appends, doesn't overwrite)

## 🎯 Recommended Workflow

1. **Test with 10 products first**:
   ```bash
   python scrape_products_with_cookies.py test 10
   ```

2. **Check the output CSV** to make sure data looks good:
   ```bash
   cat eastern_scraped_data.csv
   ```

3. **Run the full scrape**:
   ```bash
   python scrape_products_with_cookies.py full
   ```

4. **Monitor progress** - The console will show:
   - Current product number
   - Product name and price
   - Progress every 10 products
   - Cookie refresh notifications

## ❓ Troubleshooting

**If you get "Cookie file not found"**:
- The scraper will automatically run the login script

**If cookies keep expiring**:
- This is normal and handled automatically
- You'll see "⚠ Redirected to login page - cookies may be expired! Refreshing..."
- The scraper will re-authenticate and continue

**If you need to stop and resume**:
- Just press Ctrl+C to stop
- When you run again, it will append new products to the CSV
- Delete the CSV file if you want to start fresh

## 🎉 You're All Set!

Everything is configured and tested. Just run the command and let it work!
