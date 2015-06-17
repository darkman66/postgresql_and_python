
/*
 *************************
 */
create or replace function logic.view_and_set_discounted_sales(
    in_bill_number bigint,
    in_discount_percentage float,
    out out_id bigint,
    out out_bill_number varchar,
    out out_item_name text,
    out out_item_price Decimal(10,2),
    out out_item_serial_nr varchar,
    out out_bill_sent boolean
)
returns setof record as
$$

from decimal import Decimal

sql = """SELECT bill.id, bill_number, bill_item.item_name, bill_item.item_qty, bill_item.item_price, item_discount_value, bill_id, bill_sent, item_id,
    item_serial_nr
    FROM
    bill LEFT JOIN bill_item on (bill.id =bill_id)
    LEFT JOIN item on (item_id=item.id)
    WHERE 
    bill.id=%d""" % (in_bill_number)
result = []
plpy.debug(sql);
for x in plpy.execute(sql):
    item_price = plpy.execute("SELECT item_price FROM bill_item WHERE item_id=%d AND bill_id=%d" % (x['item_id'], x['bill_id']))[0]['item_price']    
    discounted_price = float(item_price)*((100.0-in_discount_percentage)/100.0)
    result.append([x['id'], x['bill_number'], x['item_name'], discounted_price, x['item_serial_nr'], x['bill_sent']])

    plpy.info('[view_and_set_discounted_sales] Updateing item id: {0} with new discounted price: {1}'.format(x['item_id'], discounted_price))
    sql = "UPDATE bill_item SET item_price={0}, item_discount_value={1} WHERE item_id={2} AND bill_id={3}".format(discounted_price, in_discount_percentage, x['item_id'], x['bill_id'])
    plpy.debug('view_and_set_discounted_sales] SQL: %s' % sql)
    plpy.execute(sql)

return result
$$
LANGUAGE plpythonu VOLATILE;




