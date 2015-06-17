CREATE TABLE client
(
  id bigserial NOT NULL,
  row_change_time timestamp without time zone NOT NULL,
  c_name varchar,
  c_surname varchar,
  dob date,
  e_mail varchar,
  CONSTRAINT client_pkey PRIMARY KEY (id),
  CONSTRAINT client_email_key UNIQUE (e_mail)
);


CREATE TABLE item
(
    id bigserial NOT NULL,
    item_name text,
    item_price Decimal(10,2),
    item_serial_nr varchar(32),
    active boolean,
  CONSTRAINT item_pkey PRIMARY KEY (id),
  CONSTRAINT item_name_id_key UNIQUE (item_name, item_serial_nr)
);

CREATE TABLE bill
(
  id bigserial NOT NULL,
  bill_created timestamp without time zone NOT NULL,
  shop_code varchar(32) NOT NULL,
  field_hash varchar(32) NOT NULL,
  client_id bigint NOT NULL,
  bill_sent boolean default false,
  bill_number varchar,
  CONSTRAINT bill_pkey PRIMARY KEY (id),
  CONSTRAINT billcode_hash_key UNIQUE (shop_code, field_hash)
  
);

ALTER TABLE bill
  ADD FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE TABLE bill_item
(
    id bigserial NOT NULL,
    item_name text,
    item_qty int,
    item_price float,
    item_discount_value float default 0,
    item_id bigint,
    bill_id bigint,
  CONSTRAINT bill_item_pkey PRIMARY KEY (id),
  CONSTRAINT bill_name_id_key UNIQUE (bill_id, item_id)
);

ALTER TABLE bill_item
  ADD FOREIGN KEY (item_id) REFERENCES item (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE bill_item
  ADD FOREIGN KEY (bill_id) REFERENCES bill(id) ON DELETE CASCADE ON UPDATE CASCADE;









CREATE SCHEMA logic;

CREATE SEQUENCE public.bill_number_seq;

