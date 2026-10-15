#La gestion des exceptions

drop database if exists commerce_202;
create database commerce_202 collate utf8mb4_general_ci;
use commerce_202;

create table produit(
	id_produit int auto_increment primary key,
	nom varchar(100),
	prix double,
	check (prix>0));


drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	insert into produit  values (null,name, price);
end $$
delimiter ;

call add_product('pc',8000);
call add_product('imprimante',-100); #erreur liée a la règle de valdation prix>0
select * from produit;


#on va ajouter une gestion d''exception générale (sqlexception)
drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare exit handler for sqlexception select "erreur d'insertion" as 'erreur';

	insert into produit  values (null,name, price);
    select "insertion effectuée avec succues" as 'succes';
end $$
delimiter ;

call add_product('clavier',80);
call add_product('imprimante',-100); #erreur liée a la règle de valdation prix>0
select * from produit;

#on va ajouter deux autres règle de validation dans la table produit;
alter table produit modify nom varchar(100) not null unique;

call add_product('souris',50);
call add_product('souris',150); #erreur d'insertion parceque le nom est en double
call add_product(null,150); #erreur d'insertion parceque le nom est null
call add_product('imprimante',-100); #erreur d'inserction parceque le prix est inférieur à zero


#on va provoquer les erreur et noter les codes d'erreur pour les traiter par la suite un par un
drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	insert into produit  values (null,name, price);
end $$
delimiter ;
select * from produit;
call add_product('table',500); #success
call add_product('souris',150); #1062
call add_product(null,150); #1048
call add_product('imprimante',-100); #3819



drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare msg varchar(100) default '';
    
    begin
		declare exit handler for 1062 set msg = "ce produit existe deja";
		declare exit handler for 1048 set msg = "le nom du produit ne peut pas être null";
		declare exit handler for 3819 set msg = "le prix du produit ne peut pas être négatif";
		insert into produit  values (null,name, price);
	end;
    if msg != '' then
		select msg as 'erreur';
	else
        select "insertion effectuée avec succues" as 'succes';
	end if;
end $$
delimiter ;




drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
		declare exit handler for 1062 select "ce produit existe deja";
		declare exit handler for 1048 select "le nom du produit ne peut pas être null";
		declare exit handler for 3819 select "le prix du produit ne peut pas être négatif";
		insert into produit  values (null,name, price);
		select "isertion effectuée avec succes";
end $$
delimiter ;


call add_product('fauteuil',1500); #success
call add_product('souris',150); #1062
call add_product(null,150); #1048
call add_product('imprimante',-100); #3819
select * from produit;
#si on souhaite lever l''erreur sans quitter la procedure


drop procedure if exists add_product;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare flag boolean default false;
    begin
		declare exit handler for sqlexception 	set flag = true;

        insert into produit values (null, name, price);
	end;
    if flag then  # true=true  is true
		select "erreur d'insertion" as "erreur";
    else
		select "insertion effecutée avec succes" as "success";
    end if;
end $$
delimiter ;
call add_product('armoire',1500); #success
call add_product('souris',150); #1062
call add_product(null,150); #1048
call add_product('imprimante',-100); #3819

# on va lever l''erreur et capturer son numero, son message et son sql_state (etat sql)


drop procedure if exists add_product;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare flag boolean default false;
    declare numero_erreur int;
    declare message_original varchar(255);
    declare sql_etat varchar(5);
    begin
		declare exit handler for sqlexception
        begin
			get diagnostics condition 1	
				numero_erreur = mysql_errno, 
				message_original = message_text,
				sql_etat = returned_sqlstate;
			set flag = true;
		end;
		insert into produit values (null, name, price);
	end;
    if flag then
		select concat(" le numero d'erreur est ", numero_erreur, " - l'etat sql est " , sql_etat, " le message original est " , message_original) as "erreur";
    else
		select "insertion effecutée avec succes" as "success";
    end if;
end $$
delimiter ;


select * from test;


select * from produit;

call add_product('souris',150); #1062  #sqlstate = 23000
call add_product(null,150); #1048   #sqlstate = 23000
call add_product('imprimante',-100); #3819  #sqlstate = HY000





# on va lever l''erreur de type sql state 23000
# liste des codes d''erreurs pour mysql
# https://www.briandunning.com/error-codes/?source=MySQL

drop procedure if exists add_product;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare code int default 0;
    begin
		declare exit handler for sqlstate '23000' set code=1;
        declare exit handler for sqlstate 'HY000' set code=2;
		insert into produit values (null, name, price);
	end;

    case code
		when 0 then select "insertion effecutée avec succes" as "success";
		when 1 then select "erreur d'insertion , soit le produit existe ou son nom est null";
		when 2 then select "le prix ne peu pas être négatif";
    end case;
    
		

end $$
delimiter ;

select * from produit;
call add_product('scanner',1500); #sql state 23000
call add_product(null,150); #sql state 23000
call add_product('imprimante',-100); #le programme se plante parceque le sqlstate de cette erreur est "HY000"


drop procedure if exists get_product;
delimiter $$
create procedure get_product(id int, out name varchar(100))
begin
	declare exit handler for not found select "produit introuvable";
	select nom into name from produit where id_produit = id;
    select "produit trouvé";
end $$
delimiter ;
select * from produit;
call get_product(4,@n);
select @n;

#Exception de type not found

select * from produit where id_produit = 4;

call get_product(4,@n);
select @n;



drop procedure if exists affecter_note;
delimiter $$
create procedure affecter_note(a int)
begin
	declare r  int;
  	declare erreur_affectation condition for sqlstate '11111';
	declare exit handler for erreur_affectation resignal set message_text = "la note doit être entre zero et 20";
	if a<0 or a>20 then
		signal erreur_affectation;
	end if;
	set r = a;
    select r;
end $$
delimiter ;

call affecter_note (10);


drop procedure if exists diviser;
delimiter $$
create procedure diviser(a int, b int, out r double)
begin
	declare erreur_division condition for sqlstate '11111';

  
		declare exit handler for erreur_division resignal set message_text = "problème de division par zero";
		if b=0 then
			signal erreur_division;
		end if;

		set r = a/b;

end $$
delimiter ;


call diviser(100,5,@r);
select @r;

