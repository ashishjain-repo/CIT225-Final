

-- Step 1 
-- (5 Inserts Performed)

/* INSERT INTO author
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
((SELECT book_id FROM book WHERE book_title = 'Fundamentals of Computer'), (SELECT publisher_id FROM publisher WHERE publisher_codename = 'NBT')); */

-- Step 2
-- (1 Update Performed)

/* UPDATE author
SET author_mname = NULL
WHERE author_fname = 'Vaidyeswaran'; */


-- Step 3
-- (1 Table Creation, Drop Table, Insert and Delete Performed)

/* CREATE TEMPORARY
TABLE tempList 
(temp VARCHAR(50));

INSERT INTO tempList 
(temp)
VALUES 
    ('Poetry')
,   ('Folk Tales');

DELETE FROM genre
WHERE genre_name IN (SELECT temp FROM tempList);

DROP TEMPORARY TABLE tempList; */

-- Step 4
-- (1 Insert and Update Performed)


/* SET @memberId = 'G7890123H56';
INSERT INTO reservation
(
    member_id
,   reservation_start
,   reservation_end
)
VALUES
    ((SELECT member_id FROM member WHERE member_membership_id = @memberId), '2024-01-20', '2024-02-20');

UPDATE book
SET 
    reservation_id = (SELECT reservation_id FROM reservation WHERE (SELECT member_id FROM member WHERE member_membership_id = @memberId))
,   member_id = (SELECT member_id FROM member WHERE member_membership_id = @memberId)
WHERE book_title = 'The Search Engine Revolution'; */

-- Step 5
-- (1 Update and Delete performed)

/* SET @memberId = 'G7890123H56';

UPDATE book b
    INNER JOIN reservation r ON b.reservation_id = r.reservation_id
    INNER JOIN member m ON r.member_id = m.member_id
SET 
    b.reservation_id = null
,   b.member_id = null
WHERE m.member_membership_id = @memberId; 

DELETE FROM reservation
WHERE member_id = (SELECT member_id FROM member WHERE member_membership_id = @memberId); */

-- Step 6
-- (1 Delete performed)

/* DELETE FROM subject
WHERE subject_id NOT IN(SELECT subject_id FROM book); */

-- Total: 6 Inserts, 3 Deletes, and 3 Updates Performed