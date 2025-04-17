# 🚖 FiveM Taxi-System

Dieses Skript implementiert ein realistisches **Taxi-System für FiveM**, inklusive NPC-Interaktion, Taxi-Fahrt, zufälliger Pannen und Reparatur-Animationen. Perfekt für immersive Roleplay-Server! 🎭🔧  

## ✨ Features
<div style="background:#000;color:#fff;padding:10px;border-radius:5px;">
✅ **NPC-Interaktion zum Starten der Fahrt**  
✅ **Zufällige Pannen während der Fahrt**  
✅ **Motor beginnt zu rauchen bei einer Panne**  
✅ **NPC steigt aus, geht zur Motorhaube und führt eine Reparatur durch**  
✅ **Motorhaube öffnet sich automatisch**  
✅ **Nach der Reparatur setzt die Fahrt sich fort**  
✅ **Spieler kann während der Fahrt nicht aussteigen**  
✅ **Kilometer-Anzeige für die verbleibende Strecke**  
</div>

## 🔧 Installation
1. **Dateien in dein FiveM-Skriptverzeichnis einfügen:**  
   Kopiere die `client.lua`, `config.lua` und `fxmanifest.lua` in dein FiveM-Resourcenverzeichnis.  

2. **Resource starten:**  
ensure taxi_system
Starte den Server und teste die Taxi-Funktion! 🚀

🌐 Frameworks & Dependencies
Dieses Skript läuft auf FiveM, einer modifizierten GTA V Multiplayer-Framework. Folgende Technologien werden verwendet:

Lua für Client- und Server-Skripte

FiveM Native Functions für Fahrzeugsteuerung & NPC-Interaktion

Entity Handling zur Steuerung von NPCs & Fahrzeugen

Falls du zusätzliche Skripte einbinden möchtest, kannst du ESX oder QBCore nutzen.

<div id="taxi-ui">
    <h2>🚖 Taxi-Fahrt läuft...</h2>
    <p id="distance">Entfernung zum Ziel: 3.2 km</p>
</div>

<script>
    document.getElementById("distance").innerText = "Entfernung zum Ziel: 2.8 km";
</script>
Dieses Beispiel zeigt eine UI-Anzeige für die verbleibende Kilometer-Distanz während der Fahrt. 🎯🚖

🎭 Nutzung
<details> <summary>Klicke hier für eine detaillierte Erklärung</summary> <p>- Gehe zum NPC an der Taxi-Station.</p> <p>- Drücke "E", um eine Fahrt zu starten.</p> <p>- Genieße die Fahrt – aber Achtung, es könnte eine Panne geben! 🚧</p> <p>- Falls eine Panne auftritt, führt der NPC eine Reparatur durch, bevor die Fahrt fortgesetzt wird.</p> </details>

📌 Hinweise
Falls der NPC nicht spawnt, überprüfe fxmanifest.lua und stelle sicher, dass client.lua richtig geladen wird.

Falls die Panne nicht korrekt funktioniert, überprüfe die Werte für Motor-Gesundheit und Partikel-Effekte.

👨‍💻 Credits
Erstellt für `FiveXLive`  – für eine realistische Spielerfahrung! 🎭✨
