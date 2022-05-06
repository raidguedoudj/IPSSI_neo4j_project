//Load Users
LOAD CSV WITH HEADERS FROM "file:///Users.csv" AS line CREATE (user:Users{user_id:line.User_ID, location:line.Location, age:toInteger(line.Age)});