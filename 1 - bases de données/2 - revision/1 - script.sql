drop database if exists courses202;
create database if not exists courses202 collate utf8mb4_general_ci;
use courses202; 

/*==============================================================*/
/* Table: CATEGORIE                                             */
/*==============================================================*/
create table CATEGORIE
(
   ID_CATEGORIE         int not null auto_increment,
   LIBELLE_CATEGORIE    varchar(50),
   primary key (ID_CATEGORIE)
);

/*==============================================================*/
/* Table: CHAMPS                                                */
/*==============================================================*/
create table CHAMPS
(
   ID_CHAMPS            int not null auto_increment,
   NOM_CHAMPS           varchar(50),
   NB_PLACES            bigint,
   primary key (ID_CHAMPS)
);

/*==============================================================*/
/* Table: ACCUEIL                                               */
/*==============================================================*/
create table ACCUEIL
(
   ID_CATEGORIE         int not null,
   ID_CHAMPS            int not null,
   primary key (ID_CATEGORIE, ID_CHAMPS)
);

/*==============================================================*/
/* Table: PROPRIETAIRE                                          */
/*==============================================================*/
create table PROPRIETAIRE
(
   ID_PROPRIETAIRE      int not null auto_increment,
   NOM_PROPRIETAIRE     varchar(50),
   PRENOM_PROPRIETAIRE  varchar(50),
   primary key (ID_PROPRIETAIRE)
);

/*==============================================================*/
/* Table: CHEVAL                                                */
/*==============================================================*/
create table CHEVAL
(
   ID_CHEVAL            int not null auto_increment,
   ID_PROPRIETAIRE      int not null,
   NOM_CHEVAL           varchar(50),
   SEXE_CHEVALE         char(1),
   DATE_NAISSANCE       date,
   primary key (ID_CHEVAL)
);

/*==============================================================*/
/* Table: COURSE                                                */
/*==============================================================*/
create table COURSE
(
   ID_COURSE            int not null auto_increment,
   ID_CATEGORIE         int not null,
   ID_CHAMPS            int not null,
   DESIGNATION          varchar(50),
   primary key (ID_COURSE)
);

/*==============================================================*/
/* Table: JOCKEY                                                */
/*==============================================================*/
create table JOCKEY
(
   ID_JOCKEY            int not null auto_increment,
   NOM_JOCKEY           varchar(50),
   PRENOM_JOCKEY        varchar(50),
   primary key (ID_JOCKEY)
);

/*==============================================================*/
/* Table: PARENT                                                */
/*==============================================================*/
create table PARENT
(
   ID_CHEVAL            int not null,
   CHE_ID_CHEVAL        int not null,
   primary key (ID_CHEVAL, CHE_ID_CHEVAL)
);

/*==============================================================*/
/* Table: SAISON                                                */
/*==============================================================*/
create table SAISON
(
   ID_SAISON            int not null auto_increment,
   ID_COURSE            int not null,
   DATE_COURSE          datetime,
   DOTATION             decimal,
   primary key (ID_SAISON)
);

/*==============================================================*/
/* Table: PARTICIPE                                             */
/*==============================================================*/
create table PARTICIPE
(
   ID_JOCKEY            int not null,
   ID_SAISON            int not null,
   ID_CHEVAL            int not null,
   CLASSEMENT           int,
   primary key (ID_JOCKEY, ID_SAISON, ID_CHEVAL)
);

alter table ACCUEIL add constraint FK_ACCUEIL foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

alter table ACCUEIL add constraint FK_ACCUEIL2 foreign key (ID_CHAMPS)
      references CHAMPS (ID_CHAMPS) on delete restrict on update restrict;

alter table CHEVAL add constraint FK_POSEDE foreign key (ID_PROPRIETAIRE)
      references PROPRIETAIRE (ID_PROPRIETAIRE) on delete restrict on update restrict;

alter table COURSE add constraint FK_APPARTIENT foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

alter table COURSE add constraint FK_SE_DEROULE foreign key (ID_CHAMPS)
      references CHAMPS (ID_CHAMPS) on delete restrict on update restrict;

alter table PARENT add constraint FK_PARENT foreign key (ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict;

alter table PARENT add constraint FK_PARENT2 foreign key (CHE_ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict;

alter table PARTICIPE add constraint FK_PARTICIPE foreign key (ID_JOCKEY)
      references JOCKEY (ID_JOCKEY) on delete restrict on update restrict;

alter table PARTICIPE add constraint FK_PARTICIPE2 foreign key (ID_SAISON)
      references SAISON (ID_SAISON) on delete restrict on update restrict;

alter table PARTICIPE add constraint FK_PARTICIPE3 foreign key (ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict;

alter table SAISON add constraint FK_ORAGNISER foreign key (ID_COURSE)
      references COURSE (ID_COURSE) on delete restrict on update restrict;


-- ==========================================
-- INSERTS
-- ==========================================

-- CATEGORIE (3 catégories)
INSERT INTO CATEGORIE (ID_CATEGORIE, LIBELLE_CATEGORIE) VALUES
(1, 'Galop'),
(2, 'Trot'),
(3, 'Obstacle');

-- CHAMPS (3 champs/hippodromes)
INSERT INTO CHAMPS (ID_CHAMPS, NOM_CHAMPS, NB_PLACES) VALUES
(1, 'Hippodrome de Paris', 50000),
(2, 'Hippodrome de Lyon', 25000),
(3, 'Hippodrome de Deauville', 30000);

-- PROPRIETAIRE (5 propriétaires)
INSERT INTO PROPRIETAIRE (ID_PROPRIETAIRE, NOM_PROPRIETAIRE, PRENOM_PROPRIETAIRE) VALUES
(1, 'Dupont', 'Jean'),
(2, 'Martin', 'Claire'),
(3, 'Bernard', 'Luc'),
(4, 'Thomas', 'Sophie'),
(5, 'Robert', 'Marc');

-- CHEVAL (20 chevaux)
INSERT INTO CHEVAL (ID_CHEVAL, ID_PROPRIETAIRE, NOM_CHEVAL, SEXE_CHEVALE, DATE_NAISSANCE) VALUES
(1, 1, 'Tonnerre', 'M', '2020-03-12'),
(2, 1, 'Eclair', 'M', '2019-05-14'),
(3, 2, 'Storm', 'F', '2021-01-20'),
(4, 2, 'Breeze', 'F', '2020-07-08'),
(5, 3, 'Shadow', 'M', '2018-11-05'),
(6, 3, 'Flash', 'M', '2019-04-22'),
(7, 4, 'Spirit', 'F', '2021-06-15'),
(8, 4, 'Comete', 'F', '2020-09-30'),
(9, 5, 'Zephyr', 'M', '2019-02-18'),
(10, 5, 'Pegase', 'M', '2018-12-10'),
(11, 1, 'Vortex', 'M', '2021-03-01'),
(12, 2, 'Galaxie', 'F', '2020-05-25'),
(13, 3, 'Titan', 'M', '2019-08-14'),
(14, 4, 'Stella', 'F', '2021-02-11'),
(15, 5, 'Apollo', 'M', '2020-10-04'),
(16, 1, 'Neptune', 'M', '2019-07-19'),
(17, 2, 'Athena', 'F', '2021-04-30'),
(18, 3, 'Hercule', 'M', '2018-06-21'),
(19, 4, 'Diana', 'F', '2020-12-05'),
(20, 5, 'Vulcan', 'M', '2019-01-15');

-- COURSE (5 courses)
INSERT INTO COURSE (ID_COURSE, ID_CATEGORIE, ID_CHAMPS, DESIGNATION) VALUES
(1, 1, 1, 'Grand Prix de Paris'),
(2, 2, 2, 'Prix de Lyon'),
(3, 3, 3, 'Grand Steeple de Deauville'),
(4, 1, 2, 'Derby Regional'),
(5, 2, 1, 'Trophée National');

-- JOCKEY (10 jockeys)
INSERT INTO JOCKEY (ID_JOCKEY, NOM_JOCKEY, PRENOM_JOCKEY) VALUES
(1, 'Lefevre', 'Antoine'),
(2, 'Moreau', 'Thomas'),
(3, 'Girard', 'Nicolas'),
(4, 'Rousseau', 'Julien'),
(5, 'Fournier', 'David'),
(6, 'Mercier', 'Alexandre'),
(7, 'Guerin', 'Romain'),
(8, 'Boyer', 'Maxime'),
(9, 'Brun', 'Kevin'),
(10, 'Chevalier', 'Benjamin');

-- SAISON (20 saisons)
INSERT INTO SAISON (ID_SAISON, ID_COURSE, DATE_COURSE, DOTATION) VALUES
(1, 1, '2026-01-15 14:00:00', 50000.00),
(2, 2, '2026-01-22 15:00:00', 30000.00),
(3, 3, '2026-02-05 14:30:00', 75000.00),
(4, 4, '2026-02-19 16:00:00', 40000.00),
(5, 5, '2026-03-01 13:30:00', 60000.00),
(6, 1, '2026-03-15 14:00:00', 55000.00),
(7, 2, '2026-03-29 15:00:00', 32000.00),
(8, 3, '2026-04-12 14:30:00', 80000.00),
(9, 4, '2026-04-26 16:00:00', 45000.00),
(10, 5, '2026-05-10 13:30:00', 62000.00),
(11, 1, '2026-05-24 14:00:00', 60000.00),
(12, 2, '2026-06-07 15:00:00', 35000.00),
(13, 3, '2026-06-21 14:30:00', 85000.00),
(14, 4, '2026-07-05 16:00:00', 48000.00),
(15, 5, '2026-07-19 13:30:00', 65000.00),
(16, 1, '2026-08-02 14:00:00', 70000.00),
(17, 2, '2026-08-16 15:00:00', 38000.00),
(18, 3, '2026-08-30 14:30:00', 90000.00),
(19, 4, '2026-09-13 16:00:00', 50000.00),
(20, 5, '2026-09-20 13:30:00', 70000.00);

-- PARTICIPE (20 saisons * 10 participations par saison = 200 lignes)
INSERT INTO PARTICIPE (ID_JOCKEY, ID_SAISON, ID_CHEVAL, CLASSEMENT) VALUES
-- Saison 1
(1, 1, 1, 1), (2, 1, 2, 2), (3, 1, 3, 3), (4, 1, 4, 4), (5, 1, 5, 5), 
(6, 1, 6, 6), (7, 1, 7, 7), (8, 1, 8, 8), (9, 1, 9, 9), (10, 1, 10, 10),
-- Saison 2
(1, 2, 11, 1), (2, 2, 12, 2), (3, 2, 13, 3), (4, 2, 14, 4), (5, 2, 15, 5), 
(6, 2, 16, 6), (7, 2, 17, 7), (8, 2, 18, 8), (9, 2, 19, 9), (10, 2, 20, 10),
-- Saison 3
(1, 3, 2, 3), (2, 3, 4, 1), (3, 3, 6, 2), (4, 3, 8, 4), (5, 3, 10, 5), 
(6, 3, 12, 6), (7, 3, 14, 7), (8, 3, 16, 8), (9, 3, 18, 9), (10, 3, 20, 10),
-- Saison 4
(1, 4, 1, 2), (2, 4, 3, 1), (3, 4, 5, 4), (4, 4, 7, 3), (5, 4, 9, 5), 
(6, 4, 11, 6), (7, 4, 13, 7), (8, 4, 15, 8), (9, 4, 17, 9), (10, 4, 19, 10),
-- Saison 5
(1, 5, 3, 4), (2, 5, 6, 2), (3, 5, 9, 1), (4, 5, 12, 3), (5, 5, 15, 5), 
(6, 5, 18, 6), (7, 5, 1, 7), (8, 5, 4, 8), (9, 5, 7, 9), (10, 5, 10, 10),
-- Saison 6
(1, 6, 4, 1), (2, 6, 8, 3), (3, 6, 12, 2), (4, 6, 16, 5), (5, 6, 20, 4), 
(6, 6, 2, 6), (7, 6, 6, 7), (8, 6, 10, 8), (9, 6, 14, 9), (10, 6, 18, 10),
-- Saison 7
(1, 7, 5, 2), (2, 7, 10, 1), (3, 7, 15, 4), (4, 7, 20, 3), (5, 7, 3, 5), 
(6, 7, 8, 6), (7, 7, 13, 7), (8, 7, 18, 8), (9, 7, 1, 9), (10, 7, 6, 10),
-- Saison 8
(1, 8, 7, 3), (2, 8, 14, 2), (3, 8, 1, 1), (4, 8, 9, 4), (5, 8, 16, 5), 
(6, 8, 2, 6), (7, 8, 10, 7), (8, 8, 17, 8), (9, 8, 4, 9), (10, 8, 11, 10),
-- Saison 9
(1, 9, 8, 1), (2, 9, 16, 3), (3, 9, 4, 2), (4, 9, 12, 5), (5, 9, 20, 4), 
(6, 9, 5, 6), (7, 9, 13, 7), (8, 9, 1, 8), (9, 9, 9, 9), (10, 9, 17, 10),
-- Saison 10
(1, 10, 9, 2), (2, 10, 18, 1), (3, 10, 7, 4), (4, 10, 15, 3), (5, 10, 2, 5), 
(6, 10, 11, 6), (7, 10, 20, 7), (8, 10, 6, 8), (9, 10, 14, 9), (10, 10, 3, 10),
-- Saison 11
(1, 11, 10, 3), (2, 11, 1, 2), (3, 11, 11, 1), (4, 11, 2, 5), (5, 11, 12, 4), 
(6, 11, 3, 6), (7, 11, 13, 7), (8, 11, 4, 8), (9, 11, 14, 9), (10, 11, 5, 10),
-- Saison 12
(1, 12, 11, 1), (2, 12, 3, 4), (3, 12, 15, 2), (4, 12, 7, 3), (5, 12, 19, 5), 
(6, 12, 2, 6), (7, 12, 14, 7), (8, 12, 6, 8), (9, 12, 18, 9), (10, 12, 10, 10),
-- Saison 13
(1, 13, 12, 2), (2, 13, 5, 1), (3, 13, 18, 3), (4, 13, 8, 4), (5, 13, 1, 5), 
(6, 13, 9, 6), (7, 13, 2, 7), (8, 13, 11, 8), (9, 13, 4, 9), (10, 13, 15, 10),
-- Saison 14
(1, 14, 13, 4), (2, 14, 7, 2), (3, 14, 2, 3), (4, 14, 16, 1), (5, 14, 5, 5), 
(6, 14, 10, 6), (7, 14, 3, 7), (8, 14, 12, 8), (9, 14, 6, 9), (10, 14, 17, 10),
-- Saison 15
(1, 15, 14, 3), (2, 15, 9, 1), (3, 15, 4, 2), (4, 15, 19, 4), (5, 15, 8, 5), 
(6, 15, 1, 6), (7, 15, 11, 7), (8, 15, 2, 8), (9, 15, 13, 9), (10, 15, 5, 10),
-- Saison 16
(1, 16, 15, 1), (2, 16, 11, 3), (3, 16, 6, 2), (4, 16, 2, 5), (5, 16, 17, 4), 
(6, 16, 4, 6), (7, 16, 13, 7), (8, 16, 7, 8), (9, 16, 20, 9), (10, 16, 9, 10),
-- Saison 17
(1, 17, 16, 2), (2, 17, 13, 1), (3, 17, 8, 4), (4, 17, 4, 3), (5, 17, 19, 5), 
(6, 17, 7, 6), (7, 17, 2, 7), (8, 17, 11, 8), (9, 17, 5, 9), (10, 17, 14, 10),
-- Saison 18
(1, 18, 17, 3), (2, 18, 15, 2), (3, 18, 10, 1), (4, 18, 5, 4), (5, 18, 1, 5), 
(6, 18, 12, 6), (7, 18, 3, 7), (8, 18, 16, 8), (9, 18, 8, 9), (10, 18, 19, 10),
-- Saison 19
(1, 19, 18, 1), (2, 19, 2, 3), (3, 19, 12, 2), (4, 19, 7, 5), (5, 19, 16, 4), 
(6, 19, 3, 6), (7, 19, 14, 7), (8, 19, 9, 8), (9, 19, 4, 9), (10, 19, 11, 10),
-- Saison 20
(1, 20, 19, 2), (2, 20, 4, 1), (3, 20, 14, 3), (4, 20, 9, 5), (5, 20, 18, 4), 
(6, 20, 5, 6), (7, 20, 1, 7), (8, 20, 12, 8), (9, 20, 6, 9), (10, 20, 15, 10);