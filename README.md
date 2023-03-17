# Analiza osobne mobilnosti temeljem očitanja opažanja osjetila akceleracije na pametnom telefonu

Mario Maričević, Filip Grgur, Filip Nikolaus

## **Uvod**

Aplikacijom **AndroSensor** bilo je potrebno prikupiti opažanja akcelerometara prilikom dnevne aktivnosti (trčanje, brzo hodanje, planinarenje, biciklizam ili drugo po izboru) u trajanju od barem 30 minuta. Dobivene rezultate je bilo potrebno pohraniti u CSV datoteku i statistički anallizirati u programskom okruženju R. Nad podacima je bilo potrebno provesti opisnu statističku analizu, nacrtati pripadajuće kutijaste dijagrame te provesti eksperimentalnu statističku razdiobu. Nakon uspješno provedene statističke analize bilo je potrebno grafički prikazati putanju gibanja na podlozi OpenStreetMap uz mogućnost interaktivnog zahtjeva za ispis očitanja u željenoj točki trajektorije na digitalnoj karti. Uz navedeno trebalo je voditi računa o privatnosti te naposljetku interpretirati i komentirati dobivene rezultate.

## **Podjela zadatka na manje cijeline**

1.  Instalacija aplikacije AndroSensor, prikupljanje podataka prilikom dnevne aktivnosti i spremanje u CSV datoteku

2.  Učitavanje podataka iz dobivene CSV datoteke

3.  Opisna statistička analiza akcelerometarskih podataka

4.  Kutijasti dijagrami - grafički prikaz statističke analize akcelerometarskih podataka

5.  Eksperimentalne statističke razdiobe

    -   Procjena eksperimentalne gustoće vjerojatnosti (density)

    -   Provedba statističkih testova - Shapiro-Wilkov i Kolmogorov-Smirnov test

6.  Priprema podataka lokacije za iscrtavanje putanje putem Leaflet mape

7.  Priprema točaka za mogućnost interakcije u željenoj točki putanje kretanja (trajektorije)

8.  Deklaracija Leaflet mape, iscrtavanje putanje kretanja i interaktivnih točaka

9.  Konačni komentar i zaključak

## **Rezultati**

Tijek zadatka prema navedenim koracima te dobivene rezultate moguće je pregledati preuzimanjem i otvaranjem [HTML dokumenta](https://github.com/MMaricevic64/analiza_mobilnosti/blob/main/Projekt.html) u web pregledniku ili pokretanjem [R skripte](https://github.com/MMaricevic64/analiza_mobilnosti/blob/main/Projekt.R) unutar R Studio razvojnog okruženja.
