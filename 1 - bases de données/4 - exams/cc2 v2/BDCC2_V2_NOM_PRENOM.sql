
/*Consignes importantes :
•	Utilisez le script fourni pour créer la base de données HotelStay sur votre poste de travail.
•	Enregistrez votre script de réponses sous le nom : BDCC2_V1_Nom_Prenom.sql en remplaçant les 
pointillés par votre nom et prénom.
•	Envoyez votre fichier à la fin de l'examen à l'adresse email suivante : ousrah@hotmail.com. 
•	Important : N’oubliez pas d’enregistrer régulièrement votre travail ; aucune augmentation de temps 
ne sera attribuée en cas de perte. 
*/
 
 
/*
Question 1 : Vue - 2 points
Créez une vue V_Interventions_EnCours qui affiche les interventions ayant le statut 'En cours'. La vue 
doit montrer le nom et le prénom du patient, la marque et le modèle de l'équipement médical, ainsi que
 la date de début de l'intervention.
*/
 
 
/*
Question 2 : Fonction - 2 points
Créez une fonction F_CalculerAgePatient qui prend une date de naissance (DATE) en paramètre et retourne 
l'âge actuel du patient en années.
*/
 
 
/*
Question 3 : Procédure Stockée - 2 points
Créez une procédure PS_AjouterPatient pour ajouter un nouveau patient. Cette procédure doit vérifier que 
le numéro de CIN (numero_cin) n'existe pas déjà dans la base avant de réaliser l'insertion. Si le CIN
 existe déjà, la procédure ne doit rien faire.
*/
 
 
/*
Question 4 : Procédure Stockée - 2 points
Créez une procédure PS_TerminerIntervention qui prend en paramètre un id_intervention. Cette procédure doit,
 en utilisant une transaction :
•	Mettre à jour la date_fin de l'intervention à la date et heure actuelles.
•	Changer le statut de l'intervention à 'Terminée'.
•	Calculer et mettre à jour le montant_total. Le montant est le nombre de jours (ou d'unités de temps, 
arrondi à l'entier supérieur, par exemple 25h = 2 jours) multiplié par le tarif_base de la spécialité de
 l'équipement médical associé.
*/
 
 
/*
Question 5 : Trigger - 2 points
Créez un trigger TR_Avant_Insert_Intervention qui se déclenche avant une insertion dans la table 
interventions_consultations. Ce trigger doit vérifier si l'équipement médical est déjà en cours 
d'utilisation (statut 'En cours'). Si c'est le cas, il doit annuler l'insertion et lever une erreur 
avec un message clair comme "Cet équipement est déjà réservé pour une intervention en cours".
*/
 
 
/*
Question 6 : Trigger - 2 points
Créez un trigger nommé TR_Interdire_Suppression_Specialite. Ce trigger doit se déclencher avant la 
suppression d'une ligne de la table specialites_actes. Il doit empêcher la suppression si au moins un
 équipement médical est encore associé à cette spécialité dans la table equipements_medicaux, en levant
 une erreur.
*/
 
 
/*
Question 7 : Fonction - 2 points
Créez une fonction F_ChiffreAffairesEquipement qui accepte un id_equipement et une période (deux dates :
 date_debut_periode, date_fin_periode) en paramètres. Elle doit retourner le chiffre d'affaires total 
 généré par cet équipement spécifique pour les interventions terminées (statut = 'Terminée') dont la 
 date de fin est dans cette période.
*/
 
 
/*
Question 8 : Procédure Stockée - 2 points
Créez une procédure stockée nommée PS_RapportDepensesPatients qui n'accepte aucun paramètre. Cette 
procédure doit utiliser un curseur pour parcourir chaque patient. Pour chaque patient, elle doit 
calculer et afficher son nom, son prénom, le nombre total d'interventions terminées qu'il a effectuées
 et le montant total qu'il a dépensé à la clinique.
*/
 
 
 
/*
Question 9 : Gestion des Utilisateurs (Rôles et Droits) - 2 points
Écrivez les commandes SQL pour :
•	Créer un rôle receptionnistes_clinique.
•	Donner à ce rôle les droits de SELECT, INSERT, UPDATE sur les tables patients et 
interventions_consultations.
•	Créer un utilisateur receptionniste1 avec le mot de passe 'password123'.
•	Assigner le rôle receptionnistes_clinique à l'utilisateur receptionniste1.
*/
 
 
/*
Question 10 : Sauvegarde et Restauration - 2 points
Écrivez les commandes (à exécuter dans le terminal de votre système, et non en SQL) pour :
•	Sauvegarder la base de données clinique_ophtalmo_db dans un fichier nommé backup_clinique.sql.
*/
 
 
/*
•	Supprimer la base de données (pour simuler une perte) puis la restaurer à partir du fichier 
backup_clinique.sql.
*/
