# How to Transfer This Project to Your Ubuntu PC

Step-by-step guide to move the scraper from Replit to your Ubuntu PC.

---

## 📥 Method 1: Download as ZIP (Easiest)

### On Replit:

1. Click the **three dots** menu (⋮) in the file explorer
2. Select **"Download as ZIP"**
3. Save to your computer

### On Ubuntu PC:

```bash
# 1. Extract the ZIP file
cd ~/Downloads
unzip eastern-scraper.zip -d ~/eastern-scraper

# 2. Navigate to the folder
cd ~/eastern-scraper

# 3. Continue with setup
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

---

## 📥 Method 2: Git Clone (If Using Git)

### On Replit:

If this is a Git repository, get the repository URL.

### On Ubuntu PC:

```bash
# Clone the repository
git clone <repository-url> ~/eastern-scraper

# Navigate to the folder
cd ~/eastern-scraper

# Continue with setup
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

---

## 📥 Method 3: Manual File Copy

### Files You Need:

**Essential Scripts:**
```
setup_ubuntu.sh
run_scraper.sh
verify_setup.sh
daily_scraper.py
login_and_save_cookies_.py
scrape_products_with_cookies.py
check_scraper_status.py
```

**Configuration Files:**
```
.env.example
.gitignore
requirements.txt
```

**Input Data:**
```
attached_assets/Eastern_sku_matchedd_rows_1762833767480.csv
```

**Documentation (Optional but recommended):**
```
README.md
UBUNTU_QUICK_START.md
UBUNTU_SETUP_GUIDE.md
README_UBUNTU.md
INSTALLATION_SUMMARY.md
```

### Steps:

1. **On Replit:** Download each file individually
2. **On Ubuntu PC:** Create project folder and copy files

```bash
# Create directory structure
mkdir -p ~/eastern-scraper/attached_assets

# Copy all files to ~/eastern-scraper/
# Copy CSV file to ~/eastern-scraper/attached_assets/
```

---

## 📥 Method 4: Using rsync (Advanced)

If you have SSH access between machines:

```bash
rsync -avz /path/to/replit/project/ user@ubuntu-pc:~/eastern-scraper/
```

---

## ✅ After Transfer - Verify Files

On your Ubuntu PC:

```bash
cd ~/eastern-scraper

# List all files
ls -la

# You should see:
# - setup_ubuntu.sh
# - run_scraper.sh
# - verify_setup.sh
# - *.py files
# - .env.example
# - requirements.txt
# - attached_assets/ folder with CSV
```

---

## 🚀 Next Steps After Transfer

### 1. Make Scripts Executable

```bash
chmod +x setup_ubuntu.sh run_scraper.sh verify_setup.sh
```

### 2. Run Setup

```bash
./setup_ubuntu.sh
```

### 3. Configure Credentials

```bash
cp .env.example .env
nano .env
# Add your username and password
```

### 4. Verify Setup

```bash
./verify_setup.sh
```

### 5. Test

```bash
./run_scraper.sh
# Press Ctrl+C after confirming it works
```

### 6. Setup Cron

```bash
crontab -e
# Add: 0 16 * * * /home/username/eastern-scraper/run_scraper.sh >> /home/username/eastern-scraper/scraper.log 2>&1
```

Replace `/home/username` with your actual home directory:
```bash
echo $HOME
```

---

## 🔍 Verify Transfer Was Successful

Run the verification script:

```bash
cd ~/eastern-scraper
./verify_setup.sh
```

This will check:
- ✓ All required files present
- ✓ Python installed
- ✓ Chromium installed
- ✓ Virtual environment created
- ✓ Packages installed
- ✓ Credentials configured
- ✓ Scripts executable

---

## 📦 What Gets Transferred

### Core System (Required):
- **Scripts:** All .py and .sh files
- **Config:** .env.example, requirements.txt, .gitignore
- **Data:** CSV file with product URLs

### Documentation (Recommended):
- **Setup guides:** UBUNTU_*.md files
- **README files:** README*.md files
- **This guide:** TRANSFER_TO_UBUNTU.md

### NOT Transferred (Generated on Ubuntu):
- `.env` - You create this manually with your credentials
- `venv/` - Created by setup_ubuntu.sh
- `eastern_scraped_data.csv` - Generated when you run the scraper
- `pronto_cookies.json` - Generated at login
- `scraper.log` - Created when cron runs

---

## 🎯 Quick Reference

**Minimum files needed to run:**
1. `setup_ubuntu.sh` - Setup script
2. `run_scraper.sh` - Main runner
3. `daily_scraper.py` - Wrapper
4. `login_and_save_cookies_.py` - Login script
5. `scrape_products_with_cookies.py` - Scraper
6. `requirements.txt` - Dependencies
7. `.env.example` - Credentials template
8. `attached_assets/Eastern_sku_matchedd_rows_*.csv` - Product URLs

**Total size:** ~50 KB (excluding CSV)

---

## 💡 Pro Tips

**Keep documentation:**
```bash
# The .md files are small but very helpful
# They take up minimal space but provide valuable reference
```

**Backup your .env:**
```bash
# After creating .env, keep a backup (outside git)
cp .env ~/.eastern-scraper-credentials.backup
chmod 600 ~/.eastern-scraper-credentials.backup
```

**Test before automating:**
```bash
# Always test manually first
./run_scraper.sh
# Only setup cron after successful manual test
```

---

## ⚠️ Important Notes

**DO NOT transfer from Replit:**
- `pronto_cookies.json` - Will be regenerated on Ubuntu
- `eastern_scraped_data.csv` - Will be recreated on Ubuntu
- `venv/` folder - Environment is system-specific
- `.env` file - If it exists, DON'T transfer (has your credentials)

**DO create fresh on Ubuntu:**
- `.env` - Create from .env.example
- `venv/` - Let setup_ubuntu.sh create it
- Cookies and data files - Will be generated

---

## 🆘 Troubleshooting Transfer

**Problem: "Permission denied"**
```bash
chmod +x *.sh
```

**Problem: "No such file or directory"**
```bash
# Check you're in the right folder
pwd
# Should be: /home/username/eastern-scraper
```

**Problem: "Python not found"**
```bash
# Setup script will install it
./setup_ubuntu.sh
```

**Problem: "Cannot find CSV file"**
```bash
# Make sure CSV is in attached_assets/
ls -la attached_assets/
```

---

## ✅ Transfer Checklist

- [ ] All .py files transferred
- [ ] All .sh files transferred
- [ ] .env.example transferred
- [ ] requirements.txt transferred
- [ ] CSV file in attached_assets/ folder
- [ ] Documentation .md files (optional)
- [ ] Scripts made executable
- [ ] Setup script run successfully
- [ ] .env created with credentials
- [ ] Verification script passed
- [ ] Manual test successful

---

**After transfer, follow [UBUNTU_QUICK_START.md](UBUNTU_QUICK_START.md) for setup!** 🚀
