-- Пример с DISTINCT 
SELECT DISTINCT [first_name], 
		 [last_name]
  FROM [library].[dbo].[reader]

--  Аналог DISTINCT, но через GROUP BY
SELECT [first_name]
FROM [reader]
GROUP BY [first_name]

-- Подсчет уникальных значений
SELECT COUNT (DISTINCT [first_name]) as cnt
FROM [library].[dbo].[reader]

-- INNER JOIN
SELECT * FROM reader
JOIN issuance ON reader.id_reader = issuance.id_reader

SELECT * FROM issuance
JOIN reader ON reader.id_reader = issuance.id_reader

SELECT reader.* FROM issuance
JOIN reader ON reader.id_reader = issuance.id_reader

SELECT r.* FROM issuance
JOIN reader AS r ON r.id_reader = issuance.id_reader

SELECT r.* FROM issuance
JOIN reader AS r ON r.id_reader = issuance.id_reader
-- ORDER BY r.first_name
ORDER BY 2

-- Декартово произведение
SELECT COUNT(*) FROM reader
SELECT COUNT(*) FROM issuance
SELECT COUNT(*) FROM reader
JOIN issuance ON 1 = 1

-- Так не делай (см ON)
SELECT * FROM issuance
JOIN reader AS r ON r.id_reader = issuance.id_issuance

-- LEFT JOIN Найдем книги без копии
SELECT * FROM book 
LEFT JOIN copy ON book.id_book = copy.id_book
WHERE id_copy IS NULL

-- LEFT JOIN нескольких таблиц
SELECT * FROM book AS b
LEFT JOIN author_has_book AS ahb ON ahb.id_book = b.id_book
LEFT JOIN author AS a ON a.id_author = ahb.id_author

-- Комбинация нескольких видов JOIN
SELECT * FROM book AS b
INNER JOIN author_has_book AS ahb ON ahb.id_book = b.id_book
LEFT JOIN author AS a ON a.id_author = ahb.id_author

SELECT * FROM book AS b1
LEFT JOIN book AS b2 ON b1.id_book = b2.id_book

-- Пример RIGHT JOIN
SELECT * FROM copy
RIGHT JOIN book ON copy.id_book = book.id_book

SELECT * FROM book
LEFT JOIN copy ON copy.id_book = book.id_book

-- В каких категориях опубликованы книги автора
SELECT a.id_author, c.name FROM author AS a
LEFT JOIN author_has_book AS ahb ON a.id_author = ahb.id_author
LEFT JOIN book AS b ON b.id_book = ahb.id_book
LEFT JOIN category_has_book AS chb ON chb.id_book = b.id_book
LEFT JOIN category AS c ON c.id_category = chb.id_category
GROUP BY a.id_author, c.name

-- TOP 10 книг по количеству issuance
SELECT TOP 10 b.name, COUNT(*) as cnt FROM book AS b
LEFT JOIN copy AS c ON c.id_book = b.id_book
LEFT JOIN issuance AS i ON i.id_copy = c.id_copy
LEFT JOIN reader AS r ON r.id_reader = i.id_reader
GROUP BY b.name
ORDER BY 2 DESC

SELECT b.id_book, b.name, COUNT( DISTINCT r.id_reader) as cnt FROM book AS b
LEFT JOIN copy AS c ON c.id_book = b.id_book
LEFT JOIN issuance AS i ON i.id_copy = c.id_copy
LEFT JOIN reader AS r ON r.id_reader = i.id_reader
GROUP BY b.id_book, b.name
ORDER BY 2 DESC, 3 

SELECT book.name, COUNT(*) FROM book
GROUP BY book.name
ORDER BY 2 DESC

SELECT * FROM book AS b
LEFT JOIN author_has_book AS ahb ON b.id_book = ahb.id_book
WHERE name = 'Assassins Without Duty'

SELECT * FROM copy AS c
LEFT JOIN book AS b ON c.id_book = b.id_book
WHERE name = 'Assassins Without Duty'

SELECT id_copy, COUNT(*) FROM issuance
WHERE id_copy IN (
	SELECT id_copy FROM copy AS c
	LEFT JOIN book AS b ON c.id_book = b.id_book
	WHERE name = 'Assassins Without Duty'
)
GROUP BY id_copy 

-- количество книг, написанных автором
SELECT 
ahb.id_author, 
(SELECT first_name FROM author WHERE author.id_author = ahb.id_author), 
COUNT(*) AS cnt 
FROM author_has_book AS ahb
GROUP BY ahb.id_author

SELECT * FROM (SELECT * FROM author WHERE first_name like 'A%') AS a


-- Найти читателей хотя бы брали одну книгу
SELECT DISTINCT reader.id_reader FROM reader
JOIN issuance ON reader.id_reader = issuance.id_reader

SELECT * FROM reader AS r
WHERE id_reader NOT IN 
( SELECT id_reader FROM issuance AS i)
ORDER BY 1 