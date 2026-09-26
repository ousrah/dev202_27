#Exercice 1 :
#Écrire une fonction qui renvoie une chaine qui sera exprimée sous la forme Jour, Mois 
#et Année à partir d’une date passée comme paramètre où :
#­	Mois est exprimé en toutes lettres
#exemple : décembre 
#Exemple : 2011/09/12 -----> 12 septembre 2011
use courses202;
drop function if exists ex1;
delimiter $$
create function if not exists ex1(d date)
	returns varchar(100)
    deterministic
begin
	declare mois_chaine varchar(100);
    set mois_chaine = case month(d)
		when 1 then "Janvier"
        when 2 then "Fevrier"
        when 3 then "Mars"
        when 4 then "Avril"
        when 5 then "Mai"
        when 6 then "Juin"
        when 7 then "Juillet"
        when 8 then "Aout"
        when 9 then "Septembre"
        when 10 then "Octobre"
        when 11 then "Novembre"
        when 12 then "decembre"
        else "Erreur"
	end;
    if mois_chaine = "Erreur" then
		return "Erreur";
	end if;
    return concat(day(d)," ",mois_chaine,year(d));
end $$
delimiter ;

select ex1('2012/09/12');



drop function if exists ex1;
delimiter $$
create function if not exists ex1(d date)
	returns varchar(100)
    deterministic
begin
	declare old_language varchar(50);
	set old_language = @@lc_time_names;
    set lc_time_names = 'fr_FR';
    return date_format(d,"%d %M %Y");
    set lc_time_names = old_language;
end $$
delimiter ;



select ex1('2012/09/12');

#Exercice 2:
#Ecrire une fonction qui reçoit deux dates comme paramètre et calcule l’écart en 
#fonction de l’unité de calcul passée à la fonction ;
#L’unité de calcul peut être de type : jour, mois, année, heure, minute, seconde

drop function if exists ex2;
delimiter $$
create function if not exists ex2(d1 datetime,d2 datetime, unite varchar(50))
	returns bigint
	deterministic
begin
	declare resultat bigint;
    set resultat=case unite
					when"jour"then timestampdiff(day,d1,d2)
					when"mois"then timestampdiff(month,d1,d2)
					when"année"then timestampdiff(year,d1,d2)
					when"heure"then timestampdiff(hour,d1,d2)
					when"minute"then timestampdiff(minute,d1,d2)
					when"seconde"then timestampdiff(second,d1,d2)
					else "unite unvalid"
				end;
	return resultat;
end$$
delimiter ;


select ex2('2011/01/01','2012/01/01','jour');

#Exercice 3 : application sur la bd ‘gestion_vols’
#Gestion vol
#Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
#Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
#Avion(numav,typeav ,capav)


drop database if exists vols_202;

create database vols_202 collate utf8mb4_general_ci;
use vols_202;

create table Pilote(
					numpilote int auto_increment primary key,
					nom varchar(50) ,
					titre varchar(50) ,
					villepilote varchar(50) ,
					daten date,
					datedebut date);

create table Vol(numvol int auto_increment primary key,
				villed varchar(50) ,
				villea varchar(50) ,
				dated date ,
				datea date , 
				numpil int not null,
				numav int not null);

create table Avion(numav int auto_increment primary key,
					typeav  varchar(50) ,
					capav int);

alter table vol add constraint fk_vol_pilote foreign key(numpil) references pilote(numpilote);
alter table vol add constraint fk_vol_avion foreign key(numav) references avion(numav);


insert into avion values (1,'boeing',350),
						(2,'caravel',50),
                        (3,'airbus',500),
                        (4,'test',350);
                        
insert into pilote values (1,'hassan','M.','tetouan','2000-01-01','2022-01-01'),
						(2,'saida','Mme.','casablanca','1980-01-01','2005-01-01'),
						(3,'youssef','M.','tanger','1983-01-01','2002-01-01');



update pilote set datedebut = '2002-01-01' where numpilote = 2;

insert into vol values (1,'tetouan','casablanca','2023-09-10','2023-09-10',1,1),
						(2,'casablanca','tetouan','2023-09-10','2023-09-10',1,1),
						(3,'tanger','casablanca','2023-09-11','2023-09-11',2,2),
						(4,'casablanca','tanger','2023-09-11','2023-09-11',2,2),
						(5,'agadir','casablanca','2023-09-11','2023-09-11',3,3),
						(6,'casablanca','agadir','2023-09-11','2023-09-11',3,3);


insert into vol values (7,'tetouan','casablanca','2023-09-10','2023-09-12',1,1),
						(8,'casablanca','tetouan','2023-09-10','2023-09-12',1,1),
						(9,'tanger','casablanca','2023-09-11','2023-09-13',1,2),
						(10,'casablanca','tanger','2023-09-11','2023-09-13',1,2),
						(11,'agadir','casablanca','2023-09-11','2023-09-13',3,3),
						(12,'casablanca','agadir','2023-09-11','2023-09-13',3,3),
                        (13,'tetouan','casablanca','2023-09-10','2023-09-15',2,1),
						(14,'casablanca','tetouan','2023-09-10','2023-09-15',3,1);  



select * from vol;



#1.	Ecrire une fonction qui retourne le nombre de pilotes ayant effectué un nombre 
#de vols supérieur à un nombre donné comme paramètre ;
drop function if exists ex3_q1;
delimiter $$
create function if not exists ex3_q1(num int)
	returns bigint
	deterministic
begin
declare res bigint;
set res=(select count(*) from (
							select numpil,count(*) from vol group by numpil
                            having count(*)>num) as pilote
							);
return res;
end $$
delimiter ;
select ex3_q1(2);


drop function if exists ex3_q1;

delimiter $$
create function if not exists ex3_q1(n int)
	returns int
    deterministic
begin
	return(
			with req as (select numpil, count(*) 
			from vol 
			group by numpil
			having count(*)>n)

			select count(*) from req
	);
end $$
delimiter ;

select ex3_q1(2);





drop function if exists ex3_q1;

delimiter $$
create function if not exists ex3_q1(n int)
	returns int
    deterministic
begin
			declare r int;

			with req as (select numpil, count(*) 
			from vol 
			group by numpil
			having count(*)>n)

			select count(*) into r from req;
            
            return r;

end $$
delimiter ;

select ex3_q1(2);




#2.	Ecrire une fonction qui retourne la durée de travail 
#d’un pilote dont l’identifiant est passé comme paramètre ;

drop function if exists ex3_q2;

delimiter $$
create function if not exists ex3_q2(id int)
	returns bigint
    deterministic
begin

	return(select  datediff(curdate(),datedebut) #current_date()  #now()
	from pilote
	where numpilote= id);

end $$
delimiter ;

select ex3_q2(1);




#3.	Ecrire une fonction qui renvoie le nombre des avions qui ne sont pas affectés 
#à des vols ;




drop function if exists ex3_q3;

delimiter $$
create function if not exists ex3_q3()
	returns bigint
    deterministic
begin

	return(select count(*) from (
select * from avion where numav not in (select numav from vol)) req);

end $$
delimiter ;


select ex3_q3();

#4.	Ecrire une fonction qui retourne le numero du plus ancien pilote qui a piloté 
#l’avion dont le numero est passé en paramètre ;

drop function if exists ex3_q4;

delimiter $$
create function if not exists ex3_q4(av int)
	returns bigint
    deterministic
begin
return(

		select numpilote from (
								select distinct numpilote, datedebut 
								from vol v join pilote p on v.numpil = p.numpilote 
								where numav = av
								order by datedebut asc
								limit 1) req
        )
;

end $$
delimiter ;
select ex3_q4(1);


#5.	Ecrire une fonction table qui retourne le nombre des pilotes dont le salaire 
#est inférieur à une valeur passée comme paramètre ;

# on ne peut pas créer une fonction table sous mysql il ne supporte que les fonctions scalaires

alter table pilote add salaire decimal(8,2);
update pilote set salaire = 18000 where numpilote = 1;
update pilote set salaire = 28000 where numpilote = 2;
update pilote set salaire = 38000 where numpilote = 3;
select * from pilote;


select count(*) from pilote where salaire>18000;
drop function if exists ex3_q5;
delimiter $$
create function if not exists ex3_q5(seuil int)
	returns int
    deterministic
begin
	return(
		select count(*) from pilote where salaire<seuil
        );
end $$
delimiter ;
select ex3_q5(56000);




#Exercice 4:
#Considérant la base de données suivante :
#DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
#EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE,#ID_DEP)

#1.	Créer une fonction qui retourne le nombre d’employés


#2.	Créer une fonction qui retourne la somme des salaires de tous les employés


#3.	Créer une fonction pour retourner le salaire minimum de tous les employés


#4.	Créer une fonction pour retourner le salaire maximum de tous les employés


#5.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher 
#le nombre des employés, la somme des salaires, le salaire minimum et le salaire maximum


#6.	Créer une fonction pour retourner le nombre d’employés d’un département donné.


#7.	Créer une fonction la somme des salaires des employés d’un département donné


#8.	Créer une fonction pour retourner le salaire minimum des employés d’un département donné


#9.	Créer une fonction pour retourner le salaire maximum des employés d’un département.


#10.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher 
#pour les éléments suivants : 
#a.	Le nom de département en majuscule. 
#b.	La somme des salaires du département
#c.	Le salaire minimum
#d.	Le salaire maximum


#11.	Créer une fonction qui accepte comme paramètres 2 chaines de caractères 
#et elle retourne les deux chaines en majuscules concaténé avec un espace entre eux.


