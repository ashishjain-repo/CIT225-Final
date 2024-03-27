-- INSERT Statements

INSERT INTO author
(country_id, author_fname, author_mname, author_lname, author_dob, author_dod)
VALUES
((SELECT country_id FROM country WHERE country_code = 'IN'),'Vaidyeswaran','Sarada','Rajaraman','1933-01-10',NULL);

INSERT INTO book
(subject_id, country_id, book_title, book_isbn_new, book_isbn, lang_lang_id)
VALUES
((SELECT subject_id FROM subject WHERE subject_name = 'Computer Science'), (SELECT country_id FROM country WHERE country_code = 'IN'), 'Fundamentals of Computer', '9788120329681', NULL, 'HI');

INSERT INTO book_author
(book_id, author_id)
VALUES
((SELECT book_id FROM book WHERE book_title = 'Fundamentals of Computer'), (SELECT author_id FROM author WHERE author_fname = 'Vaidyeswaran'));

INSERT book_genre
(book_id, genre_id)
VALUES
((SELECT book_id FROM book WHERE book_title = 'Fundamentals of Computer'), (SELECT genre_id FROM genre WHERE genre_name = 'Technical'));

INSERT INTO book_publisher
(book_id, publisher_id)
VALUES
((SELECT book_id FROM book WHERE book_title = 'Fundamentals of Computer'), (SELECT publisher_id FROM publisher WHERE publisher_codename = 'NBT'))


-- UPDATE Statements
UPDATE author
SET author_mname = NULL
WHERE author_fname = 'Vaidyeswaran';

-- DELETE Statements
CREATE TEMPORARY
TABLE tempList 
(temp VARCHAR(50));

INSERT INTO tempList 
(temp)
VALUES 
    ('Poetry')
,   ('Folk Tales');

DELETE FROM genre
WHERE genre_name IN (SELECT temp FROM tempList);

DROP TEMPORARY TABLE tempList;
