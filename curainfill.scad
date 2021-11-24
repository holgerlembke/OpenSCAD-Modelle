/* 
    Test für Cura mit unterschiedlichen Füllungen. Major Pain.
    
    Gebaut werden soll eine Platte mit Bohrung. Der Bereich mit der Bohrung
    soll eine dichtere Füllung erhalten.
    
    In Openscad
    
    Schritt 1:  ganz normal das Objekt bauen
    Schritt 2:  die Bereiche für ein anderes Infill mit überlapppenden Objekten füllen
                    Dabei so den Quelltext gestalten, dass die das normale Objekt und die
                    Überlappungsbereiche getrennt sind.
    Schritt 3:  Objekt als 3MF exportieren
    Schritt 4:  Überlappung als 3MF exportieren
    
    In Cura
    
    Schritt 1:  Beide 3MFs zum Druckbereich hinzufügen
                    Das sieht möglicherweise völlig falsch und unbrauchbar aus. Ruhig bleiben,
                    alles ist gut.
    Schritt 2:  Objekkt mit den besonderen Einstellungen auswählen, dann:
                    links: Einstellungen per Objekt, Einstellungen wählen, nach Fülldichte suchen
                    und ankreuzen und im nun auftauchenden Fülldichte-Feld die gewünschte
                    Fülldichte einstellen.
    Schritt 3:  beide Objekte auswählen und im Kontextmenü "Modelle gruppieren" auswählen.
                    Die beiden Objekte sollten jetzt positionsrichtig verschmelzen.
                    Es sieht möglicherweise wieder voll falsch und unbrauchbar aus. Einfach
                    in Ruhe das zusammengefügte Objekt mit der linken Seitenleiste auf der 
                    Druckfläche positionieren.
                    
Das alles ist Major Pain, wenn man am Model entwickelt. Daher noch ein Überlebenstipp:
Die Druckgeschichten einfach via Batch erzeugen: in eine "doit.cmd" hineintun:
  
"openscad.exe" -o "teil1.3mf" -D "mode=1" "teil.scad"
"openscad.exe" -o "teil2.3mf" -D "mode=2" "teil.scad"

und aufrufen, wenn man mit dem Design fertig ist.

Wenn man das Objekt in Cura geöffnet hält, läd Cura bei Änderungen auch korrekt die
Teile neu.
*/

$fn = $preview ? 10 : 100;   // hier ändern für schnelleres Rendern

// Laufzeitmodus, mode kann von Kommandozeile kommen
mode = is_undef(mode) ? 0 : mode; 
// 0: in IDE, 1: nur Basisobjekt, 2: Füllobjekt

if (mode==0) {
    // Hier kann man je nach Lust und Laune das Entwickeln machen.
    platte();
    fuellung();
}

if (mode==1) {
    platte();
}

if (mode==2) {
    fuellung();
}

module platte() {
    // Das ist das Basisobjekt: Platte mit Bohrung
    difference() {
        cube([100,100,20]);
        
        translate([40,40,-10])
        cylinder(r=10,h=30);
    }
}    

module fuellung() {
    // Das ist der dichtere Infillbereich (Höhenunterschied nur zur Visualisierung)
    difference() {
        translate([40,40,0])
        cylinder(r=20,h=22);
        
        translate([40,40,-10])
        cylinder(r=10,h=40);
    }
}

