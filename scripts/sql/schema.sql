CREATE TABLE authors(id serial PRIMARY key, name TEXT unique);
CREATE TABLE publishers(id serial PRIMARY KEY, name TEXT unique);

CREATE TABLE books(
	id serial PRIMARY KEY,
	goodreads_id int,
	title varchar,
	average_rating float,
	isbn varchar(15),
	isbn13 varchar(13),
	language_code varchar(10),
	num_pages int,
	ratings_count int,
	text_reviews_count int,
	publication_date date,
	publisher_id int REFERENCES public.publishers(id)
);


CREATE TABLE author_book(
	author_id int,
	book_id int,
	PRIMARY KEY (author_id,  book_id)
);
