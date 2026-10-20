use vod;


#gestion des utilisateurs et des droits
#Suppressiond d'un utilisateur existant
drop user if exists 'test'@'localhost';

#creation d'un utilisation avec spécification du mot de passe
create user 'test'@'localhost' identified by '123456';   #  'test'@'%' pour les utilisateur qui peuvent se connecter sur le serveur a distance
create user 'test'@'%' identified by '123456';   #  'test'@'%' pour les utilisateur qui peuvent se connecter sur le serveur a distance

#attribuer tous les droits sur tous les objets de la base de données c1alkhalil à l'utilisateur
grant all privileges on vod.* to 'test'@'localhost';

#attribuer tous les droits sur la table contenu  à l'utilisateur
grant all privileges on vod.acteur to 'test'@'localhost';

#attribuer la selection sur la table avion  à l'utilisateur
grant select on vod.acteur  to 'test'@'localhost';

#attribuer l'insertion et la modification sur la table acteur  à l'utilisateur
grant insert, update on vod.acteur  to 'test'@'localhost';

#afficher tous les droits de l'utilisateur
show grants for  'test'@'localhost';

#Enlever les droits insert et update sur la table acteur à l'utilisateur
revoke insert, update on vod.acteur  from 'test'@'localhost';


use vod;
select * from acteur;
#afficher tous les droits de l'utilisateur
show grants for  'test'@'localhost';

revoke select on vod.acteur from 'test'@'localhost';
#l'utilisateur ne peut voir que les champs id et name de la table acteur

grant select(id, name) on vod.acteur  to 'test'@'localhost';

#l'utilisateur ne peut modifier que les champs name de la table acteur
grant update(name) on vod.acteur to 'test'@'localhost';


#modifier le mot de passe de l'utilisatrice test
set password for 'test'@'localhost' = "abcdefg";



#creation de plusieurs utilisateurs
drop user if exists u1@'localhost';
drop user if exists u2@'localhost';
drop user if exists u3@'localhost';
drop user if exists u4@'localhost';
drop user if exists u5@'localhost';

create user u1@'localhost' identified by '123456';
create user u2@'localhost' identified by '123456';
create user u3@'localhost' identified by '123456';
create user u4@'localhost' identified by '123456';
create user u5@'localhost' identified by '123456';

#creation de deux roles
drop role if exists etudiants@localhost;
drop role if exists profs@localhost;

create role etudiants@localhost;
create role 'profs'@'localhost';


#donner les droits aux roles
grant all privileges on vod.contenu to etudiants@localhost;
grant  select on vod.acteur to etudiants@localhost;

grant all privileges on vod.* to profs@localhost;

#affecter les roles a plusieurs utilisateurs
grant 'etudiants'@'localhost' to u1@localhost;
grant etudiants@localhost to u2@localhost;
grant etudiants@localhost to u3@localhost;
grant etudiants@localhost to u4@localhost;
grant etudiants@localhost to u5@localhost;


#appliquer les roles
set default role all to u1@localhost;
set default role all to u2@localhost;
set default role all to u3@localhost;
set default role all to u4@localhost;
set default role all to u5@localhost;

#ajouter d'autres priviles a un role
grant select on vod.absences to etudiants@localhost;
show grants for etudiants@localhost;
show grants for u1@localhost;
#ajouter d'autres roles a certains utilisateurs
grant profs@localhost to u1@localhost;
grant profs@localhost to u5@localhost;

set default role all to u1@localhost;
set default role all to u5@localhost;

#afficher les privileges d'un utilisateur
show grants for u1@localhost;

#enelver les roles de certains utilisateurs
revoke etudiants@localhost from u4@localhost;
revoke etudiants@localhost from u5@localhost;

#afficher les privileges d'un utilisateur
show grants for u4@localhost;

#rafraichir les privileges sur le serveur pour l'utilisateur en cours
flush privileges;