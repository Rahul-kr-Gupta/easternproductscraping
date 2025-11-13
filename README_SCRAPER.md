# Eastern Distributors Product Scraper

## Overview
This scraper extracts product details from the Eastern Distributors Pronto website (https://pronto.eastdist.com) using authenticated sessions with automatic cookie management.

## Files

### Main Scripts
- **`login_and_save_cookies_.py`** - Logs into the website and saves session cookies
- **`scrape_products_with_cookies.py`** - Main scraper script that uses cookies to extract product data

### Input
- **`attached_assets/Eastern_sku_matchedd_rows_1762833767480.csv`** - CSV file containing 5,228 product URLs to scrape

### Output
- **`eastern_scraped_data.csv`** - Scraped product data with the following fields:
  - url
  - sku
  - product_name
  - price (Ex GST)
  - description
  - stock_status
  - brand
  - image_url
  - pack_weight
  - available_in
  - scraped_at

- **`pronto_cookies.json`** - Session cookies for authentication

## Features

### Automatic Cookie Management
- **Auto-refresh**: Cookies are automatically refreshed every 10 minutes
- **Expiry detection**: Detects when cookies expire and refreshes them automatically
- **Session recovery**: If redirected to login page, the scraper automatically re-authenticates

### Robust Data Extraction
- Uses JSON-LD structured data from the page (most reliable method)
- Falls back to HTML parsing for additional fields
- Extracts: product name, SKU, price, brand, description, image URL, pack weight, and availability

### Resume Capability
- Appends to existing CSV file, so you can resume if interrupted
- Each product is saved immediately after scraping

## Usage

### Test Mode (5 products by default)
```bash
python scrape_products_with_cookies.py
```

### Test Mode with custom number of products
```bash
python scrape_products_with_cookies.py test 20
```

### Full Mode (all 5,229 products)
```bash
python scrape_products_with_cookies.py full
```

## Credentials

The scraper uses environment variables for authentication:
- `EASTERN_USERNAME` - Login email
- `EASTERN_PASSWORD` - Login password

These are securely stored in Replit Secrets and never exposed in the code.

## How It Works

1. **Initial Setup**: 
   - Checks if cookies exist, if not, runs login script
   - Sets up headless Chrome browser
   - Loads and activates session cookies

2. **Scraping Loop**:
   - For each product URL in the CSV:
     - Checks if 10 minutes have passed since last cookie refresh
     - Navigates to product page
     - Detects if redirected to login (expired cookies)
     - Automatically refreshes cookies if needed
     - Extracts product data from JSON-LD and HTML
     - Saves to CSV immediately

3. **Cookie Refresh**:
   - Runs `login_and_save_cookies_.py` in subprocess
   - Updates `pronto_cookies.json`
   - Restarts browser with fresh cookies

## Estimated Time

- **Test mode (10 products)**: ~30 seconds
- **Full mode (5,229 products)**: 
  - At ~4 seconds per product = ~5.8 hours
  - With automatic cookie refreshes every 10 minutes

## Error Handling

- Continues scraping even if individual products fail
- Logs errors but doesn't stop the process
- Each product is saved immediately, so progress is never lost
- Automatic cookie refresh prevents session timeout errors

## Example Output

```csv
url,sku,product_name,price,description,stock_status,brand,image_url,pack_weight,available_in,scraped_at
https://pronto.eastdist.com/products/A4CEF200,A4CEF200,4CYTE CANINE EPIITALIS FORTE GEL 200ML,$83.45 (Ex GST),4CYTE CANINE EPIITALIS FORTE GEL 200ML,,4CYTE,https://pronto.eastdist.com/ts1762147849/attachments/Product/7149/default,0.25 kg/lt,Brand: 4CYTE,2025-11-11 04:13:51
```

## Monitoring Progress

The scraper displays:
- Current product number and total count
- Product name and price for each scraped item
- Progress summary every 10 products
- Cookie refresh notifications
- Error messages if products fail

## Tips

1. **Start with test mode** to verify everything works
2. **Check the CSV** after test mode to ensure data quality
3. **Run full mode** when you're satisfied with the test results
4. **Monitor the first hour** to ensure smooth operation
5. **The process is resumable** - if stopped, running again will append new products
