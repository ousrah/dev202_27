drop database if  exists banque202;
create database if not exists banque202 collate utf8mb4_general_ci;
use banque202;

#la gestion des exception

drop procedure if exists division;
delimiter $$
create procedure if not exists division (a float, b float)
begin
	declare x float;
	declare exit handler for sqlexception
    begin
		select "impossible de diviser par zero";
    end;
	set x =  a/b;
    select x;
end $$
delimiter ;


call division(3,0);


drop procedure if exists affecter;
delimiter $$
create procedure if not exists affecter (a bigint)
begin
	declare x smallint;
	declare exit handler for sqlexception
    begin
		select "impossible d'affecet un bigint dans un smallint";
    end;
	set x =  a;
    select x;
end $$
delimiter ;


call affecter(61556454);


create table account (
account_number varchar(50) primary key ,
funds decimal(8,2),
check (funds>=0));


insert into account value(1,10000);
insert into account value(2,10000);

select * from account;




drop procedure if exists transfert;
delimiter $$
create procedure if not exists transfert (acc1 varchar(50), acc2 varchar(50), amount decimal(8,2))
begin
	declare exit handler for sqlexception
    begin
		rollback;
        select("operation annulée");
    end;
	start transaction;
		update account set funds = funds + amount where account_number = acc2;
		update account set funds = funds - amount where account_number = acc1;
	commit;
    select("operation executée");
end $$
delimiter ;
call transfert('1','2',10000);

select * from account;
update account set funds = 10000;












