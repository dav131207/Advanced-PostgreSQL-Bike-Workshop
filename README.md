# Advanced PostgreSQL: Bike Workshop & Inventory Management\
\
Ein praxisnahes Datenbanksystem in **PostgreSQL** zur Verwaltung von Fahrradkomponenten, Lieferantenstrukturen und dynamischen Preishistorien.\
\
Tech Stack & Features\
* **Datenbank:** PostgreSQL (v18)\
* **Verwaltungstool:** DBeaver\
* **Fortgeschrittene SQL-Konzepte:** Common Table Expressions (CTEs), Datenintegrit\'e4t via Foreign Keys & Constraints, Transaktionssicherheit (`START TRANSACTION`), Aggregationen.\
\
Das Datenmodell (Schema)\
Das System ist vollst\'e4ndig normalisiert und besteht aus drei Kernbereichen:\
1. `suppliers`: Speichert Herkunft und Kontaktdaten der Lieferanten.\
2. `components`: Enth\'e4lt die Bauteile (z.B. Bremssets, Groupsets) und deren aktuellen Lagerbestand.\
3. `price_history`: Erm\'f6glicht eine l\'fcckenlose Verfolgung von Preis\'e4nderungen \'fcber die Zeit (wichtig f\'fcr historische Analysen).\
\
Beispiel-Analyse (Lagerwert-Berechnung)\
Um den echten, aktuellen finanziellen Wert des Lagers zu ermitteln, nutzt das Projekt eine **Common Table Expression (CTE)**. Dadurch werden abgelaufene Preise gefiltert und nur aktuelle Angebote (wie das Disc Brakes Set f\'fcr 25,00 \'80) mit dem Bestand multipliziert:\
\
```sql\
WITH aktuelle_preise AS (\
    SELECT component_id, price_euro\
    FROM price_history\
    WHERE valid_to IS NULL OR valid_to >= CURRENT_DATE\
)\
SELECT \
    c.part_name AS "Komponente",\
    c.stock_quantity AS "Lagerbestand",\
    p.price_euro AS "Einzelpreis (\'80)",\
    (c.stock_quantity * p.price_euro) AS "Lagerwert Gesamt (\'80)"\
...}
