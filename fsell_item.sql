/*
 *************************
 */

create or replace function logic.sell_items(
    in_user_email text,
    in_shop_code varchar,
    in_article_codes text
)
returns text as
$$

import cjson
msg = 'Bill ID: %d created'
status = True
try:
    data = cjson.decode(in_article_codes)

    client_id = plpy.execute("SELECT id FROM client WHERE e_mail='%s'" % in_user_email)[0]['id'] 
    plpy.info("Client ID: %d" % client_id)

    sql = """INSERT INTO bill (bill_created, shop_code, field_hash, client_id, bill_sent, bill_number)
        VALUES (now(), '{0}', md5(now()::varchar), {1}, true, nextval('public.bill_number_seq')) RETURNING id""".format(in_shop_code, client_id)
    bill_id = plpy.execute(sql)[0]['id']
    plpy.info("Created bill id: %d" % bill_id)
    for item, qty in data.items():
        sql = "SELECT * FROM item WHERE item_serial_nr='%s'" % item
        plpy.info(sql)
        item_dict = plpy.execute(sql)[0]
        sql = """INSERT INTO bill_item (item_name, item_qty, item_price, item_discount_value, item_id, bill_id) VALUES 
            ('{0}', {1}, {2}, 0, {3}, {4})""".format(item_dict['item_name'], qty, item_dict['item_price']*qty, item_dict['id'], bill_id)
        plpy.execute(sql)
    msg = msg % bill_id
except Exception, e:
    msg = str(e)
    status = False
return cjson.encode({'msg' : msg, 'status' : status})
$$
LANGUAGE plpythonu VOLATILE;
