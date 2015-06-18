-- client
insert into client (row_change_time, c_name, c_surname, dob, e_mail) values (now(), 'John', 'DX', '1970-08-17', 'john@foo.com');
insert into client (row_change_time, c_name, c_surname, dob, e_mail) values (now(), 'Jane', 'DY', '1907-01-12', 'jane@foo.com');


-- products
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 1', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 2', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 3', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 4', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 5', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 6', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 7', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 8', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 9', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 10', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 11', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 12', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 13', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 14', random()*100, md5(now()::varchar), true);
insert into item (item_name, item_price, item_serial_nr, active) values ('My awesome product 15', random()*100, md5(now()::varchar), true);

