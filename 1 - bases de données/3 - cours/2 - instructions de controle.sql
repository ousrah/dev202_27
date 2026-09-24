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


drop function if exists resoudre_1er;
delimiter $$
create function if not exists resoudre_1er(a float, b float)
	returns varchar(100)
    deterministic
begin
    if a=0 then 
		if b=0 then 
			return ("x = l''ensemble R");
		else
			return ("x = impossible");
		end if;
	else
		return (concat("x =",-b/a));
	end if;
end$$  
delimiter ;
select resoudre_1er(0,0);
select resoudre_1er(2,5);
select resoudre_1er(0,5);



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
    

drop function if exists resoudre_2eme;
delimiter $$
create function if not exists resoudre_2eme(a float, b float,c float)
	returns varchar(100)
    deterministic
begin
	declare delta float;

    if a=0 then 
		if b=0 then 
			if c=0 then 
				return ("x = l''ensemble R");
			else
				return ("x = impossible");
			end if;
		else
			return (concat("x =",-c/b));
		end if;
	else
        set delta= pow(b,2) - (4*a*c);
		if delta >0 then
			return concat("x1=",(-b-sqrt(delta))/(2*a)," x2=",(-b+sqrt(delta))/(2*a));
		elseif delta=0 then
			return concat("x1=x2=",-b/(2*a));
		else
			return ("x = impossible dans R");
		end if;
    end if;
end$$  
delimiter ;
select resoudre_2eme(0,0,0);
select resoudre_2eme(0,0,1);
select resoudre_2eme(0,1,2);
select resoudre_2eme(1,4,4); #delta=0
select resoudre_2eme(1,6,4); #delta>0
select resoudre_2eme(1,2,4); #delta<0



#exercice 3
#un patron decide de participer aux prix de repas de ces employés
#il instaure les règles suivantes


drop function if exists repas;
delimiter $$
create function if not exists repas(prix float, est_marié boolean, nb_enfant int, salaire float)
	returns varchar(255)
    deterministic
begin
	declare pourcentage int;
    
	# pour chaque employé on contribu de 20% de son prix de repars
    set pourcentage= 20;
    
	#si il est marié il aura 25% au lieu de 20%
    if est_marie then
		set pourcentage= 25;
	end if;
    
	# pour chaque enfant il va avoir 10%
    set pourcentage= pourcentage + nb_enfant*10;
    
    # avec un plafond de 50%
    if pourcentage>50 then
		set pourcentage=50;
	end if;
    
	# si il a un salaire inférieur à 3000 dh il aura un surplus de 10%
    if salaire<3000 then 
		set pourcentage= pourcentage + 10;
	end if;
	
    return concat("le montant de la participation du patron est ", round((prix*pourcentage)/100,2)," dh");
end$$  
delimiter ;


select repas(100,false,0,2000);
select repas(100,false,0,5000);
select repas(100,true,0,2000);
select repas(100,true,2,8000);
select repas(100,true,2,2000);
select repas(100,true,12,2000);
select repas(100,true,12,12000);


#exercice : on souhaite developper un fonction qui reçoit 
#le numero du jour et affiche son nom
#exemple select nom_jour(1) --->  dimanche
#exemple select nom_jour(7) --->  samedi
#exemple select nom_jour(8) --->  erreur

drop function if exists nom_du_jour;
delimiter $$
create function if not exists nom_du_jour(numjour int)
	returns varchar(255)
    deterministic
begin
	declare nomjour varchar(55);
    set nomjour="erreur";
		if 	   numjour=1 then 		set nomjour="Dimanche";
		elseif numjour=2 then	set nomjour="Lundi";
		elseif numjour=3 then	set nomjour="Mardi";
		elseif numjour=4 then	set nomjour="Mercredi";
		elseif numjour=5 then	set nomjour="Jeudi";
		elseif numjour=6 then	set nomjour="Vendredi";
		elseif numjour=7 then	set nomjour="Samedi";
	end if;
    return nomjour;
end$$  
delimiter ;

select nom_du_jour(7);
select nom_du_jour(1);
select nom_du_jour(8);




drop function if exists nom_du_jour;
delimiter $$
create function if not exists nom_du_jour(numjour int)
	returns varchar(255)
    deterministic
begin
	declare nomjour varchar(55);
    
    case
		when numjour=1 then set nomjour="Dimanche";
		when numjour=2 then	set nomjour="Lundi";
		when numjour=3 then	set nomjour="Mardi";
		when numjour=4 then	set nomjour="Mercredi";
		when numjour=5 then	set nomjour="Jeudi";
		when numjour=6 then	set nomjour="Vendredi";
		when numjour=7 then	set nomjour="Samedi";
        else
			set nomjour="erreur";
	end case;
    return nomjour;
end$$  
delimiter ;


select nom_du_jour(7);
select nom_du_jour(1);
select nom_du_jour(8);





drop function if exists nom_du_jour;
delimiter $$
create function if not exists nom_du_jour(numjour int)
	returns varchar(255)
    deterministic
begin
	declare nomjour varchar(55);
    set nomjour= case numjour
					when 1 then "Dimanche"
					when 2 then	"Lundi"
					when 3 then	"Mardi"
					when 4 then	"Mercredi"
					when 5 then	"Jeudi"
					when 6 then	"Vendredi"
					when 7 then	"Samedi"
					else		"erreur"
				end;
    return nomjour;
end$$  
delimiter ;


select nom_du_jour(7);
select nom_du_jour(1);
select nom_du_jour(8);




# exercice : ecrire une fonction qui récupère une note et qui affiche 
#sa mention
# en respectant les valeurs suivantes
# si note < 5 très faible
# si note entre 5 et <9 faible
# si note entre 9 et <10 insuffisant
# si note entre 10 et <12 passable
# si note entre 12 et <14 assez bien
# si note entre 14 et <16 bien
# si note entre 16 et <18 très bien
# si note entre 18 et <=20 excellent
# si note non inclus entre 0 et 20 erreur

