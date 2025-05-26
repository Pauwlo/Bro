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

Définissez le réseau comme **privé** si vous lui faites confiance. Windows 10 vous demande à la première connexion, sur Windows 11 vous devez vous rendre dans les Paramètres réseau pour le changer en "Public".

Ouvrez une fenêtre PowerShell ou Windows Terminal en tant qu'administrateur (clic droit sur le menu Démarrer, ou `Win`+`X A`).

Exécutez la commande suivante :

```powershell
irm pauw.io/bro | iex
```

Pour afficher plus de détails, exécutez plutôt :

```powershell
$VerbosePreference = 'Continue'
irm pauw.io/bro | iex
```

## Mettre à jour

Exécutez Windows Update jusqu’à ce que tout soit à jour. Redémarrez si nécessaire.

Si besoin, installez le Microsoft Store avec le raccourci sur le bureau. Cela peut prendre quelques minutes pour qu'il apparaisse dans le menu Démarrer.

Installez ensuite les applications du Store avec les raccourcis "Get..." sur le bureau une fois qu'ils affichent l'icône du Store. Supprimez-les ensuite.

Sinon, ouvrez le Microsoft Store et mettez les applications à jour.

Activez Windows si nécessaire ([besoin d'aide ?](https://github.com/massgravel/Microsoft-Activation-Scripts)).

Masquez les icônes non désirées dans la zone de notification (Intel Graphics par exemple).

Installez les pilotes importants depuis le site du fabricant (mise à jour du BIOS, pavé tactile, lecteur d'empreintes, raccourcis clavier...).

### Windows Defender

Activez la **Protection contre les falsifications** si elle est désactivée. Je ne sais pas ce qui la désactive.

Ignorez les éventuels avertissements de protection du compte et OneDrive.

### Explorateur

Déplacez les bibliothèques Documents, Images, Musique et Vidéos vers D:\ si nécessaire (espace disque limité sur C:).

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

### Photos (si installée)

Ouvrez l’application Photos.

Fermez les fenêtres de connexion et de présentation.

Supprimez le dossier Images des sources.

Désactivez la génération automatique d’albums.

Désactivez les notifications de nouveaux albums.

### Office

Ne pas installer :

- OneDrive
- OneDrive for Business
- Skype Entreprise
- Teams

Pendant l'installation d'Office 365, Teams peut s'installer automatiquement au prochain redémarrage. Pour l'en empêcher, désinstallez **Teams Machine-Wide Installer** dans les Paramètres.

Lancez Word, allez dans Options > Enregistrement > Cochez "Toujours enregistrer sur l'ordinateur".

Définissez Outlook comme client e-mail par défaut si besoin.

## Divers

### Dossiers racine

Si la capacité du disque C est limitée, créez un dossier `Programmes` dans `D:\` avec l'icône `C:\Windows\System32\shell32.dll,162`. Installez des programmes dans cet emplacement pour soulager `Program Files`.

Si nécessaire, créez un dossier `Jeux` dans `D:\` avec l'icône `C:\Windows\System32\imageres.dll,177` pour les mêmes besoins.

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
