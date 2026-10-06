drop database if exists cc1_v2;
create database cc1_v2 collate utf8mb4_general_ci;
use cc1_v2;

-- ==========================
-- SUPPRESSION DES TABLES SI EXISTENT
-- ==========================
DROP TABLE IF EXISTS INCIDENT;
DROP TABLE IF EXISTS MAINTENANCE;
DROP TABLE IF EXISTS TOURNEE;
DROP TABLE IF EXISTS VEHICULE;
DROP TABLE IF EXISTS CHAUFFEUR;
DROP TABLE IF EXISTS REGION;

-- ==========================
-- CREATION DES TABLES
-- ==========================

CREATE TABLE REGION (
  id_region INT AUTO_INCREMENT PRIMARY KEY,
  nom_region VARCHAR(100) NOT NULL
);

CREATE TABLE CHAUFFEUR (
  id_chauffeur INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  numero_permis VARCHAR(50) UNIQUE NOT NULL,
  date_embauche DATE NOT NULL
);

CREATE TABLE VEHICULE (
  immatriculation VARCHAR(20) PRIMARY KEY,
  modele VARCHAR(100) NOT NULL,
  type_vehicule VARCHAR(50) NOT NULL,
  kilometrage_total INT DEFAULT 0,
  statut varchar(50) DEFAULT 'Disponible',
  id_region_base INT,
  FOREIGN KEY (id_region_base) REFERENCES REGION(id_region)
);

CREATE TABLE TOURNEE (
  id_tournee INT AUTO_INCREMENT PRIMARY KEY,
  date_tournee DATE NOT NULL,
  kilometrage_estime INT,
  statut varchar(50)  DEFAULT 'Planifiée',
  id_chauffeur INT,
  immatriculation VARCHAR(20),
  FOREIGN KEY (id_chauffeur) REFERENCES CHAUFFEUR(id_chauffeur),
  FOREIGN KEY (immatriculation) REFERENCES VEHICULE(immatriculation)
);

CREATE TABLE MAINTENANCE (
  id_maintenance INT AUTO_INCREMENT PRIMARY KEY,
  date_debut DATE NOT NULL,
  date_fin_prevue DATE,
  description TEXT,
  cout DECIMAL(10,2),
  immatriculation VARCHAR(20),
  FOREIGN KEY (immatriculation) REFERENCES VEHICULE(immatriculation)
);

CREATE TABLE INCIDENT (
  id_incident INT AUTO_INCREMENT PRIMARY KEY,
  date_incident DATE NOT NULL,
  description TEXT,
  cout_reparation DECIMAL(10,2),
  id_tournee INT,
  FOREIGN KEY (id_tournee) REFERENCES TOURNEE(id_tournee)
);

-- ==========================
-- INSERTIONS DE DONNÉES
-- ==========================

INSERT INTO REGION (nom_region) VALUES
('Casablanca-Settat'),
('Rabat-Salé-Kénitra'),
('Fès-Meknès'),
('Tanger-Tétouan-Al Hoceima'),
('Marrakech-Safi'),
('Souss-Massa'),
('Oriental'),
('Béni Mellal-Khénifra'),
('Drâa-Tafilalet'),
('Laâyoune-Sakia El Hamra');

INSERT INTO CHAUFFEUR (nom, prenom, numero_permis, date_embauche) VALUES
('El Mansouri', 'Youssef', 'PERM12345', '2018-03-12'),
('Benali', 'Omar', 'PERM23456', '2019-07-20'),
('Zerouali', 'Hicham', 'PERM34567', '2020-01-15'),
('Tazi', 'Abdelkader', 'PERM45678', '2017-09-01'),
('Bennani', 'Rachid', 'PERM56789', '2021-04-11'),
('Lahlou', 'Mohamed', 'PERM67890', '2016-12-05'),
('Bensaid', 'Hamza', 'PERM78901', '2022-02-10'),
('Haddad', 'Karim', 'PERM89012', '2015-06-19'),
('El Fassi', 'Nabil', 'PERM90123', '2020-10-22'),
('Ouahbi', 'Ismail', 'PERM01234', '2019-01-05');

INSERT INTO VEHICULE (immatriculation, modele, type_vehicule, kilometrage_total, statut, id_region_base) VALUES
('A1111-1', 'Renault Kangoo', 'Fourgon', 150000, 'Disponible', 1),
('A2222-2', 'Peugeot Boxer', 'Camion', 230000, 'En tournée', 2),
('A3333-3', 'Mercedes Sprinter', 'Camion', 185000, 'Disponible', 3),
('A4444-4', 'Citroen Berlingo', 'Fourgon', 125000, 'En maintenance', 4),
('A5555-5', 'Dacia Dokker', 'Fourgon', 98000, 'Disponible', 5),
('A6666-6', 'Iveco Daily', 'Camion', 210000, 'Hors service', 6),
('A7777-7', 'Toyota Hilux', 'Pickup', 162000, 'Disponible', 7),
('A8888-8', 'Fiat Ducato', 'Camion', 245000, 'Disponible', 8),
('A9999-9', 'Ford Transit', 'Fourgon', 190000, 'En tournée', 9),
('B1010-1', 'Volkswagen Caddy', 'Fourgon', 87000, 'Disponible', 10);

INSERT INTO TOURNEE (date_tournee, kilometrage_estime, statut, id_chauffeur, immatriculation) VALUES
('2024-04-01', 300, 'Terminée', 1, 'A1111-1'),
('2024-04-03', 450, 'Terminée', 2, 'A2222-2'),
('2024-04-05', 200, 'Planifiée', 3, 'A3333-3'),
('2024-04-07', 320, 'En cours', 4, 'A4444-4'),
('2024-04-10', 280, 'Terminée', 5, 'A5555-5'),
('2024-04-12', 500, 'Terminée', 6, 'A6666-6'),
('2024-04-15', 350, 'Planifiée', 7, 'A7777-7'),
('2024-04-18', 410, 'Terminée', 8, 'A8888-8'),
('2024-04-20', 390, 'En cours', 9, 'A9999-9'),
('2024-04-22', 250, 'Planifiée', 10, 'B1010-1');

INSERT INTO MAINTENANCE (date_debut, date_fin_prevue, description, cout, immatriculation) VALUES
('2024-02-10', '2024-02-20', 'Vidange + freins', 1200.00, 'A1111-1'),
('2024-03-01', '2024-03-10', 'Changement d’embrayage', 4500.00, 'A2222-2'),
('2024-03-15', '2024-03-18', 'Révision moteur', 8000.00, 'A3333-3'),
('2024-03-22', '2024-03-25', 'Carrosserie', 2200.00, 'A4444-4'),
('2024-04-01', '2024-04-05', 'Remplacement pneus', 1600.00, 'A5555-5'),
('2024-04-08', '2024-04-12', 'Système de freinage', 2300.00, 'A6666-6'),
('2024-04-15', '2024-04-20', 'Vidange complète', 900.00, 'A7777-7'),
('2024-04-20', '2024-04-25', 'Réparation moteur', 9500.00, 'A8888-8'),
('2024-05-01', '2024-05-07', 'Révision générale', 5000.00, 'A9999-9'),
('2024-05-05', '2024-05-10', 'Entretien périodique', 1200.00, 'B1010-1');

INSERT INTO INCIDENT (date_incident, description, cout_reparation, id_tournee) VALUES
('2024-04-01', 'Pneu crevé sur autoroute', 300.00, 1),
('2024-04-03', 'Petite collision à un rond-point', 1200.00, 2),
('2024-04-07', 'Problème de batterie', 400.00, 4),
('2024-04-10', 'Casse du rétroviseur', 250.00, 5),
('2024-04-12', 'Fuite d’huile détectée', 700.00, 6),
('2024-04-15', 'Accrochage léger', 950.00, 7),
('2024-04-18', 'Panne de frein', 2500.00, 8),
('2024-04-20', 'Feu arrière cassé', 150.00, 9),
('2024-04-22', 'Problème moteur mineur', 1800.00, 10),
('2024-04-25', 'Crevaison multiple', 600.00, 3);


#Fonctions :

#1.	Créez une fonction nommée CalculerAncienneteChauffeur qui prend en paramètre un
# id_chauffeur et retourne le nombre d'années complètes depuis sa date d'embauche.
# (2 points)
 

 drop function if exists CalculerAncienneteChauffeur;
delimiter $$
create function CalculerAncienneteChauffeur(id_c int)
returns int
deterministic
begin
	declare anciennete int;
	select timestampdiff(year,date_embauche, curdate()) into anciennete from chauffeur where id_chauffeur=id_c;
	return anciennete;
end$$
delimiter ;
 
 select CalculerAncienneteChauffeur(2);
#2.	Créez une fonction ChauffeurPlusDeTournees qui accepte en paramètres un 
#id_region et une annee. Elle doit retourner l'identifiant (id_chauffeur) du 
#chauffeur ayant effectué le plus de tournées pour des véhicules basés dans cette 
#région durant l'année spécifiée. (2 points)
update vehicule set id_region_base = 1;


drop function if exists ChauffeurPlusDeTournees;
delimiter $$
create function ChauffeurPlusDeTournees(id_r int, annee int)
returns int
deterministic
begin
	declare id_c int;

	select  id_chauffeur into id_c from 
	tournee  join vehicule using(immatriculation)
	where year(date_tournee) = annee
	and id_region_base = id_r
	group by id_chauffeur
	order by count(*) desc
	limit 1 ;	
    
	return id_c;
end$$
delimiter ;




#Procédures stockées :

#3.	Élaborez une procédure stockée PlanifierMaintenance qui prend en paramètres 
#l'immatriculation d'un véhicule, une date de début, une description et une date de
# fin prévue. La procédure doit insérer une nouvelle entrée dans la table MAINTENANCE 
# et mettre à jour le statut du véhicule à 'En maintenance' pour le rendre indisponible.
# (2 points)
 
 
 
 drop procedure if exists PlanifierMaintenance;
 delimiter $$
 create procedure PlanifierMaintenance(imm varchar(50), dd date,des text,df date)
 begin
	insert into maintenance (   date_debut,  date_fin_prevue,  description , immatriculation) 
	values 
	(dd,df,des,imm);
	update vehicule set statut = 'en maintenance' where immatriculation = imm;
 end $$
 delimiter ;
 
 call PlanifierMaintenance('A4444-4','2025/10/10','test','2025/11/11');
 select * from maintenance;
#4.	Créez une procédure stockée CloturerTournee qui prend en paramètres un id_tournee 
#et le kilometrage_reel_parcouru. Cette procédure doit être transactionnelle et réaliser
# les opérations suivantes :
#•	Mettre à jour le statut de la tournée à 'Terminée'.
#•	Ajouter le kilometrage_reel_parcouru au kilometrage_total du véhicule concerné.
#•	Remettre le statut du véhicule à 'Disponible'.
#En cas d'erreur, toutes les modifications devront être annulées. (2 points)


 drop procedure if exists CloturerTournee;
 delimiter $$
 create procedure CloturerTournee(id_t bigint, km bigint)
 begin
 	declare imm varchar(50);
	declare exit handler for sqlexception
    begin
		rollback;
		select("coluture de la tounrée annulée");
    end;

    select immatriculation into imm from tournee where id_tournee = id_t; 
	start transaction;
		update tournee set statut = 'Terminée' where id_tournee = id_t;
		update vehicule set kilometrage_total = kilometrage_total+km, statut = 'Disponible' where immatriculation = imm;
    commit;
 end $$
 delimiter ;
select * from tournee;
select * from vehicule where immatriculation = 'A4444-4';
call CloturerTournee(4,15000);

#Triggers (Déclencheurs) :

#5.	Mettez en place un trigger nommé AlerteKilometrageMaintenance qui se déclenche
# automatiquement après une mise à jour sur la colonne kilometrage_total de la table 
# VEHICULE. Si le kilométrage total du véhicule dépasse un seuil de 15 000 km depuis 
# sa dernière maintenance majeure (par exemple, de description 'Révision complète'),
# le trigger devra insérer une alerte dans une table ALERTE_SYSTEME (id_alerte, message,
# date_creation, #immatriculation). (On supposera que la table ALERTE_SYSTEME existe)
# . (2 points)
 
 create table 
 ALERTE_SYSTEME (id_alerte int auto_increment primary key, message varchar(100), date_creation date, immatriculation varchar(50));
 select * from maintenance;
select * from alerte_systeme;
select * from vehicule;
drop trigger if exists AlerteKilometrageMaintenance;
delimiter $$
create trigger AlerteKilometrageMaintenance after update on vehicule for each row
begin
	if (new.kilometrage_total-old.kilometrage_total>15000) then
		insert into alerte_systeme values (null,'alerte kilometrage',curdate(),new.immatriculation);
	end if;
end $$
delimiter ;
 update vehicule set kilometrage_total = 170000 where immatriculation = 'A4444-4';
 
 
#6.	Créez un trigger nommé VerifierDisponibiliteVehicule qui s'active avant 
#toute insertion dans la table TOURNEE. Ce trigger doit vérifier que le statut 
#du véhicule assigné à la tournée est bien 'Disponible'. Si le statut est 'En maintenance'
# ou 'Hors service', le trigger doit lever une erreur et empêcher la création de la
# tournée. (2 points)


drop trigger if exists VerifierDisponibiliteVehicule;
delimiter $$
create trigger VerifierDisponibiliteVehicule before insert on TOURNEE for each row
begin
	declare  st varchar(50);

    select statut into st from vehicule where immatriculation = new.immatriculation;
    if (st in ('En maintenance', 'Hors service')) then
		signal sqlstate '45000' set message_text = 'voiture non disponible pour la tournée';
    end if;
    
end $$
delimiter ;

select * from vehicule;
select * from tournee;
insert into tournee values (null,'2024/01/01',300,'Planifiée',1,'A5555-5');