use sakila;

-- Query 1: Convert the query into a simple stored procedure. Use the following query:
DELIMITER //
CREATE PROCEDURE Test ()
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = 'Action'
  group by first_name, last_name, email;
  
end //
DELIMITER ;

call Test();

-- Query 2: Now keep working on the previous stored procedure to make it more dynamic. 
-- Update the stored procedure in a such manner that it can take a string argument for the 
-- category name and return the results for all customers that rented movie of that category/genre. 
-- For eg., it could be action, animation, children, classics, etc.

DELIMITER //
CREATE PROCEDURE Test1 (in name varchar(10))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = name
  group by first_name, last_name, email;
  
end //
DELIMITER ;

call Test1('Action');
call Test1('Animation');
call Test1('Children');
call Test1('Classics');
call Test1('Comedy');


-- Query 3:Write a query to check the number of movies released in each movie category. 
-- Convert the query in to a stored procedure to filter only those categories that have movies 
-- released greater than a certain number. Pass that number as an argument in the stored procedure.
-- Step 1:
select category_id, name, count(film.film_id) as total_movies from category
join film_category using(category_id)
join film using (film_id)
-- where film.release_year= '2006'
group by category_id, name;

-- Step 2:
DELIMITER //
CREATE PROCEDURE Movies_by_Category() -- , out total_movies int)
begin
	select category_id, name, count(film.film_id) as total_movies from category
	join film_category using(category_id)
	join film using (film_id)
	group by category_id, name
	;

end //
DELIMITER ;

call Movies_by_Category();

