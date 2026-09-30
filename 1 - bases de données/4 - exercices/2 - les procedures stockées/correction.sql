#Exercice 1 :
#On considère la table suivante :
#Produit (NumProduit, libelle, PU, stock)


drop database if exists produits_202;

create database produits_202 collate utf8mb4_general_ci;
use produits_202;

create table Produit(
numProduit int auto_increment primary key,
libelle varchar(50) ,
PU float ,
stock int);


insert into produit values (1,'table',350,100),
							(2,'chaise',100,10),
                            (3,'armoire',2350,10),
                            (4,'pc',3500,20),
                            (5,'clavier',150,200),
                            (6,'souris',50,200),
                            (7,'ecran',2350,70),
                            (8,'scanner',1350,5),
                            (9,'imprimante',950,5);
                            



select * from produit;


#1.	Ecrire une PS qui affiche tous les produits ;

drop procedure if exists ex1_q1;
delimiter $$
create procedure if not exists ex1_q1()
begin
	select * from produit;
end$$
delimiter ;
call ex1_q1();
#2.	Ecrire une procédure stockée qui affiche les libellés des produits 
#dont le stock est inférieur à 10 ;


drop procedure if exists ex1_q2;
delimiter $$
create procedure if not exists ex1_q2()
begin
	select libelle from produit where stock < 10;
end$$
delimiter ;
call ex1_q2();




#3.	Ecrire une PS qui admet en paramètre un numéro de produit et affiche 
#un message contenant le libellé, le prix et la quantité en stock équivalents,
# si l’utilisateur passe une valeur lors de l’exécution de la procédure ;
select * from produit;
drop procedure if exists ex1_q3;
delimiter $$
create procedure if not exists ex1_q3(n int)
begin
	declare nb int;
	set nb = (select count(*) from produit where numproduit = n);
	if nb=0 then
		select ("aucun produit");
	else
		
		select concat(" le libelle ", libelle,
		" le prix " , pu,
		" la quantite " ,stock) as message
		from produit
		where numproduit =n;
	end if;
end$$
delimiter ;
call ex1_q3();



#4.	Ecrire une PS qui permet de supprimer un produit en passant son numéro 
#comme paramètre ;
drop procedure if exists ex1_q4;
delimiter $$
create procedure if not exists ex1_q4(id int)
begin
	if (select count(*) from produit where numproduit=id) =0 then
		select "ce produit nexiste pas" as message;
	else
		delete from produit where numproduit=id;
		select 'produit supprimé avec succes';
	end if;
end$$
delimiter ;
call ex1_q4(2);

#Exercice 2 :
#Ecrire une PS qui permet de mettre à jour le stock après une opération 
#de vente de produits, la PS admet en paramètre le numéro d’article à vendre
# et la quantité à vendre puis retourne un message suivant les cas :
#a.	Opération impossible : si la quantité est supérieure au stock de l’article ;
#b.	Besoin de réapprovisionnement si stock-quantité < 10
#c.	Opération effectuée  avec succès, la nouvelle valeur du stock est (afficher la nouvelle valeur) ;
drop procedure if exists ex2;
delimiter &&
create procedure ex2(num int,q int)
begin
	declare res varchar(100);
	declare s int;
	select stock into s from produit where numProduit=num;
	if q>s then 
			set res="operation impossible";
	else
		update produit set stock=stock-q where numProduit=num;
        if s-q<10 then
			set res="Besoin de réapprovisionnement";
		else 
            set res="Opération effectuée";
		end if;
	end if;
    select res;
end &&
delimiter ;

select * from produit;
call ex2(4,8);        
			
		



#Exercice 3 :
#Ecrire une PS qui retourne le prix moyen des produits (utiliser un paramètre OUTPUT) 
#; Exécuter la PS ;

drop procedure if exists ex3;
delimiter &&
create procedure ex3(out r float)
begin
	set r=(select avg(pu) from produit);
	
end &&
delimiter ;

call ex3(@r);   
select @r;

#Exercice 4 :
#Créer une procédure stockée qui accepte comme paramètre un entier et retourne 
#le factoriel de ce nombre.

drop procedure if exists ex4;
delimiter &&
create procedure ex4(in n float,out f int )
begin
	declare i int default 1;
    set f=1;
    while i<=n do
		set f=f*i;
        set i= i+1;
	end while;
end &&
delimiter ;
call ex4(5,@f);
select @f;







#Exercice 5 :
#1.	Créer une procédure stockée qui accepte les paramètres suivants : 
#a.	 2 paramètres de type entier  
#b.	 1 paramètre de type caractère.
#c.	1 paramètre output de type entier
#La procédure doit enregistrer le résultat de calcul entre les deux nombres
# selon l’opérateur passé dans le troisième paramètre (+,-,%,/,*). 
drop procedure if exists ex5;
delimiter &&
create procedure ex5( a float, b float ,c char , out r varchar(50))
begin
 case c 
   when '+' then set r=a+b;
    when '-' then set r=a-b;
    when '%' then set r=a%b;
    when '*' then set r=a*b;
    when '/'  then
       if b=0 then 
         set r= 'impossible';
	   else 
		  set r=a/b ;
       end if;
	else
		set r = "erreur";
	end case;
    select r;
end &&
delimiter ;


call ex5(1,0,'#',@r);
select @r;
   






##Exercice 6 :
#Soit la base de données suivante :
#Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
#Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
#Composition_Recette (NumRec, NumIng, QteUtilisee)
#Fournisseur (NumFou, RSFou, AdrFou)



drop database if exists cuisine_202;
create database cuisine_202;
use cuisine_202;
create table Recettes (
NumRec int auto_increment primary key, 
NomRec varchar(50), 
MethodePreparation varchar(60), 
TempsPreparation int
);
create table Fournisseur (
NumFou int auto_increment primary key, 
RSFou varchar(50), 
AdrFou varchar(100)
);
create table Ingredients (
NumIng int auto_increment primary key,
NomIng varchar(50), 
PUIng float, 
UniteMesureIng varchar(20), 
NumFou int,
   constraint  fkIngredientsFournisseur foreign key (NumFou) references Fournisseur(NumFou)
);
create table Composition_Recette (
NumRec int not null,
constraint  fkCompo_RecetteRecette foreign key (NumRec) references Recettes(NumRec), 
NumIng int not null ,
  constraint  fkCompo_RecetteIngredients foreign key (NumIng) references Ingredients(NumIng),
QteUtilisee int,
constraint  pkRecetteIngredients primary key (NumIng,NumRec)
);


INSERT INTO Fournisseur (RSFou, AdrFou) VALUES
('Fournisseur A', '123 Rue des Oliviers, Casablanca'),
('Fournisseur B', '456 Avenue des Pâtes, Rabat'),
('Fournisseur C', '789 Boulevard des Epices, Marrakech');

INSERT INTO Ingredients (NomIng, PUIng, UniteMesureIng, NumFou) VALUES
('Farine', 3.50, 'kg', 1),
('Oeufs', 0.20, 'unité', 1),
('Beurre', 8.00, 'kg', 2),
('Sucre', 2.50, 'kg', 1),
('Lait', 1.00, 'litre', 2),
('Poulet', 6.00, 'kg', 3),
('Tomates', 2.00, 'kg', 3),
('Oignon', 1.20, 'kg', 3),
('Ail', 1.80, 'kg', 3),
('Poivre', 15.00, 'kg', 2);


INSERT INTO Recettes (NomRec, MethodePreparation, TempsPreparation) VALUES
('Gâteau au chocolat', 'Mélanger les ingrédients, cuire au four', 45),
('Crêpes', 'Mélanger, faire cuire des petites galettes', 20),
('Poulet rôti', 'Assaisonner et cuire le poulet au four', 60),
('Salade de tomates', 'Couper et mélanger les ingrédients', 10),
('Omelette', 'Battre les oeufs et cuire à la poêle', 10),
('Pain maison', 'Pétrir et cuire au four', 90),
('Soupe à l\'oignon', 'Faire revenir les oignons et cuire dans un bouillon', 40),
('Poulet curry', 'Faire cuire le poulet et les épices', 50),
('Tarte aux pommes', 'Préparer la pâte et garnir avec les pommes', 60),
('Gratin dauphinois', 'Couper les pommes de terre, ajouter la crème et cuire', 70);


INSERT INTO Composition_Recette (NumRec, NumIng, QteUtilisee) VALUES
-- Gâteau au chocolat
(1, 1, 1), -- Farine
(1, 2, 3), -- Oeufs
(1, 3, 0.2), -- Beurre
(1, 4, 0.5), -- Sucre
(1, 5, 0.25), -- Lait

-- Crêpes
(2, 1, 0.5), -- Farine
(2, 2, 2), -- Oeufs
(2, 3, 0.1), -- Beurre
(2, 5, 0.3), -- Lait

-- Poulet rôti
(3, 6, 1), -- Poulet
(3, 8, 0.1), -- Oignon
(3, 9, 0.05), -- Ail
(3, 10, 0.01), -- Poivre

-- Salade de tomates
(4, 7, 0.5), -- Tomates
(4, 8, 0.1), -- Oignon
(4, 9, 0.02), -- Ail

-- Omelette
(5, 2, 3), -- Oeufs
(5, 3, 0.05), -- Beurre
(5, 9, 0.01), -- Ail
(5, 10, 0.01), -- Poivre

-- Pain maison
(6, 1, 0.8), -- Farine
(6, 4, 0.2), -- Sucre
(6, 5, 0.5), -- Lait

-- Soupe à l'oignon
(7, 8, 0.5), -- Oignon
(7, 9, 0.05), -- Ail
(7, 10, 0.01), -- Poivre

-- Poulet curry
(8, 6, 0.8), -- Poulet
(8, 8, 0.1), -- Oignon
(8, 9, 0.05), -- Ail
(8, 10, 0.02), -- Poivre

-- Tarte aux pommes
(9, 1, 0.3), -- Farine
(9, 3, 0.15), -- Beurre
(9, 4, 0.2), -- Sucre

-- Gratin dauphinois
(10, 5, 0.7), -- Lait
(10, 8, 0.2), -- Oignon
(10, 10, 0.01); -- Poivre




#Créer les procédures stockées suivantes :
#PS1 : Qui affiche la liste des ingrédients avec pour chaque ingrédient 
#le numéro, le nom et la raison sociale du fournisseur.


#PS2 : Qui affiche pour chaque recette le nombre d'ingrédients et le montant 
#cette recette


#PS3 : Qui affiche la liste des recettes qui se composent de plus de 
#10 ingrédients avec pour chaque recette le numéro et le nom


#PS4 : Qui reçoit un numéro de recette et qui retourne son nom


#PS5 : Qui reçoit un numéro de recette. Si cette recette a au moins un 
#ingrédient, la procédure retourne son meilleur ingrédient (celui qui a 
#le montant le plus bas) sinon elle ne retourne "Aucun ingrédient associé"


#PS6 : Qui reçoit un numéro de recette et qui affiche la liste des ingrédients 
#correspondant à cette recette avec pour chaque ingrédient le nom,
#la quantité utilisée et le montant


#PS7 : Qui reçoit un numéro de recette et qui affiche :
#Son nom (Procédure PS_4)
#La liste des ingrédients (procédure PS_6)
#Son meilleur ingrédient (PS_5)


#PS8 : Qui reçoit un numéro de fournisseur vérifie si ce fournisseur existe. 
#Si ce n'est pas le cas afficher le message 'Aucun fournisseur ne porte ce numéro'
# Sinon vérifier, s'il existe des ingrédients fournis par ce fournisseur si 
#c'est le cas afficher la liste des ingrédients associés (numéro et nom) Sinon 
#afficher un message 'Ce fournisseur n'a aucun ingrédient associé. 
#Il sera supprimé' et supprimer ce fournisseur



#PS9 : Qui affiche pour chaque recette :
#Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
#La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
#Un message sous la forme : Sa méthode de préparation est : (Méthode)
#Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
#'Prix intéressant'
