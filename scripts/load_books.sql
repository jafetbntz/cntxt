
UPDATE tmp.books SET publication_date = '6/30/1982'  WHERE publication_date ILIKE '6/31/1982';
UPDATE tmp.books SET publication_date = '11/30/2000'  WHERE publication_date ILIKE '11/31/2000';
INSERT INTO public.books (
	goodreads_id,
	title,
	average_rating,
	isbn,
	isbn13,
	language_code,
	num_pages,
	ratings_count,
	text_reviews_count,
	publication_date,
	publisher_id)
SELECT 
	b.bookid::int "goodreads_id",
	b.title,
	b.average_rating::float "average_rating",
	b.isbn,
	b.isbn13,
	b.language_code,
	b.num_pages::int "num_pages",
	b.ratings_count::int "raitings_count",
	b.text_reviews_count::int "text_reviews_count",
	to_date(b.publication_date, 'MM/DD/YYYY') "publication_date",
	p.id "publisher_id"
FROM tmp.books b
INNER JOIN public.publishers p ON ltrim(rtrim(p."name")) = b.publisher;


INSERT INTO public.author_book(book_id, author_id)
SELECT 
	DISTINCT 
	b.id "book_id",
	a.id "author_id"
FROM books b 
INNER JOIN tmp.books tempo ON b.goodreads_id::text = tempo.bookid
LEFT JOIN authors a ON tempo.authors ILIKE concat('%', a."name" ,'%');