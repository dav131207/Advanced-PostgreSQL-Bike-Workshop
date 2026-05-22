-- Wir isolieren die aktuell gültigen Preise in einer temporären Tabelle (CTE)
WITH aktuelle_preise AS (
    SELECT 
        component_id,
        price_euro
    FROM price_history
    WHERE valid_to IS NULL OR valid_to >= CURRENT_DATE
)
-- Jetzt verknüpfen wir die Hauptdaten mit den gefilterten Preisen
SELECT 
    c.part_name AS "Komponente",
    c.category AS "Kategorie",
    c.stock_quantity AS "Lagerbestand",
    p.price_euro AS "Einzelpreis (€)",
    -- Finanzielle Berechnung des Gesamtwerts pro Teil im Lager
    (c.stock_quantity * p.price_euro) AS "Lagerwert Gesamt (€)",
    s.supplier_name AS "Lieferant"
FROM components c
JOIN aktuelle_preise p ON c.component_id = p.component_id
LEFT JOIN suppliers s ON c.supplier_id = s.supplier_id
ORDER BY "Lagerwert Gesamt (€)" DESC;