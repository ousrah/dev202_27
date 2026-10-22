#Travail à faire#
#Pour chaque question, rédigez la requête SQL permettant de répondre au besoin.
USE HotelStay;

#Fonctions

#1.	[2 Pts] Créez une fonction nommée CalculerAncienneteClient qui prend 
#en paramètre un id_client et retourne le nombre d'années complètes écoulées
# depuis sa date d'inscription.

drop function if exists CalculerAncienneteClient;

delimiter //

create function if not exists CalculerAncienneteClient(id int)
returns varchar(30)
deterministic
begin
	if exists (select * from client where id_client=id) then
		return (select timestampdiff(year,date_inscription,curdate())from client where id_client=id);
	#	return (select floor(datediff(curdate(),date_inscription)/365) from client where id_client=id);

	else 
		return "client n'existe pas";
	end if ;
end //
delimiter ;

select CalculerAncienneteClient(4);
#2.	[2 Pts] Créez une fonction ClientPlusGrandNombreReservations qui 
#accepte en paramètres un id_hotel et une annee. Elle doit retourner 
#l'identifiant (id_client) du client ayant effectué le plus grand nombre
## de réservations pour des chambres rattachées à cet hôtel au cours de 
# l'année spécifiée. (vous pouvez utiliser LIMIT 1 si vous le souhaitez)


drop function if exists ClientPlusGrandNombreReservations;

delimiter //

create function if not exists ClientPlusGrandNombreReservations(idhotel int, annee int)
returns int
deterministic
begin
return(
	select id_client  
	from Reservation 
	inner join chambre using(numero_chambre)
	where id_hotel = idhotel 
		  and year(date_debut) = annee
	group by id_client
	order by count(*) desc
	limit 1
);
end //
delimiter ;

select ClientPlusGrandNombreReservations(1,2026);








select * from reservation;

#Procédures Stockées

#3.	[2 Pts] Élaborez une procédure stockée PlanifierTravauxChambre qui 
#prend en paramètres le numero_chambre, une date_debut, une description 
##et une date_fin_reelle (optionnelle/prévue). La procédure doit insérer 
#une nouvelle entrée dans la table TRAVAUX_ENTRETIEN et mettre à jour le 
#statut de la chambre concernée à 'En rénovation' pour la rendre indisponible.
drop procedure if exists PlannifierTraveauxChambre;
delimiter &&
create procedure if not exists PlannifierTraveauxChambre(
num_chambre int , 
date_d date ,
descriptionn text ,
 date_f date)
 begin
	insert into travaux_entretien(numero_chambre,date_debut,date_fin_reelle,description,cout)
	values(num_chambre,date_d,date_f,descriptionn,0);

	update chambre
	set statut = 'en rénovation' where numero_chambre = num_chambre;

end&&
delimiter ;
call PlannifierTraveauxChambre(101,'2026/10/10','test',null);
;



select * from chambre;
select * from travaux_entretien;

#4.	[2 Pts] Créez une procédure stockée CloturerReservation qui prend en 
#paramètres un id_reservation et les indemnite_accordee_eventuelles. 
#Cette procédure doit réaliser les opérations suivantes :
#•	Mettre à jour le statut de la réservation à 'Clôturée'.
#•	Si des indemnités ou frais supplémentaires existent 
#(indemnite_accordee_eventuelles > 0), insérer un enregistrement dans 
###la table RECLAMATION lié à la réservation.
#•	Remettre le statut de la chambre rattachée à cette réservation à 
#'Disponible'.

drop procedure if exists CloturerReservation;
delimiter &&
create procedure if not exists CloturerReservation(
id_res int , 
indemnites float)
 begin
	update Reservation set statut='cloturée' where id_reservation = id_res ;
    if indemnites>0 then
		insert into RECLAMATION (date_constat,description, indemnite_accordee,id_reservation)
        values (current_date(),'', indemnites,id_res);
	end if;
    #update chambre join reservation using(numero_chambre) 
    #set chambre.statut  = 'Disponible' where id_reservation = id_res;
    update chambre 
    set statut = 'disponible' 
    where numero_chambre in (select numero_chambre 
							from reservation 
							where id_reservation = id_res);
end&&
delimiter ;

call CloturerReservation(1,100);
;





#Triggers (Déclencheurs)

#5.	[2 Pts] Mettez en place un trigger nommé AlerteCoutTravaux qui se 
#déclenche automatiquement après une insertion dans la table TRAVAUX_ENTRETIEN.
# Si le coût total cumulé des travaux pour une chambre donnée dépasse 
# un seuil de 30 000 DH, le trigger doit insérer une alerte dans une 
# table ALERTE_RENOVATION (id_alerte, message, date_alerte, #numero_chambre).
# (On supposera que la table ALERTE_RENOVATION existe déjà).

create table ALERTE_RENOVATION (id_alerte int auto_increment primary key,
 message text , date_alerte datetime, numero_chambre int,
 FOREIGN KEY (numero_chambre) REFERENCES CHAMBRE(numero_chambre) ON DELETE CASCADE

 );


drop trigger if exists AlerteCoutTravaux;
delimiter $$
create trigger AlerteCoutTravaux after insert on travaux_entretien for each row
begin
	declare cout_total decimal(10,2);
    select sum(cout) into cout_total from travaux_entretien 
    where numero_chambre=new.numero_chambre;
    if (cout_total> 30000) then
		insert into ALERTE_RENOVATION 
        values(null,'le cout total dépasse 30 000',curdate(),new.numero_chambre);
	end if;
end $$
delimiter ;
select sum(cout) from travaux_entretien where numero_chambre = 101;


	insert into travaux_entretien(numero_chambre,date_debut,date_fin_reelle,description,cout)
	values(101,'2026/10/10','2026/10/10','test',100);
    
    select * from ALERTE_RENOVATION;



#6.	[2 Pts] Créez un trigger nommé HistoriserChangementStatutChambre 
#qui s'active automatiquement après toute mise à jour de la colonne statut
# de la table CHAMBRE. Si le statut a changé, le trigger doit insérer un 
# enregistrement dans une table d'historique HISTORIQUE_STATUT_CHAMBRE 
# (id_historique, anc_statut, nouveau_statut, date_changement, #numero_chambre).



create table HISTORIQUE_STATUT_CHAMBRE 
(id_historique int auto_increment primary key, anc_statut
varchar(50), nouveau_statut varchar(50), date_changement datetime ,
  numero_chambre int,
 FOREIGN KEY (numero_chambre) REFERENCES CHAMBRE(numero_chambre) ON DELETE CASCADE

 );


# (On supposera que la table HISTORIQUE_STATUT_CHAMBRE existe déjà).
drop trigger if exists HistoriserChangementStatutChambre;
delimiter $$
create trigger HistoriserChangementStatutChambre after update on chambre for each row
begin
	if old.statut <>new.statut then
       insert into HISTORIQUE_STATUT_CHAMBRE(anc_statut, nouveau_statut, date_changement,numero_chambre)
       values (old.statut,new.statut,now(),new.numero_chambre);
	end if;
end $$
delimiter ;



	insert into travaux_entretien(numero_chambre,date_debut,date_fin_reelle,description,cout)
	values(101,'2026/10/10','2026/10/10','test',100);
    
    select * from ALERTE_RENOVATION;

