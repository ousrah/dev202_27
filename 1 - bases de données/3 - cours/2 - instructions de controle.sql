#La programmation procedurale sous my sql


#les instructions de controle

drop function if exists hello;
delimiter $$
create function if not exists hello()
	returns varchar(100)
    deterministic
begin
	return concat("hello world");
end$$
delimiter ;

#fonction avec un paramétre
drop function if exists helloN;
delimiter $$
create function if not exists helloN(name varchar(50))
	returns varchar(100)
    deterministic
begin
	return concat("hello ",name);
end$$
delimiter ;

select helloN('youssef');
    
    
    
#la declration et l'affecation    
 
 
 
 
 
drop function if exists hello;
delimiter $$
create function if not exists hello(first_name varchar(50), last_name varchar(50))
	returns varchar(100)
    deterministic
begin
	declare full_name varchar(50);
    set full_name = concat(first_name, " ", last_name);
	return concat("hello ",full_name);
end$$
delimiter ;

select hello('youssef','qlq');


drop function if exists addition;
delimiter $$
create function addition(a int, b int)
	returns int
    deterministic
begin
	declare c int;
    #set c = a+b;
    select a+b into c;
    return c;
end $$
delimiter ;

  select addition(3,5); 
 
declare a int;


drop function if exists get_nb_of_horses;
delimiter $$
create function if not exists get_nb_of_horses()
	returns int
    deterministic
begin
	declare nb int;
    #set nb = (select count(*) from cheval);
    select count(*) into nb from cheval;
    return nb;
end$$
delimiter ;


select get_nb_of_horses();
select count(*) from cheval;


drop function if exists division;
delimiter $$
create function if not exists division(a int, b int)
	returns varchar(100)
    deterministic
begin
	declare r varchar(100);
    if b=0 then
		set r = 'impossible';
	else
		set r = a/b;
	end if;
    return round(r,2);
end$$
delimiter ;

select division(5,3);


drop function if exists comparaison;
delimiter $$
create function if not exists comparaison(a int, b int)
	returns varchar(100)
    deterministic
begin
    if (a>b) then
		return('a est la plus grande');
	elseif (b>a) then
		return('b est la plus grande');
	else
		return('a et b sont egaux');
	end if;
   
end$$
delimiter ;

select comparaison (50,50);


drop function if exists comparaison;
delimiter $$
create function if not exists comparaison(a int, b int, c int)
	returns varchar(100)
    deterministic
begin
     if (a>b and a>c) then
		return ('a est la plus grand');
     elseif (b>a and b>c) then
		return ('b est la plus grand');
     elseif (c>a and c>b) then
		return ('c est la plus grand');
     else
		return (' a , b est c sont egaux');
     end if;
end$$  
delimiter ;
select comparaison(20000,8000,4005);



drop function if exists comparaison;
delimiter $$
create function if not exists comparaison(a int, b int, c int)
	returns varchar(100)
    deterministic
begin
     if a>b then
		if a>c then
			return ('a est la plus grand');
		else
			return ('c est la plus grand');
		end if;
    else     
		if b>c then
			return ('b est la plus grand');
		else
			return ('c est la plus grand');
		end if;
     end if;
end$$  
delimiter ;
select comparaison(2,18,14);




drop function if exists comparaison;
delimiter $$
create function if not exists comparaison(a int, b int, c int)
	returns varchar(100)
    deterministic
begin
	declare max int;
    set max = a;
    if b>max then 
		set max=b;
	end if;
    if c>max then 
		set max=c;
	end if;
    return concat(max,' est la plus grande valeur');
    
end$$  
delimiter ;
select comparaison(200,18,140);




#exercice 1
#ecrire un algorithme qui permet de resoudre une euqation de premier degrès
8x+0= 0

si A = 0 et B = 0 alors  x = l''ensemble R
si A = 0 et B <> 0 alors x = impossible
si A <> 0 alors x = -B/A






#exercice 2
#ecrire un algorithme qui permet de resoudre une euqation de deuxième degrès
0x²+5x+C = 0 
A=0, B=0, C= 0  x = R
A=0, B=0,C<>0   x=impossible
A=0, B<> 0      x = -C/B
A<>0
	delta = (B*B) - (4*A*C) 
    si delta >0 alors x1=(-B-racine(delta))/(2*A)  x2=(-B+racine(delta))/(2*A) 
    si delta = 0 alors x1=x2= -B/(2*A)
    si delta <0 alors impossible dans R
    
    
select pow(5,3);    
select sqrt(25);


#exercice 3
#un patron decide de participer aux prix de repas de ces employés
#il instaure les règles suivantes
# pour chaque employé on contribu de 20% de son prix de repars
#si il est marié il aura 25% au lieu de 20%
# pour chaque enfant il va avoir 10% avec un plafond de 50%
# si il a un salaire inférieur à 3000 dh il aura un surplus de 10%




