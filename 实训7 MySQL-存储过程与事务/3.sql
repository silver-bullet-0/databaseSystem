use finance1;

-- 在金融应用场景数据库中，编程实现一个转账操作的存储过程sp_transfer_balance，实现从一个帐户向另一个帐户转账。
-- 请补充代码完成该过程：
delimiter $$
create procedure sp_transfer(
	                 IN applicant_id int,      
                     IN source_card_id char(30),
					 IN receiver_id int, 
                     IN dest_card_id char(30),
					 IN	amount numeric(10,2),
					 OUT return_code int)
proc1:
BEGIN
    
    declare balanceOut numeric(10,2);
    declare balanceIn numeric(10,2);
    declare idOut integer;
    declare idIn integer;
    declare typeOut char(20);
    declare typeIn char(20);
    start transaction;
    select b_c_id, b_type into idOut, typeOut from bank_card where b_number = source_card_id;
    select b_c_id, b_type into idIn, typeIn from bank_card where b_number = dest_card_id;
    if idOut != applicant_id or idIn != receiver_id then
        rollback;
        set return_code = 0;
        leave proc1;
    end if;
    if typeOut = '信用卡' then
        rollback;
        set return_code = 0;
        leave proc1;
    end if;
    select b_balance into balanceOut from bank_card where b_number = source_card_id;
    if balanceOut < amount then 
        rollback;
        set return_code = 0;
        leave proc1;
    end if;
    if typeIn = '储蓄卡' then
        update bank_card set b_balance = b_balance + amount where b_number = dest_card_id;
        update bank_card set b_balance = b_balance - amount where b_number = source_card_id;
    else 
        update bank_card set b_balance = b_balance - amount where b_number = dest_card_id or b_number = source_card_id;
    end if;
    set return_code = 1;

END$$

delimiter ;








/*  end  of  your code  */ 