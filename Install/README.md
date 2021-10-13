# Install

## Download Windows

### Get Windows

Download the desired Windows ISO via [TechBench](https://tb.rg-adguard.net/).

Create a bootable USB drive with [Rufus](https://rufus.ie/).

## Install Windows

Make sure the computer is **not** connected to the internet.

Boot from USB, in UEFI mode when available.

Common keys for BIOS and Select Boot Media menus:

Brand | BIOS Setup / Booting options | Select Boot Media
----- | ---------------------------- | -----------------
Acer  | F2                           | F12 (if enabled in BIOS)
Asus  | Del                          | F8
Dell  | F12                          | N/A
MSI   | Del                          | F11

Format the drive you want to install Windows on. Remove recovery partitions if you know what you're doing.

Install Windows. Your computer will restart and show you the OOBE.

Select region and keyboard layout(s).

Make sure you stay offline (click on `I don't have internet` then `Continue with limited setup`), so you can create a local account. With a password, please!

Use secret questions if you feel like needing them. I don't. I usually just type some long and random string of letters and numbers.

Decline all "recommended" settings, such as activity history, Cortana, speech recognition, location, etc.

## Run Init

If you want to import certificates with Init, place them in the `.\Init\Files\Certificates` folder. They will be imported in Local Machine\Trusted Root Certification Authorities.

Copy the Init script folder and its shortcut `Start Init.lnk` on a USB drive. The one you used to install Windows, for example.

Insert the USB drive into the computer, then select "Open folder" when prompted.

Copy the two elements on the desktop.

Double-click on `Start Init`. Click on Yes when prompted (Init requires administrator privileges).

Enter the computer name, then press Enter.

The script will do its job then reboot the computer.

## Finish setting up Windows

### Explorer settings

Open a Windows Explorer window (`Win`+`E`) and expand "This PC" in the sidebar.

### Windows settings

Open Windows settings (`Win`+`I`).

#### System

##### Focus assist

Disable automatic rules.

#### Gaming

Don't open Xbox Game Bar using a button on a controller.

### Connect to the Internet

Connect your computer to the internet.

Set the network as Private if you trust it.

Windows may show you various prompts for using a Microsoft account instead of a local account. Always decline these *not-intrusive-at-all* messages.

Run Windows Update until you're up to date. You will probably have to restart your computer several times. If you have errors, wait 5-10 minutes, and try again. Some updates are installing in background, and Windows Update app won't show them.

Open Microsoft Store and Get updates.

Activate Windows if needed.

Synchronize time & date.

Hide unwanted icons from the system tray (Bluetooth, or Intel Graphics for example).

Install system drivers, generally from the PC manufacturer support website.

### Windows Defender

Disclaimer: Windows Defender may notify you about a `SettingsModifier:Win32/HostsFileHijack` threat after running Init. Of course, Microsoft doesn't like people to get rid of their telemetry stuff, so they're trying to scare you so you wipe the Hosts file. Please ignore the notification, allow the "threat" on your device and review [Hosts.txt](https://github.com/Pauwlo/Init/blob/main/Install/Init/Files/Hosts.txt) if you feel like so.

Enable **Tamper protection** if it's disabled. I don't know what is disabling it.

Dismiss account protection and OneDrive warnings, if any.

Disable notifications about recent activity and scan results.

### Explorer

If the SSD capacity is limited, move **Documents**, **Pictures**, **Music** and **Videos** to `D:\`.

## Programs

### Chocolatey

Run the `Post install` script on the Desktop.

### Mozilla Firefox

Start Firefox.

Pin to taskbar, make default browser and select theme.

Remove default **Getting started** and **Mozilla Firefox** bookmarks.

Always show bookmarks toolbar.

Remove the "Import bookmarks..." button from the toolbar.

Remove Pocket from the toolbar.

#### Options

General: Don't recommend extensions or features as you browse.

Home: Only keep **Web Search** on Firefox Home Content.

Search: Remove alternative search engines.

Privacy: Use **Strict mode**, don't suggest **Shortcuts** and **Search engines** in address bar and disable **Firefox Data Collection**.

If using self-signed certificates, set `security.enterprise_roots.enabled` to `true`. *(Go to about:config)*

Install **uBlock Origin**. Allow it to run in Private Windows.

This script has created a dummy file on your desktop so you can easily set Firefox as the default application for .pdf files.

Right-click the file -> Properties -> Change... -> Select Firefox -> OK -> Delete.

### 7-Zip

This script has created dummy files on your desktop so you can easily set 7-Zip as the default application for:

- .7z
- .rar
- .zip

For each file, right-click -> Properties -> Change... -> Select `7-Zip\7zFM.exe` -> OK -> Delete.

### VLC

Start VLC.

Don't allow network access to metadata.

Never show media change popups.

### Photos

Open Windows Photos app.

Close the Sign in and introduction windows.

Remove the Pictures folder from sources.

Disable automatically generated albums.

Don't show a notification when new albums are available.

### Office

Don't install:

- OneDrive
- OneDrive for Business
- Skype Entreprise
- Teams

During an Office 365 installation, Teams might install automatically after next reboot. To prevent that, uninstall **Teams Machine-Wide Installer** from Windows Settings.

Start Word, go to Options > Save > Check "Save to Computer by default".

Set Outlook as default Email application, if needed.

## Misc

### HDD Folders

If the SSD capacity is limited, create a `Programs` folder in `D:\` with icon: `C:\Windows\System32\shell32.dll,162`. Install future non-critical programs in this folder instead of regular `C:\Program Files\`.

If needed, create a `Games` folder in `D:\` with icon: `C:\Windows\System32\imageres.dll,177`. Install future non-critical games in this folder instead of regular `C:\Program Files\`.

### Desktop

Clean the Desktop. I usually only keep Firefox's shortcut and the Recycle Bin.

Find a nice wallpaper on the internet. I usually save it to `Pictures\Saved Pictures` and use it as Desktop & Lock screen background image.

### Start menu

Clean `%ProgramData%\Microsoft\Windows\Start Menu` and `%AppData%\Microsoft\Windows\Start Menu`.

Hide software folders in `~` and `D:\Documents`, if any.

Pin important software in Start menu. (Firefox, Office apps, Calculator...)

### Final clean-up

Empty the **Downloads** folder and the Recycle Bin.

Clear Windows notifications, if any.

Clear recent Firefox history (`Ctrl`+`Shift`+`Del`).

Set Volume to 20%.

*Congratulations, your computer is ready.*
