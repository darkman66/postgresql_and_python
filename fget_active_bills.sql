create or replace function logic.get_active_bills()
returns text as
$$

import redis
from cPickle import loads
from cjson import encode

in_server = '127.0.0.1'
in_port = 6379

POOL = redis.ConnectionPool(host=in_server, port = in_port if in_port is not None else 6379, db = 1)
r = redis.Redis(connection_pool = POOL)

status = {'msg' : '', 'status' : False } # let False means error, True - all OK
bills = r.keys('bill_active:*')
all_bills = []
for k in bills if bills else []:
    out = r.get(k)
    if out is None:
        continue
    data = loads(out)
    all_bills.append(data)

return encode({'status' : status, 'data' : all_bills})
$$
LANGUAGE plpythonu VOLATILE;


