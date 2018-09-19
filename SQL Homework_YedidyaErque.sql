
USE sakila;
-- 1a.
SELECT 
  first_name AS 'First Name', 
  last_name AS 'Last name' 
FROM 
  actor;
-- 1b. 
SELECT 
  UPPER(
    CONCAT(first_name, ' ', last_name)
  ) AS 'Actor Name' 
FROM 
  actor;
-- 2a.
SELECT 
  actor_id AS 'ID', 
  first_name AS 'First Name', 
  last_name AS 'Last Name' 
FROM 
  actor 
WHERE 
  first_name = 'JOE';
-- 2b.
SELECT 
  first_name AS 'First Name', 
  last_name AS 'Last Name' 
FROM 
  actor 
WHERE 
  last_name LIKE '%GEN%';
-- 2c.
SELECT 
  first_name AS 'First Name', 
  last_name AS 'Last Name' 
FROM 
  actor 
WHERE 
  last_name LIKE '%LI%' 
ORDER BY 
  last_name, 
  first_name ASC;
-- 2d.
SELECT 
  country_id AS 'Country ID', 
  country AS 'Country' 
FROM 
  country 
WHERE 
  country IN (
    'Afghanistan', 'Bangladesh', 'China'
  );
-- 3a
ALTER TABLE 
  actor 
ADD 
  COLUMN description BLOB;
-- 3b.
ALTER TABLE 
  actor 
DROP 
  COLUMN description;
-- 4a
SELECT 
  last_name AS 'Last Name', 
  COUNT(*) AS 'Last Name Count' 
FROM 
  actor 
GROUP BY 
  last_name;
-- 4b
SELECT 
  last_name AS 'Last Name', 
  COUNT(*) AS 'Last Name Count' 
FROM 
  actor 
GROUP BY 
  last_name 
HAVING 
  (
    COUNT(*) >= 2
  );
SET 
  SQL_SAFE_UPDATES = 0;
-- 4c
UPDATE 
  actor 
SET 
  first_name = 'HARPO' 
WHERE 
  first_name = 'GROUCHO' 
  AND last_name = 'Williams';
-- 4d
UPDATE 
  actor 
SET 
  first_name = 'GROUCHO' 
WHERE 
  first_name = 'HARPO' 
  AND last_name = 'Williams';
-- 5a 
SELECT 
  * 
FROM 
  `INFORMATION_SCHEMA`.`TABLES` 
WHERE 
  TABLE_NAME LIKE 'address';
-- 6a 
SELECT 
  s.first_name AS 'First Name', 
  s.last_name AS 'Last Name', 
  a.address AS 'Staff Address' 
FROM 
  staff s 
  JOIN address a ON s.address_id = a.address_id;
-- 6b
SELECT 
  s.first_name AS 'First Name', 
  s.last_name AS 'Last Name', 
  COUNT(p.amount) AS 'Total Amount' 
FROM 
  staff s 
  JOIN payment p ON s.staff_id = p.staff_id 
WHERE 
  p.payment_date >= '2005-08-01 00:00:00' 
  AND p.payment_date < '2005-09-01 00:00:00' 
GROUP BY 
  s.first_name, 
  s.last_name;
-- 6c
SELECT 
  f.title AS 'Film Title', 
  COUNT(fa.actor_id) AS 'Number of Actors' 
FROM 
  film f 
  INNER JOIN film_actor fa ON f.film_id = fa.film_id 
GROUP BY 
  f.title;
-- 6d.
SELECT 
  f.title AS 'Film Title', 
  COUNT(i.inventory_id) AS 'Number of Copies' 
FROM 
  film f 
  JOIN inventory i ON f.film_id = i.film_id 
WHERE 
  f.title = 'Hunchback Impossible';
-- 6e 
SELECT 
  c.first_name AS 'First Name', 
  c.last_name AS 'Last Name', 
  SUM(p.amount) AS 'Total Payment' 
FROM 
  customer c 
  JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY 
  c.first_name, 
  c.last_name 
ORDER BY 
  c.last_name ASC;
-- 7a.
SELECT 
  title AS 'Title' 
FROM 
  film 
WHERE 
  (
    title LIKE 'K%' 
    OR title LIKE 'Q%'
  ) 
  AND language_id IN (
    SELECT 
      language_id 
    FROM 
      language 
    WHERE 
      name = 'English'
  );
-- 7b.
SELECT 
  first_name AS 'First Name', 
  last_name AS 'Last Name' 
FROM 
  actor 
WHERE 
  actor_id IN (
    SELECT 
      actor_id 
    FROM 
      film_actor 
    WHERE 
      film_id IN (
        SELECT 
          film_id 
        FROM 
          film 
        WHERE 
          title = 'Alone Trip'
      )
  );
-- 7c
SELECT 
  c.first_name AS 'First Name', 
  c.last_name AS 'Last Name', 
  c.email AS 'Email', 
  a.address AS 'Address', 
  city AS 'City', 
  country AS 'Country' 
FROM 
  customer c 
  JOIN address a ON c.address_id = a.address_id 
  JOIN city ON a.city_id = city.city_id 
  JOIN country ON city.country_id = country.country_id 
WHERE 
  country = 'Canada';
-- 7d
SELECT 
  f.title AS 'Film Title', 
  c.name AS 'Film Category Name' 
FROM 
  film f 
  JOIN film_category fc ON f.film_id = fc.film_id 
  JOIN category c ON fc.category_id = c.category_id 
WHERE 
  name = 'Children' 
  OR name = 'Family';
-- 7e 
SELECT 
  f.title AS 'Film Title', 
  COUNT(r.rental_id) AS 'Rental Frequency' 
FROM 
  film f 
  JOIN inventory i ON f.film_id = i.film_id 
  JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY 
  f.title 
ORDER BY 
  COUNT(r.rental_id) DESC;
-- 7f
SELECT 
  s.store_id AS 'Store ID', 
  SUM(p.amount) AS 'Total Revenue' 
FROM 
  payment p 
  JOIN staff s ON p.staff_id = s.staff_id 
  JOIN store ON s.store_id = store.store_id 
GROUP BY 
  store.store_id;
-- 7g
SELECT 
  store.store_id AS 'Store ID', 
  city.city AS 'Store City', 
  country.country AS 'Store Country' 
FROM 
  store 
  JOIN address a ON store.address_id = a.address_id 
  JOIN city ON a.city_id = city.city_id 
  JOIN country ON city.country_id = country.country_id 
GROUP BY 
  store_id;
-- 7h
SELECT 
  c.name AS 'Genre', 
  SUM(p.amount) AS 'Gross Revenue' 
FROM 
  category C 
  JOIN film_category fc ON c.category_id = fc.category_id 
  JOIN inventory i ON fc.film_id = i.film_id 
  JOIN rental r ON i.inventory_id = r.inventory_id 
  JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY 
  c.name 
ORDER BY 
  SUM(p.amount) DESC;
-- 8a
CREATE VIEW Revenue_By_Genre AS 
SELECT 
  c.name AS 'Genre', 
  SUM(p.amount) AS 'Gross Revenue' 
FROM 
  category C 
  JOIN film_category fc ON c.category_id = fc.category_id 
  JOIN inventory i ON fc.film_id = i.film_id 
  JOIN rental r ON i.inventory_id = r.inventory_id 
  JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY 
  c.name 
ORDER BY 
  SUM(p.amount) DESC;
-- 8b
SELECT 
  * 
FROM 
  Revenue_By_Genre;
-- 8c 
DROP 
  VIEW Revenue_By_Genre;
