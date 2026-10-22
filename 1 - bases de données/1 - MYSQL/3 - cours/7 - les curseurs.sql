
# les curseurs



drop database if exists vols_202;

create database vols_202 collate utf8mb4_general_ci;
use vols_202;

create table Pilote(
numpilote int auto_increment primary key,
nom varchar(50) ,
titre varchar(50) ,
villepilote varchar(50) ,
daten date,
datedebut date,
nbhv time default '00:00:00');

create table Vol(numvol int auto_increment primary key,
villed varchar(50) ,
villea varchar(50) ,
dated datetime ,
datea datetime , 
numpil int not null,
numav int not null);

create table Avion(numav int auto_increment primary key,
typeav  varchar(50) ,
capav int);

alter table vol add constraint fk_vol_pilote foreign key(numpil) references pilote(numpilote);
alter table vol add constraint fk_vol_avion foreign key(numav) references avion(numav);

insert into avion values (1,'boeing',350),
						(2,'caravel',50),
                        (3,'airbus',500),
                        (4,'test',350);
                        
insert into pilote (numpilote, nom,titre, villepilote, daten, datedebut) values 
						(1,'hassan','M.','tetouan','2000-01-01','2022-01-01'),
						(2,'saida','Mme.','casablanca','1980-01-01','2005-01-01'),
						(3,'youssef','M.','tanger','1983-01-01','2002-01-01');



insert into vol values (1,'tetouan','casablanca','2023-09-10 08:00:00','2023-09-10 10:00:00',1,1),
						(2,'casablanca','tetouan','2023-09-10 08:00:00','2023-09-10 10:00:00',1,1),
						(3,'tanger','casablanca','2023-09-11 08:00:00','2023-09-11 10:00:00',2,2),
						(4,'casablanca','tanger','2023-09-11 08:00:00','2023-09-11 10:00:00',2,2),
						(5,'agadir','casablanca','2023-09-11 08:00:00','2023-09-11 10:00:00',3,3),
						(6,'casablanca','agadir','2023-09-11 08:00:00','2023-09-11 10:00:00',3,3);



insert into vol values (7,'tetouan','casablanca','2023-09-10 08:00:00','2023-09-10 10:30:00',1,1),
						(8,'casablanca','tetouan','2023-09-10 08:00:00','2023-09-10 11:00:00',1,1),
						(9,'tanger','casablanca','2023-09-11 08:00:00','2023-09-11 12:00:00',1,2),
						(10,'casablanca','tanger','2023-09-11 08:00:00','2023-09-11 09:00:00',1,2),
						(11,'agadir','casablanca','2023-09-11 08:00:00','2023-09-11 13:00:00',3,3),
						(12,'casablanca','agadir','2023-09-11 08:00:00','2023-09-11 09:30:00',3,3),
                        (13,'tetouan','casablanca','2023-09-10 08:00:00','2023-09-10 11:00:00',2,1),
						(14,'casablanca','tetouan','2023-09-10 08:00:00','2023-09-10 11:30:00',3,1);  


select * from pilote ;


 

select numpilote  from pilote;

drop procedure if exists calculer_nbhv_par_pilote;
delimiter $$
create procedure if not exists calculer_nbhv_par_pilote()
begin
	declare idp int;
	declare t time;
    declare flag boolean default false;
	declare c1 cursor for select numpilote from pilote;
    declare continue handler for  not found set flag = true;
	open c1;
    b1: loop
		#lire la ligne en cours
		fetch c1 into idp;
        if flag then
			leave b1;
		end if;
        
        #calculer la somme de  nombre d'heure de vol du pilote en cours
		select sec_to_time(sum(timestampdiff(second, dated, datea))) into  t
		from vol 
		where numpil = idp;
        
        #modifier le champs nbhv de la table pilote pour le pilote en cours
        update pilote set nbhv = t where numpilote = idp;

    
    
    end loop b1;
    # autres traitements a faire apès la fin du curseurs
    close c1;


end $$
delimiter ; 


call calculer_nbhv_par_pilote();
use vols_202;
select * from pilote;
update pilote set nbhv = '00:00:00';


