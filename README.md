# 🐉 Le Donjon Maudit - Batch RPG

[![Language](https://shields.io)](https://wikipedia.org)
[![License: MIT](https://shields.io)](https://opensource.org)

Un mini-RPG textuel et immersif entièrement codé en **script Batch**, jouable directement dans l'invite de commandes Windows (ou via le Bloc-notes). 

> 🛠️ **Credits:** Ce projet a été développé en collaboration par un super Game Designer (Moi-même) et l'IA de Google.

---

## 🎮 Fonctionnalités / Features

* **3 Classes de personnages uniques :** 
  * ⚔️ **Guerrier :** Beaucoup de points de vie, dégâts stables.
  * 🔮 **Mage :** Fragile mais inflige d'énormes dégâts magiques avec sa Boule de Feu.
  * 🗡️ **Voleur :** Dégâts plus faibles mais possède un bonus de chance de 75% sur les esquives.
* **Système de combat au tour par tour :** Choix entre attaque classique, esquive risquée (contre-attaque) et utilisation de potions de soin.
* **Gestion d'inventaire :** Le jeu vérifie dynamiquement si vous possédez la clé du donjon pour ouvrir l'arène finale.
* **Ambiance textuelle immersive :** Une introduction travaillée et plusieurs fins possibles selon vos choix.

---

## 🚀 Comment jouer ? / How to play?

### Windows
1. Téléchargez le fichier `donjon.bat` depuis ce dépôt.
2. Double-cliquez sur `donjon.bat`.
3. C'est tout ! L'aventure commence.

### Alternative (Do It Yourself)
1. Copiez le code source présent dans `donjon.bat`.
2. Ouvrez le **Bloc-notes** Windows.
3. Collez le code, puis enregistrez sous le nom `donjon.bat` (sélectionnez "Tous les fichiers" dans le type d'enregistrement).

---

## 🛠️ Aperçu du Code / Code Preview

Le jeu utilise des variables d'environnement CMD standards pour gérer la santé (`%player_hp%`), les dégâts (`%degats%`) et le système d'aléatoire pour l'esquive :

```batch
if "%classe%"=="VOLEUR" (
    set /a hasard=%random% %% 4
    if not "%hasard%"=="3" (goto esquive_reussie) else (goto esquive_echec)
)
```

---

## 📜 License

Ce projet est sous licence MIT. Vous pouvez librement le cloner, le modifier et l'améliorer !
