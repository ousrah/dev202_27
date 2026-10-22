drop database if exists vod202_;
create database if not exists vod202_ collate utf8mb4_general_ci;
use vod202_;

## outside foreign keys

create table  utilisateur (
id_utilisateur bigint auto_increment,
nom varchar(50) not null ,
email varchar(50) not null ,
`password` varchar(50) not null ,
id_abonnement bigint not null,
constraint pk_utilisateur primary key (id_utilisateur)

 );

create table  abonnement (
id_abonnement bigint auto_increment primary key,
libelle_abonnement  varchar(150) not null 
 );

create table  contenu (
id_contenu bigint auto_increment primary key,
titre   varchar(150) not null ,
duree smallint not null,
annee smallint ,
`resume` text,
numero_episode smallint,
id_saison bigint ,
id_classification bigint not null
 );

create table  langue (
id_langue bigint auto_increment primary key,
libelle_langue  varchar(50) not null 

 );

create table  classification (
id_classification bigint auto_increment primary key,
libelle_classification  varchar(50) not null 
 );

create table  genre (
id_genre bigint auto_increment primary key,
libelle_genre  varchar(50) not null 

 );

create table  saison (
id_saison bigint auto_increment primary key,
libelle_saison  varchar(50) not null ,
id_serie bigint not null
 );

create table  serie (
id_serie bigint auto_increment primary key,
libelle_serie  varchar(50) not null 

 );

create table  historique (
id_utilisateur bigint not null,
id_contenu bigint not null,
min_vue integer,
constraint pk_historique primary key (id_utilisateur, id_contenu),
constraint fk_historique_utilisateur foreign key (id_utilisateur) references utilisateur(id_utilisateur),
constraint fk_historique_contenu foreign key (id_contenu) references contenu(id_contenu)
);

create table  joue (
id_acteur bigint not null,
id_contenu bigint not null,
constraint pk_joue primary key (id_acteur, id_contenu)
);

create table  acteur (
id_acteur bigint auto_increment primary key,
nom_acteur varchar(50) not null 
 );

create table  doublage (
id_langue bigint not null,
id_contenu bigint not null,
constraint pk_double primary key (id_langue, id_contenu)
 );

create table  appartient (
id_genre bigint not null,
id_contenu bigint not null,
constraint pk_double primary key (id_genre, id_contenu)
 );
 
 alter table utilisateur add constraint fk_utilisateur_abonnement foreign key (id_abonnement) references abonnement(id_abonnement);
 
 alter table contenu add constraint fk_contenu_classification foreign key (id_classification) references classification(id_classification);
 alter table contenu add constraint fk_contenu_saison foreign key (id_saison) references saison(id_saison);
 
 alter table saison add constraint fk_saison_serie foreign key (id_serie) references serie(id_serie);
 
 
 alter table joue add constraint fk_joue_acteur foreign key (id_acteur) references acteur(id_acteur);
 alter table joue add constraint fk_joue_contenu foreign key (id_contenu) references contenu(id_contenu);


 alter table appartient add constraint fk_appartient_genre foreign key (id_genre) references genre(id_genre);
 alter table appartient add constraint fk_appartient_contenu foreign key (id_contenu) references contenu(id_contenu);


 alter table doublage add constraint fk_doublage_langue foreign key (id_langue) references langue(id_langue);
 alter table doublage add constraint fk_doublage_contenu foreign key (id_contenu) references contenu(id_contenu);
