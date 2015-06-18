create or replace function logic.tgr_client_d_before()
returns trigger as
$$
declare
    l_id bigint;
begin
SELECT id INTO l_id FROM bill WHERE client_id=OLD.id;
if l_id > 0 then
    raise warning 'Will not remove user ID %, there are assosiated bill!', l_id;
    return NULL;
end if;
return OLD;
end;
$$
LANGUAGE plpgsql VOLATILE;


DROP TRIGGER t_client_d_before ON client;
CREATE TRIGGER t_client_d_before
    BEFORE DELETE ON client
    FOR EACH ROW
    EXECUTE PROCEDURE logic.tgr_client_d_before();



