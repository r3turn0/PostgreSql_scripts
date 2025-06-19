-- PROCEDURE: etc.update_item_types()

-- DROP PROCEDURE IF EXISTS etc.update_item_types();

CREATE OR REPLACE PROCEDURE etc.update_item_types(
	)
LANGUAGE 'sql'
AS $BODY$
UPDATE etc.netsuite_union SET item_type = 'sample' WHERE item_id ILIKE '%-S%';
UPDATE etc.netsuite_union SET item_type = 'mfg' WHERE item_id ILIKE '%mfg%';
UPDATE etc.netsuite_union SET item_type = 'real' WHERE item_type <> 'sample' AND item_type <> 'mfg';
$BODY$;
ALTER PROCEDURE etc.update_item_types()
    OWNER TO "DUser";
