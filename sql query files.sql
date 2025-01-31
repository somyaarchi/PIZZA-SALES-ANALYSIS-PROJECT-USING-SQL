create database sales_pizza;
use sales_pizza;
select * from pizzas;
select *  from pizza_types;
-- Retrieve the total number of orders placed.

select * from order_details;
select count(order_id) as num_of_placed from order_details;
-- Calculate the total revenue generated from pizza sales.
--  total revenue = price * Quantity   --
SELECT 
  round(SUM(p.price * o.quantity),2) AS total_revenue
FROM
    pizzas AS p
        JOIN
    order_details AS o USING (pizza_id)
GROUP BY p.pizza_id;
-- Identify the highest-priced pizza.-- 
SELECT 
    pizza_types.name, pizzas.price AS highest_price_pizza
FROM
    pizza_types join pizzas
order by pizzas.price desc
limit 1;
-- Identify the most common pizza size ordered.
aggregate value hota h to group by karna padta h -- 
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
using(pizza_id)
group by pizzas.size order by order_count desc;
-- List the top 5 most ordered pizza types along with their quantities.
select  p.name , sum(q.quantity) as quantity from pizza_type p join pizzas p1
using(pizza_type_id)
join order_details q using(pizza_id)
group by p.name
order by quantity desc
limit 5; 
-- intermidiate question
-- Join the necessary tables to find the total quantity of each pizza category ordered. 
select p.category , sum(o.quantity) as qun from pizza_types p join pizzas p1 
on p.pizza_type_id = p1.pizza_type_id
join order_details o on p1.pizza_id = o.pizza_id
group by p.category;
-- Determine the distribution of orders by hour of the day

select hour(time) as hour, count(order_id) as order_count from orders
group by hour(time);
-- Join relevant tables to find the category-wise distribution of pizzas.
select category , count(pizza_type_id) as count_of_pizza from pizza_types
group by category;
-- Group the orders by date and calculate the average number of pizzas ordered per day.
-- Determine the top 3 most ordered pizza types based on revenue.
select p.name , sum(p1.price*o.quantity) as revenue 
from pizza_types p join pizzas p1 
on p.pizza_type_id = p1.pizza_type_id
join order_details o on p1.pizza_id = o.pizza_id
group by p.name 
order by revenue desc 
limit 3;
-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
select p.category , (sum(p1.price*o.quantity) / (select round(sum(o.quantity* p1.price),2) as total_sales 
from order_details o join pizzas p1 on p1.pizza_id = o.pizza_id )) * 100 as revenue 
from pizza_types p join pizzas p1 
on p.pizza_type_id = p1.pizza_type_id
join order_details o on p1.pizza_id = o.pizza_id
group by p.category 
order by revenue desc 
-- Analyze the cumulative revenue generated over time.

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.



