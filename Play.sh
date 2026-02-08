#!/bin/bash

# --- Configuration: Exact Filenames from your Screenshot ---
FILE_GSF_LOGIN="com.google.android.gsf.login_7.1.2-25_minAPI23(nodpi)_apkmirror.com.apk"
FILE_GSF="com.google.android.gsf_10-6494331-29_minAPI29(nodpi)_apkmirror.com.apk"
FILE_GMS="com.google.android.gms_26.02.35_(150400-862924022)-260235022_minAPI30(arm64-v8a,armeabi-v7a)(nodpi)_apkmirror.com.apk"
FILE_VENDING="com.android.vending_50.0.19-31_0_PR_863343899-85001930_minAPI31(arm64-v8a,armeabi-v7a,x86,x86_64)(nodpi)_apkmirror.com.apk"

# --- Step 1: Check and Install ADB (The software you need) ---
echo "Checking for ADB (Android Debug Bridge)..."

if ! command -v adb &> /dev/null; then
    echo "ADB is not installed. Attempting to install..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Debian/Ubuntu/Mint
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y adb
        # Fedora
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y android-tools
        # Arch Linux
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm android-tools
        else
            echo "Error: Could not detect package manager. Please install 'android-tools-adb' or 'platform-tools' manually."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS with Homebrew
        if command -v brew &> /dev/null; then
            brew install android-platform-tools
        else
            echo "Error: Homebrew not found. Please install ADB manually."
            exit 1
        fi
    else
        echo "Error: OS not supported for auto-install. Please install ADB manually."
        exit 1
    fi
else
    echo "ADB is already installed."
fi

# --- Step 2: Verify Device Connection ---
echo "Waiting for Kindle Fire connection..."
adb start-server
echo "Please ensure your Kindle is connected and you have accepted the 'Allow USB Debugging' prompt on the screen."
adb wait-for-device

# simple check to see if we are authorized
if adb devices | grep -q "unauthorized"; then
    echo "ERROR: Device is unauthorized. Check your tablet screen and press 'Allow'."
    exit 1
fi

echo "Device connected successfully!"

# --- Step 3: Verify Files Exist Locally ---
echo "Verifying APK files in current directory..."
MISSING_FILES=0

for file in "$FILE_GSF_LOGIN" "$FILE_GSF" "$FILE_GMS" "$FILE_VENDING"; do
    if [ ! -f "$file" ]; then
        echo "ERROR: File not found: $file"
        MISSING_FILES=1
    fi
done

if [ $MISSING_FILES -eq 1 ]; then
    echo "Please ensure all 4 APK files are in the same folder as this script."
    exit 1
fi

# --- Step 4: Install in Specific Order ---
echo "Starting Installation..."

# 1. Google Account Manager
echo "Installing 1/4: Google Account Manager..."
adb install -r "$FILE_GSF_LOGIN"

# 2. Google Services Framework
echo "Installing 2/4: Google Services Framework..."
adb install -r "$FILE_GSF"

# 3. Google Play Services
echo "Installing 3/4: Google Play Services..."
adb install -r "$FILE_GMS"

# 4. Google Play Store
echo "Installing 4/4: Google Play Store..."
adb install -r "$FILE_VENDING"

# --- Step 5: Finalize ---
echo "--- Installation Complete! ---"
echo "It is highly recommended to reboot your tablet now."
read -p "Do you want to reboot the tablet now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    adb reboot
fi
