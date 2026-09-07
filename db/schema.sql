CREATE TABLE network_site(
id  BIGINT  AUTO_INCREMENT,
site_code VARCHAR(20) NOT NULL,
name VARCHAR(120) NOT NULL,
address VARCHAR(255) NULL,
city VARCHAR(80) NULL,
country_code CHAR(2) NULL,
latitude DECIMAL(9,6) NULL,
longitude DECIMAL(9,6) NULL,
status VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NULL,


CONSTRAINT PK_network_site PRIMARY KEY (id),
CONSTRAINT UQ_network_site_site_code UNIQUE (site_code),
CONSTRAINT CK_network_site_status CHECK (status IN ('ACTIVE', 'PLANNED', 'DECOMMISSIONED'))

);

CREATE TABLE router(
id BIGINT AUTO_INCREMENT,
site_id BIGINT NOT NULL,
hostname VARCHAR(100) NOT NULL,
vendor VARCHAR(60) NOT NULL,
model VARCHAR(60) NOT NULL,
serial_number VARCHAR(60) NOT NULL,
management_ip VARCHAR(45) NULL,
software_version VARCHAR(40) NULL,
status VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NULL,


CONSTRAINT PK_router PRIMARY KEY (id),
CONSTRAINT FK_router_network_site FOREIGN KEY (site_id) REFERENCES network_site(id),
CONSTRAINT UQ_router_hostname UNIQUE (hostname),
CONSTRAINT UQ_router_serial_number UNIQUE (serial_number),
CONSTRAINT CK_router_status CHECK (status IN ('IN_SERVICE','MAINTENANCE','SPARE','DECOMMISSIONED'))

);

CREATE TABLE shelf(
id BIGINT AUTO_INCREMENT,
router_id BIGINT NOT NULL,
shelf_number INT NOT NULL,
shelf_type VARCHAR(60) NULL,
serial_number VARCHAR(60) NULL,
total_slots INT NOT NULL,
status VARCHAR(20) NOT NULL,
created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NULL,

CONSTRAINT PK_shelf PRIMARY KEY (id),
CONSTRAINT FK_shelf_router FOREIGN KEY(router_id) REFERENCES router(id),
CONSTRAINT UQ_shelf_router_number UNIQUE (router_id, shelf_number),
CONSTRAINT CK_shelf_total_slots CHECK (total_slots > 0)


);

CREATE TABLE slot(
id BIGINT AUTO_INCREMENT,
shelf_id BIGINT NOT NULL,
slot_number INT NOT NULL, 
slot_type VARCHAR(60) NULL,
status VARCHAR(20) NOT NULL, 
created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NULL,

CONSTRAINT PK_slot PRIMARY KEY (id),
CONSTRAINT FK_slot_shelf FOREIGN KEY (shelf_id) REFERENCES shelf(id),
CONSTRAINT UQ_slot_slot_number UNIQUE (shelf_id, slot_number),
CONSTRAINT CK_slot_status CHECK(status  IN ('EMPTY','OCCUPIED','RESERVED','FAULTY'))

);

CREATE TABLE card(
id BIGINT AUTO_INCREMENT,
slot_id BIGINT NULL,
part_number VARCHAR(60) NOT NULL,
serial_number VARCHAR(60) NOT NULL, 
card_type VARCHAR(40) NOT NULL,
port_count INT NULL,
hardware_revision VARCHAR(20) NULL,
status VARCHAR(20) NOT NULL, 
created_at TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NULL,

CONSTRAINT PK_card PRIMARY KEY (id),
CONSTRAINT FK_card_slot FOREIGN KEY(slot_id) REFERENCES slot(id),
CONSTRAINT UQ_card_slot_id UNIQUE (slot_id),
CONSTRAINT UQ_card_serial_number UNIQUE (serial_number),
CONSTRAINT CK_card_port_count CHECK (port_count >= 0),
CONSTRAINT CK_card_status CHECK(status IN('INSTALLED','IN_STOCK','FAULTY','RETIRED'))
);
