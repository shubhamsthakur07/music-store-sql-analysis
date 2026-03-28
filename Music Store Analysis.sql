--- Who is the senior most employee?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

--- Which Country has most invoices?

SELECT COUNT(*) AS C, billing_country
FROM Invoice
GROUP BY billing_country
ORDER BY C DESC;

--- What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

--- Which City has the highest sum of invoice totals?
--- Return both City Name & Sum of all invoices.

SELECT billing_city, SUM(total) AS Total
FROM invoice
GROUP BY billing_city
ORDER BY Total DESC
LIMIT 1;

--- Which customer has spent the most money?

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS Total
FROM customer AS c
JOIN invoice AS i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY Total DESC
LIMIT 1;

--- Write query to return Email, First name, Last Name, & Genre of all Rock Music listeners.
--- Return the list ordered alphabetically by Email starting with A.

SELECT DISTINCT c.email, c.first_name, c.last_name
FROM customer AS c
JOIN invoice AS i
ON c.customer_id = i.Customer_id
JOIN invoice_line AS il
ON i.invoice_id = il.invoice_id
WHERE track_id IN(
SELECT track_id FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
)
ORDER BY c.email ASC;

--- Which Artist has written most rock song in our dataset?
--- Write a query that returns the Artist name and total track count of the TOP 10 rock bands.

SELECT ar.artist_id,ar.name, COUNT(ar.artist_id) AS Number_of_songs
FROM track AS t
JOIN album AS al
ON t.album_id = al.album_id
JOIN artist AS ar
ON ar.artist_id = al.artist_id
JOIN genre AS g
ON t.genre_id = g.genre_id
WHERE g.name ='Rock'
GROUP BY ar.artist_id
ORDER BY Number_of_songs DESC
LIMIT 10;

--- Return all track names that have a song length longer than average song length.
--- Return the name and milliseconds for each track.
--- Order by the song length with the longest song listed first.

SELECT name,milliseconds
FROM track
WHERE milliseconds >
	(SELECT AVG(milliseconds)
	FROM track
)
ORDER BY milliseconds DESC;

--- Find out how much amount spent by each customer on top artist?
--- Write a query to return customer name, artist name, and total spent.

WITH best_selling_artist AS (
	SELECT ar.artist_id, ar.name AS artist_name, SUM(il.unit_price*il.quantity) AS total_spent
	FROM invoice_line AS il
	JOIN track AS t
	ON il.track_id = t.track_id
	JOIN album AS al
	ON t.album_id = al.album_id
	JOIN artist AS ar
	ON al.artist_id = ar.artist_id
	GROUP BY ar.artist_id
	ORDER BY total_spent DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS total_spent
FROM invoice AS i
JOIN customer AS c
ON i.customer_id = c.customer_id
JOIN invoice_line AS il
ON i.invoice_id = il.invoice_id
JOIN track AS t
ON il.track_id = t.track_id
JOIN album AS al
ON t.album_id = al.album_id
JOIN best_selling_artist AS bsa
ON al.artist_id = bsa.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY total_spent DESC;

--- Write the query to return each country along with the top genre.
--- For Countries where the maximum number of purchases is shared return all genres.

 WITH popular_genre AS(
		SELECT COUNT(il.quantity) AS purchases, c.country, g.name, g.genre_id,
		ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS RowNO
		FROM invoice_line AS il
		JOIN invoice AS i 
		ON il.invoice_id = i.invoice_id	
		JOIN customer AS c
		ON i.customer_id = c.customer_id
		JOIN track AS t
		ON il.track_id = t.track_id
		JOIN genre AS g
		ON t.genre_id = g.genre_id
		GROUP BY c.country, g.name, g.genre_id
		ORDER BY c.country ASC, purchases DESC
 )
 SELECT * 
 FROM popular_genre
 WHERE RowNo <= 1;

--- Write a query that returns the country along with the top customer and how much they spent.
--- For the countries where the top amount spent is shared, provide all customers who spent this amount.

WITH customer_country AS(
	SELECT c.customer_id, c.first_name, c.last_name, i.billing_country AS country, SUM(i.total) AS total_spent,
	ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS RowNo
	FROM invoice AS i
	JOIN customer AS c
	ON i.customer_id = c.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name, i.billing_country
	ORDER BY country ASC, total_spent DESC
)
SELECT cc.country, cc.first_name AS name, cc.last_name AS surname, cc.total_spent
FROM customer_country AS cc
WHERE RowNO <= 1;

