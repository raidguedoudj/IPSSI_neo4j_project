# binome 

Raid GUEDOUDJ
Wissem Meridj

# Load Books

LOAD CSV WITH HEADERS FROM "file:///Books.csv" AS line CREATE (book:Books{isbn:line.ISBN, book_title:line.Book_Title, book_author:line.Book_Author, year_of_publication:line.Year_Of_Publication, publisher:line.Publisher, image_url_s:line.Image_URL_S, image_url_m:line.Image_URL_M, image_url_l:line.Image_URL_L})


# Load Users
LOAD CSV WITH HEADERS FROM "file:///Users.csv" AS line CREATE (user:Users{user_id:line.User_ID, location:line.Location, age:toInteger(line.Age)})

# Load Ratigs
LOAD CSV WITH HEADERS FROM "file:///Ratings.csv" AS line MERGE(user:Users{user_id:line.User_ID})  MERGE(book:Books{isbn:line.ISBN})  CREATE(rating:Ratings{book_rating:toInteger(line.Book_Rating)})
CREATE (book)-[:has]->(rating)
CREATE (user)-[:make]->(rating)
CREATE (user)-[:rate]->(book)


# Schéma de Connection des noeuds
call db.schema.visualization

# Création des indexes

CREATE INDEX book_id for (b: Books) ON (b.isbn);
CREATE INDEX user_id for (u: Users) ON (u.user)
CREATE INDEX ratings_id for (r:Ratings) ON (r.isbn, r.user_id);


# les livres que un user à noté
match (u:Users) -[rate]->(b:Books) return *

# récupere les livre noté par un user et la note donnée
match (u:Users)-[:make]->(r:Ratings) match (u:Users)-[:rate]->(b:Books) match (b:Books)-[:has]->(r:Ratings) return *


## les autres requettes match set update remove delete detach vous pouvez les trouver dans le fichier pdf