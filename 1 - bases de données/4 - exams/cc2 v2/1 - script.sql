-- Thème : Clinique Ophtalmologique
-- =================================================================

DROP DATABASE IF EXISTS ophtalmo;
CREATE DATABASE ophtalmo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ophtalmo;

-- 1. Table : patients

CREATE TABLE patients (
id_patient INT AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(50) NOT NULL,
prenom VARCHAR(50) NOT NULL,
date_naissance DATE NOT NULL,
numero_cin VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 2. Table : specialites_actes

CREATE TABLE specialites_actes (
id_specialite INT AUTO_INCREMENT PRIMARY KEY,
nom_specialite VARCHAR(50) NOT NULL,
tarif_base DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- 3. Table : equipements_medicaux

CREATE TABLE equipements_medicaux (
id_equipement INT AUTO_INCREMENT PRIMARY KEY,
numero_serie VARCHAR(20) NOT NULL UNIQUE,
marque VARCHAR(50) NOT NULL,
modele VARCHAR(50) NOT NULL,
id_specialite INT NOT NULL,
CONSTRAINT fk_equipements_specialite FOREIGN KEY (id_specialite)
REFERENCES specialites_actes(id_specialite)
ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Table : interventions_consultations

CREATE TABLE interventions_consultations (
id_intervention INT AUTO_INCREMENT PRIMARY KEY,
id_patient INT NOT NULL,
id_equipement INT NOT NULL,
date_debut DATETIME NOT NULL,
date_fin DATETIME,
montant_total DECIMAL(10,2),
statut ENUM('En cours', 'Terminée', 'Annulée') NOT NULL DEFAULT 'En cours',
CONSTRAINT fk_interventions_patient FOREIGN KEY (id_patient)
REFERENCES patients(id_patient)
ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_interventions_equipement FOREIGN KEY (id_equipement)
REFERENCES equipements_medicaux(id_equipement)
ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =================================================================
-- INSERTION DES DONNÉES (20 lignes par table)
-- =================================================================

-- Insertion dans patients

INSERT INTO patients (nom, prenom, date_naissance, numero_cin) VALUES
('El Amrani', 'Youssef', '1985-03-15', 'AB123456'),
('Bennani', 'Salma', '1992-07-22', 'CD234567'),
('Chraibi', 'Karim', '1978-11-05', 'EF345678'),
('Fassi', 'Amina', '1995-01-30', 'GH456789'),
('Alaoui', 'Omar', '1960-09-18', 'IJ567890'),
('Idrissi', 'Meriem', '1989-12-12', 'KL678901'),
('Tazi', 'Mehdi', '2001-04-25', 'MN789012'),
('Berrada', 'Houda', '1975-06-08', 'OP890123'),
('Kettani', 'Hamza', '1998-08-14', 'QR901234'),
('Guessous', 'Fatima', '1952-02-28', 'ST012345'),
('Naciri', 'Rachid', '1982-10-10', 'UV123456'),
('Sefrioui', 'Sanae', '1990-05-04', 'WX234567'),
('Filali', 'Tariq', '1968-11-20', 'YZ345678'),
('Zerouali', 'Nadia', '2003-01-17', 'AA456789'),
('Lahlou', 'Othmane', '1994-09-02', 'BB567890'),
('Bouazza', 'Khadija', '1980-04-11', 'CC678901'),
('Choukri', 'Adil', '1972-12-01', 'DD789012'),
('Moussaoui', 'Imane', '1999-07-19', 'EE890123'),
('Belkhadir', 'Hassan', '1963-03-27', 'FF901234'),
('Mansouri', 'Zineb', '1991-08-09', 'GG012345');

-- Insertion dans specialites_actes

INSERT INTO specialites_actes (nom_specialite, tarif_base) VALUES
('Chirurgie Réfractive (LASIK)', 1500.00),
('Chirurgie de la Cataracte', 2200.00),
('Traitement Glaucome (Laser SLT)', 1200.00),
('Rétinographie et Fond d’œil', 450.00),
('Angiographie Fluorescéinique', 800.00),
('Topographie Cornéenne', 500.00),
('OCT (Tomographie en Cohérence Optique)', 650.00),
('Chirurgie du Ptérygion', 1800.00),
('Traitement de la DMLA (IVT)', 2500.00),
('Vitrectomie', 3500.00),
('Cross-linking Cornéen', 1300.00),
('Capsulotomie Laser YAG', 900.00),
('Iridotomie Laser', 850.00),
('Bilan Orthoptique Approfondi', 300.00),
('Biométrie Oculaire', 400.00),
('Champ Visuel Automatisé', 350.00),
('Chirurgie du Strabisme', 2800.00),
('Greffe de Cornée', 5000.00),
('Pachymentrie Cornéenne', 250.00),
('Consultation Spécialisée Cornée', 550.00);

-- Insertion dans equipements_medicaux

INSERT INTO equipements_medicaux (numero_serie, marque, modele, id_specialite) VALUES
('EQ-LAS-001', 'Zeiss', 'MEL 90 Excimer', 1),
('EQ-LAS-002', 'Alcon', 'WaveLight EX500', 1),
('EQ-CAT-001', 'Alcon', 'Centurion Vision System', 2),
('EQ-CAT-002', 'Bausch + Lomb', 'Stellaris Elite', 2),
('EQ-GLA-001', 'Lumenis', 'Selecta Trio SLT', 3),
('EQ-RET-001', 'Topcon', 'TRC-50DX', 4),
('EQ-ANG-001', 'Heidelberg', 'SPECTRALIS HRA', 5),
('EQ-TOP-001', 'Oculus', 'Pentacam HR', 6),
('EQ-OCT-001', 'Zeiss', 'Cirrus HD-OCT 5000', 7),
('EQ-OCT-002', 'Optovue', 'RTVue XR Avanti', 7),
('EQ-PTE-001', 'Leica', 'M822 F20 Surgical', 8),
('EQ-DML-001', 'Haag-Streit', 'BI 900 Imaging', 9),
('EQ-VIT-001', 'Alcon', 'Constellation Vision', 10),
('EQ-CRO-001', 'Avedro', 'KXL System', 11),
('EQ-YAG-001', 'Ellex', 'Tango Reflex YAG/SLT', 12),
('EQ-IRI-001', 'Quantel Medical', 'Soltis Laser', 13),
('EQ-ORT-001', 'Nidek', 'Synoptophore 200', 14),
('EQ-BIO-001', 'Zeiss', 'IOLMaster 700', 15),
('EQ-CVI-001', 'Haag-Streit', 'Octopus 900', 16),
('EQ-STR-001', 'Zeiss', 'OPMI Lumera 700', 17);

-- Insertion dans interventions_consultations

INSERT INTO interventions_consultations (id_patient, id_equipement, date_debut, date_fin, montant_total, statut) VALUES
(1, 1, '2025-10-01 08:30:00', '2025-10-01 11:30:00', 1500.00, 'Terminée'),
(2, 3, '2025-10-02 09:00:00', '2025-10-03 09:00:00', 4400.00, 'Terminée'),
(3, 9, '2025-10-05 14:00:00', '2025-10-05 15:30:00', 650.00, 'Terminée'),
(4, 5, '2025-10-10 10:00:00', '2025-10-10 12:00:00', 1200.00, 'Terminée'),
(5, 3, '2025-10-12 11:00:00', '2025-10-14 11:00:00', 6600.00, 'Terminée'),
(6, 7, '2025-10-15 08:00:00', '2025-10-15 10:00:00', 800.00, 'Terminée'),
(7, 2, '2025-10-18 13:00:00', '2025-10-18 16:00:00', 1500.00, 'Terminée'),
(8, 8, '2025-10-20 15:00:00', '2025-10-20 16:00:00', 500.00, 'Terminée'),
(9, 13, '2025-10-21 07:30:00', '2025-10-23 07:30:00', 7000.00, 'Terminée'),
(10, 15, '2025-10-21 09:00:00', NULL, NULL, 'En cours'),
(11, 4, '2025-10-21 10:30:00', NULL, NULL, 'En cours'),
(12, 1, '2025-10-21 11:00:00', NULL, NULL, 'En cours'),
(13, 6, '2025-10-19 16:00:00', '2025-10-19 17:00:00', 450.00, 'Terminée'),
(14, 18, '2025-10-17 08:30:00', '2025-10-17 09:30:00', 400.00, 'Terminée'),
(15, 19, '2025-10-16 14:30:00', '2025-10-16 15:30:00', 350.00, 'Terminée'),
(16, 11, '2025-10-14 10:00:00', '2025-10-14 13:00:00', 1800.00, 'Terminée'),
(17, 14, '2025-10-11 09:00:00', '2025-10-11 11:00:00', 1300.00, 'Terminée'),
(18, 12, '2025-10-09 15:00:00', '2025-10-09 18:00:00', 2500.00, 'Terminée'),
(19, 20, '2025-10-08 08:00:00', '2025-10-09 08:00:00', 5600.00, 'Terminée'),
(20, 10, '2025-10-21 12:00:00', NULL, NULL, 'En cours');