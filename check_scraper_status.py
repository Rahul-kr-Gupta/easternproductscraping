#!/usr/bin/env python3
import os
import csv
from datetime import datetime

def check_status():
    print("\n" + "="*60)
    print("EASTERN DISTRIBUTORS SCRAPER - STATUS CHECK")
    print("="*60)
    print(f"Checked at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    cookies_file = "pronto_cookies.json"
    csv_file = "eastern_scraped_data.csv"
    
    print("📁 Files Status:")
    print("-" * 60)
    
    if os.path.exists(cookies_file):
        size = os.path.getsize(cookies_file)
        mtime = datetime.fromtimestamp(os.path.getmtime(cookies_file))
        print(f"✓ Cookies: {cookies_file}")
        print(f"  Size: {size} bytes")
        print(f"  Last updated: {mtime.strftime('%Y-%m-%d %H:%M:%S')}")
    else:
        print(f"✗ Cookies file not found: {cookies_file}")
    
    print()
    
    if os.path.exists(csv_file):
        size = os.path.getsize(csv_file)
        mtime = datetime.fromtimestamp(os.path.getmtime(csv_file))
        print(f"✓ Data: {csv_file}")
        print(f"  Size: {size/1024/1024:.2f} MB")
        print(f"  Last updated: {mtime.strftime('%Y-%m-%d %H:%M:%S')}")
        
        with open(csv_file, 'r') as f:
            reader = csv.DictReader(f)
            rows = list(reader)
            total = len(rows)
            
            print(f"  Total products: {total:,}")
            
            if rows:
                latest = rows[-1]
                print(f"\n  Latest scraped product:")
                print(f"    SKU: {latest.get('sku', 'N/A')}")
                print(f"    Name: {latest.get('product_name', 'N/A')}")
                print(f"    Price: {latest.get('price', 'N/A')}")
                print(f"    Scraped: {latest.get('scraped_at', 'N/A')}")
    else:
        print(f"✗ Data file not found: {csv_file}")
    
    print("\n" + "="*60)
    print("📋 Daily Automation Status")
    print("="*60)
    print("✓ Login script: login_and_save_cookies_.py")
    print("✓ Scraper script: scrape_products_with_cookies.py")
    print("✓ Daily wrapper: daily_scraper.py")
    print("\nTo deploy daily automation:")
    print("1. Click 'Deploy' button in Replit")
    print("2. Select 'Scheduled' deployment")
    print("3. Set cron: 0 6 * * * (4pm AEST daily)")
    print("="*60 + "\n")

if __name__ == "__main__":
    check_status()
