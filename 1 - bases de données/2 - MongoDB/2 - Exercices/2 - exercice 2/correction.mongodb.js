
// 1.   Liste de tous les livres (type « Book ») ;

use('DBLP');
db.dblp.find({type:'Book'});

// 2.   Liste des publications depuis 2011 ;
use('DBLP');
db.dblp.find({year:{$gte:2011}});


// 3.   Liste des livres depuis 2014 ;
use('DBLP');
db.dblp.find({
    type:'Book',
    year:{$gte:2014}
});

// 4.   Liste des publications de l’auteur « Toru Ishida » ;
use('DBLP');
db.dblp.fin(d{authors:"Toru Ishida"});

// 5.   Liste de tous les éditeurs (type « ('DBLP') »), 
// distincts('DBLP')
use('DBLP');
db.dblp.distinct('publisher');






// 6.   Liste de tous les auteurs distincts ;
use('DBLP');
db.dblp.distinct('authors');

// 7.   Trier les publications de « Toru Ishida » par 
// titre de livre et par page de début ;
use('DBLP');
db.dblp.find({authors:"Toru Ishida"})
.sort ({'title':-1,'pages.start':1});

// 8.   Projeter le résultat sur le titre de la publication,
//  et les pages ;
use('DBLP');
db.dblp.find({authors:"Toru Ishida"},{title:1,pages:1,_id:0})
.sort ({'title':-1,'pages.start':1});
// 9.   Compter le nombre de ses publications ;
use('DBLP');
db.dblp.countDocuments({authors:"Toru Ishida"});
// db.dblp.find({authors:"Toru Ishida"}).count();
// db.dblp.count({authors:"Toru Ishida"});

use('DBLP');
db.dblp.aggregate(
    {$match:{authors:"Toru Ishida"}},
    {$count:"total"}
);


use('DBLP');
db.dblp.aggregate(
    {$match:{authors:"Toru Ishida"}},
    {$group:{"_id":null,total:{$sum:1}}}
);







// 10.  Compter le nombre de publications part type 
// depuis 2011  ;
use('DBLP');
db.dblp.aggregate(
    {$match:{year:{$gte:2011}}},
    {$group:{"_id":"$type",total:{$sum:1}}}
);





// 11.  Donnez pour chaque type le nombre des ouvrages 
// edités depuis 2011, n’affichez que ceux qui dépassent 1000 
use('DBLP');
db.dblp.aggregate({$match:{year:{$gte:2011}}},
    {$group:{"_id":"$type",total:{$sum:1}}},
    {$match:{total:{$gt:1000}}}
);





// 12.  Compter le nombre de publications par auteur et 
// trier le résultat par ordre croissant ;
use('DBLP');
db.dblp.aggregate([
{$unwind:"$authors"},
{$group:{"_id":"$authors",total:{$sum:1}}},
{$sort:{"total":1}}
]);