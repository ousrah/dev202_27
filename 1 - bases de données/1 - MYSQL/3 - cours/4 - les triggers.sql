drop database if exists ventes_202;
create database ventes_202 collate utf8mb4_general_ci;
use ventes_202;

create table produit(
id_produit int auto_increment primary key,
nom varchar(50),
prix float,
stock int,
check (stock>=0)
);



create table vente(
id_vente int auto_increment primary key,
date_vente datetime default current_timestamp,
qte int,
id_produit int,
constraint fk_vente_produit foreign key (id_produit) references produit(id_produit)
);


insert into produit values 
(1,'chaise',200,20),
(2,'table',1500,10),
(3,'armoire',5000,5);

select * from produit;

-- insertion

insert into vente (qte, id_produit) values (5,3);


insert into vente (qte, id_produit) values (3,1),(2,2),(1,3);


#update produit set stock = stock-2 where id_produit =1;
select *  from vente;
select * from produit;

drop trigger if exists tr1 ;
delimiter $$
create trigger if not exists tr1 after insert on vente for each row
begin
    update produit set stock = stock - new.qte 
    where id_produit = new.id_produit;
end$$
delimiter ;
delete from vente where id_produit = 1;



drop trigger if exists tr2 ;
delimiter $$
create trigger if not exists tr2 after delete on vente for each row
begin
    update produit set stock = stock + old.qte 
    where id_produit = old.id_produit;
end$$
delimiter ;





drop trigger if exists tr3 ;
delimiter $$
create trigger if not exists tr3 after update on vente for each row
begin
    update produit set stock = stock + old.qte  - new.qte
    where id_produit = old.id_produit;
end$$
delimiter ;

update vente set qte = 5 where id_vente = 5;

select *  from vente;
select * from produit;

