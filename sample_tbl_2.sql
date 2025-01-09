CREATE TABLE etc.sample_tbl_2(
	"id" SERIAL,
	filename VARCHAR NOT NULL,
	date_upload VARCHAR NOT NULL,
	uploaded_by VARCHAR NOT NULL,
	item_type_name VARCHAR NOT NULL,
	internal_id VARCHAR NULL,
	unit_name VARCHAR NOT NULL,
	plural_name VARCHAR NOT NULL,
	abbreviation VARCHAR NOT NULL,
	plural_abbreviation VARCHAR NOT NULL,
	conversion_rate_base VARCHAR NOT NULL,
	base_unit VARCHAR NOT NULL
)

SELECT * FROM etc.sample_tbl_2;