-- Suppression de la base de données si elle existe pour un redémarrage propre
DROP DATABASE IF EXISTS `dentiste_db`;

-- Création de la base de données avec le bon encodage
CREATE DATABASE `dentiste_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `dentiste_db`;

-- =================================================================
-- CREATION DES TABLES PRINCIPALES
-- =================================================================

CREATE TABLE `dentistes` (
  `id_dentiste` INT AUTO_INCREMENT PRIMARY KEY,
  `nom` VARCHAR(50) NOT NULL,
  `prenom` VARCHAR(50) NOT NULL,
  `specialite` VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE `patients` (
  `id_patient` INT AUTO_INCREMENT PRIMARY KEY,
  `nom` VARCHAR(50) NOT NULL,
  `prenom` VARCHAR(50) NOT NULL,
  `date_naissance` DATE,
  `telephone` VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE `rendez_vous` (
  `id_rv` INT AUTO_INCREMENT PRIMARY KEY,
  `date_rv` DATETIME NOT NULL,
  `id_patient` INT,
  `id_dentiste` INT,
  `motif` VARCHAR(255),
  `statut` ENUM('Programmé', 'Annulé', 'Réalisé') DEFAULT 'Programmé',
  FOREIGN KEY (`id_patient`) REFERENCES `patients`(`id_patient`),
  FOREIGN KEY (`id_dentiste`) REFERENCES `dentistes`(`id_dentiste`)
) ENGINE=InnoDB;

CREATE TABLE `traitements` (
  `id_traitement` INT AUTO_INCREMENT PRIMARY KEY,
  `libelle` VARCHAR(100) NOT NULL,
  `prix_unitaire` DECIMAL(10, 2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `actes_effectues` (
  `id_acte` INT AUTO_INCREMENT PRIMARY KEY,
  `id_rv` INT,
  `id_traitement` INT,
  `quantite` INT DEFAULT 1,
  `prix_total` DECIMAL(10, 2),
  FOREIGN KEY (`id_rv`) REFERENCES `rendez_vous`(`id_rv`),
  FOREIGN KEY (`id_traitement`) REFERENCES `traitements`(`id_traitement`)
) ENGINE=InnoDB;


-- =================================================================
-- INSERTION DES DONNEES (IDENTIQUE A LA VERSION PRECEDENTE)
-- =================================================================

INSERT INTO `dentistes` (`nom`, `prenom`, `specialite`) VALUES
('El Alaoui', 'Karim', 'Chirurgie dentaire'), ('Bennani', 'Salma', 'Orthodontie'), ('Cherkaoui', 'Amine', 'Dentisterie générale'),
('Saidi', 'Fatima', 'Pédodontie'), ('Fassi', 'Mehdi', 'Parodontologie'), ('Tazi', 'Nadia', 'Implantologie'),
('Lahlou', 'Youssef', 'Dentisterie esthétique'), ('Kadiri', 'Leila', 'Endodontie'), ('Ouazzani', 'Samir', 'Prothèse dentaire'),
('Filali', 'Hind', 'Dentisterie générale');

INSERT INTO `patients` (`nom`, `prenom`, `date_naissance`, `telephone`) VALUES
('Amrani', 'Ali', '1985-04-12', '0661123456'), ('Benjelloun', 'Sofia', '1992-08-20', '0662345678'),
('Chraibi', 'Omar', '1978-11-30', '0663456789'), ('Daoudi', 'Kenza', '2001-03-15', '0664567890'),
('El Fassi', 'Yassine', '1995-07-22', '0665678901'), ('Ghandi', 'Meryem', '1989-12-05', '0666789012'),
('Hassani', 'Driss', '2010-01-18', '0667890123'), ('Idrissi', 'Zineb', '1980-06-09', '0668901234'),
('Jebli', 'Adam', '1973-09-01', '0669012345'), ('Kettani', 'Nora', '1998-02-25', '0670123456'),
('Lamrani', 'Rachid', '2005-05-14', '0671234567'), ('Mikou', 'Asmae', '1991-10-03', '0672345678'),
('Naciri', 'Hicham', '1982-12-12', '0673456789'), ('Tazi', 'Anas', '1970-01-01', '0610000000'),
('Belkadi', 'Imane', '1994-04-04', '0612222222');

INSERT INTO `traitements` (`libelle`, `prix_unitaire`) VALUES
('Consultation', 300.00), ('Détartrage', 500.00), ('Extraction simple', 800.00), ('Traitement de carie 1 face', 700.00),
('Blanchiment dentaire', 2500.00), ('Extraction dent de sagesse', 1500.00), ('Pose de couronne céramique', 4000.00),
('Appareil dentaire (semestre)', 6000.00), ('Radio panoramique', 400.00), ('Greffe osseuse', 8000.00),
('Facette dentaire (par unité)', 3500.00), ('Scéance de Pédodontie', 450.00);

INSERT INTO `rendez_vous` (`date_rv`, `id_patient`, `id_dentiste`, `motif`, `statut`) VALUES
('2025-11-20 09:00:00', 1, 3, 'Contrôle annuel', 'Programmé'), ('2025-11-20 10:30:00', 2, 2, 'Suivi orthodontie', 'Programmé'),
('2025-11-20 14:00:00', 5, 1, 'Consultation chirurgicale', 'Programmé'), ('2025-11-10 11:00:00', 1, 3, 'Détartrage', 'Réalisé'),
('2025-11-12 15:00:00', 4, 3, 'Soins carie', 'Réalisé'), ('2025-10-25 09:30:00', 6, 7, 'Blanchiment', 'Réalisé'),
('2025-11-05 16:00:00', 7, 4, 'Soins enfant', 'Réalisé'), ('2025-09-15 10:00:00', 11, 2, 'Pose appareil', 'Réalisé'),
('2025-08-20 11:00:00', 13, 9, 'Prise d\'empreinte prothèse', 'Réalisé'), ('2025-11-18 14:00:00', 8, 5, 'Traitement gencives', 'Réalisé'),
('2025-11-19 10:00:00', 9, 6, 'Consultation implant', 'Réalisé'), ('2025-11-25 11:30:00', 3, 1, 'Extraction dent de sagesse', 'Programmé'),
('2025-12-02 15:00:00', 10, 7, 'Pose facettes', 'Programmé'), ('2025-11-28 09:00:00', 12, 10, 'Contrôle de routine', 'Programmé'),
('2025-11-15 10:00:00', 5, 6, 'Consultation implant', 'Annulé'), ('2025-11-17 14:00:00', 2, 2, 'Réglage appareil', 'Annulé'),
('2018-06-15 10:00:00', 14, 3, 'Ancien contrôle', 'Réalisé'), ('2025-11-11 11:00:00', 15, 8, 'Radio et diagnostic', 'Réalisé'),
('2025-11-13 09:30:00', 1, 1, 'Suivi post-opératoire', 'Réalisé'), ('2025-10-20 15:30:00', 3, 3, 'Soins conservateurs', 'Réalisé');

INSERT INTO `actes_effectues` (`id_rv`, `id_traitement`, `quantite`, `prix_total`) VALUES
(4, 2, 1, 500.00), (5, 4, 1, 700.00), (6, 5, 1, 2500.00), (7, 12, 1, 450.00), (8, 8, 1, 6000.00), (9, 1, 1, 300.00),
(10, 1, 1, 300.00), (11, 1, 1, 300.00), (17, 1, 1, 300.00), (18, 9, 1, 400.00), (19, 1, 1, 300.00), (20, 4, 2, 1400.00),
(18, 1, 1, NULL), (10, 1, 1, NULL), (4, 9, 1, NULL);