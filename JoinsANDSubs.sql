SELECT * 
FROM 


-- Join between the film and film_actor table
SELECT *
FROM film_actor fa 
JOIN film f 
ON f.film_id = fa.film_id;

--join betwen the actor and film_actor table
SELECT *
FROM film_actor fa 
JOIN actor a 
ON a.actor_id = fa.actor_id;

-- Multi-JOIN
SELECT a.first_name, a.last_name, a.actor_id, fa.actor_id, fa.film_id, f.film_id, f.title, f.description
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id 
JOIN film f
ON f.film_id = fa.film_id;

-- Display customer name and film that they rented -- customer -> rental -> inventory -> film
SELECT c.first_name, c.last_name, c.customer_id, r.rental_id, r.inventory_id, i.inventory_id, i.film_id, f.film_id, f.title
FROM customer c
JOIN rental r 
ON c.customer_id = r.customer_id 
JOIN inventory i 
ON r.inventory_id = i.inventory_id 
JOIN film f 
ON i.film_id = f.film_id ;

-- we can still do all of the other Fun DQL clauses
SELECT c.first_name, c.last_name, c.customer_id, r.rental_id, r.inventory_id, i.inventory_id, i.film_id, f.film_id, f.title
FROM customer c
JOIN rental r 
ON c.customer_id = r.customer_id 
JOIN inventory i 
ON r.inventory_id = i.inventory_id 
JOIN film f 
ON i.film_id = f.film_id 
WHERE c.first_name LIKE 'R%'
ORDER BY f.title 
LIMIT 10
OFFSET 5;

-- SUBQUERIES!!!
-- Subquery is a query within another query

-- Ex. Which films have exactly 12 actors in the film?

-- Step 1. Get ths IDs of the films that have exactly 12 actors
SELECT film_id  -->can remove this, only there for self to see really,---> COUNT(*)
FROM film_actor
GROUP BY film_id
HAVING COUNT(*) = 12;

--film_id|
---------+
--    529|
--    802|
--     34|
--    892|
--    414|
--    517|

-- Step 2. Get the films from the film table that match those IDs
SELECT *
FROM film 
WHERE film_id IN (
	529,
	802,
	34,
	892,
	414,
	517
);

-- Put the two steps together into a subquery
-- The query that we want to execute first is the subquery
-- ** Subquery must return only ONE column **  *unless used in a FROM clause

SELECT *  -- subquery
FROM film 
WHERE film_id IN (
	SELECT film_id   -- query
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*) = 12
);

SELECT *  -- subquery
FROM film 
JOIN (
	SELECT film_id   -- query
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*) = 12
) AS temp_table
ON temp_table.film_id = film.film_id;   -- AIDAN'S IDEA NOT a great way TO GO


--subquery vs Join
-- which employee has sold the most rentals (use the rental table)
SELECT *  -- subquery
FROM staff 
WHERE staff_id IN(
	SELECT staff_id
	FROM rental r 
	GROUP BY staff_id 
	ORDER BY count(*) DESC 
	LIMIT 1
);

SELECT s.staff_id, first_name, last_name, count(*)
FROM rental r 
JOIN staff s 
ON r.staff_id = s.staff_id 
GROUP BY s.staff_id 
ORDER BY count(*) DESC ;

-- use subqueries for calculations
-- find all of the payments that are more than the average payment

SELECT * 
FROM payment p 
WHERE amount > (
	SELECT avg(amount)
	FROM payment
);

-- subqueries with the FROM clause
-- *subqeury in a FROM must ne in paranthesis * 

-- find the average number of rentals per customer 

-- Step 1. Get the count for each customer
SELECT customer_id, count(*) AS num_rentals
FROM rental r 
GROUP BY customer_id ;

-- Step 2. Use the temp table from step 1 as the table to find the average via subquery
SELECT *
FROM (
	SELECT customer_id, count(*) AS num_rentals
	FROM rental r 
	GROUP BY customer_id
) AS customer_rentals_totals
WHERE num_rentals > 40
ORDER BY num_rentals;

-- subqueries can also be used in DML statements

-- setup --> add loyalty 
ALTER TABLE customer 
ADD COLUMN loyalty_member boolean;

UPDATE customer 
SET loyalty_member = FALSE;

SELECT *
FROM customer;



-- update the customer table and set any character who has over 25 rentals to be a loyalty_member

-- step 1. Find all the customer IDs of those customer who have rented 25+ films
SELECT customer_id, count(*)
FROM rental r 
GROUP BY customer_id 
HAVING count(*) >= 25;

-- Step 2. make an update statment and update all customers with those IDs
UPDATE customer 
SET loyalty_member = TRUE 
WHERE customer_id IN (
	select customer_id
	FROM rental 
	GROUP BY customer_id 
	HAVING count(*) >=25
);

SELECT loyalty_member, count(*)
FROM customer c 
GROUP BY loyalty_member;



