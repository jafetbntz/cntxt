--DROP TABLE publishers;

CREATE TABLE publishers(id serial PRIMARY KEY, name TEXT unique);

INSERT INTO public.publishers(name)
	SELECT DISTINCT rtrim(ltrim(publisher)) FROM tmp.books;
	

SELECT * FROM public.publishers;