-- network_site (2 rows)
INSERT INTO network_site (id, site_code, name, address, city, country_code, latitude, longitude, status)
VALUES
(1, 'SOF-DC-01', 'Sofia Data Center', 'Bul. Tsarigradsko Shose 135', 'Sofia',  'BG',  42.693611,  23.332222, 'ACTIVE'),
(2, 'LON-EX-01', 'London Exchange',   '1 Harbour Exchange Square',   'London', 'GB',  51.505000,  -0.017000, 'ACTIVE');

-- router (3 rows)
INSERT INTO router (id, site_id, hostname, vendor, model, serial_number, management_ip, software_version, status)
VALUES
(1, 1, 'sofia-core-01',   'Cisco',   'ASR9001',    'SN-CSC-001001', '10.0.1.1', '7.5.2',    'IN_SERVICE'),
(2, 1, 'sofia-edge-01',   'Juniper', 'MX204',      'SN-JNP-002001', '10.0.1.2', '21.4R1',   'IN_SERVICE'),
(3, 2, 'london-core-01',  'Nokia',   '7250-IXR-6', 'SN-NOK-003001', '10.1.1.1', '22.10.R1', 'MAINTENANCE');

-- shelf (5 rows)
INSERT INTO shelf (id, router_id, shelf_number, shelf_type, serial_number, total_slots, status)
VALUES
(1, 1, 1, 'CHASSIS',   'SHF-001-A', 8, 'ACTIVE'),
(2, 1, 2, 'EXPANSION', 'SHF-001-B', 4, 'ACTIVE'),
(3, 2, 1, 'CHASSIS',   'SHF-002-A', 6, 'ACTIVE'),
(4, 3, 1, 'CHASSIS',   'SHF-003-A', 8, 'ACTIVE'),
(5, 3, 2, 'EXPANSION', 'SHF-003-B', 4, 'ACTIVE');

-- slot (20 rows)
-- shelf 1 → slot_numbers 1-8
-- shelf 2 → slot_numbers 1-4
-- shelf 3 → slot_numbers 1-4
-- shelf 4 → slot_numbers 1-2
-- shelf 5 → slot_numbers 1-2
INSERT INTO slot (id, shelf_id, slot_number, slot_type, status)
VALUES
(1,  1, 1, 'LINE',    'OCCUPIED'),
(2,  1, 2, 'LINE',    'OCCUPIED'),
(3,  1, 3, 'LINE',    'OCCUPIED'),
(4,  1, 4, 'LINE',    'EMPTY'),
(5,  1, 5, 'LINE',    'EMPTY'),
(6,  1, 6, 'CONTROL', 'OCCUPIED'),
(7,  1, 7, 'POWER',   'OCCUPIED'),
(8,  1, 8, 'FAN',     'OCCUPIED'),
(9,  2, 1, 'LINE',    'OCCUPIED'),
(10, 2, 2, 'LINE',    'OCCUPIED'),
(11, 2, 3, 'LINE',    'EMPTY'),
(12, 2, 4, 'LINE',    'RESERVED'),
(13, 3, 1, 'LINE',    'OCCUPIED'),
(14, 3, 2, 'LINE',    'EMPTY'),
(15, 3, 3, 'CONTROL', 'EMPTY'),
(16, 3, 4, 'POWER',   'EMPTY'),
(17, 4, 1, 'LINE',    'FAULTY'),
(18, 4, 2, 'LINE',    'EMPTY'),
(19, 5, 1, 'LINE',    'EMPTY'),
(20, 5, 2, 'LINE',    'EMPTY');

-- card (12 rows)
-- Cards 1-9: INSTALLED in occupied slots
-- Cards 10-12: IN_STOCK (not in any slot, slot_id is NULL)
INSERT INTO card (id, slot_id, part_number, serial_number, card_type, port_count, hardware_revision, status)
VALUES
(1,  1,  'PN-LC-10G-48', 'CRD-0001', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
(2,  2,  'PN-LC-10G-48', 'CRD-0002', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
(3,  3,  'PN-LC-100G-8', 'CRD-0003', 'LINE_CARD',     8, 'REV-B', 'INSTALLED'),
(4,  6,  'PN-CC-MAIN',   'CRD-0004', 'CONTROL_CARD',  0, 'REV-C', 'INSTALLED'),
(5,  7,  'PN-PWR-2400',  'CRD-0005', 'POWER_CARD',    0, 'REV-A', 'INSTALLED'),
(6,  8,  'PN-FAN-6X',    'CRD-0006', 'FAN_CARD',      0, 'REV-A', 'INSTALLED'),
(7,  9,  'PN-LC-10G-48', 'CRD-0007', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
(8,  10, 'PN-LC-100G-8', 'CRD-0008', 'LINE_CARD',     8, 'REV-B', 'INSTALLED'),
(9,  13, 'PN-LC-10G-48', 'CRD-0009', 'LINE_CARD',    48, 'REV-A', 'INSTALLED'),
(10, NULL, 'PN-LC-10G-48', 'CRD-0010', 'LINE_CARD',  48, 'REV-A', 'IN_STOCK'),
(11, NULL, 'PN-LC-100G-8', 'CRD-0011', 'LINE_CARD',   8, 'REV-B', 'IN_STOCK'),
(12, NULL, 'PN-CC-MAIN',   'CRD-0012', 'CONTROL_CARD', 0, 'REV-C', 'FAULTY');