drop database if exists fleetrent;
create database if not exists fleetrent collate utf8mb4_general_ci;
use fleetrent;

-- ==========================================
-- 1. TABLE DEPOT
-- ==========================================
CREATE TABLE DEPOT (
    id_depot INT AUTO_INCREMENT PRIMARY KEY,
    nom_depot VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL
);

INSERT INTO DEPOT (id_depot, nom_depot, ville) VALUES
(1, 'Depot Nord - Lille', 'Lille'),
(2, 'Depot IDF - Paris Centre', 'Paris'),
(3, 'Depot Est - Strasbourg', 'Strasbourg'),
(4, 'Depot Ouest - Nantes', 'Nantes'),
(5, 'Depot Sud-Est - Lyon', 'Lyon'),
(6, 'Depot Sud-Ouest - Bordeaux', 'Bordeaux'),
(7, 'Depot Mediterranee - Marseille', 'Marseille'),
(8, 'Depot Centre - Clermont-Ferrand', 'Clermont-Ferrand'),
(9, 'Depot Normandie - Rouen', 'Rouen'),
(10, 'Depot Occitanie - Toulouse', 'Toulouse');


-- ==========================================
-- 2. TABLE CLIENT
-- ==========================================
CREATE TABLE CLIENT (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom_societe VARCHAR(100) NOT NULL,
    responsable VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    date_adhesion DATE NOT NULL
);

INSERT INTO CLIENT (id_client, nom_societe, responsable, email, date_adhesion) VALUES
(1, 'Vinci Construction', 'Marc Lefevre', 'm.lefevre@vinci-construit.fr', '2022-01-15'),
(2, 'Eiffage TP', 'Sophie Bernard', 's.bernard@eiffage-tp.com', '2022-03-20'),
(3, 'Bouygues Travaux Publics', 'Jean Dupont', 'j.dupont@bouygues-tp.fr', '2021-11-05'),
(4, 'Colas Midi', 'Claire Moreau', 'c.moreau@colas-midi.fr', '2023-02-10'),
(5, 'NGE Fondations', 'Thomas Petit', 't.petit@nge-fondations.fr', '2023-06-18'),
(6, 'Spie Batignolles', 'Julie Leroy', 'j.leroy@spiebatignolles.fr', '2020-09-12'),
(7, 'Fayat Bâtiment', 'David Roux', 'd.roux@fayat-batiment.com', '2022-07-25'),
(8, 'Demathieu Bard', 'Emilie Fournier', 'e.fournier@demathieu-bard.fr', '2021-04-30'),
(9, 'Vicat TP', 'Alexandre Girard', 'a.girard@vicat-tp.fr', '2023-01-08'),
(10, 'Lingenheld TP', 'Karine Bonnet', 'k.bonnet@lingenheld.fr', '2023-09-01');


-- ==========================================
-- 3. TABLE MATERIEL
-- ==========================================
CREATE TABLE MATERIEL (
    code_materiel INT AUTO_INCREMENT PRIMARY KEY,
    designation VARCHAR(100) NOT NULL,
    categorie VARCHAR(50) NOT NULL,
    tarif_journalier DECIMAL(10, 2) NOT NULL,
    statut ENUM('Disponible', 'En location', 'En entretien', 'Hors service') NOT NULL DEFAULT 'Disponible',
    id_depot_base INT NOT NULL,
    CONSTRAINT fk_materiel_depot FOREIGN KEY (id_depot_base) REFERENCES DEPOT(id_depot)
);

INSERT INTO MATERIEL (code_materiel, designation, categorie, tarif_journalier, statut, id_depot_base) VALUES
(101, 'Pelle hydraulique sur chenilles 20T', 'Terrassement', 450.00, 'En location', 1),
(102, 'Nacelle articulée 20m diesel', 'Elevation', 280.00, 'Disponible', 2),
(103, 'Compacteur monocylindre 12T', 'Compactage', 320.00, 'En entretien', 3),
(104, 'Mini-pelle 2.5T compacte', 'Terrassement', 180.00, 'Disponible', 4),
(105, 'Chantier Grue mobile 40T', 'Levage', 1200.00, 'Hors service', 5),
(106, 'Chargeuse sur pneus 15m3', 'Terrassement', 500.00, 'En location', 6),
(107, 'Groupe électrogène 100 kVA', 'Energie', 150.00, 'Disponible', 7),
(108, 'Marteau piqueur pneumatique lourd', 'Outillage', 45.00, 'Disponible', 8),
(109, 'Telescopique rotatif 18m', 'Manutention', 420.00, 'En location', 9),
(110, 'Plaque vibrante reversible 500kg', 'Compactage', 90.00, 'En entretien', 10);


-- ==========================================
-- 4. TABLE CONTRAT_LOCATION
-- ==========================================
CREATE TABLE CONTRAT_LOCATION (
    id_contrat INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin_prevue DATE NOT NULL,
    kilometrage_heures_estime INT NOT NULL,
    statut VARCHAR(50) NOT NULL,
    id_client INT NOT NULL,
    code_materiel INT NOT NULL,
    CONSTRAINT fk_contrat_client FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
    CONSTRAINT fk_contrat_materiel FOREIGN KEY (code_materiel) REFERENCES MATERIEL(code_materiel)
);

INSERT INTO CONTRAT_LOCATION (id_contrat, date_debut, date_fin_prevue, kilometrage_heures_estime, statut, id_client, code_materiel) VALUES
(1, '2026-03-01', '2026-04-01', 160, 'En cours', 1, 101),
(2, '2026-03-05', '2026-03-20', 80, 'En cours', 2, 102),
(3, '2026-02-10', '2026-02-28', 120, 'Clôturé', 3, 103),
(4, '2026-03-10', '2026-03-25', 100, 'En cours', 4, 104),
(5, '2026-01-15', '2026-02-15', 200, 'Clôturé', 5, 105),
(6, '2026-03-02', '2026-04-15', 250, 'En cours', 6, 106),
(7, '2026-02-01', '2026-02-10', 50, 'Clôturé', 7, 107),
(8, '2026-03-08', '2026-03-12', 30, 'En cours', 8, 108),
(9, '2026-03-04', '2026-03-30', 180, 'En cours', 9, 109),
(10, '2026-01-20', '2026-02-05', 90, 'Clôturé', 10, 110);


-- ==========================================
-- 5. TABLE ENTRETIEN
-- ==========================================
CREATE TABLE ENTRETIEN (
    id_entretien INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin_reelle DATE DEFAULT NULL,
    description TEXT NOT NULL,
    cout DECIMAL(10, 2) NOT NULL,
    code_materiel INT NOT NULL,
    CONSTRAINT fk_entretien_materiel FOREIGN KEY (code_materiel) REFERENCES MATERIEL(code_materiel)
);

INSERT INTO ENTRETIEN (id_entretien, date_debut, date_fin_reelle, description, cout, code_materiel) VALUES
(1, '2026-01-10', '2026-01-12', 'Vidange complète et changement des filtres hydrauliques', 450.00, 101),
(2, '2026-02-05', '2026-02-06', 'Contrôle réglementaire VGP et graissage des articulations', 220.00, 102),
(3, '2026-03-01', '2026-03-04', 'Remplacement des galets de chenille et vérification moteur', 1350.00, 103),
(4, '2026-01-20', '2026-01-21', 'Révision standard des 500 heures', 300.00, 104),
(5, '2026-02-20', NULL, 'Diagnostic panne système hydraulique principal', 890.00, 105),
(6, '2026-01-05', '2026-01-07', 'Changement des pneumatiques avant', 2100.00, 106),
(7, '2026-02-15', '2026-02-16', 'Maintenance préventive alternateur', 180.00, 107),
(8, '2026-01-30', '2026-01-30', 'Affûtage et graissage du mécanisme de percussion', 75.00, 108),
(9, '2026-02-10', '2026-02-12', 'Étalonnage des capteurs de charge et contrôle flèche', 520.00, 109),
(10, '2026-03-02', NULL, 'Réparation fuite d’huile sur le carter vibrant', 260.00, 110);


-- ==========================================
-- 6. TABLE ANOMALIE
-- ==========================================
CREATE TABLE ANOMALIE (
    id_anomalie INT AUTO_INCREMENT PRIMARY KEY,
    date_constat DATE NOT NULL,
    description TEXT NOT NULL,
    frais_imposes DECIMAL(10, 2) DEFAULT 0.00,
    id_contrat INT NOT NULL,
    CONSTRAINT fk_anomalie_contrat FOREIGN KEY (id_contrat) REFERENCES CONTRAT_LOCATION(id_contrat)
);

INSERT INTO ANOMALIE (id_anomalie, date_constat, description, frais_imposes, id_contrat) VALUES
(1, '2026-03-10', 'Impact important sur le pare-brise de la cabine', 350.00, 1),
(2, '2026-03-12', 'Rayure profonde sur le flanc du bras télescopique', 450.00, 2),
(3, '2026-02-20', 'Retrait du matériel avec retard de restitution', 150.00, 3),
(4, '2026-03-15', 'Niveau de carburant non restitué au même niveau', 90.00, 4),
(5, '2026-02-01', 'Choc sur le capot moteur lors de la manipulation', 650.00, 5),
(6, '2026-03-18', 'Crevaison lente sur un pneu arrière due à un débris', 280.00, 6),
(7, '2026-02-05', 'Perte du câble de raccordement électrique principal', 120.00, 7),
(8, '2026-03-09', 'Flexible hydraulique endommagé par mauvaise utilisation', 210.00, 8),
(9, '2026-03-14', 'Matériel rendu extrêmement sale (nettoyage lourd requis)', 180.00, 9),
(10, '2026-01-25', 'Carter de protection inférieur enfoncé', 320.00, 10);