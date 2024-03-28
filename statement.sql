/* SELECT CONCAT(m.member_fname,' ' ,m.member_mname, ' ', m.member_lname) AS 'Full Name'
    ,   member_membership_id AS 'Member Id'
    ,   c.member_type AS 'Account As'
FROM member m
INNER JOIN common_lookup c
ON m.common_lookup_id = c.common_lookup_id
ORDER BY m.member_fname ASC; */

/* SELECT a.author_fname, c.country_name
FROM author a
INNER JOIN country c
ON a.country_id = c.country_id
ORDER BY a.author_fname ASC; */

/* SELECT c.country_name, b.book_title
FROM country c
INNER JOIN book b
ON c.country_id =  b.book_id
ORDER BY b.book_title ASC; */

/* SELECT
    CONCAT(a.author_fname, ' ', a.author_lname) AS 'Author Name'
,   b.book_title AS 'Book Name'
,   c.country_name AS 'Country Origin'
FROM book b
INNER JOIN country c
ON b.country_id = c.country_id
INNER JOIN book_author ba
ON b.book_id = ba.book_id
INNER JOIN author a
ON ba.author_id = a.author_id
ORDER BY a.author_fname ASC; */

/* SELECT
    a.author_fname AS 'Author Name'
,   b.book_title AS 'Book Name'
,   c.country_name AS 'Country Origin'
,   GROUP_CONCAT(g.genre_name SEPARATOR ', ') AS 'Genre'
FROM
    book_author ba
INNER JOIN book b ON ba.book_id = b.book_id
INNER JOIN author a ON ba.author_id = a.author_id
INNER JOIN country c ON b.country_id = c.country_id
INNER JOIN book_genre bg ON b.book_id = bg.book_id
INNER JOIN genre g ON bg.genre_id = g.genre_id
GROUP BY a.author_fname, b.book_title, c.country_name; */

/* SELECT
    a.author_fname AS 'Author Name'
,   b.book_title AS 'Book Name'
,   c.country_name AS 'Country Origin'
,   GROUP_CONCAT(g.genre_name SEPARATOR ', ') AS 'Genre'
,   p.publisher_name AS 'Publishing Company'
FROM
    book_author ba
INNER JOIN book b ON ba.book_id = b.book_id
INNER JOIN author a ON ba.author_id = a.author_id
INNER JOIN country c ON b.country_id = c.country_id
INNER JOIN book_genre bg ON b.book_id = bg.book_id
INNER JOIN genre g ON bg.genre_id = g.genre_id
INNER JOIN book_publisher bp ON b.book_id =bp.book_id
INNER JOIN publisher p ON bp.publisher_id = p.publisher_id
GROUP BY a.author_fname, b.book_title, c.country_name, p.publisher_name; */



-- Main Select Statement

SELECT
    b.book_title AS 'Book Title'
,   CONCAT(a.author_fname,' ',a.author_lname) AS 'Book Author'
,   l.display AS 'Book Language'
,   GROUP_CONCAT(g.genre_name SEPARATOR ', ') AS 'Book Genre'
,   p.publisher_name AS 'Book Publisher'
,   s.subject_name AS 'Book Subject'
,   c.country_name AS 'Book Origin'
,   IF
        (
            b.reservation_id IS NOT NULL, 'Reserved', 'Available'
        ) AS 'Book Reservation'
FROM book b
INNER JOIN book_author ba ON b.book_id = ba.book_id
INNER JOIN author a ON ba.author_id = a.author_id
INNER JOIN book_genre bg ON b.book_id = bg.book_id
INNER JOIN genre g ON bg.genre_id = g.genre_id
INNER JOIN book_publisher bp ON b.book_id = bp.book_id
INNER JOIN publisher p ON bp.publisher_id = p.publisher_id
INNER JOIN subject s ON b.subject_id = s.subject_id
INNER JOIN country c ON b.country_id = c.country_id
INNER JOIN lang l ON b.lang_lang_id = l.lang_id
GROUP BY 
    2
,   b.book_title
,   l.display
,   s.subject_name
,   c.country_name
,   p.publisher_name
,   b.reservation_id
ORDER BY b.book_title ASC;



-- Select to see membership info using subquery
/* SELECT 
    CONCAT
    (
        m.member_fname,' ',m.member_mname,' ',m.member_lname
    )       AS 'Member Name'
,   CONCAT
        (
                LEFT(m.member_membership_id,2),'-'
            ,   SUBSTRING(m.member_membership_id,3,3),'-'
            ,   RIGHT(m.member_membership_id, 4)
        )   AS 'Membership Id'
,   
    (
        SELECT cl.member_type 
        FROM common_lookup cl 
        WHERE cl.common_lookup_id = m.common_lookup_id
    )       AS 'Member Type'
FROM member m; */

/* SELECT 
    b.book_title  AS 'Book Title'
,   CONCAT(a.author_fname, ' ',IFNULL(author_mname,''), ' ',a.author_lname) AS 'Author Name'
FROM book b
INNER JOIN book_author ba
ON b.book_id = ba.book_id
INNER JOIN author a
ON ba.author_id = a.author_id
WHERE b.book_title = 'Fundamentals of Computer'; */

/* SET @lenderId = 'G7890123H56';

SELECT b.book_title, m.member_fname
FROM book b
INNER JOIN reservation r
ON b.reservation_id = r.reservation_id
INNER JOIN member m
ON r.member_id = m.member_id
WHERE member_membership_id = @lenderId; */

    
    
    /* UPDATE book b
    LEFT JOIN reservation r ON b.reservation_id = r.reservation_id
    LEFT JOIN member m ON r.member_id = m.member_id
    SET
        b.reservation_id = NULL
    ,   b.member_id = NULL
    WHERE m.member_membership_id = @memberId; */

/* DELETE FROM reservation
WHERE member_id = (SELECT member_id FROM member WHERE member_membership_id = @memberId); */



/* INSERT INTO reservation
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

-- Member Name Change Form
/* SELECT 
    member_fname
,   member_mname
,   member_lname
FROM member
WHERE member_membership_id = 'I9012345J78'; */

/* SET @memberId = 'I9012345J78';
SET @updatedName = 'Kane';

UPDATE member
SET member_mname = @updatedName
WHERE member_membership_id = @memberId; */

-- ----------------------------------------------------------!
-- INSERT FOR FORM

/* SET @bookTitle = 'Godan - The Gift of a Cow';
SET @bookSubject = 'Arts & Literature';
SET @isbn10 = '9386000679';
SET @isbn13 = '9789386000675';
SET @authorFname = 'Munshi';
SET @authorLname = 'Premchand';
SET @publisherCode = 'NBT';
SET @bookGenre = 'Drama';
SET @bookOrigin = 'IN';
SET @bookLanguage = 'HI';

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
    ((SELECT subject_id FROM subject WHERE subject_name = @bookSubject), (SELECT country_id FROM country WHERE country_code = @bookOrigin), @bookTitle, @isbn13, @isbn10, @bookLanguage);

INSERT INTO book_author
(
    book_id
,   author_id
)
VALUES
    ((SELECT book_id FROM book WHERE book_title = @bookTitle), (SELECT author_id FROM author WHERE author_fname = @authorFname));

INSERT INTO book_genre
(
    book_id
,   genre_id
)
VALUES
    ((SELECT book_id FROM book WHERE book_title = @bookTitle), (SELECT genre_id FROM genre WHERE genre_name = @bookGenre));

INSERT INTO book_publisher
(
    book_id
,   publisher_id
)
VALUES
    ((SELECT book_id FROM book WHERE book_title = @bookTitle), (SELECT publisher_id FROM publisher WHERE publisher_codename = @publisherCode)); */