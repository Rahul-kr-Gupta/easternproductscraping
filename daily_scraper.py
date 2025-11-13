#!/usr/bin/env python3
import subprocess
import sys
import time
from datetime import datetime

def run_command(command, description):
    """Run a command and return success status"""
    print(f"\n{'='*60}")
    print(f"{description}")
    print(f"{'='*60}")
    print(f"Command: {command}")
    print(f"Started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    try:
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True,
            timeout=21600
        )
        
        print(result.stdout)
        if result.stderr:
            print("STDERR:", result.stderr)
            
        if result.returncode == 0:
            print(f"✓ {description} completed successfully")
            return True
        else:
            print(f"✗ {description} failed with exit code {result.returncode}")
            return False
            
    except subprocess.TimeoutExpired:
        print(f"✗ {description} timed out after 6 hours")
        return False
    except Exception as e:
        print(f"✗ {description} failed with error: {str(e)}")
        return False

def main():
    print(f"\n{'='*60}")
    print("DAILY PRODUCT SCRAPER - EASTERN DISTRIBUTORS")
    print(f"{'='*60}")
    print(f"Run started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S AEST')}")
    print(f"{'='*60}\n")
    
    step1_success = run_command(
        "python login_and_save_cookies_.py",
        "STEP 1: Login and Save Cookies"
    )
    
    if not step1_success:
        print("\n✗ Login failed. Aborting scrape.")
        sys.exit(1)
    
    time.sleep(5)
    
    step2_success = run_command(
        "python scrape_products_with_cookies.py full",
        "STEP 2: Scrape All Products"
    )
    
    print(f"\n{'='*60}")
    print("DAILY SCRAPER RUN SUMMARY")
    print(f"{'='*60}")
    print(f"Completed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S AEST')}")
    print(f"Step 1 (Login): {'✓ SUCCESS' if step1_success else '✗ FAILED'}")
    print(f"Step 2 (Scrape): {'✓ SUCCESS' if step2_success else '✗ FAILED'}")
    
    try:
        with open('eastern_scraped_data.csv', 'r') as f:
            lines = len(f.readlines())
            print(f"Total products in CSV: {lines - 1}")
    except:
        print("CSV file status: Not found or empty")
    
    print(f"{'='*60}\n")
    
    if step1_success and step2_success:
        print("✓ Daily scrape completed successfully!")
        sys.exit(0)
    else:
        print("✗ Daily scrape completed with errors")
        sys.exit(1)

if __name__ == "__main__":
    main()
