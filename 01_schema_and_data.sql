-- Wir starten eine Transaktion. Wenn ein Fehler passiert, wird alles zurückgesetzt.
START TRANSACTION;

-- 1. Tabellen komplett leeren, um Altlasten zu entfernen
TRUNCATE TABLE price_history, components, suppliers RESTART IDENTITY CASCADE;

-- 2. Zuerst die Lieferanten eintragen
INSERT INTO suppliers (supplier_id, supplier_name, contact_email, country) VALUES
(1, 'Bike-Parts GmbH', 'info@bikeparts.de', 'Deutschland'),
(2, 'EuroVelos Distribution', 'sales@eurovelos.fr', 'Frankreich');

-- 3. DANACH die Komponenten eintragen (Jetzt existiert ID 1 definitiv!)
INSERT INTO components (component_id, part_name, category, stock_quantity, supplier_id) VALUES
(1, 'Disc Brakes Set (2 Pcs)', 'Brakes', 14, 1),
(2, 'Advent 9 Speed Microshift Dropbar Groupset', 'Groupset', 5, 2),
(3, '9-Speed Cassette 11-42T', 'Cassette', 8, 2),
(4, 'Hydraulic Brake Pads', 'Brakes', 50, 1);

-- 4. UND ERST JETZT die Preise eintragen
INSERT INTO price_history (component_id, price_euro, valid_from, valid_to) VALUES
(1, 32.00, '2026-01-01', '2026-03-01'),
(1, 25.00, '2026-03-02', NULL), 
(2, 189.00, '2026-01-15', NULL),
(3, 39.50, '2026-01-15', NULL),
(4, 12.00, '2025-11-01', '2026-02-15'),
(4, 9.99, '2026-02-16', NULL);

-- Wenn alles bis hierher klappt, wird es dauerhaft gespeichert
COMMIT;
