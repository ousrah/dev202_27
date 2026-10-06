#EX 1 - Soit la base de données suivante :  (Utilisez celle de la série des fonctions):
#Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
#Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
#Avion(numav,typeav ,capav)


use vols_202;

#1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00:00 ».
alter table pilote add column nbhv time default '00:00:00';
alter table vol modify datea datetime;
alter table vol modify dated datetime;


select * from pilote;

#2 – Ajouter un déclencheur qui calcule le nombre heures lorsqu’on ajoute un nouveau vol
# et qui augmente automatiquement le nb d’heures de vols du pilote qui a effectué le vol.

select * from vol;


drop trigger if exists tr1_q2;
delimiter //
create trigger if not exists tr1_q2 after insert on vol for each row
begin 
		update pilote 
        # set nbhv=nbhv+timediff(new.datea,new.dated)
        set nbhv=addtime(nbhv,timediff(new.datea,new.dated))
        where numpilote=new.numpil;
end//
delimiter ;

update pilote set nbhv = "00:00:00";
insert into vol values (null,'test','test','2026-10-06 08:00:00', '2026-10-06 10:00:00', 1,1);


#3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit 
#être recalculé. Proposez une solution.

drop trigger if exists tr1_q3;
delimiter //
create trigger if not exists tr1_q3 after delete on vol for each row
begin 
		update pilote 
        # set nbhv=nbhv-timediff(old.datea,old.dated)
        set nbhv=subtime(nbhv,timediff(old.datea,old.dated))
        where numpilote=old.numpil;
end//
delimiter ;

select * from vol;
select * from pilote;
delete from vol where numvol = 7;

delete from vol where numpil=1;

#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du
# pilote qui a effectué ce vol doit être recalculé. Proposez une solution.

drop trigger if exists tr1_q4;
delimiter //
create trigger if not exists tr1_q4 after update on vol for each row
begin 
		update pilote 
        set nbhv=subtime(nbhv,timediff(old.datea,old.dated))
        where numpilote=old.numpil;
        
        update pilote 
        set nbhv=addtime(nbhv,timediff(new.datea,new.dated))
        where numpilote=new.numpil;
        
end//
delimiter ;

select * from pilote;
select * from vol;
insert into vol values (null,'test','test','2026-10-06 08:00:00', '2026-10-06 10:00:00', 1,1);
update vol set datea = '2026-10-06 09:00:00' where numvol = 21;



#EX 2 - Soit la base de données suivante :  (Utilisez celle de la série des PS):

#DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
#EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, #ID_DEP)
#1 – Ajouter le champs salaire moyen dans la table département.
use employes_202;
alter table departement add salaire_moyen float default 0;

select * from departement;

#2 – On souhaite que le salaire moyen soit recalculé automatiquement si on ajoute 
#un nouvel employé, on supprime ou on modifie le salaire d’un ou plusieurs employés.
# Proposez une solution.
use employes_202;
drop function if exists get_salaire_moyen;
delimiter $$
create function if not exists get_salaire_moyen(num_dep int)
	returns  float
    deterministic
begin    
 return (select avg(salaire)   from employe where id_dep = num_dep);
end $$
delimiter ;


select get_salaire_moyen(3);

drop trigger if exists tr2_q21;
delimiter //
create trigger if not exists tr2_q21 after insert on employe for each row
begin 
	update departement
    set salaire_moyen = get_salaire_moyen(new.id_dep)
	where id_dep = new.id_dep;
        
end//
delimiter ;

drop trigger if exists tr2_q22;
delimiter //
create trigger if not exists tr2_q22 after delete on employe for each row
begin 
	update departement
    set salaire_moyen = get_salaire_moyen(old.id_dep)
	where id_dep = old.id_dep;
        
end//
delimiter ;
drop trigger if exists tr2_q23;
delimiter //
create trigger if not exists tr2_q23 after update on employe for each row
begin 
	update departement
    set salaire_moyen =  get_salaire_moyen(new.id_dep)
	where id_dep = new.id_dep;
        
end//
delimiter ;


select * from employe;
insert into employe value(null,'test','test','1990-01-01',9000,1);
update employe set salaire = 19000 where id_emp = 9;
delete from employe where id_emp = 9;
select * from departement;





#EX 2 - Soit la base de données suivante : (Utilisez celle de la série des PS):
#Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
#Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
#Composition_Recette (NumRec, NumIng, QteUtilisee)
#Fournisseur (NumFou, RSFou, AdrFou)
#1 – Ajoutez le champ prix à la table recettes.
use cuisine_202;
alter table recettes add prix float ;
update recettes set prix = 0;
select * from recettes;


select ceiling(rand()*22);


#2 – On souhaite que le prix de la recette soit calculé automatiquement si on ajoute 
#un nouvel ingrédient, on supprime un ingrédient ou on modifie la quantité ou 
#le prix d’un ou plusieurs ingrédients. Proposez une solution. 
drop function if  exists get_prix_recette;
delimiter $$
create function if not exists get_prix_recette(id_rec int)
 returns float
 deterministic
 begin
 return (select sum(qteutilisee*puing) from composition_recette join ingredients using(numing) where numrec = id_rec);
 
 end $$
delimiter ;


drop procedure if  exists modifier_prix_recette;
delimiter $$
create procedure if not exists modifier_prix_recette(id_rec int)
 begin
 update recettes set prix = get_prix_recette(id_rec) where numrec = id_rec;

 end $$
delimiter ;



select get_prix_recette(1);


drop trigger if exists ex3_tr1;
delimiter $$
create  trigger if not exists  ex3_tr1 after insert on composition_recette for each row
begin
 call modifier_prix_recette(new.numrec);
end$$
delimiter ;
 
 drop trigger if exists ex3_tr2;
delimiter $$
create  trigger if not exists  ex3_tr2 after delete on composition_recette for each row
begin
 call modifier_prix_recette(old.numrec);
end$$
delimiter ;


 drop trigger if exists ex3_tr3;
delimiter $$
create  trigger if not exists  ex3_tr3 after update on composition_recette for each row
begin
 call modifier_prix_recette(old.numrec);
end$$
delimiter ;



select * from recettes;
select * from composition_recette where numrec = 1;
update composition_recette set qteUtilisee = 2 where numrec = 1 and numing = 1;

select * from ingredients;
insert into composition_recette values (1,3,1);
delete from composition_recette where numing = 3 and numrec = 1;


#il faut programmer un dernier trigger qui se déclanche lorsque le prix de l'ingrédient change
#sauf que on aura besoin d'un curseur pour modifier les prix de chaque recette
#qui utilise l'ingrédient modifié, donc la solution sera repporté après le cours
#des curseurs
