-- Création de la base de données
DROP DATABASE IF EXISTS HotelStay;
CREATE DATABASE HotelStay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE HotelStay;

-- 1. Table HOTEL
CREATE TABLE HOTEL (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    nom_hotel VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- 2. Table CLIENT
CREATE TABLE CLIENT (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_inscription DATE NOT NULL
) ENGINE=InnoDB;

-- 3. Table CHAMBRE
CREATE TABLE CHAMBRE (
    numero_chambre INT PRIMARY KEY,
    type_chambre VARCHAR(50) NOT NULL,
    superficie DECIMAL(5,2) NOT NULL,
    prix_nuit DECIMAL(8,2) NOT NULL,
    statut ENUM('Disponible', 'Occupée', 'En rénovation', 'Hors service') NOT NULL,
    id_hotel INT NOT NULL,
    FOREIGN KEY (id_hotel) REFERENCES HOTEL(id_hotel) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Table RESERVATION
CREATE TABLE RESERVATION (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin_prevue DATE NOT NULL,
    nb_personnes INT NOT NULL,
    statut VARCHAR(50) NOT NULL,
    id_client INT NOT NULL,
    numero_chambre INT NOT NULL,
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client) ON DELETE CASCADE,
    FOREIGN KEY (numero_chambre) REFERENCES CHAMBRE(numero_chambre) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Table TRAVAUX_ENTRETIEN
CREATE TABLE TRAVAUX_ENTRETIEN (
    id_travail INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin_reelle DATE DEFAULT NULL,
    description TEXT NOT NULL,
    cout DECIMAL(8,2) NOT NULL,
    numero_chambre INT NOT NULL,
    FOREIGN KEY (numero_chambre) REFERENCES CHAMBRE(numero_chambre) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. Table RECLAMATION
CREATE TABLE RECLAMATION (
    id_reclamation INT AUTO_INCREMENT PRIMARY KEY,
    date_constat DATE NOT NULL,
    description TEXT NOT NULL,
    indemnite_accordee DECIMAL(8,2) DEFAULT 0.00,
    id_reservation INT NOT NULL,
    FOREIGN KEY (id_reservation) REFERENCES RESERVATION(id_reservation) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insertion des données (10 enregistrements par table)

INSERT INTO HOTEL (id_hotel, nom_hotel, ville) VALUES
(1, 'Grand Palace', 'Paris'),
(2, 'Hotel Riviera', 'Nice'),
(3, 'Alpine Lodge', 'Chamonix'),
(4, 'Ocean View', 'Marseille'),
(5, 'The Metro', 'Lyon'),
(6, 'Historic Center', 'Strasbourg'),
(7, 'Sunny Bay', 'Cannes'),
(8, 'Green Valley', 'Bordeaux'),
(9, 'The Zenith', 'Toulouse'),
(10, 'Castle Inn', 'Nantes');

INSERT INTO CLIENT (id_client, nom, prenom, email, date_inscription) VALUES
(1, 'Dupont', 'Jean', 'jean.dupont@email.com', '2025-01-15'),
(2, 'Martin', 'Claire', 'claire.martin@email.com', '2025-02-20'),
(3, 'Bernard', 'Luc', 'luc.bernard@email.com', '2025-03-05'),
(4, 'Thomas', 'Sophie', 'sophie.thomas@email.com', '2025-04-10'),
(5, 'Petit', 'Marc', 'marc.petit@email.com', '2025-05-12'),
(6, 'Robert', 'Julie', 'julie.robert@email.com', '2025-06-18'),
(7, 'Richard', 'Paul', 'paul.richard@email.com', '2025-07-22'),
(8, 'Durand', 'Emma', 'emma.durand@email.com', '2025-08-01'),
(9, 'Leroy', 'Antoine', 'antoine.leroy@email.com', '2025-09-14'),
(10, 'Moreau', 'Chantal', 'chantal.moreau@email.com', '2025-10-30');

INSERT INTO CHAMBRE (numero_chambre, type_chambre, superficie, prix_nuit, statut, id_hotel) VALUES
(101, 'Simple', 20.00, 85.00, 'Disponible', 1),
(102, 'Double', 30.00, 130.00, 'Occupée', 1),
(201, 'Suite', 55.00, 280.00, 'Disponible', 2),
(202, 'Double', 32.00, 140.00, 'En rénovation', 2),
(301, 'Simple', 22.00, 90.00, 'Hors service', 3),
(302, 'Suite', 60.00, 310.00, 'Disponible', 3),
(401, 'Double', 28.00, 120.00, 'Occupée', 4),
(501, 'Simple', 18.00, 75.00, 'Disponible', 5),
(601, 'Double', 35.00, 150.00, 'Occupée', 6),
(701, 'Suite', 50.00, 260.00, 'Disponible', 7);

INSERT INTO RESERVATION (id_reservation, date_debut, date_fin_prevue, nb_personnes, statut, id_client, numero_chambre) VALUES
(1, '2026-03-01', '2026-03-05', 1, 'Confirmée', 1, 101),
(2, '2026-03-02', '2026-03-06', 2, 'En cours', 2, 102),
(3, '2026-03-10', '2026-03-15', 2, 'Confirmée', 3, 201),
(4, '2026-03-12', '2026-03-18', 3, 'Annulée', 4, 302),
(5, '2026-03-15', '2026-03-20', 2, 'En cours', 5, 401),
(6, '2026-03-18', '2026-03-22', 1, 'Confirmée', 6, 501),
(7, '2026-03-20', '2026-03-25', 2, 'En cours', 7, 601),
(8, '2026-03-22', '2026-03-28', 2, 'Confirmée', 8, 701),
(9, '2026-03-25', '2026-03-30', 1, 'Confirmée', 9, 101),
(10, '2026-03-28', '2026-04-02', 2, 'Confirmée', 10, 201);

INSERT INTO TRAVAUX_ENTRETIEN (id_travail, date_debut, date_fin_reelle, description, cout, numero_chambre) VALUES
(1, '2026-01-10', '2026-01-12', 'Réparation fuite salle de bain', 150.00, 101),
(2, '2026-01-15', '2026-01-18', 'Remplacement moquette', 450.00, 102),
(3, '2026-01-20', NULL, 'Rénovation complète suite', 2500.00, 202),
(4, '2026-01-22', '2026-01-23', 'Changement serrure porte', 80.00, 301),
(5, '2026-02-01', '2026-02-02', 'Maintenance climatisation', 120.00, 302),
(6, '2026-02-05', '2026-02-06', 'Peinture murale', 200.00, 401),
(7, '2026-02-10', '2026-02-10', 'Réparation TV', 75.00, 501),
(8, '2026-02-15', '2026-02-17', 'Changement literie', 600.00, 601),
(9, '2026-02-20', '2026-02-21', 'Électricité - révision prises', 90.00, 701),
(10, '2026-02-25', NULL, 'Remplacement fenêtre double vitrage', 1200.00, 301);

INSERT INTO RECLAMATION (id_reclamation, date_constat, description, indemnite_accordee, id_reservation) VALUES
(1, '2026-03-03', 'Bruit excessif provenant du couloir', 30.00, 1),
(2, '2026-03-04', 'Climatisation inopérante', 50.00, 2),
(3, '2026-03-11', 'Propreté de la salle de bain insuffisante', 0.00, 3),
(4, '2026-03-13', 'Erreur de facturation du minibar', 15.00, 5),
(5, '2026-03-19', 'Connexion Wi-Fi instable', 0.00, 6),
(6, '2026-03-21', 'Lit double remplacé par deux lits simples', 40.00, 7),
(7, '2026-03-23', 'Télévision cassée', 25.00, 8),
(8, '2026-03-26', 'Absence de serviettes propres', 20.00, 9),
(9, '2026-03-29', 'Vue obstruée par des travaux extérieurs', 60.00, 10),
(10, '2026-03-30', 'Odeur de tabac dans la chambre non-fumeur', 45.00, 2);

