// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.


// 1. les films dont le nom contient le mot «forest »
use("movies");
db.movies.find({title:/forest/i});


// 2. les films dans lesquelles participe l’acteur « tom hanks »
use("movies");

db.movies.find({cast : "Tom Hanks"})


// 3. les films du pass France 
use("movies");
db.movies.find({countries : "France"})


// 4. les films de France avant 1990
use("movies");
db.movies.find({
    countries : "France",
    year: {$lt: 1990}
})


// // 5.  chercher les films dont la description 
// contient le mot « mystery »
use("movies");
db.movies.find({plot : /mystery/i})


// // 6.  le nombre des films qui ont un rating 
// imdb supérieur ou égale à  7
use("movies");
db.movies.countDocuments({"imdb.rating":{$gte:7}}
)



// // 7.  le nombre des films par acteur dans 
// l’ordre croissant sur le nom d’acteur
use("movies");   
db.movies.aggregate([
    {$unwind: "$cast"},
    {$group:{_id:"$cast",total:{$sum:1}}},
    {$sort:{"_id":1}}])


// // 8.  les films dont le titre commence par 
// « the » « utiliser « $regex »
use("movies");
db.movies.find({title :{$regex:/^the/i}})


// // 9.  les différents type de films
use("movies");
db.movies.distinct("type");


// // 10. la liste des acteur qui ont participé 
// dans plus que 10 films
use("movies");
db.movies.aggregate([
    {$unwind: "$cast"},
    {$group:{_id:"$cast",total:{$sum:1}}},
    {$match:{total:{$gt:10}}}])

// // 11. le nombre de films produit par pays
use("movies");
db.movies.aggregate([
    {$unwind: "$countries"},
    {$group:{_id:"$countries",total:{$sum:1}}}])
// 12. le rating imdb moyenne des films de  
//« Steven Spielberg»
use("movies"); 
db.movies.aggregate([
    {$match: {directors: "Steven Spielberg"}},
    {$group:{_id:null,avgRating:{$avg:"$imdb.rating"}}}])

// // 13. les différents genres de films de 
// « Steven Spielberg»
use("movies"); 
var1= {$unwind:"$genres"}
var2= {$match: {directors:/Steven Spielberg/i}}
var3= {$group:{_id:"$genres"}}
db.movies.aggregate([

var1,var2,var3
    ])


// // 14. qle nombre des films par année du genre 
// « sci-fi » 
use("movies");
var1={$match: {genres: /sci-fi/i}};
var2={$group:{_id:"$year",nb_films:{$sum:1}}}
db.movies.aggregate([  var1,var2 ])


// // 15. Les films d’ « angelina jolie » qui ont 
// rated « pg »
use("movies");
db.movies.find({cast : /angelina jolie/i,rated:"PG"})



 // // 16.  Le nombre de films par genre  - 
// n’afficher que les 5 plus grands
use("movies");
db.movies.aggregate([
{$unwind: "$genres"},
{$group: {_id:"$genres",total:{$sum: 1}}},
{$sort: {total:-1}},
{$limit: 5}
])

// // 17. trier les films de « tom hanks » par 
// imdb score dans l’ordre décroissant
use("movies");
db.movies.find({cast:/tom hanks/i}).sort({"imdb.rating":-1})


// // 18. le pays qui a le film qui a réalisé 
// le plus de reviews
use("movies");
db.movies.find({},{_id:0,countries:1, imdb:1})
        .sort({"imdb.votes":-1})
        .limit(1)



// // 19. donnez les cinq meilleurs directeurs 
// de l’année 2000
use("movies");
varMatch = {$match : {year :2000}}
varUnwind = {$unwind: "$directors"}
varGroup = {$group :{_id :"$directors",moyenne:{$avg :"$imdb.rating"}}}
varSort = {$sort : {moyenne :-1}}
varLimit = {$limit : 5}
db.movies.aggregate([varMatch, varUnwind, varGroup, varSort, varLimit])
// // 20. l’année dans laquelle on a produit le 
// plus grand nombre de films
use("movies");
varGroup = {$group :{_id :"$year",nb:{$sum :1}}}
varSort = {$sort : {nb :-1}}
varLimit = {$limit : 1}
db.movies.aggregate([varGroup, varSort, varLimit])
