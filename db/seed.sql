DELETE FROM card;
DELETE FROM slot;
DELETE FROM shelf;
DELETE FROM router;
DELETE FROM network_site;
-- network_site (2 rows)
INSERT INTO network_site ( site_code, name, address, city, country_code, latitude, longitude, status)
VALUES
( 'SOF-DC-01', 'Sofia Data Center', 'Bul. Tsarigradsko Shose 135', 'Sofia',  'BG',  42.693611,  23.332222, 'ACTIVE'),
( 'LON-EX-01', 'London Exchange',   '1 Harbour Exchange Square',   'London', 'GB',  51.505000,  -0.017000, 'ACTIVE');

-- router (3 rows)
INSERT INTO router ( site_id, hostname, vendor, model, serial_number, management_ip, software_version, status)
SELECT s.id, 'sofia-core-01',   'Cisco',   'ASR9001',    'SN-CSC-001001', '10.0.1.1', '7.5.2',    'IN_SERVICE'
FROM network_site s
WHERE s.site_code = 'SOF-DC-01';

INSERT INTO router ( site_id, hostname, vendor, model, serial_number, management_ip, software_version, status)
SELECT s.id, 'sofia-edge-01',   'Juniper', 'MX204',      'SN-JNP-002001', '10.0.1.2', '21.4R1',   'IN_SERVICE'
FROM network_site s
WHERE s.site_code = 'SOF-DC-01';

INSERT INTO router ( site_id, hostname, vendor, model, serial_number, management_ip, software_version, status)
SELECT s.id, 'london-core-01',  'Nokia',   '7250-IXR-6', 'SN-NOK-003001', '10.1.1.1', '22.10.R1', 'MAINTENANCE'
FROM network_site s
WHERE s.site_code = 'LON-EX-01';

-- shelf (5 rows)
INSERT INTO shelf ( router_id, shelf_number, shelf_type, serial_number, total_slots, status)
SELECT r.id, 1, 'CHASSIS',   'SHF-001-A', 8, 'ACTIVE'
FROM router r
WHERE r.hostname = 'sofia-core-01';

INSERT INTO shelf ( router_id, shelf_number, shelf_type, serial_number, total_slots, status)
SELECT r.id, 2, 'EXPANSION', 'SHF-001-B', 4, 'ACTIVE'
FROM router r
WHERE r.hostname = 'sofia-core-01';

INSERT INTO shelf ( router_id, shelf_number, shelf_type, serial_number, total_slots, status)
SELECT r.id, 1, 'CHASSIS',   'SHF-002-A', 6, 'ACTIVE'
FROM router r
WHERE r.hostname = 'sofia-edge-01';

INSERT INTO shelf ( router_id, shelf_number, shelf_type, serial_number, total_slots, status)
SELECT r.id, 1, 'CHASSIS',   'SHF-003-A', 8, 'ACTIVE'
FROM router r
WHERE r.hostname = 'london-core-01';

INSERT INTO shelf ( router_id, shelf_number, shelf_type, serial_number, total_slots, status)
SELECT r.id, 2, 'EXPANSION', 'SHF-003-B', 4, 'ACTIVE'
FROM router r
WHERE r.hostname = 'london-core-01';

-- slot (20 rows)
INSERT INTO slot ( shelf_id, slot_number, slot_type, status)
SELECT sh.id, v.slot_number, v.slot_type, v.status
FROM (VALUES
    ('sofia-core-01',  1, 1, 'LINE',    'OCCUPIED'),
    ('sofia-core-01',  1, 2, 'LINE',    'OCCUPIED'),
    ('sofia-core-01',  1, 3, 'LINE',    'OCCUPIED'),
    ('sofia-core-01',  1, 4, 'LINE',    'EMPTY'),
    ('sofia-core-01',  1, 5, 'LINE',    'EMPTY'),
    ('sofia-core-01',  1, 6, 'CONTROL', 'OCCUPIED'),
    ('sofia-core-01',  1, 7, 'POWER',   'OCCUPIED'),
    ('sofia-core-01',  1, 8, 'FAN',     'OCCUPIED'),
    ('sofia-core-01',  2, 1, 'LINE',    'OCCUPIED'),
    ('sofia-core-01',  2, 2, 'LINE',    'OCCUPIED'),
    ('sofia-core-01',  2, 3, 'LINE',    'EMPTY'),
    ('sofia-core-01',  2, 4, 'LINE',    'RESERVED'),
    ('sofia-edge-01',  1, 1, 'LINE',    'OCCUPIED'),
    ('sofia-edge-01',  1, 2, 'LINE',    'EMPTY'),
    ('sofia-edge-01',  1, 3, 'CONTROL', 'EMPTY'),
    ('sofia-edge-01',  1, 4, 'POWER',   'EMPTY'),
    ('london-core-01', 1, 1, 'LINE',    'FAULTY'),
    ('london-core-01', 1, 2, 'LINE',    'EMPTY'),
    ('london-core-01', 2, 1, 'LINE',    'EMPTY'),
    ('london-core-01', 2, 2, 'LINE',    'EMPTY')
) AS v (hostname, shelf_number, slot_number, slot_type, status)
JOIN router r ON r.hostname = v.hostname
JOIN shelf sh ON sh.router_id = r.id AND sh.shelf_number = v.shelf_number
ORDER BY sh.id, v.slot_number;

-- card (12 rows)
INSERT INTO card ( slot_id, part_number, serial_number, card_type, port_count, hardware_revision, status)
SELECT sl.id, v.part_number, v.serial_number, v.card_type, v.port_count, v.hardware_revision, v.status
FROM (VALUES
    ('sofia-core-01', 1, 1, 'PN-LC-10G-48', 'CRD-0001', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
    ('sofia-core-01', 1, 2, 'PN-LC-10G-48', 'CRD-0002', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
    ('sofia-core-01', 1, 3, 'PN-LC-100G-8', 'CRD-0003', 'LINE_CARD',     8, 'REV-B', 'INSTALLED'),
    ('sofia-core-01', 1, 6, 'PN-CC-MAIN',   'CRD-0004', 'CONTROL_CARD',  0, 'REV-C', 'INSTALLED'),
    ('sofia-core-01', 1, 7, 'PN-PWR-2400',  'CRD-0005', 'POWER_CARD',    0, 'REV-A', 'INSTALLED'),
    ('sofia-core-01', 1, 8, 'PN-FAN-6X',    'CRD-0006', 'FAN_CARD',      0, 'REV-A', 'INSTALLED'),
    ('sofia-core-01', 2, 1, 'PN-LC-10G-48', 'CRD-0007', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
    ('sofia-core-01', 2, 2, 'PN-LC-100G-8', 'CRD-0008', 'LINE_CARD',     8, 'REV-B', 'INSTALLED'),
    ('sofia-edge-01', 1, 1, 'PN-LC-10G-48', 'CRD-0009', 'LINE_CARD',    48, 'REV-A', 'INSTALLED')
) AS v (hostname, shelf_number, slot_number, part_number, serial_number, card_type, port_count, hardware_revision, status)
JOIN router r ON r.hostname = v.hostname
JOIN shelf sh ON sh.router_id = r.id AND sh.shelf_number = v.shelf_number
JOIN slot sl ON sl.shelf_id = sh.id AND sl.slot_number = v.slot_number
ORDER BY v.serial_number;

INSERT INTO card ( slot_id, part_number, serial_number, card_type, port_count, hardware_revision, status)
VALUES
( NULL, 'PN-LC-10G-48', 'CRD-0010', 'LINE_CARD',  48, 'REV-A', 'IN_STOCK'),
( NULL, 'PN-LC-100G-8', 'CRD-0011', 'LINE_CARD',   8, 'REV-B', 'IN_STOCK'),
( NULL, 'PN-CC-MAIN',   'CRD-0012', 'CONTROL_CARD', 0, 'REV-C', 'FAULTY');
