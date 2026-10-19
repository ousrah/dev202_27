#Objectif : Manipuler les curseurs/imbriquer les curseurs


#1 - Terminer la questions 9 du dernier exercice des procedures stockées

#PS9 : Qui affiche pour chaque recette :
#Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
#La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
#Un message sous la forme : Sa méthode de préparation est : (Méthode)
#Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
#'Prix intéressant'


#Base de données ‘Gestion_vols’ :

#EX 2 - Soit la base de données suivante : (Utilisez celle de la série des PS):
#Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
#Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
#Composition_Recette (NumRec, NumIng, QteUtilisee)
#Fournisseur (NumFou, RSFou, AdrFou)
#1 – Ajoutez le champ prix à la table recettes.
#2 – On souhaite que le prix de la recette soit calculé automatiquement si on ajoute un nouvel ingrédient, on supprime un ingrédient ou on modifie la quantité ou le prix d’un ou plusieurs ingrédients. Proposez une solution. 



use cuisine_201;

select ceiling(rand()*22);


drop procedure if exists ps9;
delimiter $$
create procedure if not exists ps9()
begin
   declare id int;
  declare Nr varchar(30) ;
  declare mtd varchar(100);
  declare tmp int;
  declare somme float;
  declare flag boolean default false;
	declare c1 cursor for select  numrec, NomRec,TempsPreparation, methodePreparation from recettes;
    declare continue handler for  not found set flag = true;
	open c1;
    b1: loop
		fetch c1 into id, nr,tmp, mtd ;
        if flag then
			leave b1;
		end if;
        select concat("Recette : ",nr," temps de préparation : ",tmp) as recette;
        select noming , qteutilisee from Ingredients
        join Composition_Recette using (NumIng)
        where numrec = id;
        select concat("Sa methode de préparation est " , mtd) as methode;
        
        
        select sum(puing*qteutilisee) into somme 
        from composition_recette
        join ingredients using (numing)
        where numrec = id ;
        if somme < 50 then
			select 'prix interessant ', somme;
		end if ;
        	
    end loop b1;
    close c1;


end $$
delimiter ;
call ps9();





#2 – Ajouter le trigger qui permet de modifier le prix des recettes  
#lorsqu'on change le prix unitaire d'un ingrédient ( voir le dernier 
#exercice de la série des triggers)

select * from recettes;
alter table recettes add prixtotal float default 0;
select * from ingredients;
select * from composition_recette where numing = 1;



drop trigger if exists trg_prx;
delimiter //
create trigger trg_prx after update on ingredients for each row
begin
	declare flag boolean default false;
	declare num_recette int;
    declare prix_recette float;
	declare c1 cursor for select numrec from composition_recette cr where cr.numing = new.numing;
    declare continue handler for not found set flag = true;
    open c1;
		b1 :loop
			fetch c1 into num_recette;
			if flag then 
				leave b1;
			end if;
            
            select round(sum(PUIng*QteUtilisee),2) into prix_recette 
            from ingredients 
            join composition_recette using(NumIng)
            where NumRec=num_recette;
            
            update recettes
            set prixtotal=prix_recette
            where NumRec=num_recette;
            
		end loop b1;
    close c1;
	
end//
delimiter ;

select round(sum(PUIng*QteUtilisee))
from ingredients 
join composition_recette using(NumIng)
where NumRec=1;

select* from ingredients;
select * from recettes;
update ingredients
set PUIng=4
where NumIng=1;


grant, revoke, ....

#1)	Réalisez un curseur en lecture seule avec déplacement vers l’avant 
#qui extrait la liste des pilotes avec pour informations l’identifiant, 
#le nom et le salaire du pilote ;
#Affichez les informations à l’aide de l’instruction Select (print)

select * from pilote;
alter table pilote add salaire float default 5000;
use vols_202;
drop procedure if exists cur1;
delimiter $$
create procedure if not exists cur1()
begin
	declare nump int;
    declare nomp varchar(50);
    declare salp float;
    declare flag bool default false;
    declare c1 cursor for select numpilote, nom, salaire from pilote;
    declare continue handler for not found set flag = true;
	open c1;
    b1: loop
		fetch c1 into nump, nomp, salp;
        if flag then
			leave b1;
		end if;
        select nump as numero, nomp as nom, salp as salaire;
    end loop b1;
    close c1;
    select "fin du curseur";
end $$
delimiter ;


call cur1();




#2)	Complétez le script précédent en imbriquant un deuxième curseur qui va préciser pour chaque pilote, quels sont les vols effectués par celui-ci.

#Vous imprimerez alors, pour chaque pilote une liste sous la forme suivante :
#- Le pilote ‘ xxxxx xxxxxxxxxxxxxxxxx est affecté aux vols :
#       Départ : xxxx  Arrivée : xxxx
#       Départ : xxxx  Arrivée : xxxx
#       Départ : xxxx  Arrivée : xxxx
#-Le pilote ‘ YYY YYYYYYYY est affecté aux vols :
#       Départ : xxxx  Arrivée : xxxx
#       Départ : xxxx  Arrivée : xxxx



drop procedure if exists cur2;
delimiter $$
create procedure if not exists cur2()
begin
	declare nump int;
    declare nomp varchar(50);
    declare salp float;
    declare flag bool default false;
    declare c1 cursor for select numpilote, nom, salaire from pilote;
    declare continue handler for not found set flag = true;
	open c1;
    b1: loop
		fetch c1 into nump, nomp, salp;
        if flag then
			leave b1;
		end if;
        select concat('le pilote ', nomp, ' est affecté aux vols: ');
        begin
			declare dd, da datetime;
            declare flag2 bool default false;
			declare c2 cursor for select dated, datea from vol where numpil = nump;
            declare continue handler for not found set flag2 = true;
            open c2;
            b2: loop
				fetch c2 into dd,da;
                if flag2 then
					leave b2;
				end if;
				select concat("depart :",dd," -- arrivée :",da	);
            
            end loop b2;
            close c2;
        end;
    end loop b1;
    close c1;
    select "fin du curseur";
end $$
delimiter ;


call cur2();


#3)	Vous allez modifier le curseur précédent pour pouvoir mettre à jour le salaire du pilote. Vous afficherz une ligne supplémentaire à la suite de la liste des vols en précisant l’ancien et le nouveau salaire du pilote.
#Le salaire brut du pilote est fonction du nombre de vols auxquels il est affecté :
#	Si 0 alors le salaire est 5 000
#	Si entre 1 et 3,  salaire de 7 000
#	Plus de 3, salaire de 8000




drop procedure if exists cur3;
delimiter $$
create procedure if not exists cur3()
begin
	declare nump int;
    declare s float;
    declare nomp varchar(50);
    declare salp float;
    declare nb int default 0;
    declare flag bool default false;
    declare c1 cursor for select numpilote, nom, salaire from pilote;
    declare continue handler for not found set flag = true;
	open c1;
    b1: loop
		fetch c1 into nump, nomp, salp;
        if flag then
			leave b1;
		end if;
        select concat('le pilote ', nomp, ' est affecté aux vols: ');
        begin
			
			declare dd, da datetime;
            declare flag2 bool default false;
			declare c2 cursor for select dated, datea from vol where numpil = nump;
            declare continue handler for not found set flag2 = true;
            set nb = 0;
            open c2;
            b2: loop
				fetch c2 into dd,da;
                if flag2 then
					leave b2;
				end if;
				select concat("depart :",dd," -- arrivée :",da	);
                set nb=nb+1;
            end loop b2;
            close c2;
        end;
        set s = 5000;
        if nb>0 then
			if nb<=3 then
				set s = 7000;
			else
				set s = 8000;
			end if;
		end if;
		update pilote set salaire = s where numpilote = nump;
        
        
        
    end loop b1;
    close c1;
    select "fin du curseur";
end $$
delimiter ;

select * from vol where numpil=3;
call cur3();




#Exercice 2
#Soit la base de données suivante
#
#Employé :

#Matricule	nom	prénom	état
#1453	Lemrani	Kamal	fatigué
#4532	Senhaji	sara	En forme
#			…
#			..

#Groupe :
#Matricule	Groupe
#1453	Administrateur
#1453	Chef
#4532	Besoin vacances
#…	

-- Création de la base de données
drop database if exists GestionEmployes_202;
CREATE DATABASE IF NOT EXISTS GestionEmployes_202
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

-- Sélection de la base de données
USE GestionEmployes_202;

-- Création de la table Employe
CREATE TABLE Employe (
    Matricule INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    etat VARCHAR(50) NOT NULL
);

-- Création de la table Groupe
CREATE TABLE Groupe (
    Matricule INT NOT NULL,
    Groupe VARCHAR(100) NOT NULL,

    PRIMARY KEY (Matricule, Groupe),

    FOREIGN KEY (Matricule)
        REFERENCES Employe(Matricule)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- Insertion des employés
INSERT INTO Employe (Matricule, nom, prenom, etat)
VALUES
    (1453, 'Lemrani', 'Kamal', 'fatigué'),
    (4532, 'Senhaji', 'sara', 'En forme');

-- Insertion des groupes
INSERT INTO Groupe (Matricule, Groupe)
VALUES
    (1453, 'Administrateur'),
    (1453, 'Chef'),
    (4532, 'Besoin vacances');
    


#On désire ajouter les employés dont l’état est fatigué dans le groupe ‘besoin vacances’ dans la table Groupe;
#Utiliser un curseur ;


drop procedure if exists cur4;
delimiter $$
create procedure if not exists cur4()
begin
	declare mat int;
    declare flag bool default false;
    declare c1 cursor for select matricule from employe where etat = 'fatigué';
    declare continue handler for not found set flag = true;
	open c1;
    b1: loop
		fetch c1 into mat;
        if flag then
			leave b1;
		end if;
        if not exists (select * from groupe where matricule = mat and groupe = 'besoin vacances') then
			insert into groupe values (mat, 'besoin vacances');
		end if;
    end loop b1;
    close c1;
    select "fin du curseur";
end $$
delimiter ;

select * from groupe;
call cur4();





