create or replace function logic.tgr_bill_i()
returns trigger as
$$
import redis
from cPickle import dumps
in_server = '127.0.0.1'
in_port = 6379

POOL = redis.ConnectionPool(host=in_server, port = in_port if in_port is not None else 6379, db = 1)
r = redis.Redis(connection_pool = POOL)

if TD['new']['bill_created']:
    bill_key = 'bill_active:%s' % TD['new']['field_hash']
    r.set(bill_key, dumps({
        'bill_created' : TD['new']['bill_created'],
        'shop_code' : TD['new']['shop_code'],
        'field_hash' : TD['new']['field_hash'],
        'id' : TD['new']['id'],
        'client_id' : TD['new']['client_id']
        }))
    plpy.info('[tgr_bill_i] Saving bill hash: {0}'.format(bill_key))
$$
LANGUAGE plpythonu VOLATILE;


DROP TRIGGER t_bill_i ON bill;
CREATE TRIGGER t_bill_i
    AFTER INSERT ON bill
    FOR EACH ROW
    EXECUTE PROCEDURE logic.tgr_bill_i();



