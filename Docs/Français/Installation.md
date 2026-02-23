# Installation

## Télécharger Windows

### Obtenir Windows

Je recommande [Windows 10 LTSC 2021](https://pauw.io/windows-10-fr). [Voir plus...](https://github.com/Pauwlo/Bro/blob/main/Docs/Français/Obtenir%20Windows.md)

Créez une clé USB bootable avec [Rufus](https://rufus.ie/).

## Installer Windows

Assurez-vous que l'ordinateur **n'est pas** connecté à Internet.

Démarrez depuis la clé USB en mode UEFI.

<details>
    <summary>Touches courantes pour accéder aux menus du BIOS et sélection du périphérique de démarrage</summary>
  
    Marque | Accès BIOS / Options de démarrage | Selection du périphérique
    ------ | --------------------------------- | -----------------
    Acer   | F2                                | F12 (si activé dans le BIOS)
    Asus   | Del                               | F8
    Dell   | F12                               | N/A
    HP     | Esc F10                           | Esc F9
    Huawei | F2                                | F12
    Lenovo | F1, F2                            | F10, fn + F11, F12
    MSI    | Del                               | F11

    *Voir plus [ici](https://www.disk-image.com/faq-bootmenu.htm).*
</details>

Formatez le disque sur lequel vous voulez installer Windows. Supprimez les partitions de récupération si vous savez ce que vous faites.

Installez Windows. L'ordinateur redémarrera et affichera l'OOBE.

Choisissez votre région et la disposition du clavier.

Si vous utilisez Windows 11, appuyez sur `Shift+F10`, puis exécutez la commande suivante : `oobe\BypassNRO`. Votre ordinateur redémarrera et ne vous obligera plus à vous connecter à internet pour poursuivre.

Assurez-vous de rester hors ligne (cliquez sur `Je n’ai pas Internet` puis `Continuer avec l'installation limitée`) pour créer un compte local.

Refusez **tous** les paramètres "recommandés" : historique d’activité, Cortana, reconnaissance vocale, localisation, etc.

## Exécuter Bro

Connectez l’ordinateur à Internet.

Définissez le réseau comme **privé** si vous lui faites confiance. Windows 10 vous demande à la première connexion, sinon rendez-vous dans les Paramètres réseau pour le changer.

Ouvrez une fenêtre PowerShell ou Windows Terminal en tant qu'administrateur (clic droit sur le menu Démarrer, ou `Win`+`X A`).

Exécutez la commande suivante :

```powershell
irm pauw.io/bro | iex
```

Vous pouvez choisir d'[Installer](https://github.com/Pauwlo/Bro/tree/main/Modules/Invoke-Install.psm1) (appuyez sur `I`) ou [Debloat (désencombrer)](https://github.com/Pauwlo/Bro/tree/main/Modules/Invoke-Debloat.psm1) (appuyez sur `D`) votre système.

## Mettre à jour

Exécutez Windows Update jusqu’à ce que tout soit à jour. Vous pouvez être amené à redémarrer votre ordinateur plusieurs fois. Si des erreurs apparaîssent, patientez 5-10 minutes, puis réessayez. Certaines mises à jour s'installent en arrière-plan et l'app Paramètres ne les affiche pas toujours.

## Installation du Microsoft Store (LTSC seulement)

Installez le Microsoft Store avec le raccourci sur le bureau. Cela peut prendre quelques minutes pour qu'il apparaisse dans le menu Démarrer.

Installez les applications du Store avec les raccourcis "Get..." sur le bureau une fois qu'ils affichent l'icône du Store.

Supprimez les raccourcis lorsque les applications sont installées.

Si Internet Explorer s'ouvre, choisissez de Ne pas utiliser les paramètres recommandés, puis fermez-le.

## Finaliser l'installation Windows

Ouvrez le Microsoft Store et mettez les applications à jour.

Activez Windows si nécessaire ([besoin d'aide ?](https://github.com/massgravel/Microsoft-Activation-Scripts)).

Masquez les icônes non désirées dans la zone de notification (Intel Graphics par exemple).

Installez les pilotes importants depuis le site du fabricant (mise à jour du BIOS, pavé tactile, lecteur d'empreintes, raccourcis clavier...).

### Windows Defender

Windows Defender peut vous avertir d'une menace `SettingsModifier:Win32/HostsFileHijack` après avoir exécuté Bro. Ce n'est rien. Windows considère désormais toute modification du fichier hosts comme malveillante. Une partie du travail de Bro consiste à préserver la confidentialité en désactivant la télémétrie de Microsoft via une modification inoffensive du fichier hosts, mais Microsoft a décidé que le fait de bloquer sa capacité à espionner les utilisateurs était *malveillant*, d'où cet avertissement. Vous pouvez toujours consulter le contenu du fichier [Hosts.txt](https://github.com/Pauwlo/Bro/blob/main/Stuff/Hosts.txt).

Activez la **Protection contre les falsifications** si elle est désactivée. Je ne sais pas ce qui la désactive.

Ignorez les éventuels avertissements de protection du compte et OneDrive.

### Explorateur

Si possible, lorsque l'espace du SSD est limité, déplacez les bibliothèques **Documents**, **Images**, **Musique** et **Vidéos** vers un disque secondaire, généralement `D:\`.

## Programmes

### Mozilla Firefox

Lancez Firefox.

Faîtes de Firefox le navigateur par défaut, ne rien importer, continuez.

Affichez la barre personnelle (`Ctrl+Shift+B`).

Supprimez les marque-pages par défaut.

Retirez le bouton "Importer les marque-pages..." de la barre de favoris.

Retirez les boutons View et Pocket.

#### Paramètres

Général : Ne pas recommander des extensions ou des fonctionnalités en cours de navigation.

Accueil : Gardez seulement la Recherche Web.

Recherche : Supprimez les moteurs inutiles, ne pas suggérer de **Raccourcis** ou de **Moteurs de recherche** dans la barre d'adresse.

Vie privée et sécurité : Utilisez la protection **stricte** et désactivez la **collecte de données par Firefox**.

Installez [uBlock Origin](https://addons.mozilla.org/firefox/addon/ublock-origin/). Autorisez-le en navigation privée.

Épinglez uBlock Origin à la barre d'outils.

Si vous voulez une belle et légère page d'accueil, installez [Bonjourr](https://addons.mozilla.org/firefox/addon/bonjourr-startpage/).

Un fichier factice est créé sur le bureau pour associer les fichiers PDF à Firefox.

Cliquez-droit sur le fichier -> Propriétés -> Modifier... -> Choisir Firefox -> OK -> Supprimez le fichier.

### 7-Zip

Des fichiers factices sont créés sur le bureau pour associer 7-Zip aux extensions :

- .7z
- .rar
- .zip

Pour chaque fichier : clic droit -> Propriétés -> Modifier... -> Choisir `7-Zip\7zFM.exe` -> OK -> Supprimer.

### VLC

Lancez VLC.

Refusez l’accès réseau aux métadonnées.

Ne jamais afficher une infobulle de changement de média.

### JPEGView

Définir en tant que visionneuse d'image par défaut.

### Office (facultatif)

Pendant l'installation d'Office 365, Teams peut s'installer automatiquement au prochain redémarrage. Pour l'en empêcher, désinstallez **Teams Machine-Wide Installer** dans les Paramètres.

Lancez Word, allez dans Options > Enregistrement > Cochez "Toujours enregistrer sur l'ordinateur".

Définissez Outlook comme client e-mail par défaut si besoin.

## Divers

### Dossiers racine

Si possible, lorsque l'espace du SSD est limité, créez un dossier `Programmes`  vers un disque secondaire (généralement `D:\`) avec l'icône `C:\Windows\System32\shell32.dll,162`. Installez des programmes dans cet emplacement pour soulager `Program Files`.

Si nécessaire, créez aussi un dossier `Jeux` avec l'icône `C:\Windows\System32\imageres.dll,177`. Installez des jeux dans cet emplacement pour soulager `Program Files`.

### Bureau

Nettoyez le bureau. Je ne garde généralement que la corbeille.

Trouvez un beau fond d’écran et enregistrez-le dans `Images\Images enregistrées`. Définissez-le en tant que fond d'écran et écran de verrouillage.

### Menu Démarrer

Supprimez les raccourcis inutiles dans `%ProgramData%\Microsoft\Windows\Start Menu` et `%AppData%\Microsoft\Windows\Start Menu`.

Cachez les dossiers d'applications dans `~` et `Documents`, s'il y en a.

Épinglez les logiciels importants (Firefox, applications Office, Calculatrice...).

### Nettoyage final

Videz le dossier **Téléchargements** et la Corbeille.

Effacez les notifications Windows, s'il y en a.

Effacez l’historique de Firefox (`Ctrl`+`Shift`+`Suppr`).

Réglez le volume à 20 %.

*Bravo, votre ordinateur est prêt.*
