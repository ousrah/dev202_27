#1.	la liste de tous les cheveaux.

select * from cheval;


#2.	la listes de champs qui peuvent acceuillir la catégorie "trot"
select * from categorie;

select * from accueil;

select ch.* 
from champs ch join accueil a using(id_champs)
join categorie c using(id_categorie)
where c.libelle_categorie="Trot";

select * 
from champs 
where id_champs in (select id_champs 
					from accueil 
                    where id_categorie in (select id_categorie 
											from categorie 
                                            where libelle_categorie = 'trot')
					);

#3.	la liste des cheveaux qui participent a la course "Grand Prix de paris" 
#de l'edition 'Janvier 2026' 
#triés par classement

select nom_cheval, classement from cheval
join participe using(id_cheval)
join saison  using(id_saison)
join course  using(id_course)
where designation = "Grand Prix de paris" and 
month(date_course) = 1 and year(date_course) = 2026
#date_course between "2026-01-01" 	and "2026-01-31"
#date_course like "2026-01%"
order by classement;

#sur cette methode je ne peut pas afficher le classement et je ne peut pas trier par classement
select nom_cheval 
from cheval 
where id_cheval in (select id_cheval from participe 
					where  id_saison in (select id_saison from saison 
										where month(date_course) = 1 
                                        and year(date_course) = 2026 
                                        and id_course in (select id_course 
														  from course 
                                                          where designation = "Grand Prix de paris"
                                                          )
										)
					);
;


#methode 2 mélange de join et sous requette
select nom_cheval, classement 
from cheval
join participe using(id_cheval)
join saison  using(id_saison)
where  month(date_course) = 1 and year(date_course) = 2026
and id_course in (select id_course from course where designation = "Grand Prix de paris")
order by classement;

#4.	la liste des jockeys qui ont monté le cheval 
#"Tonnerre" durant tout son historique
select * from cheval;


select distinct PRENOM_JOCKEY,NOM_JOCKEY
from jockey 
join participe  using(id_jockey)
join cheval  using(ID_CHEVAL)
where NOM_CHEVAL="Tonnerre";

#methode de sous requette pas besoin de distinct
select nom_jockey, prenom_jockey
from jockey where id_jockey in( select id_jockey 
								from participe
                                where id_cheval in (select id_cheval 
													from cheval
                                                    where NOM_CHEVAL="Tonnerre")
								);
                                                    


#5.	Le cheval qui a remporté le plus grand nombre de compétitions
select nom_cheval, count(*)
from cheval
join participe using (id_cheval)
where classement = 1
group by id_cheval, nom_cheval
having count(*)=(
				select max(nb_victoire)from(
					select count(*) as nb_victoire
                    from cheval
					join participe using (id_cheval)
					where classement = 1
					group by id_cheval, nom_cheval
                    )reg1
				);

select nom_cheval, count(*) as nb_victoires
from cheval join participe using(id_cheval)
where classement = 1
group by nom_cheval
having nb_victoires = (
				select max(nb_victoire) as maximum from (
							select  count(*) as nb_victoire
							from participe where classement = 1
							group by id_cheval) req1
						);






#6.	Les parents du cheval qui a remporté le plus grand nombre de compétitions


use courses202;
with f as (
	select id_cheval, count(classement) as nb
	from participe 
	where classement = 1 
	group by id_cheval
		),
	g as (select max(nb) as maximum from f),
champion as (
select c.id_cheval, nom_cheval, count(classement) as nb
	from participe p join cheval c using(id_cheval)
	where classement = 1 
	group by c.id_cheval, nom_cheval 
    having nb = (select maximum from g))
    
select c.nom_cheval as cheval_champion, ch.nom_cheval as parent
from champion c 
join parent p  on p.che_id_cheval = c.id_cheval 
join cheval ch on p.id_cheval = ch.id_cheval  ;     


select * from parent;
select * from participe where classement = 1;
-- 7.	Le montant total remporté par tonnerre dans toutes les compétitions qu'il a remporté

select sum(dotation) as somme_gains_Idao
from participe 
join saison using(id_saison)
where classement = 1 and id_cheval in (select id_cheval from cheval where nom_cheval = 'Tonnerre');

select * from cheval;

-- 8.	La catégorie que le cheval Tonnerre remporte le plus

select libelle_categorie, count(*)
from participe 
join saison using(id_saison)
join course using(id_course)
join categorie using (id_categorie)
where classement = 1 and id_cheval in (select id_cheval from cheval where nom_cheval = 'Tonnerre')
group by libelle_categorie
order by count(*) desc
limit 1;

