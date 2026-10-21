-- Groupe : 
-- Nom : 
-- Prénom : 


-- Question 1 : Vue - 2 points
-- Créez une vue V_Locations_EnCours qui affiche les locations ayant le statut 'En cours'. 
-- La vue doit montrer le nom et prénom du client, la marque et le modèle du véhicule, 
-- ainsi que la date de début de la location.



-- Question 2 : Fonction - 2 points
-- Créez une fonction F_CalculerAgeClient qui prend une date de naissance (DATE) en paramètre
--  et retourne l'âge actuel du client en années.



-- Question 3 : Procédure Stockée - 2 points
-- Créez une procédure PS_AjouterClient pour ajouter un nouveau client. Cette procédure doit 
-- vérifier que le numéro de permis n'existe pas déjà dans la base avant de réaliser l'insertion.
--  Si le permis existe déjà, la procédure ne doit rien faire.



-- Question 4 : Procédure Stockée - 2 points
-- Créez une procédure PS_TerminerLocation qui prend en paramètre un id_location. Cette procédure 
-- doit, en utilisant une transaction :
-- 1.	Mettre à jour la date_fin de la location à la date et heure actuelles .
-- 2.	Changer le statut de la location à 'Terminée'.
-- 3.	Calculer et mettre à jour le montant_total. Le montant est le nombre de jours de location
--  (arrondi à l'entier supérieur, par exemple 25h = 2 jours) multiplié par le prix_journalier
--   de la catégorie du véhicule.



-- Question 5 : Trigger - 2 points
-- Créez un trigger TR_Avant_Insert_Location qui se déclenche avant une insertion dans la table 
-- locations. Ce trigger doit vérifier si le véhicule est déjà en cours de location 
-- (statut 'En cours'). Si c'est le cas, il doit annuler l'insertion et lever une erreur avec
--  un message clair comme "Ce véhicule est déjà en location".



-- Question 6 : Trigger - 2 points
-- Créez un trigger nommé TR_Interdire_Suppression_Categorie. Ce trigger doit se déclencher 
-- avant la suppression d'une ligne de la table categories. Il doit empêcher la suppression 
-- si au moins un véhicule est encore associé à cette catégorie dans la table vehicules, 
-- en levant une erreur.



-- Question 7 : Fonction - 2 points
-- Créez une fonction F_ChiffreAffairesVehicule qui accepte un id_vehicule et une période 
-- (deux dates : date_debut_periode, date_fin_periode) en paramètres. Elle doit retourner
--  le chiffre d'affaires total généré par ce véhicule spécifique pour les locations
--   terminées (statut = 'Terminée') dont la date de fin est dans cette période.



-- Question 8 : Procédure Stockée - 2 points
-- Créez une procédure stockée nommée PS_RapportDepensesClients qui n'accepte aucun paramètre.
--  Cette procédure doit utiliser un curseur pour parcourir chaque client. Pour chaque client,
--   elle doit calculer et afficher son nom, son prénom, le nombre total de locations terminées 
--   qu'il a effectuées et le montant total qu'il a dépensé dans l'agence.



-- Question 9 : Gestion des Utilisateurs (Rôles et Droits) - 2 points
-- Écrivez les commandes SQL pour :
-- 1.	Créer un rôle agents_accueil.
-- 2.	Donner à ce rôle les droits de SELECT, INSERT, UPDATE sur les tables clients et locations.
-- 3.	Créer un utilisateur agent1 avec le mot de passe 'password123'.
-- 4.	Assigner le rôle agents_accueil à l'utilisateur agent1.



-- Question 10 : Sauvegarde et Restauration - 2 points
-- Écrivez les commandes (à exécuter dans le terminal de votre système, et non en SQL) pour :
-- 1.	Sauvegarder la base de données location_voitures_db dans un fichier nommé backup_location.sql.
-- 2.	Supprimer la base de données (pour simuler une perte) puis la restaurer à partir 
-- du fichier backup_location.sql.

