CREATE TABLE etc.documents (
	"id" SERIAL,
	filename VARCHAR NOT NULL,
	date_upload timestamp NOT NULL,
	"uid" uuid NOT NULL,
	uploaded_by VARCHAR NOT NULL,
	filepath VARCHAR NOT NULL
)

SELECT * FROM etc.documents;

ALTER TABLE etc.documents ALTER COLUMN date_upload TYPE timestamp;

TRUNCATE etc.documents RESTART IDENTITY;

SELECT docs.id, docs.filename, docs.date_upload, docs.uid, CONCAT(u.first_name,' ', u.last_name) as uploaded_by, u.email, 
docs.filepath from etc.documents as docs LEFT JOIN etc.users as u ON docs.uid = u.uid;