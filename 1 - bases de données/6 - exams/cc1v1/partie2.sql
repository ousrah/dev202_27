#Partie 2 : Langage SQL et Programmation Avancée (12 points)
#Exercice 2 : Fonctions, Procédures Stockées et Triggers
#Contexte
#Vous gérez la base de données de l'entreprise "FleetRent", spécialisée dans la location de matériel de chantier pour les entreprises de BTP. Le schéma relationnel est le suivant :
#•	CLIENT (id_client, nom_societe, responsable, email, date_adhesion)
#•	MATERIEL (code_materiel, designation, categorie, tarif_journalier, statut, #id_depot_base)
#•	DEPOT (id_depot, nom_depot, ville)
#•	CONTRAT_LOCATION (id_contrat, date_debut, date_fin_prevue, kilometrage_heures_estime, statut, #id_client, #code_materiel)
#•	ENTRETIEN (id_entretien, date_debut, date_fin_reelle, description, cout, #code_materiel)
#•	ANOMALIE (id_anomalie, date_constat, description, frais_imposes, #id_contrat)
#(Note : le champ statut de la table MATERIEL peut prendre les valeurs : 'Disponible', 'En location', 'En entretien', 'Hors service').
 
 
 #voir fichier script_fleetrent.sql



#Travail à faire
#Pour chaque question, rédigez la requête SQL permettant de répondre au besoin.


#Fonctions
##1.	[2 Pts] Créez une fonction nommée CalculerAncienneteClient qui 
#prend en paramètre un id_client et retourne
# le nombre d'années complètes écoulées depuis sa date d'adhésion.
use fleetrent;
drop function if exists CalculerAncienneteClient;
delimiter &
create function CalculerAncienneteClient(c_id int)
returns int 
deterministic
begin 
	declare AC int;
	select timestampdiff(year,date_adhesion,current_date())
	into AC
	from client 
	where id_client=c_id;
    #on peut la faire aussi avec datediff
    #select floor(datediff(current_date(),date_adhesion)/365)
	#into AC
	#from client 
	#where id_client=c_id;
    
 
 return AC;
 end&
 delimiter ; 
 select CalculerAncienneteClient(1);



#2.	[2 Pts] Créez une fonction ClientPlusGrandNombreLocations qui 
#accepte en paramètres un id_depot et une annee. Elle doit retourner 
#l'identifiant (id_client) du client ayant effectué le plus grand nombre 
#de contrats de location pour des matériels rattachés à ce dépôt au cours 
#de l'année spécifiée. (vous pouvez utiliser limit 1 si vous la souhaitez)
drop function if exists ClientPlusGrandNombreLocations;
delimiter //
create function ClientPlusGrandNombreLocations(depot int,annee int)
returns int 
deterministic
begin 
	return (
		select id_client 
        from contrat_location
        join materiel using(code_materiel)
        where id_depot_base=depot 
        and year(date_debut)=annee
        group by id_client
        order by count(*) desc
        limit 1
    );
end//
delimiter ;
select * from contrat_location;
select ClientPlusGrandNombreLocations(1,2026);








#Procédures Stockées
#3.	[2 Pts] Élaborez une procédure stockée PlanifierEntretien qui 
#prend en paramètres le code_materiel, une date_debut, une description 
#et une date_fin_reelle (optionnelle/prévue). La procédure doit insérer 
#une nouvelle entrée dans la table ENTRETIEN et mettre à jour le statut 
#du matériel concerné à 'En entretien' pour le rendre indisponible.
drop procedure if exists PlanifierEntretien;
delimiter ::
create procedure if not exists PlanifierEntretien(codemateriel int ,datedebut date 
,descriptions varchar(50),datefinreelle date)
begin
insert into ENTRETIEN values (null,datedebut,datefinreelle,descriptions
, 0,codemateriel);
update materiel set statut='En entretien' where code_materiel=codemateriel;
end ::
delimiter ;
 call PlanifierEntretien(104  , curdate() ,'test',null);
 





#4.	[2 Pts] Créez une procédure stockée CloturerContratLocation qui prend 
#en paramètres un id_contrat et les frais_anomalie_eventuels. Cette procédure
# doit réaliser les opérations suivantes :
# o	Mettre à jour le statut du contrat de location à 'Clôturé'.
##o	Si des frais supplémentaires existent (frais_anomalie_eventuels > 0), 
#   insérer un enregistrement dans la table ANOMALIE lié au contrat.
# o	Remettre le statut du matériel rattaché à ce contrat à 'Disponible'.


drop procedure if exists CloturerContratLocation;
delimiter ::
create procedure if not exists CloturerContratLocation(idcontrat int ,frais_anomalie_eventuels float)
begin
	declare codeM int;
	select code_materiel into codeM from contrat_location where id_contrat = idcontrat;
	update contrat_location set statut = 'clôturé' where id_contrat = idcontrat;
	if frais_anomalie_eventuels >0 then 
		insert into anomalie values (null,curdate(), 'test',frais_anomalie_eventuels,idcontrat);
	end if ;
	update materiel set statut = 'Disponible' where code_materiel= codeM;
end ::
delimiter ;
call CloturerContratLocation(1,0);
select* from anomalie;



#Triggers (Déclencheurs)
#5.	[2 Pts] Mettez en place un trigger nommé AlerteCoutEntretien qui se 
#déclenche automatiquement après une insertion dans la table ENTRETIEN. 
#Si le coût total cumulé des entretiens pour un matériel donné dépasse 
#un seuil de 50 000 DH, le trigger doit insérer une alerte dans une table 
#ALERTE_RENOUVELLEMENT (id_alerte, message, date_alerte, #code_materiel). 
#(On supposera que la table ALERTE_RENOUVELLEMENT existe déjà).

create table ALERTE_RENOUVELLEMENT (id_alerte int auto_increment primary key,
 message text not null, date_alerte datetime , code_materiel int,
     CONSTRAINT fk_ALERTE_RENOUVELLEMEN_materiel FOREIGN KEY (code_materiel) REFERENCES MATERIEL(code_materiel)
);

select ceiling(rand()*22);

drop trigger if exists AlerteCoutEntretien;
delimiter //
create trigger AlerteCoutEntretien
 after insert on ENTRETIEN for each row
 begin 
	declare cout_total int;
	select sum(cout) into cout_total  from ENTRETIEN
	where code_materiel=new.code_materiel;
	if cout_total>500 then 
		insert into ALERTE_RENOUVELLEMENT values ( null,concat("coût cumulée = ",cout_total) ,curdate(),new.code_materiel);
	end if;
 end //
 delimiter ;
 
 select * from ALERTE_RENOUVELLEMENT;
 insert into entretien values (null,curdate(),null,'test',100,101);
 
 
 



#6.	[2 Pts] Créez un trigger nommé HistoriserChangementStatutMateriel 
#qui s'active automatiquement après toute mise à jour de la colonne 
#statut de la table MATERIEL. Si le statut a changé, le trigger doit 
#insérer un enregistrement dans une table d'historique 
#HISTORIQUE_STATUT (id_historique, anc_statut, nouveau_statut, 
#date_changement, #code_materiel). 
#(On supposera que la table #HISTORIQUE_STATUT existe déjà).


create table HISTORIQUE_STATUT (id_historique int auto_increment primary key,
 anc_statut varchar(50), nouveau_statut varchar(50), 
date_changement datetime,
 code_materiel int,
     CONSTRAINT fk_HISTORIQUE_STATUT_materiel FOREIGN KEY (code_materiel)
     REFERENCES MATERIEL(code_materiel)
);



drop trigger if exists HistoriserChangementStatutMateriel;
delimiter //
create trigger HistoriserChangementStatutMateriel
 after update on MATERIEL for each row
 begin 
	
    if old.statut<>new.statut then
		insert into HISTORIQUE_STATUT (id_historique, anc_statut, nouveau_statut, 
				date_changement, code_materiel)
				values(null, old.statut,new.statut,current_date(),new.code_materiel);
   end if;
end//
delimiter ;

    
    
 end //
 delimiter ;
 
 select * from contrat_location;
 select * from materiel;
 
 select * from HISTORIQUE_STATUT;


call CloturerContratLocation(2,0);