use finance1;
drop trigger if exists before_property_inserted;
-- 请在适当的地方补充代码，完成任务要求：
delimiter $$
CREATE TRIGGER before_property_inserted BEFORE INSERT ON property
-- referencing new row as newTuple
FOR EACH ROW 
BEGIN
    declare type int default new.pro_type;
    declare id int default new.pro_pif_id;
    declare msg varchar(50);
    if type = 1 then
        if id not in (select p_id from finances_product) then
            set msg = concat("finances product #", id, " not found!");
        end if;
    elseif type = 2 then
        if id not in (select i_id from insurance) then
            set msg = concat("insurance #", id, " not found!");
        end if;
    elseif type = 3 then
        if id not in (select f_id from fund) then
            set msg = concat("fund #", id, " not found!");
        end if;
    else
        set msg = concat("type ", type, " is illegal!");
    end if;
    if msg is not null then
        signal sqlstate "45000" set message_text = msg;
    end if;


END$$
 
delimiter ;