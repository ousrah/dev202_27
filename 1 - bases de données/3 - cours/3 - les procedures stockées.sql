#les procedures stockées

use vols_202;

drop procedure if exists test1;
delimiter $$
create procedure if not exists test1()
begin
	select * from pilote;
    select * from vol;
    select * from avion;
end $$
delimiter ;

call test1();



drop procedure if exists test2;
delimiter $$
create procedure if not exists test2(id int)
begin
	select * from pilote where numpilote = id;
    select * from vol where numpil = id;
    select * from avion where numav in (select numav from vol where numpil = id);
end $$
delimiter ;

call test2(1);



drop procedure if exists addition;
delimiter $$
create procedure if not exists addition(a int, b int)
begin
	select a+b;
end $$
delimiter ;

call addition(5,3);




drop procedure if exists addition2;
delimiter $$
create procedure if not exists addition2(in a int,in b int)
begin
	select a+b;
end $$
delimiter ;

call addition2(1,3);



drop procedure if exists addition3;
delimiter $$
create procedure if not exists addition3(in a int,in b int, out r int)
begin
	set r = a+b;
end $$
delimiter ;

call addition3(7,3,@result);
select @result;




drop procedure if exists calculs;
delimiter $$
create procedure if not exists calculs(in a float,in b float, op char, out r varchar(50))
begin
	case op
		when "+" then set r = a+b;
		when "x" then set r = a*b;
		when "-" then set r = a-b;
		when "/" then 
			if b=0 then
				set r = 'erreur division par zero';
			else
				set r = a/b;
			end if;   
        when "%" then	set r = a%b;
		else  set r = "erreur";
	end case;
end $$
delimiter ;

call calculs(7,2,'%',@result);
select @result;


drop procedure if exists augmenter_salaire;
delimiter $$
create procedure augmenter_salaire(salaire float, out nev_salaire float)
begin
	set nev_salaire = salaire * 1.2;

end $$
delimiter ;

call augmenter_salaire(10000, @n);
select @n;





drop procedure if exists augmenter_salaire;
delimiter $$
create procedure augmenter_salaire(inout salaire float)
begin
	set salaire = salaire * 1.2;

end $$
delimiter ;

set @salaire = 10000;
call augmenter_salaire(@salaire);
select @salaire;



drop procedure if exists get_nb_vols_by_pilote;
delimiter $$
create procedure get_nb_vols_by_pilote(in id int , out nb int)
begin
	select count(*) into nb from vol where numpil = id;

end $$
delimiter ;

call get_nb_vols_by_pilote(1,@nb);
select @nb;




