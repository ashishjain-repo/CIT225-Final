INSERT INTO continent
(   
    continent_name
,   continent_code
)
VALUES
('Asia','AS')
,('Europe','EU')
,('Africa','AF');

INSERT INTO country
(
    continent_continent_id
,   country_name
,   country_code
)
VALUES
    ((SELECT continent_id FROM continent WHERE continent_code = 'AS'),'India','IN')
,   ((SELECT continent_id FROM continent WHERE continent_code = 'EU'),'England','EN')
,   ((SELECT continent_id FROM continent WHERE continent_code = 'AF'),'South Africa','SA')
,   ((SELECT continent_id FROM continent WHERE continent_code = 'AS'),'Cambodia','KH');

INSERT INTO author
(
    country_id
,   author_fname
,   author_mname
,   author_lname
,   author_dob
,   author_dod
)
VALUES
    ((SELECT country_id FROM country WHERE country_code = 'IN'),'Munshi',NULL,'Premchand','1880-07-31','1936-10-08')
,   ((SELECT country_id FROM country WHERE country_code = 'EN'),'William',NULL,'Shakespeare','1564-04-26','1616-04-23')
,   ((SELECT country_id FROM country WHERE country_code = 'SA'),'Herman','Charles','Bosman','1905-02-03','1951-10-14')
,   ((SELECT country_id FROM country WHERE country_code = 'KH'),'Keng',NULL,'Vannsak','1925-07-19','2008-12-18')
,   ((SELECT country_id FROM country WHERE country_code = 'IN'), 'Sundar',NULL, 'Pichai', '1972-06-10', NULL) -- Computer Science
,   ((SELECT country_id FROM country WHERE country_code = 'EN'), 'Margot',NULL, 'Fonteyn', '1919-05-18', '1991-02-21') -- Dance
,   ((SELECT country_id FROM country WHERE country_code = 'SA'), 'Allan',NULL, 'Cormack', '1924-02-23', '1998-05-07') -- Physics
,   ((SELECT country_id FROM country WHERE country_code = 'KH'), 'Sourya',NULL, 'Panda', '1973-08-08', NULL); -- Computer Science




INSERT INTO publisher
(
    country_id
,   publisher_name
,   publisher_codename
,   publisher_contact
)
VALUES
    ((SELECT country_id FROM country WHERE country_code = 'IN'),'National Book Trust India','NBT',26707700)
,   ((SELECT country_id FROM country WHERE country_code = 'EN'),'Penguin Random House UK','Penguin',2071393000)
,   ((SELECT country_id FROM country WHERE country_code = 'SA'),'Nota Bene Publishers','NB',116018111)
,   ((SELECT country_id FROM country WHERE country_code = 'KH'),'Sipar Publishing','SIPAR',23212407);

INSERT INTO lang
(
    lang_id
,   language
,   display_language
,   display
)
VALUES
    ('EN', 'English', 'EN', 'English')
,   ('HI','Hindi','HI','Hindi')
,   ('AF','Afrikaans','AF','Afrikaans');

INSERT INTO genre
(
    genre_name
)
VALUES
    ('Fiction')
,   ('Drama')
,   ('Non-fiction')
,   ('Technical')
,   ('History')
,   ('Instructional')
,   ('Poetry')
,   ('Folk Tales');

INSERT INTO common_lookup
(
    member_type
)
VALUES
('Student'),
('Faculty'),
('Staff');

INSERT INTO subject
(
    subject_code
,   subject_name
)
VALUES
    ('CS','Computer Science')
,   ('PHL','Philosophy')
,   ('DAN','Dance')
,   ('BIO','Biology')
,   ('PH','Physics')
,   ('Art','Arts & Literature');

INSERT INTO member
(
    member_fname
,   member_mname
,   member_lname
,   member_dob
,   common_lookup_id
,   member_membership_id
)
VALUES
    ('John', 'Doe', 'Smith', '1990-05-15', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Staff'), 'A1234567B90')
,   ('Alice', NULL, 'Johnson', '1985-08-20', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Faculty'), 'B2345678C01')
,   ('Emily', NULL, 'Brown', '1992-03-10', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Student'), 'C3456789D12')
,   ('Michael',NULL, 'Taylor', '1988-11-25', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Faculty'), 'D4567890E23')
,   ('Sarah', 'Elizabeth', 'Clark', '1995-06-05', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Student'), 'E5678901F34')
,   ('David', 'Robert', 'Miller', '1983-09-30', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Faculty'), 'F6789012G45')
,   ('Emma', NULL, 'Anderson', '1998-01-12', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Student'), 'G7890123H56')
,   ('James', 'Patrick', 'White', '1980-07-17', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Staff'), 'H8901234I67')
,   ('Olivia', 'Jane', 'Robinson', '1993-04-08', (SELECT common_lookup_id FROM common_lookup WHERE member_type = 'Staff'), 'I9012345J78');

INSERT INTO book
(
    subject_id
,   country_id
,   book_title
,   book_isbn_new
,   book_isbn
,   lang_lang_id
)
VALUES
    ((SELECT subject_id FROM subject WHERE subject_name = 'Computer Science'), (SELECT country_id FROM country WHERE country_code = 'IN'), 'The Search Engine Revolution', '9780123456789', NULL, 'EN')
,   ((SELECT subject_id FROM subject WHERE subject_name = 'Dance'), (SELECT country_id FROM country WHERE country_code = 'EN'), 'The Art of Ballet', '9781234567890', NULL, 'EN')
,   ((SELECT subject_id FROM subject WHERE subject_name = 'Physics'), (SELECT country_id FROM country WHERE country_code = 'SA'), 'Insights into Medical Imaging', '9782345678901', NULL, 'EN')
,   ((SELECT subject_id FROM subject WHERE subject_name = 'Computer Science'), (SELECT country_id FROM country WHERE country_code = 'KH'), 'Machine Learning Essentials', '9783456789012', NULL, 'EN');

INSERT INTO book_author
(
    book_id
,   author_id
)
VALUES
    ((SELECT book_id FROM book WHERE book_title = 'The Search Engine Revolution'), (SELECT author_id FROM author WHERE author_fname = 'Sundar'))
,   ((SELECT book_id FROM book WHERE book_title = 'The Art of Ballet'), (SELECT author_id FROM author WHERE author_fname = 'Margot'))
,   ((SELECT book_id FROM book WHERE book_title = 'Insights into Medical Imaging'), (SELECT author_id FROM author WHERE author_fname = 'Allan'))
,   ((SELECT book_id FROM book WHERE book_title = 'Machine Learning Essentials'), (SELECT author_id FROM author WHERE author_fname = 'Sourya'));

INSERT INTO book_genre
(
    book_id
,   genre_id
)
VALUES
    ((SELECT book_id FROM book WHERE book_title = 'The Search Engine Revolution'), (SELECT genre_id FROM genre WHERE genre_name = 'Technical'))
,   ((SELECT book_id FROM book WHERE book_title = 'The Art of Ballet'), (SELECT genre_id FROM genre WHERE genre_name = 'History'))
,   ((SELECT book_id FROM book WHERE book_title = 'The Art of Ballet'), (SELECT genre_id FROM genre WHERE genre_name = 'Instructional'))
,   ((SELECT book_id FROM book WHERE book_title = 'Insights into Medical Imaging'), (SELECT genre_id FROM genre WHERE genre_name = 'Technical'))
,   ((SELECT book_id FROM book WHERE book_title = 'Insights into Medical Imaging'), (SELECT genre_id FROM genre WHERE genre_name = 'Instructional'))
,   ((SELECT book_id FROM book WHERE book_title = 'Machine Learning Essentials'), (SELECT genre_id FROM genre WHERE genre_name = 'Technical'));

INSERT INTO book_publisher
(
    book_id
,   publisher_id
)
VALUES
    ((SELECT book_id FROM book WHERE book_title = 'The Search Engine Revolution'), (SELECT publisher_id FROM publisher WHERE publisher_codename = 'NBT'))
,   ((SELECT book_id FROM book WHERE book_title = 'The Art of Ballet'), (SELECT publisher_id FROM publisher WHERE publisher_codename = 'Penguin'))
,   ((SELECT book_id FROM book WHERE book_title = 'Insights into Medical Imaging'), (SELECT publisher_id FROM publisher WHERE publisher_codename = 'NB'))
,   ((SELECT book_id FROM book WHERE book_title = 'Machine Learning Essentials'), (SELECT publisher_id FROM publisher WHERE publisher_codename = 'SIPAR'));

SET @memberId = 'G7890123H56';

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
WHERE book_title = 'The Search Engine Revolution';
