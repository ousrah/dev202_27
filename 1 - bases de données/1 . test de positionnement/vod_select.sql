select ceiling(rand()*22);

-- Partie 2 : Manipulation et Optimisation (40 points)
-- 1.	Insertion de Données (5 pts)
-- 1.	Insérez les genres 'Horreur', 'Documentaire' et 'Fantastique' 
-- en une seule requête INSERT.
insert into genre (libelle_genre) values 
('Horreur'),('Documentaire'),('Fantastique');


-- 2.	Ajoutez un nouvel utilisateur de votre choix. 
insert into utilisateur(nom,email,`password`,id_abonnement) value ('ahmad','ahmad@gmail.com','ahmad1234',1);




-- Ensuite, simulez le fait qu'il ait regardé 30 minutes du film 
-- 'Inception'.
select * from utilisateur;
insert into historique values(4,1,30) ;

insert into historique values (
(select id_utilisateur from utilisateur where email = 'ahmad@gmail.com'),
(select id_contenu from contenu where titre = 'Inception'),
30
);


select * from historique;
-- 2.	Modification et Suppression (10 pts)
-- 1.	Avec ALTER TABLE, ajoutez une colonne nationalite (VARCHAR(50)) à la table Acteurs.

alter table acteur add  nationalite VARCHAR(50) ;

select * from acteur;

-- 2.	Mettez à jour la nationalité de l'acteur Keanu Reeves pour 'Canadienne'.

update acteur 
set nationalite='canadienne' 
where nom_acteur='Keanu Reeves';

-- 3.	Mettez à jour tous les contenus de "Science-Fiction" 
-- sortis avant 2000 pour ajouter la mention "[CLASSIQUE]" au début de leur titre.

select * from  contenu c
join appartient a on c.id_contenu=a.id_contenu
join genre g on a.id_genre=g.id_genre
where annee<2000 
and libelle_genre='Science-Fiction';


update contenu c
join appartient a  using(id_contenu)  #  on c.id_contenu=a.id_contenu
join genre g  using (id_genre)   # on a.id_genre=g.id_genre
set c.titre=concat('[CLASSIQUE] - ',titre)
where annee<2000 
and libelle_genre='Science-Fiction' 
and titre not like '[CLASSIQUE]%';

-- 4.	Supprimez la série "Chronique des Techies". Vérifiez que les épisodes associés ont bien été supprimés également (grâce à la contrainte ON DELETE CASCADE).

delete from serie where libelle_serie = 'Breaking Bad';

alter table saison drop constraint fk_serie_saison;
alter table saison add constraint fk_serie_saison foreign key(id_serie) references serie(id_serie) on delete cascade on update cascade ;

alter table contenu drop constraint fk_saison_contenu;
alter table contenu add constraint fk_saison_contenu foreign key(id_saison) references saison(id_saison) on delete cascade on update cascade ;




select * from saison;
select * from contenu;

-- 3.	Optimisation de Requêtes (5 pts)
-- Expliquez l'utilité d'un index. Sur quelle(s) colonne(s) de la table Contenus serait-il le plus pertinent d'ajouter un index pour accélérer la recherche par titre ? Justifiez et écrivez la requête CREATE INDEX.

-- Présentez votre travail au formateur pour validation avant de continuer.
 
-- Partie 3 : Requêtes de Sélection (30 points)
-- (Pour cette partie, les étudiants utiliseront le script SQL corrigé fourni par l'enseignant pour s'assurer que tout le monde travaille sur la même base de données.)

-- Instructions : Rédigez une requête SQL pour chacune des demandes suivantes (chaque requête vaut 2 points).
-- Niveau 1 : Sélection, Filtrage et Tri
-- 1.	Lister les titres et années de sortie de tous les contenus disponibles.
-- 2.	Lister tous les utilisateurs inscrits en triant les résultats du plus récent au plus ancien.
-- 3.	Afficher les titres des contenus qui durent plus de 2 heures (120 minutes).
-- 4.	Trouver tous les films (non les épisodes) sortis en 1994.
-- 5.	Lister les noms et prénoms de tous les acteurs dont le nom de famille est 'Hanks' ou 'Reeves'.
-- Niveau 2 : Jointures et Agrégations
-- 6.	Afficher le titre de la série ainsi que les titres de tous ses épisodes.
-- 7. Compter le nombre total de films disponibles dans la base de données.
-- 8. Lister les genres et le nombre de contenus associés à chaque genre, triés par 
-- ordre décroissant du nombre de contenus.

-- 9. Calculer la durée moyenne (en minutes) des films du genre "Action".

-- 10. Afficher les noms des utilisateurs et les titres des contenus qu'ils ont regardés.
-- Niveau 3 : Sous-requêtes et Requêtes Complexes
-- 11. Lister les titres de tous les contenus dans lesquels l'acteur 'Tom Hanks' a joué (utilisez une sous-requête dans la clause WHERE).

-- 12. Afficher les titres des contenus qui n'ont encore jamais été vus par aucun utilisateur.

-- 13. Lister les genres qui sont associés à plus de 2 contenus différents (utilisez HAVING).

-- 14. Afficher le nom de l'utilisateur qui a regardé le plus de minutes au total.
-- 15. En utilisant une clause WITH (Common Table Expression), affichez pour chaque genre le titre du film le plus récent.

