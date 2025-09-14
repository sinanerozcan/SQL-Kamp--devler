IF OBJECT_ID('dbo.books', 'U') IS NOT NULL
    DROP TABLE dbo.books;
GO

CREATE TABLE books (
book_id INT IDENTITY(1,1) PRIMARY KEY,
title VARCHAR(100) NOT NULL,
author VARCHAR(100) NOT NULL,
genre VARCHAR(100),
price DECIMAL (10,2),
stock INT CHECK (stock >= 0),
published_year INT,
added_at_tarih DATE
);

INSERT INTO books (title, author, genre, price, stock, published_year, added_at_tarih)
VALUES
('Kayýp Zamanýn Ýzinde','M. Proust','Roman',129.90,25,1913,'2025-08-20'),
('Simyacý','P. Coelho','Roman',89.50,40,1988,'2025-08-21'),
('Sapiens','Y. N. Harari','Tarih',159.00,18,2011,'2025-08-25'),
('Ýnce Memed','Y. Kemal','Roman',99.90,12,1955,'2025-08-22'),
('Körlük','J. Saramago','Roman',119.00,7,1995,'2025-08-28'),
('Dune','F. Herbert','Bilim',149.00,30,1965,'2025-09-01'),
('Hayvan Çiftliði','G. Orwell','Roman',79.90,55,1945,'2025-08-23'),
('1984','G. Orwell','Roman',99.00,35,1949,'2025-08-24'),
('Nutuk','M. K. Atatürk','Tarih',139.00,20,1927,'2025-08-27'),
('Küçük Prens','A. de Saint-Exupéry','Çocuk',69.90,80,1943,'2025-08-26'),
('Baþlangýç','D. Brown','Roman',109.00,22,2017,'2025-09-02'),
('Atomik Alýþkanlýklar','J. Clear','Kiþisel Geliþim',129.00,28,2018,'2025-09-03'),
('Zamanýn Kýsa Tarihi','S. Hawking','Bilim',119.50,16,1988,'2025-08-29'),
('Þeker Portakalý','J. M. de Vasconcelos','Roman',84.90,45,1968,'2025-08-30'),
('Bir Ýdam Mahkûmunun Son Günü','V. Hugo','Roman',74.90,26,1829,'2025-08-31')

-- SORU - 1

SELECT title, author, price
FROM books
ORDER BY price ASC;

-- SORU - 2

SELECT *
FROM books
WHERE genre = N'roman'
ORDER BY title ASC;

-- SORU - 3

SELECT *
FROM books
WHERE price BETWEEN 80 AND 120;

-- SORU - 4
SELECT * 
FROM books
WHERE stock < 20;

-- SORU - 5
SELECT *
FROM books
WHERE LOWER(title) LIKE N'%zaman%';

-- SORU - 6
SELECT * 
FROM books
WHERE genre IN (N'Roman', N'Bilim');

-- SORU - 7
SELECT* 
FROM books
WHERE published_year >= 2000
ORDER BY published_year DESC;

-- SORU - 8
SELECT *
FROM books
WHERE added_at_tarih >= DATEADD(DAY, -10, CAST(GETDATE() AS DATE));

-- SORU - 9
SELECT TOP 5 *
FROM books
ORDER BY price DESC;

-- SORU - 10
SELECT *
FROM books
WHERE stock BETWEEN 30 AND 60
ORDER BY price ASC;