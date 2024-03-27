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

SELECT
    b.book_title AS 'Book Title'
,   CONCAT(a.author_fname,' ',a.author_mname,' ',a.author_lname) AS 'Book Author'
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