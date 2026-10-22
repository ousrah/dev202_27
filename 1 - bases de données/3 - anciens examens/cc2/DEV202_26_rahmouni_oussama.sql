Groupe : 
Nom : 
Prénom : 




-- Question 1 : Vue - 2 points
-- Créez une vue V_RendezVous_Aujourdhui qui affiche les rendez-vous du '2025-11-20'
--  avec le nom du patient, du dentiste et l'heure du RDV.



-- Question 2 : Fonction  - 2 points
-- Créez une fonction F_CalculerAge qui prend une date de naissance en paramètre 
-- et retourne l'âge du patient.


-- Question 3 : Procédure Stockée - 2 points
-- Créez une procédure PS_AjouterPatient pour ajouter un nouveau patient en vérifiant
-- qu'il n'existe pas déjà (même nom et prénom).


-- Question 4 : Procédure Stockée - 2 points
-- Créez une procédure PS_FacturerRendezVousRealises qui utilise un curseur et une 
-- transaction pour calculer et mettre à jour le prix_total de tous les actes effectués.


-- Question 5 : Trigger - 2 points
-- Créez un trigger TR_Avant_Insert_Acte qui calcule automatiquement le prix_total
--  avant chaque insertion dans actes_effectues.


-- Question 6 : Trigger  2 points
-- Créez un trigger nommé TR_Interdire_Suppression_Traitement. Ce trigger doit se 
-- déclencher avant la suppression d'une ligne de la table traitements. Il doit empêcher 
-- la suppression d'un traitement s'il a déjà été utilisé au moins une fois dans la 
-- table actes_effectues, en affichant un message d'erreur clair.


-- Question 7 : Fonction 2 points
-- Créez une fonction F_ChiffreAffairesDentiste qui accepte un id_dentiste et une 
-- période (deux dates) en paramètres et qui retourne le chiffre d'affaires total généré 
-- par ce dentiste. (Le chiffre d’affaires c’est le montant totale qu’il a réalisée durant
--  la période indiquée)


-- Question 8 : Procédure Stockée - 2 points
-- Créez une procédure stockée nommée PS_GenererRapportRentabilite qui n'accepte 
-- aucun paramètre. Cette procédure doit utiliser un curseur pour parcourir chaque 
-- dentiste de la table dentistes. Pour chaque dentiste, elle doit trouver le 
-- traitement qui lui a rapporté le plus d'argent (le plus rentable) et le 
-- montant total de ce revenu. La procédure devra afficher pour chaque dentiste 
-- son nom, son prénom, le nom du traitement le plus rentable et le montant 
-- généré par ce traitement.


-- Question 9 : Gestion des Utilisateurs (Groupes et Droits) - 2 points
-- Écrivez les commandes SQL pour créer un rôle secretaires avec des droits
--  (SELECT, INSERT, UPDATE) sur les tables patients et rendez_vous, créer un 
--  utilisateur secretaire1 et lui assigner ce rôle.


-- Question 10 : Sauvegarde et Restauration - 2 points
-- Écrivez les commandes en ligne de commande pour sauvegarder et 
-- restaurer la base de données dentiste_db.
