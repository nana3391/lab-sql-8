USE Sakila;
-- 1. 
SELECT s.store_id, ci.city, co.country
FROM city ci
JOIN address a ON ci.city_id = a.city_id
JOIN store s ON a.address_id = s.address_id
JOIN country co ON ci.country_id = co.country_id;

-- 2.
SELECT s.store_id, SUM(p.amount) as total_business
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

-- 3.
SELECT fc.category_id, c.name AS category_name, AVG(f.length) AS avg_film_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY fc.category_id, c.name
ORDER BY avg_film_length DESC;

-- 4.
SELECT f.film_id, f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;

-- 5.
SELECT c.name AS genre_name, SUM(p.amount) AS gross_revenue
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 6.
SELECT f.title AS film_title, s.store_id AS store_id, IFNULL(i.inventory_id, 0) AS is_available
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
LIMIT 1;

-- 7.
SELECT DISTINCT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
                CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id != fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id;