# Install

## Download Windows

### Get Windows

I recommend [Windows 10 LTSC 2021](https://pauw.io/windows-10). [See more...](https://github.com/Pauwlo/Bro/blob/main/Docs/Get%20Windows.md)

Create a bootable USB drive with [Rufus](https://rufus.ie/).

## Install Windows

Make sure the computer is **not** connected to the internet.

Boot from USB in UEFI mode.

<details>
    <summary>Common hotkeys for BIOS Setup and Select Boot Media menus</summary>
  
    Brand  | BIOS Setup / Booting options | Select Boot Media
    ------ | ---------------------------- | -----------------
    Acer   | F2                           | F12 (if enabled in BIOS)
    Asus   | Del                          | F8
    Dell   | F12                          | N/A
    HP     | Esc F10                      | Esc F9
    Lenovo | F1, F2                       | F10, fn + F11, F12
    MSI    | Del                          | F11

    *See more [here](https://www.disk-image.com/faq-bootmenu.htm).*
</details>

Format the drive you want to install Windows on. Remove recovery partitions if you know what you're doing.

Install Windows. Your computer will restart and show you the OOBE.

Select region and keyboard layout(s).

If you're using Windows 11, press `Shift+F10`, and run the following command: `oobe\BypassNRO`. This will reboot the computer and force the OOBE to skip the Microsoft sign in part.

Make sure you stay offline (click on `I don't have internet` then `Continue with limited setup`), so you can create a local account.

Decline **all** "recommended" settings, such as activity history, Cortana, speech recognition, location, etc.

## Run Bro

Connect your computer to the internet.

Set the network as Private if you trust it. Windows 10 will ask you on your first connect, on Windows 11 you have to go to Network settings to change it from Public.

Open a PowerShell or Windows Terminal window with admin privileges (right-click on Start menu, or `Win`+`X A`).

Run the following command:

```powershell
irm pauw.io/bro | iex
```

For more verbose output, run:

```powershell
$VerbosePreference = 'Continue'
irm pauw.io/bro | iex
```

## Get Updates

Run Windows Update until you're up to date. You may have to restart your computer several times. If you see update errors, wait 5-10 minutes, and try again. Some updates are installing in the background, and the Settings app may not show them.

If applicable, install Microsoft Store with the shortcut on the desktop. It may take a few minutes to install and show up in the Start menu.

Then, install the Store apps with the "Get..." shortcuts on the desktop once they show the Store icon. Delete them afterwards.

Otherwise, just open Microsoft Store and Get updates.

Activate Windows if needed ([need help?](https://github.com/massgravel/Microsoft-Activation-Scripts)).

Hide unwanted icons from the system tray (Intel Graphics for example).

Install important or missing system drivers (BIOS update, touchpad, fingerprint reader or laptop hotkeys support...), generally from the PC manufacturer support website.

### Windows Defender

Warning: Windows Defender may notify you about a `SettingsModifier:Win32/HostsFileHijack` threat after running Bro. It's fine. Microsoft doesn't like it when people mess with their telemetry stuff, so they're going out of their way and flag the Hosts file as a "threat" when it blocks their data collection servers. You can always check the [Hosts.txt](https://github.com/Pauwlo/Bro/blob/main/Stuff/Hosts.txt) file content.

Enable **Tamper protection** if it's disabled. I don't know what is disabling it.

Dismiss account protection and OneDrive warnings, if any.

### Explorer

If the SSD capacity is limited, move **Documents**, **Pictures**, **Music** and **Videos** to `D:\`.

## Programs

### Mozilla Firefox

Start Firefox.

Set as default browser, don't import from previous browser, save and continue.

Always show bookmarks toolbar (`Ctrl+Shift+B`).

Remove default bookmarks.

Remove the "Import bookmarks..." button from the toolbar.

Remove View and Pocket from the toolbar.

#### Options

General: Don't recommend extensions or features as you browse.

Home: Only keep **Web Search** on Firefox Home Content.

Search: Remove alternative search engines.

Privacy: Use **Strict mode**, don't suggest **Shortcuts** and **Search engines** in address bar and disable **Firefox Data Collection**.

If using self-signed certificates, set `security.enterprise_roots.enabled` to `true`. *(Go to about:config)*

Install [uBlock Origin](https://addons.mozilla.org/firefox/addon/ublock-origin/). Allow it to run in Private Windows.

Pin uBlock Origin to Toolbar.

This script has created a dummy file on your desktop so you can easily set Firefox as the default application for PDF files.

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

Clean the Desktop. I usually only keep the Recycle Bin.

Find a nice wallpaper on the internet. I usually save it to `Pictures\Saved Pictures` and use it as Desktop & Lock screen background image.

### Start menu

Remove unnecessary folders and shortcuts in `%ProgramData%\Microsoft\Windows\Start Menu` and `%AppData%\Microsoft\Windows\Start Menu`.

Hide software folders in `~` and `Documents`, if any.

Pin important software in Start menu. (Firefox, Office apps, Calculator...)

### Final clean-up

Empty the **Downloads** folder and the Recycle Bin.

Clear Windows notifications, if any.

Clear recent Firefox history (`Ctrl`+`Shift`+`Del`).

Set Volume to 20%.

*Bravo, your computer is ready.*
