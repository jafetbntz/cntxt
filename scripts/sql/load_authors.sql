
DO
$$
DECLARE 
	rec record;
	author_name VARCHAR;
BEGIN
	
	FOR rec IN 
		SELECT DISTINCT string_to_array(authors, '/') AS "authors" FROM tmp.books

	LOOP 
		FOREACH author_name IN ARRAY rec.authors

		LOOP 
			INSERT INTO authors(name)VALUES(rtrim(ltrim(author_name)))
			ON CONFLICT DO NOTHING ;
		END LOOP;
		
	END LOOP;
	
END ;
$$


-- SELECT * FROM authors ;