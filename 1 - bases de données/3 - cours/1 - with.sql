-- with

use vod202_;
select * from contenu
where id_contenu in (select id_contenu 
					from joue join acteur using (id_acteur) 
                    where nom_acteur like '%caprio%');
         
         
with contenus_de_dicaprio as (
					select id_contenu 
					from joue join acteur using (id_acteur) 
                    where nom_acteur like '%caprio%')
select * 
from contenu 
join  contenus_de_dicaprio using(id_contenu);   





select u.nom, sum(min_vue) somme
						from utilisateur u
						join historique  using(id_utilisateur)
						group by u.id_utilisateur,nom 
						having sum(min_vue) = (
											select max(somme) from (
												select sum(min_vue) somme
												from utilisateur u
												join historique  using(id_utilisateur)
												group by u.id_utilisateur 
						                     ) req1
						);
                        
with min_vue_par_utilisateur as (
	select sum(min_vue) somme, id_utilisateur
	from  historique
    group by id_utilisateur ),
    
max_min_vue as (
	select max(somme) maximum from min_vue_par_utilisateur)    
    
    
select u.nom, sum(min_vue) somme
from utilisateur u
join historique  using(id_utilisateur)
group by u.id_utilisateur , nom
having somme = (select maximum from max_min_vue) ;