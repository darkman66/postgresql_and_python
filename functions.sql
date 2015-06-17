
/***************************/
create or replace function logic.tgr_bill_i()
returns trigger as
$$
from cPickle import dups

if TD['new']['bill_created']:
    bill_key = 'bill:%s' % TD['new']['field_hash']
    r.set(bill_key, dumps({
        'timestamp' : TD['new']['timestamp'],
        'shop_code' : TD['new']['shop_code'],
        'field_hash' : TD['new']['field_hash'],
        'bill_items' : TD['new']['bill_items'],
        'client_id' : TD['new']['client_id']
        }))
    plpy.info('[tgr_bill_i] Saving bill hash: {0}'.format(bill_key))
$$
LANGUAGE plpythonu VOLATILE;



