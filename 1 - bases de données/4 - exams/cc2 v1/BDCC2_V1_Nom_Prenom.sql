/*Consignes importantes :
•	Utilisez le script fourni pour créer la base de données HotelStay sur votre poste de travail.
•	Enregistrez votre script de réponses sous le nom : BDCC2_V1_Nom_Prenom.sql en remplaçant les 
pointillés par votre nom et prénom.
•	Envoyez votre fichier à la fin de l'examen à l'adresse email suivante : ousrah@hotmail.com. 
•	Important : N’oubliez pas d’enregistrer régulièrement votre travail ; aucune augmentation de temps
 ne sera attribuée en cas de perte. 
*/



/*
Question 1 : Vue (2 points)
Créez une vue nommée V_Reservations_Mars2026 qui affiche les réservations du mois de mars 2026 
(dont la date de début est comprise entre '2026-03-01' et '2026-03-31') avec le nom et le prénom du client,
 le nom de l'hôtel, le numéro de chambre ainsi que la date de début et le statut de la réservation.
*/



/*
Question 2 : Fonction (2 points)
Créez une fonction nommée F_CalculerDureeSejour qui prend en paramètre l'identifiant d'une réservation
 (id_reservation) et retourne le nombre de jours total de la réservation (différence entre date_fin_prevue
 et date_debut).
*/



/*
Question 3 : Procédure Stockée (2 points)
Créez une procédure stockée nommée PS_AjouterClient pour ajouter un nouveau client dans la table CLIENT.
 La procédure doit vérifier au préalable qu'aucun client n'existe déjà avec le même email. Si l'email existe
 déjà, elle doit afficher un message d'erreur, sinon elle procède à l'insertion.
*/



/*
Question 4 : Procédure Stockée (2 points)
Créez une procédure stockée nommée PS_MettreAJourStatutsChambres qui utilise un curseur et une transaction
 pour parcourir toutes les chambres et mettre à jour automatiquement leur statut à 'Disponible' si leur date 
 de fin de réservation prévue est dépassée par rapport à la date du jour, en veillant à garantir l'intégrité
 des données.
*/



/*
Question 5 : Trigger (2 points)
Créez un trigger nommé TR_Avant_Insert_Travaux qui se déclenche avant l'insertion dans la table
 TRAVAUX_ENTRETIEN. Ce trigger doit vérifier si la date de début des travaux est antérieure à 
 la date du jour ; si c'est le cas, il doit forcer ou attribuer automatiquement la date du jour 
 (CURRENT_DATE()) comme date de début.

 
*/



/*
Question 6 : Trigger (2 points)
Créez un trigger nommé TR_Interdire_Suppression_Chambre. Ce trigger doit se déclencher avant la 
suppression d'une ligne de la table CHAMBRE. Il doit empêcher la suppression d'une chambre si celle-ci 
possède des enregistrements associés dans la table TRAVAUX_ENTRETIEN, en déclenchant une erreur explicite 
pour l'utilisateur.
*/



/*
Question 7 : Fonction (2 points)
Créez une fonction nommée F_ChiffreAffairesHotel qui accepte un identifiant d'hôtel (id_hotel) en paramètre 
et retourne le montant total généré par les réservations confirmées ou en cours pour cet hôtel (somme des 
(nb_personnes * prix_nuit * durée du séjour) ou basée sur le tarif des nuits des chambres réservées de
 cet hôtel).
*/



/*
Question 8 : Procédure Stockée (2 points)
Créez une procédure stockée nommée PS_GenererRapportReclamations qui n'accepte aucun paramètre. 
Cette procédure doit utiliser un curseur pour parcourir chaque hôtel de la table HOTEL. Pour chaque hôtel, 
elle doit calculer le montant total des indemnités accordées suite aux réclamations liées à ses réservations.
 La procédure affichera le nom de l'hôtel, sa ville et le montant total des indemnités versées.
*/



/*
Question 9 : Gestion des Utilisateurs (Groupes et Droits) (2 points)
Écrivez les commandes SQL pour créer un rôle nommé responsables_hotel disposant des droits de consultation 
et de modification (SELECT, INSERT, UPDATE) sur les tables CHAMBRE et RESERVATION, puis créez un utilisateur
 nommé agent_accueil1 et assignez-lui ce rôle.
*/



/*
Question 10 : Sauvegarde et Restauration (2 points)
Écrivez les commandes en ligne de commande (sous l'invite de commande du système ou terminal) permettant de :
1.	Sauvegarder (faire un dump de) la base de données HotelStay dans un fichier nommé backup_hotelstay.sql.
*/



/*
2.	Restaurer cette base de données à partir du fichier de sauvegarde.
*/


