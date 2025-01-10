CREATE TABLE etc.users (
	"id" SERIAL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	"uid" uuid DEFAULT gen_random_uuid() PRIMARY KEY,
	email VARCHAR NOT NULL
)

SELECT * FROM etc.users;

ALTER TABLE etc.users 
	ADD COLUMN email VARCHAR NOT NULL;

INSERT INTO etc.users(
	first_name,
	last_name,
	email
) VALUES 
	('postgres', 'postgres', 'database_admin@tiledata.net'),
	('DUser', 'DUser', 'database_admin@tiledata.net'),
	('John', 'Ericta', 'john@tiledata.net'),
	('Bing', 'Bing', 'bing@tilemart.com') RETURNING *;