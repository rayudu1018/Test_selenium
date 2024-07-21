-- script to create Clearwater Traders database
-- revised 01/27/2007 for MySQL

DROP DATABASE clearwater;
CREATE DATABASE clearwater;
USE clearwater;


CREATE TABLE customer
(cust_id MEDIUMINT(5), 
last VARCHAR(30),
first VARCHAR(30),
mi CHAR(1),
address VARCHAR(30),
city VARCHAR(30),
state CHAR(2),
zip VARCHAR(10),
d_phone VARCHAR(10),
e_phone VARCHAR(10),
PRIMARY KEY (cust_id)
);

CREATE TABLE order_source
(order_source_id SMALLINT(3),
source_desc VARCHAR(30),
PRIMARY KEY(order_source_id)
);

CREATE TABLE cust_order
(order_id INT(8), 
order_date DATE,
meth_pmt VARCHAR(10),
cust_id MEDIUMINT(5),
order_source_id SMALLINT(3),
PRIMARY KEY (order_id),
INDEX (cust_id),
INDEX (order_source_id),
FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
FOREIGN KEY (order_source_id) REFERENCES order_source(order_source_id)
);

CREATE TABLE category
(category_id SMALLINT(2),
category_desc VARCHAR(20),
PRIMARY KEY (category_id)
);

CREATE TABLE item
(item_id INT(8),
item_desc VARCHAR(100) NOT NULL,
category_id SMALLINT(2),
PRIMARY KEY (item_id),
INDEX (category_id),
FOREIGN KEY (category_id) REFERENCES category(category_id) 
);

CREATE TABLE color
(color VARCHAR(20),
PRIMARY KEY (color)
);

CREATE TABLE inventory
(inv_id BIGINT(10),
item_id INT(8),
item_size VARCHAR(10),
color VARCHAR(20),
price DECIMAL(6,2),
qoh SMALLINT(4),
PRIMARY KEY (inv_id),
INDEX (item_id),
INDEX (color),
FOREIGN KEY (item_id) REFERENCES item(item_id),
FOREIGN KEY (color) REFERENCES color(color)
) ;

CREATE TABLE shipment
(shipment_id BIGINT(10),
date_expected DATE,
PRIMARY KEY (shipment_id)
);

CREATE TABLE shipment_line
(shipment_id BIGINT(10), 
inv_id BIGINT(10),
ship_quantity SMALLINT(4),
date_received DATE, 
PRIMARY KEY(shipment_id, inv_id),
INDEX (shipment_id),
INDEX (inv_id),
FOREIGN KEY (shipment_id) REFERENCES shipment(shipment_id),
FOREIGN KEY (inv_id) REFERENCES inventory(inv_id)
) ;

CREATE TABLE order_line 
(order_id INT(8), 
inv_id BIGINT(10), 
order_quantity SMALLINT(4),
PRIMARY KEY (order_id, inv_id), 
INDEX (order_id),
INDEX (inv_id), 
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (inv_id) REFERENCES inventory(inv_id)
);


-- inserting records into CUSTOMER
INSERT INTO CUSTOMER VALUES
(107, 'Harris', 'Paula', 'E', '1156 Water Street, Apt. #3', 'Osseo', 'WI', 
'54705', '7155558943', '7155559035');

INSERT INTO CUSTOMER VALUES
(232, 'Edwards', 'Mitch', 'M', '4204 Garner Street', 'Washburn', 'WI', 
'54891', '7155558243', '7155556975');

INSERT INTO CUSTOMER VALUES
(133, 'Garcia', 'Maria', 'H', '2211 Pine Drive', 'Radisson', 'WI', 
'54867', '7155558332', '7155558332');

INSERT INTO CUSTOMER VALUES
(154, 'Miller', 'Lee', NULL, '699 Pluto St. NW', 'Silver Lake', 'WI', 
'53821', '7155554978', '7155559002');

INSERT INTO CUSTOMER VALUES
(179, 'Chang', 'Alissa', 'R', '987 Durham Rd.', 'Sister Bay', 'WI', 
'54234', '7155557651', '7155550087');

-- inserting records into ORDER_SOURCE
INSERT INTO order_source VALUES (1, 'Winter 2002');
INSERT INTO order_source VALUES (2, 'Spring 2003');
INSERT INTO order_source VALUES (3, 'Summer 2003');
INSERT INTO order_source VALUES (4, 'Outdoor 2003');
INSERT INTO order_source VALUES (5, 'Children''s 2003');
INSERT INTO order_source VALUES (6, 'Web Site');

-- inserting records into CUST_ORDER
INSERT INTO cust_order VALUES
(1057, '2003-05-29', 'CC', 107, 2);

INSERT INTO cust_order VALUES
(1058, '2003-05-29', 'CC', 232, 6);

INSERT INTO cust_order VALUES
(1059, '2003-05-31', 'CHECK', 133, 2);

INSERT INTO cust_order VALUES
(1060, '2003-05-31', 'CC', 154, 3);

INSERT INTO cust_order VALUES
(1061, '2003-06-01', 'CC', 179, 6);

INSERT INTO cust_order VALUES
(1062, '2003-06-01', 'CC', 179, 3);

-- inserting records into CATEGORY
INSERT INTO category VALUES (1, 'Women''s Clothing');
INSERT INTO category VALUES (2, 'Children''s Clothing');
INSERT INTO category VALUES (3, 'Men''s Clothing');
INSERT INTO category VALUES (4, 'Outdoor Gear');

-- inserting records into ITEM
INSERT INTO item VALUES
(894, 'Women''s Hiking Shorts', 1);

INSERT INTO item VALUES
(897, 'Women''s Fleece Pullover', 1);

INSERT INTO item VALUES
(995, 'Children''s Beachcomber Sandals', 2);

INSERT INTO item VALUES
(559, 'Men''s Expedition Parka', 3);

INSERT INTO item VALUES
(786, '3-Season Tent', 4);


-- inserting records into COLOR
INSERT INTO color VALUES ('Sky Blue');
INSERT INTO color VALUES ('Light Grey');
INSERT INTO color VALUES ('Khaki');
INSERT INTO color VALUES ('Navy');
INSERT INTO color VALUES ('Royal');
INSERT INTO color VALUES ('Eggplant');
INSERT INTO color VALUES ('Blue');
INSERT INTO color VALUES ('Red');
INSERT INTO color VALUES ('Spruce');
INSERT INTO color VALUES ('Turquoise');
INSERT INTO color VALUES ('Bright Pink');

-- inserting records into INVENTORY
INSERT INTO inventory VALUES
(11668, 786, NULL, 'Sky Blue', 259.99, 16);

INSERT INTO inventory VALUES
(11669, 786, NULL, 'Light Grey', 259.99, 12);

INSERT INTO inventory VALUES
(11775, 894, 'S', 'Khaki', 29.95, 150);

INSERT INTO inventory VALUES
(11776, 894, 'M', 'Khaki', 29.95, 147);

INSERT INTO inventory VALUES
(11777, 894, 'L', 'Khaki', 29.95, 0);

INSERT INTO inventory VALUES
(11778, 894, 'S', 'Navy', 29.95, 139);

INSERT INTO inventory VALUES
(11779, 894, 'M', 'Navy', 29.95, 137);

INSERT INTO inventory VALUES
(11780, 894, 'L', 'Navy', 29.95, 115);

INSERT INTO inventory VALUES
(11795, 897, 'S', 'Eggplant', 59.95, 135);

INSERT INTO inventory VALUES
(11796, 897, 'M', 'Eggplant', 59.95, 168);

INSERT INTO inventory VALUES
(11797, 897, 'L', 'Eggplant', 59.95, 187);

INSERT INTO inventory VALUES
(11798, 897, 'S', 'Royal', 59.95, 0);

INSERT INTO inventory VALUES
(11799, 897, 'M', 'Royal', 59.95, 124);

INSERT INTO inventory VALUES
(11800, 897, 'L', 'Royal', 59.95, 112);

INSERT INTO inventory VALUES
(11820, 995, '10', 'Turquoise', 15.99, 121);

INSERT INTO inventory VALUES
(11821, 995, '11', 'Turquoise', 15.99, 111);

INSERT INTO inventory VALUES
(11822, 995, '12', 'Turquoise', 15.99, 113);

INSERT INTO inventory VALUES
(11823, 995, '1', 'Turquoise', 15.99, 121);

INSERT INTO inventory VALUES
(11824, 995, '10', 'Bright Pink', 15.99, 148);

INSERT INTO inventory VALUES
(11825, 995, '11', 'Bright Pink', 15.99, 137);

INSERT INTO inventory VALUES
(11826, 995, '12', 'Bright Pink', 15.99, 134);

INSERT INTO inventory VALUES
(11827, 995, '1', 'Bright Pink', 15.99, 123);

INSERT INTO inventory VALUES
(11845, 559, 'S', 'Spruce', 199.95, 114);

INSERT INTO inventory VALUES
(11846, 559, 'M', 'Spruce', 199.95, 17);

INSERT INTO inventory VALUES
(11847, 559, 'L', 'Spruce', 209.95, 0);

INSERT INTO inventory VALUES
(11848, 559, 'XL', 'Spruce', 209.95, 12);

-- inserting records into SHIPMENT

INSERT INTO shipment VALUES
(211, '2003-09-15');

INSERT INTO shipment VALUES
(212, '2003-11-15');

INSERT INTO shipment VALUES
(213, '2003-06-25');

INSERT INTO shipment VALUES
(214, '2003-06-25');

INSERT INTO shipment VALUES
(215, '2003-08-15');

-- inserting records into SHIPMENT_LINE
INSERT INTO shipment_line VALUES
(211, 11668, 25, '2003-09-10');

INSERT INTO shipment_line VALUES
(211, 11669, 25, '2003-09-10');

INSERT INTO shipment_line VALUES
(212, 11669, 25, NULL);

INSERT INTO shipment_line VALUES
(213, 11777, 200, NULL);

INSERT INTO shipment_line VALUES
(213, 11778, 200, NULL);

INSERT INTO shipment_line VALUES
(213, 11779, 200, NULL);

INSERT INTO shipment_line VALUES
(214, 11798, 100, '2003-08-15');

INSERT INTO shipment_line VALUES
(214, 11799, 100, '2003-08-25');

INSERT INTO shipment_line VALUES
(215, 11845, 50, '2003-08-15');

INSERT INTO shipment_line VALUES
(215, 11846, 100, '2003-08-15');

INSERT INTO shipment_line VALUES
(215, 11847, 100, '2003-08-15');

-- inserting records into ORDER_LINE
INSERT INTO order_line VALUES (1057, 11668, 1);
INSERT INTO order_line VALUES (1057, 11800, 2);
INSERT INTO order_line VALUES (1058, 11824, 1);
INSERT INTO order_line VALUES (1059, 11846, 1);
INSERT INTO order_line VALUES (1059, 11848, 1);
INSERT INTO order_line VALUES (1060, 11798, 2);
INSERT INTO order_line VALUES (1061, 11779, 1);
INSERT INTO order_line VALUES (1061, 11780, 1);
INSERT INTO order_line VALUES (1062, 11799, 1);
INSERT INTO order_line VALUES (1062, 11669, 3);
