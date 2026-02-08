So I couldn't upload all the files to my account cause of size limits, so I included a screenshot of the remaining two that you need to download on apkmirror. This will only work for the Kindle Fire 7 12th Generation.

# Kindle Fire Google Play Installer

A streamlined Bash script designed to automate the installation of Google Play Services on Amazon Kindle Fire tablets. This tool is optimized for **Fedora** but includes support for other major Linux distributions and macOS.

## Features
* **Automated Dependency Management**: Detects and installs `android-tools` (ADB) using `dnf` on Fedora, `apt` on Debian/Ubuntu, or `pacman` on Arch.
* **Connection Validation**: Verifies device connectivity and authorization status before starting the install.
* **Strict Installation Order**: Automates the precise 4-step sequence required to prevent service crashes.
* **Safety Checks**: Validates that all required APK files are present in the local directory before execution.

---

## Prerequisites

### 1. Prepare Your Kindle Fire
* **Enable Developer Options**: Go to **Settings > Device Options > About Fire Tablet** and tap the **Serial Number** 7 times.
* **Enable USB Debugging**: Navigate to **Settings > Device Options > Developer Options** and toggle **USB Debugging** to ON.

### 2. Download Required APKs
Place the following four APKs in the same folder as `Play.sh`. The script is pre-configured for these specific filenames:

1. **Google Account Manager**: `com.google.android.gsf.login_7.1.2-25_minAPI23(nodpi)_apkmirror.com.apk`
2. **Google Services Framework**: `com.google.android.gsf_10-6494331-29_minAPI29(nodpi)_apkmirror.com.apk`
3. **Google Play Services**: `com.google.android.gms_26.02.35_(150400-862924022)-260235022_minAPI30(arm64-v8a,armeabi-v7a)(nodpi)_apkmirror.com.apk`
4. **Google Play Store**: `com.android.vending_50.0.19-31_0_PR_863343899-85001930_minAPI31(arm64-v8a,armeabi-v7a,x86,x86_64)(nodpi)_apkmirror.com.apk`

---

## Usage

1. **Make the script executable**:
   ```bash
   chmod +x Play.sh
