drop database if exists cc1_v1;
create database cc1_v1 collate utf8mb4_general_ci;
use cc1_v1;

-- ==========================
-- SUPPRESSION SI EXISTE
-- ==========================
DROP TABLE IF EXISTS CLASSEMENT;
DROP TABLE IF EXISTS BUT;
DROP TABLE IF EXISTS PARTICIPATION;
DROP TABLE IF EXISTS `MATCH`;
DROP TABLE IF EXISTS TOURNOI;
DROP TABLE IF EXISTS JOUEUR;
DROP TABLE IF EXISTS EQUIPE;

-- ==========================
-- CREATION DES TABLES
-- ==========================

CREATE TABLE EQUIPE (
  id_equipe INT AUTO_INCREMENT PRIMARY KEY,
  nom_equipe VARCHAR(100) NOT NULL,
  pays VARCHAR(50) NOT NULL
);

CREATE TABLE JOUEUR (
  id_joueur INT AUTO_INCREMENT PRIMARY KEY,
  nom_joueur VARCHAR(100) NOT NULL,
  prenom_joueur VARCHAR(100) NOT NULL,
  date_naissance DATE,
  id_equipe INT,
  FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe)
);

CREATE TABLE TOURNOI (
  id_tournoi INT AUTO_INCREMENT PRIMARY KEY,
  nom_tournoi VARCHAR(100) NOT NULL,
  annee INT NOT NULL
);

CREATE TABLE `MATCH` (
  id_match INT AUTO_INCREMENT PRIMARY KEY,
  date_match DATE NOT NULL,
  stade VARCHAR(100) NOT NULL,
  id_tournoi INT,
  id_equipe_domicile INT,
  id_equipe_exterieur INT,
  FOREIGN KEY (id_tournoi) REFERENCES TOURNOI(id_tournoi),
  FOREIGN KEY (id_equipe_domicile) REFERENCES EQUIPE(id_equipe),
  FOREIGN KEY (id_equipe_exterieur) REFERENCES EQUIPE(id_equipe)
);

CREATE TABLE PARTICIPATION (
  id_match INT,
  id_joueur INT,
  temps_joue_minutes INT,
  PRIMARY KEY (id_match, id_joueur),
  FOREIGN KEY (id_match) REFERENCES `MATCH`(id_match),
  FOREIGN KEY (id_joueur) REFERENCES JOUEUR(id_joueur)
);

CREATE TABLE BUT (
  id_but INT AUTO_INCREMENT PRIMARY KEY,
  minute_but INT NOT NULL,
  id_match INT,
  id_joueur_buteur INT,
  id_joueur_passeur INT,
  FOREIGN KEY (id_match) REFERENCES `MATCH`(id_match),
  FOREIGN KEY (id_joueur_buteur) REFERENCES JOUEUR(id_joueur),
  FOREIGN KEY (id_joueur_passeur) REFERENCES JOUEUR(id_joueur)
);

CREATE TABLE CLASSEMENT (
  id_tournoi INT,
  id_equipe INT,
  points INT,
  buts_marques INT,
  buts_encaisses INT,
  PRIMARY KEY (id_tournoi, id_equipe),
  FOREIGN KEY (id_tournoi) REFERENCES TOURNOI(id_tournoi),
  FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe)
);

-- ==========================
-- INSERTIONS DE DONNÉES
-- ==========================

INSERT INTO EQUIPE (nom_equipe, pays) VALUES
('Real Madrid', 'Espagne'),
('Barcelona', 'Espagne'),
('Manchester City', 'Angleterre'),
('Liverpool', 'Angleterre'),
('Bayern Munich', 'Allemagne'),
('PSG', 'France'),
('Juventus', 'Italie'),
('AC Milan', 'Italie'),
('Chelsea', 'Angleterre'),
('Ajax', 'Pays-Bas');

INSERT INTO JOUEUR (nom_joueur, prenom_joueur, date_naissance, id_equipe) VALUES
('Benzema', 'Karim', '1987-12-19', 1),
('Vinicius', 'Junior', '2000-07-12', 1),
('Lewandowski', 'Robert', '1988-08-21', 2),
('Pedri', 'Gonzalez', '2002-11-25', 2),
('Haaland', 'Erling', '2000-07-21', 3),
('De Bruyne', 'Kevin', '1991-06-28', 3),
('Salah', 'Mohamed', '1992-06-15', 4),
('Alexander-Arnold', 'Trent', '1998-10-07', 4),
('Mbappe', 'Kylian', '1998-12-20', 6),
('Neymar', 'Junior', '1992-02-05', 6),
('Kane', 'Harry', '1993-07-28', 9),
('Chiesa', 'Federico', '1997-10-25', 7),
('Theo', 'Hernandez', '1997-10-06', 8),
('Muller', 'Thomas', '1989-09-13', 5),
('Tadic', 'Dusan', '1988-11-20', 10);

INSERT INTO TOURNOI (nom_tournoi, annee) VALUES
('Champions League', 2023),
('Champions League', 2024),
('Europa League', 2024),
('Super Cup', 2024),
('Ligue 1', 2024),
('Premier League', 2024),
('Serie A', 2024),
('Bundesliga', 2024),
('La Liga', 2024),
('Eredivisie', 2024);

INSERT INTO `MATCH` (date_match, stade, id_tournoi, id_equipe_domicile, id_equipe_exterieur) VALUES
('2024-03-10', 'Santiago Bernabeu', 1, 1, 2),
('2024-03-15', 'Etihad Stadium', 1, 3, 4),
('2024-03-20', 'Allianz Arena', 1, 5, 6),
('2024-03-25', 'Juventus Stadium', 1, 7, 8),
('2024-04-01', 'Stamford Bridge', 1, 9, 3),
('2024-04-05', 'Parc des Princes', 2, 6, 2),
('2024-04-10', 'Anfield', 2, 4, 1),
('2024-04-15', 'Johan Cruyff Arena', 2, 10, 5),
('2024-04-20', 'Camp Nou', 2 , 2, 1),
('2024-04-25', 'Etihad Stadium', 2, 3, 6);

INSERT INTO PARTICIPATION (id_match, id_joueur, temps_joue_minutes) VALUES
(1, 1, 90), (1, 2, 85), (1, 3, 90), (1, 4, 80),
(2, 5, 90), (2, 6, 88), (2, 7, 90), (2, 8, 85),
(3, 9, 90), (3, 10, 88), (3, 14, 85), (3, 13, 90),
(4, 11, 90), (4, 12, 85), (4, 13, 90), (4, 14, 88),
(5, 5, 90), (5, 6, 85), (5, 11, 90), (5, 7, 80);

INSERT INTO BUT (minute_but, id_match, id_joueur_buteur, id_joueur_passeur) VALUES
(23, 1, 1, 2),
(45, 1, 3, 4),
(12, 2, 5, 6),
(67, 2, 7, 8),
(34, 3, 9, 10),
(56, 3, 14, 13),
(11, 4, 11, 12),
(75, 5, 6, 11),
(83, 5, 5, 7),
(90, 10, 9, 10);

INSERT INTO CLASSEMENT (id_tournoi, id_equipe, points, buts_marques, buts_encaisses) VALUES
(9, 1, 12, 10, 5),
(9, 2, 9, 8, 7),
(6, 3, 15, 12, 4),
(6, 4, 11, 10, 8),
(8, 5, 13, 11, 6),
(5, 6, 17, 14, 3),
(7, 7, 9, 8, 9),
(7, 8, 11, 10, 7),
(6, 9, 7, 6, 10),
(10, 10, 10, 9, 9);


#Fonctions :

#1.	Créez une fonction nommée CalculerAgeJoueur qui prend en paramètre un 
#id_joueur et retourne l'âge actuel du joueur. (2 points)
drop function if exists CalculerAgeJoueur;
delimiter $$
create function CalculerAgeJoueur(id int)
returns int
deterministic
begin
	declare age int;
	select timestampdiff(year,date_naissance, curdate()) into age from joueur where id_joueur=id;
	return age;
end$$
delimiter ;

select CalculerAgeJoueur(1);


select * from joueur;
select floor(datediff(curdate(),date_naissance)/365) from joueur;
select timestampdiff(year,date_naissance, curdate()) from joueur;

#2.	Créez une fonction MeilleurButeurEquipeTournoi qui accepte 
#un id_equipe et un id_tournoi en paramètres. Elle doit retourner
# l'identifiant (id_joueur) du joueur de cette équipe ayant marqué 
# le plus de buts durant ce tournoi. (2 points)
 
 
 drop function if exists MeilleurButeurEquipeTournoi;
delimiter $$
create function MeilleurButeurEquipeTournoi(e int, t int)
returns int
deterministic
begin
	declare id_j int;
 select  id_joueur into id_j from but b
 join joueur j on b.id_joueur_buteur = j.id_joueur
 join `MATCH` m  on b.id_match = m.id_match
 where j.id_equipe = e
 and m.id_tournoi = t
 group by id_joueur
 order by count(*) desc
 limit 1;	
 return id_j;
end$$
delimiter ;

select f2(5,1);


 
 
 
#Procédures stockées :

#3.	Élaborez une procédure stockée AjouterJoueur qui prend en
# paramètres les informations d'un nouveau joueur (nom, prénom, 
# date de naissance) ainsi que l'identifiant de son équipe. La 
# procédure devra vérifier que l'équipe spécifiée existe avant 
# d'insérer le nouveau joueur dans la base de données. (2 points)

drop procedure if exists AjouterJoueur;
delimiter $$
create procedure AjouterJoueur(n varchar(50) , p varchar(50), e int)
begin

	if exists (select id_equipe from equipe where id_equipe=e) then
		insert into joueur (nom_joueur, prenom_joueur, id_equipe) values (n,p,e);
	else
		select "cette equipe n'existe pas";
    end if;
end $$
delimiter ;
 select * from joueur;
 call AjouterJoueur('a','b',2);

#1.	Créez une procédure stockée EnregistrerResultatMatch qui prend 
#en paramètres un id_match, le nombre de buts de l'équipe à domicile 
#et le nombre de buts de l'équipe à l'extérieur. Cette procédure 
#doit mettre à jour la table CLASSEMENT (points, buts_marqués, buts_encaissés) 
#pour les deux équipes. La procédure devra être transactionnelle : en cas 
#d'erreur, toutes les modifications devront être annulées. (Rappel : 
#Victoire = 3 points, Nul = 1 point, Défaite = 0 point). (2 points)


drop procedure if exists EnregistrerResultatMatch;
delimiter $$
create procedure EnregistrerResultatMatch(m int , bed int, bee int)
begin
	declare ed,ee,pd, pe int;

    declare exit handler for sqlexception
    begin
	 rollback;
	 select "erreur d'insertion";
	end;
    
    start transaction;
    select id_equipe_domicile into ed from  `match` where id_match = m;
    select id_equipe_exterieur into ee from  `match` where id_match = m;
    if bed>bee then
		set pd=3;
        set pe=0;
	elseif bed=bee then
		set pd=1;
        set pe=1;
	else
		set pd=0;
        set pe=3;
    end if;
		update classement set points= points + pd, buts_marques = buts_marques+bed, buts_encaisses= buts_encaisses+bee where id_equipe = ed;
		update classement set points= points + pe, buts_marques = buts_marques+bee, buts_encaisses= buts_encaisses+bed where id_equipe = ee;
	commit;
end $$
delimiter ;
select * from `match`;
select * from classement order by id_equipe;
select * from equipe;

call EnregistrerResultatMatch(1,2,0);  #12/5 p=15

#Triggers (Déclencheurs) :

#1.	Mettez en place un trigger nommé MiseAJourScoreCumulatif qui se 
#déclenche automatiquement après l'insertion d'une nouvelle ligne dans 
#la table BUT. Ce trigger doit mettre à jour les colonnes buts_marques
# de l'équipe du buteur et buts_encaisses de l'équipe adverse dans la
# table CLASSEMENT. (2 points)
select * from but;
select * from classement order by id_equipe;
select* from `match`;
insert into but values (null,20,1,3,4);
select * from joueur where id_equipe = 2;

drop trigger if exists MiseAJourScoreCumulatif;
delimiter $$
create trigger MiseAJourScoreCumulatif after insert on but for each row
begin
	declare em, ee, edm, eem int; #em = equipe marquee, ee=equipe encaisse, edm equipe domicile matche, eem equipe exterieur match
    select id_equipe into em from  joueur where id_joueur= new.id_joueur_buteur ;
    select id_equipe_domicile into edm from `match` where id_match=new.id_match;
    select id_equipe_exterieur into eem from `match` where id_match=new.id_match;
    if em=edm then
		set ee = eem;
	else
		set ee = edm;
	end if;
    update classement set buts_marques = buts_marques+1 where id_equipe = em;
	update classement set buts_encaisses= buts_encaisses+1 where id_equipe = ee;
end $$
delimiter ;


 
#2.	Créez un trigger nommé VerifierDateMatch qui s'active avant 
#toute insertion ou modification dans la table MATCH. Ce trigger doit 
#empêcher l'opération si la date_match est antérieure au 1er janvier de
# l'année du tournoi (annee de la table TOURNOI). Si la condition n'est
# pas respectée, une erreur doit être levée. (2 points)

select * from `match`;
insert into `match` values (null,'2023-03-03','mly abdellah',1,1,2);
select * from tournoi;

drop trigger if exists VerifierDateMatch;
delimiter $$
create trigger VerifierDateMatch before insert on `match` for each row
begin
	declare annee_t int ; #année tournoi
    select annee into annee_t from  tournoi where id_tournoi= new.id_tournoi ;
    if date(concat(annee_t,'-01-01')) > new.date_match then
		signal  sqlstate '45000' set message_text = 'la date du match doit être supérieure a la date du tournoi';
    end if;
end $$
delimiter ;

