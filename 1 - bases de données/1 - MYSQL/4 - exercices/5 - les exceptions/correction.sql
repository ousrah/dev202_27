#Exercice 1 : Gestion simple d'une erreur (Procédure stockée + SQLEXCEPTION)
#Objectif : Créer une procédure qui tente d'insérer un utilisateur. 
#Si une erreur se produit (par exemple, un doublon sur la clé primaire 
#ou un champ obligatoire manquant), on intercepte l'exception via 
#SQLEXCEPTION pour éviter le plantage et renvoyer un message personnalisé.
#Instructions :
#1.	Créez une table utilisateurs avec un identifiant (id INT PRIMARY KEY) 
#et un nom (nom VARCHAR(50) NOT NULL).
#2.	Écrivez une procédure stockée ajouter_utilisateur
#(IN p_id INT, IN p_nom VARCHAR(50)) qui insère une ligne.
#3.	Utilisez un gestionnaire d'erreur
# (DECLARE CONTINUE HANDLER FOR SQLEXCEPTION) pour capturer 
# l'erreur et positionner un message ou une variable d'état.
drop database if exists utilisateurs_202;
create database utilisateurs_202 collate utf8mb4_general_ci;
use utilisateurs_202;

create table utilisateur(id int auto_increment primary key, nom varchar(50));


drop procedure if exists ajouter_utilisateur;
delimiter $$
create procedure if not exists ajouter_utilisateur(IN p_id INT, IN p_nom VARCHAR(50))
begin
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION select 'erreur';
	insert utilisateur values(p_id,p_nom);
end $$
delimiter ;
select * from utilisateur;
call  ajouter_utilisateur(3, 'hhh');
 

#Exercice 2 : Gestion de données introuvables ou erreur de calcul 
#(Procédure + NOT FOUND)
#Objectif : Utiliser le gestionnaire NOT FOUND pour intercepter le cas où une requête de sélection (SELECT ... INTO) ne retourne aucune ligne.
#Instructions :
#1.	Utilisez la table utilisateurs précédente.
#2.	Écrivez une procédure stockée recuperer_nom(IN p_id INT) qui 
#cherche le nom d'un utilisateur grâce à son ID et le stocke dans 
#une variable locale avec SELECT ... INTO.
#3.	Utilisez DECLARE   HANDLER FOR NOT FOUND pour afficher 
#un message propre si l'ID recherché n'existe pas dans la table.#


drop procedure if exists recuperer_nom;
delimiter $$
create procedure if not exists recuperer_nom(p_id INT)
begin
	
    declare utilisateur_trouve varchar(25);
    declare exit handler for not found select "utilisateur non trouvé" as message;
    select nom into utilisateur_trouve from utilisateur where id=p_id;
    select utilisateur_trouve;
    
end $$
delimiter ;
call recuperer_nom(3);
call recuperer_nom(99);


#Exercice 3 : Utilisation de SQLSTATE spécifique (Procédure stockée + SQLSTATE)
#Objectif : Gérer spécifiquement une erreur de type clé dupliquée 
#(dont le code SQLSTATE standard est '23000') en plus d'une gestion 
#générale des autres erreurs.
#Instructions :
#1.	En reprenant la table utilisateurs, écrivez une procédure 
#stockée inserer_securise(IN p_id INT, IN p_nom VARCHAR(50)).
#2.	Déclarez un gestionnaire spécifique pour le SQLSTATE '23000' 
#(Violation de contrainte d'intégrité / doublon).
#3.	Déclarez un second gestionnaire pour toutes les autres SQLEXCEPTION.



drop procedure if exists inserer_securise;
delimiter $$
create procedure if not exists inserer_securise(IN p_id INT, IN p_nom VARCHAR(50))
begin
	declare exit handler for sqlstate '23000' select "Violation de contrainte d'intégrité / doublon";
    declare exit handler for sqlexception select "erreur d'insertion";
    insert into utilisateur values(p_id,p_nom);
    select "insertion effectuée avec succes";
end $$
delimiter ;
call inserer_securise(11,"zaid");

#Exercice 4 : Remontée d'erreur personnalisée avec SIGNAL (Trigger + SIGNAL)
#Objectif : Empêcher l'insertion d'un employé dont le salaire est négatif ou égal à zéro en déclenchant une erreur explicite à l'aide de l'instruction SIGNAL.
#Instructions :
#1.	Créez une table employes avec un champ salaire DECIMAL(10,2).
#2.	Créez un trigger avant_insertion_employe sur les opérations 
#BEFORE INSERT de la table employes.
#3.	Si le salaire inséré est inférieur ou égale à  0 , utilisez 
#SIGNAL SQLSTATE '45000' avec un message explicite (MESSAGE_TEXT) 
#pour bloquer l'insertion.

create table employes (id int auto_increment primary key, nom varchar(50),salaire float);


drop trigger if exists avant_insertion_employe;
delimiter $$
create trigger  if not exists avant_insertion_employe  before insert on employes    for each row
begin
	if new.salaire<=0 then
		SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT='le salaire doit etre >0';
	end if;
end $$
delimiter ;


insert into employes values (1,'test',100);
select * from employes;
insert into employes values (1,'test',-100);




#Exercice 5 : Extraction des détails de l'erreur avec GET DIAGNOSTICS 
#(Procédure + DIAGNOSTICS)
#Objectif : Capturer une erreur, puis utiliser la clause GET DIAGNOSTICS pour récupérer des informations précises sur l'erreur (le code d'erreur MySQL et le texte exact de l'erreur) afin de les afficher proprement.
#Instructions :
#1.	Écrivez une procédure stockée tester_diagnostics(IN p_id INT,
# IN p_nom VARCHAR(50)) qui tente d'insérer dans la table utilisateurs.
#2.	En cas de SQLEXCEPTION, capturez l'erreur.
#3.	À l'intérieur du gestionnaire d'erreur, utilisez GET DIAGNOSTICS 
#pour extraire le message (MESSAGE_TEXT) et l'état (MYSQL_ERRNO),
# puis affichez-les.

drop procedure if exists tester_diagnostics;
delimiter $$
create procedure if not exists tester_diagnostics(IN p_id INT, IN p_nom VARCHAR(50))
begin
	declare flag boolean  default false;
    declare num_err int;
    declare msg varchar(20);
    declare state varchar(5);
    begin
		declare exit handler for sqlexception
        begin
			get diagnostics condition 1
				 num_err= mysql_errno,
				 msg= message_text,
				 state=returned_sqlstate;
			set flag=true;
		end;
		insert into utilisateur value (p_id,p_nom,0);
    end;
	
    if flag then 
		select num_err as code, msg as message, state as `sqlstate`;
	else
		select "reussi";
	end if;
    

end $$
delimiter ;
call tester_diagnostics(19,"zaid");





