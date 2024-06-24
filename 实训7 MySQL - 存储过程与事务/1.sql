use fib;

-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

drop procedure if exists sp_fibonacci;
delimiter $$
create procedure sp_fibonacci(in m int)
begin
######## 请补充代码完成存储过程体 ########
    declare i int;
    declare a int;
    declare b int;
    declare c int;
    insert into fibonacci values(0,0);
    set m = m - 1;
    if m >= 1 then 
        insert into fibonacci values(1,1);
    end if;
    if m >=2 then 
        insert into fibonacci values(2,1);
    end if;

    set i = 3, a = 1, b = 1, c = 2;

    while i <= m do
        insert into fibonacci values(i, c);
        set a = b, b = c, c = a + b, i = i + 1;
    end while;
end $$
delimiter ;

 
