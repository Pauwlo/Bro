# Install

## Download Windows

### Get Windows

Get latest Windows 10 ISO with [Fido](https://github.com/pbatard/fido).

Create a bootable USB drive with [Rufus](https://rufus.ie).

## Install Windows

Make sure the computer is **not** connected to the internet.

Boot from USB, in UEFI mode when available.

**Common keys for BIOS and Select Boot Media menus**

Brand | BIOS Setup / Booting options | Select Boot Media
----- | ---------------------------- | -----------------
Asus  | Del                          | F8
Dell  | F12                          | N/A
MSI   | Del                          | N/A

Format the drive you want to install Windows on. Remove recovery partitions if you know what you're doing.

Install Windows 10. Your computer will restart and show you the OOBE.

Select region and keyboard layout(s).

Make sure you're still offline, and create a local account. With a password, please!

Use secret questions if you feel like needing them. I don't. I usually just type some long and random suite of letters and numbers.

Decline all "recommended" settings, such as activity history, Cortana, speech recognition, location, etc.

## Run Init

Copy the Init script folder and its shortcut `Start Init.lnk` on a USB drive. The one you used to install Windows 10, for example.

Insert the USB drive into the computer, then select "Open folder" when prompted.

Copy the two elements on the desktop.

Double-click on `Start Init`. Click on Yes when prompted (Init requires administrator privileges).

Enter the computer name, then press Enter.

The script will do its job then reboot the computer.

## Finish setting up Windows

### Explorer settings

Hide agenda setup from taskbar.

Open an Explorer Window (`Win`+`E`) then expand "This PC" in the sidebar.

Rename the hard drives. If I have only one (called C:), I usually call it "Local Disk".

If I have an SSD and HDD, I usually call them "SSD" and "HDD".

### Windows settings

Open Windows settings (`Win`+`I`).

#### System

##### Focus assist

Disable automatic rules.

##### Multitasking

Do not show what I can snap next to it.

#### Accounts

##### Sign-in options

Do not reopen my apps after an update or restart.

#### Personalization

##### Colors

Set default Windows mode to Dark, if it was set to Light.

##### Start

Do not show recently opened items in Jump Lists and Quick Access.

Choose which folders appear on Start: Settings only.

### Connect to the Internet

Connect your computer to the internet.

Choose if you want to enable network discovery on the sidebar (Yes or No). Recommended if you trust your network.

Sometimes, Windows will detect that you're now connected to the internet and will show you a new prompt for using a Microsoft account (like OOBE). If so, click OK, then "Ignore for now".

Run Windows Update until you're up to date. You will probably have to restart your computer several times. If you have errors, wait 5-10 minutes, and try again. Some updates are installing in background, and Windows Update app won't show them.

Activate Windows if needed.

Synchronize time & date.

Hide unwanted icons from the system tray (Bluetooth, or Intel Graphics for example).

### Windows Defender

Enable **Tamper protection** if it has been disabled. I don't know which update is disabling it.

Dismiss account protection and OneDrive warnings, if any.

Disable notifications about recent activity and scan results.

### Certificates

Install personal/professional certificates, if any.

Store location: **Local Machine**

Place all certificates in the following store: **Trusted Root Certification Authorities**

### Explorer

If the SSD capacity is limited, move **Documents**, **Pictures**, **Music** and **Videos** to `D:\`.

## Programs

### Mozilla Firefox

Download [Firefox](https://www.mozilla.org/firefox/all/) from your other computer and put the setup on a USB drive. The one you used to install Windows 10, for example.

Install and start Firefox.

Pin to taskbar.

Set as default browser.

Show bookmarks toolbar.

Delete default **Getting started** and **Mozilla Firefox** bookmarks.

#### Options

Home: Only keep **Web Search** on Firefox Home Content.

Search: Remove other **One-Click** search engines.

Privacy: Use **Strict mode**, always **"Do Not Track"** and disable **Firefox Data Collection**.

If using custom certificates, set `security.enterprise_roots.enabled` to `true`. *(Go to about:config)*

Install **uBlock Origin**. Allow it to run in Private Windows.

### TeamViewer

Download, install and start [TeamViewer](https://www.teamviewer.com/) (Default installation).

Go to **Extra** -> **Options**.

Remote control: Uncheck **Remove remote wallpaper**.

Advanced: Check **Automatically minimize local TeamViewer panel**.

Close TeamViewer.

### 7-Zip

Download, install and start [7-Zip](https://www.7-zip.org/).

Go to **Tools** -> **Options** -> **7-Zip** tab.

Only check the following context menu items:

- Extract files...
- Extract here
- Extract to <Folder>
- Add to archive...
- Add to <Archive>.zip

Click OK and close 7-Zip.

Run script: `Create dummy files & add 7z to Path`. Copy the 2 files from this repo in **Software/7-Zip** on your computer, and double-click the shortcut. Remove the files afterwards.

This script will create dummy files on your desktop so you can easily set 7-Zip as the default application for:

- .7z
- .rar
- .zip

For each file, right-click -> Properties -> Change... -> Select `7-Zip\7zFM.exe` -> OK -> Delete.

### MPC-HC

Install [MPC-HC](https://mpc-hc.org/).

Don't create a desktop shortcut.

Start MPC-HC.

Allow automatic check for updates.

Open settings. (Press `O`)

Go to **Player** > **Formats**, then click **Run as administrator**.

Select all formats, then click OK twice and close MPC-HC.

Set as default application for music and videos.

### ImageGlass

Install [ImageGlass](https://imageglass.org/).

Start ImageGlass, follow the First-Launch Configurations.

Install **Windows 10 Dark HiDPI theme**.

Close ImageGlass.

Set as default application for pictures.

### NVIDIA GeForce Experience

*Only if you have a dedicated NVIDIA GPU.*

Log into your NVIDIA account.

Do not optimize games automatically.

Ignore tour.

Install latest drivers.

### Notepad++

Download and install Notepad++.

Don't install themes.

Run script: `Import Material theme`. Copy the 3 files from this repo in **Software/Notepad++** on your computer, and double-click the shortcut. Remove the files afterwards.

Start Notepad++, and select theme `Material` (**Settings** -> **Style Configurator...**).

Save & Close, then close Notepad++.

### Office

Don't install:

- OneNote
- OneDrive
- OneDrive for Business
- Skype Entreprise
- Teams

For an Office 365 installation, Teams might install automatically after next reboot. To prevent that, uninstall **Teams Machine-Wide Installer** from Windows Settings.

Set Outlook as default Email application, if needed.

### Adobe Acrobat Reader DC

Download, install and start Acrobat Reader DC.

Set as default application for PDF files.

Collapse Tools and Sign-in cards.

Close Acrobat Reader DC.

If Acrobat's icon in Start menu is broken (happens when ImageGlass is installed), run script: `Fix Adobe Acrobat Reader DC icon in Start menu`. Copy the 2 files from this repo in **Software/Adobe Acrobat Reader DC** on your computer, and double-click the shortcut. Remove the files afterwards.

## Misc

### HDD Folders

If the SSD capacity is limited, create a `Programs` folder in `D:\` with icon: `C:\Windows\System32\shell32.dll,162`. Install future non-critical programs in this folder instead of regular `C:\Program Files\`.

If needed, create a `# Path Shortcuts` folder in `C:\Program Files\` (or `D:\Programs`), and add it to Path (System).

If needed, create a `Games` folder in `D:\` with icon: `C:\Windows\System32\imageres.dll,177`. Install future non-critical games in this folder instead of regular `C:\Program Files\`.

### Desktop

Clean the Desktop. I usually only keep Firefox's shortcut and the Recycle Bin.

Find a nice wallpaper on the internet. I usually save it to `Pictures\Saved Pictures` and use it as Desktop & Lock screen background image.

### Start menu

Clean `%ProgramData%\Microsoft\Windows\Start Menu\Programs` and `%AppData%\Microsoft\Windows\Start Menu`.

Hide software folders in `~` and `D:\Documents`, if any.

Pin important software in Start menu. (Firefox, Office apps, Calculator...)

### Final clean-up

Empty the **Downloads** folder and the Recycle Bin.

Clear Windows notifications, if any.

Clear recent Firefox history (`Ctrl`+`Shift`+`Del`).

Set Volume to 20%.

*Congratulations, your computer is ready.*
