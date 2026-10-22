
-- Abonnements
INSERT INTO abonnement (libelle_abonnement) VALUES 
('Gratuit'),
('Standard'),
('Premium 4K');

-- Classifications (Publics)
INSERT INTO classification (libelle_classification) VALUES 
('Tous publics'),
('-10 ans'),
('-16 ans'),
('Interdit aux moins de 18 ans');

-- Genres
INSERT INTO genre (libelle_genre) VALUES 
('Action'),
('Science-Fiction'),
('Drame'),
('Comédie'),
('Thriller'),
('Animation'),
('Fantastique');

-- Langues
INSERT INTO langue (libelle_langue) VALUES 
('Français'),
('Anglais'),
('Espagnol'),
('Japonais'),
('Allemand');

-- Utilisateurs
INSERT INTO utilisateur (nom, email, password, id_abonnement) VALUES 
('Alice Martin', 'alice@email.com', 'pass123', 3),
('Bob Dupont', 'bob@email.com', 'pass123', 1),
('Charlie Durand', 'charlie@email.com', 'pass123', 2);

-- Séries (4 séries pour les 20 épisodes)
INSERT INTO serie (libelle_serie) VALUES 
('Stranger Things'),
('Breaking Bad'),
('The Office'),
('Attack on Titan');

-- Saisons (1 saison par série pour simplifier)
INSERT INTO saison (libelle_saison, id_serie) VALUES 
('Saison 1', 1),
('Saison 1', 2),
('Saison 1', 3),
('Saison 1', 4);

-- Acteurs
INSERT INTO acteur (nom_acteur) VALUES 
('Keanu Reeves'), ('Leonardo DiCaprio'), ('Scarlett Johansson'), 
('Tom Hanks'), ('Millie Bobby Brown'), ('Bryan Cranston'), 
('Steve Carell'), ('Yuki Kaji');



-- ==================== 20 FILMS ====================
INSERT INTO contenu (titre, duree, annee, resume, numero_episode, id_saison, id_classification) VALUES 
('Inception', 148, 2010, 'Un voleur qui infiltre les rêves...', NULL, NULL, 2),
('Interstellar', 169, 2014, 'Une équipe d''explorateurs voyage à travers un trou de ver...', NULL, NULL, 1),
('Matrix', 136, 1999, 'Un hacker découvre la triste réalité de sa matrice...', NULL, NULL, 3),
('Gladiator', 155, 2000, 'Un général romain cherche à se venger...', NULL, NULL, 3),
('Titanic', 195, 1997, 'Une romance tragique à bord du paquebot...', NULL, NULL, 1),
('Avatar', 162, 2009, 'Sur la lune de Pandora...', NULL, NULL, 1),
('The Dark Knight', 152, 2008, 'Batman affronte le Joker...', NULL, NULL, 2),
('Pulp Fiction', 154, 1994, 'Les vies de plusieurs criminels à Los Angeles...', NULL, NULL, 4),
('Forrest Gump', 142, 1994, 'La vie extraordinaire d''un homme simple...', NULL, NULL, 1),
('Jurassic Park', 127, 1993, 'Des dinosaures clonés s''échappent d''un parc...', NULL, NULL, 1),
('Le Seigneur des Anneaux : La Communauté de l''Anneau', 178, 2001, 'Un anneau unique à détruire...', NULL, NULL, 2),
('Fight Club', 139, 1999, 'Création d''un club de combat clandestin...', NULL, NULL, 4),
('Seven', 127, 1995, 'Deux policiers traquent un tueur en série...', NULL, NULL, 3),
('Le Roi Lion', 88, 1994, 'Le destin d''un jeune lionceau...', NULL, NULL, 1),
('Spider-Man : New Generation', 117, 2018, 'Un multivers de Hommes-Araignées...', NULL, NULL, 1),
('Parasite', 132, 2019, 'Une famille pauvre s''incruste chez des riches...', NULL, NULL, 3),
('Whiplash', 106, 2014, 'Un jeune batteur poussé par un professeur impitoyable...', NULL, NULL, 2),
('The Truman Show', 103, 1998, 'Un homme réalise que sa vie est une émission de télé-réalité...', NULL, NULL, 1),
('La La Land', 128, 2016, 'Une romance musicale à Los Angeles...', NULL, NULL, 1),
('Gladiator II', 140, 2024, 'La suite des aventures dans l''arène...', NULL, NULL, 3);

-- ==================== 20 ÉPISODES (5 par série / 4 séries) ====================
INSERT INTO contenu (titre, duree, annee, resume, numero_episode, id_saison, id_classification) VALUES 
-- Stranger Things (Saison 1 - id_saison = 1)
('Chapitre Un : La Disparition de Will Byers', 48, 2016, 'Un garçon disparaît mystérieusement.', 1, 1, 2),
('Chapitre Deux : La Dingue de la ville', 55, 2016, 'Mike cache une fille étrange.', 2, 1, 2),
('Chapitre Trois : Joyeux Noël, ouate de phoque', 51, 2016, 'Joyce communique avec son fils.', 3, 1, 2),
('Chapitre Quatre : Le Corps', 50, 2016, 'Un corps est repêché, mais le doute persiste.', 4, 1, 2),
('Chapitre Cinq : La Puce et l''Acrobate', 53, 2016, 'Le groupe cherche un portail.', 5, 1, 2),

-- Breaking Bad (Saison 1 - id_saison = 2)
('Chacun sa loterie', 58, 2008, 'Un prof de chimie apprend sa maladie.', 1, 2, 3),
('Le Chat et la R</td>', 48, 2008, 'Premières péripéties dans le désert.', 2, 2, 3),
('Déboires', 47, 2008, 'Gestion d''un cadavre encombrant.', 3, 2, 3),
('Maladie d''amour', 47, 2008, 'Walter cache la vérité à sa femme.', 4, 2, 3),
('Le Avis d''un père', 52, 2008, 'Tensions familiales accrues.', 5, 2, 3),

-- The Office (Saison 1 - id_saison = 3)
('Frère de bureau', 22, 2005, 'Arrivée d''une équipe de documentaristes.', 1, 3, 1),
('La Diversité', 22, 2005, 'Séminaire sur la diversité au bureau.', 2, 3, 1),
('La Santé de la PME', 22, 2005, 'Réduction des coûts annoncée.', 3, 3, 1),
('L''Alliance', 22, 2005, 'Stratégies de survie en entreprise.', 4, 3, 1),
('Basketball', 22, 2005, 'Match entre la compta et l''entrepôt.', 5, 3, 1),

-- Attack on Titan (Saison 1 - id_saison = 4)
('À toi, dans 2000 ans', 24, 2013, 'La chute du mur Maria.', 1, 4, 3),
('Ce jour-là', 24, 2013, 'Réfugiés et pénuries.', 2, 4, 3),
('Une faible lueur dans l''obscurité', 24, 2013, 'Entrainement des cadets.', 3, 4, 3),
('Le combat tactique', 24, 2013, 'Premier déploiement.', 4, 4, 3),
('Première bataille', 24, 2013, 'Affrontement direct avec les Titans.', 5, 4, 3);


-- Historique de visionnage (Utilisateurs / Contenus)
INSERT INTO historique (id_utilisateur, id_contenu, min_vue) VALUES 
(1, 1, 140),  -- Alice a presque fini Inception
(1, 21, 48),  -- Alice a fini l'épisode 1 de Stranger Things
(2, 5, 60),   -- Bob a commencé Titanic
(3, 10, 127); -- Charlie a fini Jurassic Park

-- Acteurs dans les contenus (Joue)
INSERT INTO joue (id_acteur, id_contenu) VALUES 
(1, 3),  -- Keanu Reeves dans Matrix
(2, 1),  -- Leonardo DiCaprio dans Inception
(3, 7),  -- Scarlett Johansson (simulé)
(4, 9),  -- Tom Hanks dans Forrest Gump
(5, 21); -- Millie Bobby Brown dans Stranger Things

-- Doublages des contenus (Langues)
INSERT INTO doublage (id_langue, id_contenu) VALUES 
(1, 1), (2, 1), -- Inception en FR et ENG
(1, 21), (2, 21); -- Stranger Things en FR et ENG

-- Genres associés aux contenus (Appartient)
INSERT INTO appartient (id_genre, id_contenu) VALUES 
(2, 1), (5, 1), -- Inception: Sci-Fi, Thriller
(2, 2), (3, 2), -- Interstellar: Sci-Fi, Drame
(1, 3), (2, 3), -- Matrix: Action, Sci-Fi
(6, 14),        -- Le Roi Lion: Animation
(6, 15);        -- Spider-Man: Animation

