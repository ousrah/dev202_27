-- Suppression de la base de données si elle existe pour un redémarrage propre
DROP DATABASE IF EXISTS `location_voitures_db`;

-- Création de la base de données avec le bon encodage
CREATE DATABASE `location_voitures_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `location_voitures_db`;

-- =================================================================
-- CREATION DES TABLES
-- =================================================================

CREATE TABLE `clients` (
  `id_client` INT AUTO_INCREMENT PRIMARY KEY,
  `nom` VARCHAR(50) NOT NULL,
  `prenom` VARCHAR(50) NOT NULL,
  `date_naissance` DATE NOT NULL,
  `numero_permis` VARCHAR(50) UNIQUE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `categories` (
  `id_categorie` INT AUTO_INCREMENT PRIMARY KEY,
  `nom_categorie` VARCHAR(50) NOT NULL, -- Ex: Citadine, Berline, SUV
  `prix_journalier` DECIMAL(10, 2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `vehicules` (
  `id_vehicule` INT AUTO_INCREMENT PRIMARY KEY,
  `immatriculation` VARCHAR(20) UNIQUE NOT NULL,
  `marque` VARCHAR(50),
  `modele` VARCHAR(50),
  `id_categorie` INT,
  FOREIGN KEY (`id_categorie`) REFERENCES `categories`(`id_categorie`)
) ENGINE=InnoDB;

CREATE TABLE `locations` (
  `id_location` INT AUTO_INCREMENT PRIMARY KEY,
  `id_client` INT,
  `id_vehicule` INT,
  `date_debut` DATETIME NOT NULL,
  `date_fin` DATETIME,
  `montant_total` DECIMAL(10, 2), -- Ce champ est NULL au début, il sera calculé à la fin de la location
  `statut` ENUM('En cours', 'Terminée', 'Annulée') DEFAULT 'En cours',
  FOREIGN KEY (`id_client`) REFERENCES `clients`(`id_client`),
  FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules`(`id_vehicule`)
) ENGINE=InnoDB;

-- =================================================================
-- INSERTION DES DONNEES
-- =================================================================

-- Clients avec des noms arabes transcrits en lettres latines
INSERT INTO `clients` (`nom`, `prenom`, `date_naissance`, `numero_permis`) VALUES
('El Alaoui', 'Karim', '1985-04-12', 'B123456'),
('Bennani', 'Fatima Zahra', '1992-08-20', 'B789012'),
('Cherkaoui', 'Amine', '1978-11-30', 'B345678'),
('Saidi', 'Leila', '2001-03-15', 'B901234'),
('Fassi', 'Yassine', '1995-07-22', 'B567890'),
('Kadiri', 'Sofia', '1990-02-10', 'B112233'),
('Tazi', 'Mohammed', '1982-06-25', 'B445566'),
('Lahlou', 'Aicha', '1998-09-01', 'B778899');

-- Catégories de véhicules
INSERT INTO `categories` (`nom_categorie`, `prix_journalier`) VALUES
('Citadine', 350.00), ('Berline', 550.00), ('SUV', 750.00), ('Utilitaire', 480.00), ('Luxe', 1200.00);

-- Flotte de véhicules
INSERT INTO `vehicules` (`immatriculation`, `marque`, `modele`, `id_categorie`) VALUES
('11-A-12345', 'Renault', 'Clio', 1), ('22-B-67890', 'Dacia', 'Logan', 1),
('33-C-11223', 'Peugeot', '3008', 3), ('44-D-44556', 'BMW', 'Série 5', 2),
('55-E-77889', 'Ford', 'Transit', 4), ('66-F-10112', 'Mercedes', 'Classe C', 2),
('77-G-13141', 'Jeep', 'Avenger', 3), ('88-H-15161', 'Porsche', 'Cayenne', 5);



-- Locations passées, présentes et annulées pour alimenter les questions de l'examen
INSERT INTO `locations` (`id_client`, `id_vehicule`, `date_debut`, `date_fin`, `montant_total`, `statut`) VALUES
-- Locations EN COURS (pour Q1 et Q5)
(1, 1, '2025-11-20 09:00:00', NULL, NULL, 'En cours'),
(2, 3, '2025-11-21 10:00:00', NULL, NULL, 'En cours'),

-- Locations TERMINEES (pour Q4, Q7, Q8)
(3, 2, '2025-11-10 14:00:00', '2025-11-15 14:00:00', 1750.00, 'Terminée'), -- 5 jours * 350
(4, 5, '2025-11-05 08:00:00', '2025-11-08 10:00:00', 1920.00, 'Terminée'), -- 4 jours (arrondi sup de 3.1j) * 480
(1, 4, '2025-10-15 16:00:00', '2025-10-20 16:00:00', 2750.00, 'Terminée'), -- 5 jours * 550
(6, 6, '2025-09-01 12:00:00', '2025-09-04 12:00:00', 1650.00, 'Terminée'), -- 3 jours * 550
(7, 8, '2025-11-01 10:00:00', '2025-11-04 10:00:00', 3600.00, 'Terminée'), -- 3 jours * 1200

-- Location ANNULEE
(5, 7, '2025-11-18 11:00:00', '2025-11-19 11:00:00', NULL, 'Annulée'),

-- Une autre location EN COURS pour un client qui a déjà des locations terminées
(3, 7, '2025-11-22 09:00:00', NULL, NULL, 'En cours');