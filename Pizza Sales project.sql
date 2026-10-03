----BEGINNER
--Q1 Retrieve the total numbers of orders.

SELECT COUNT(order_id) as total_orders 
FROM orders;                                   -- Total Orders = 21350



--Q2 Calculate total revenue from total sales.

SELECT ROUND(SUM(order_details.quantity * pizzahut.price)) AS total_revenue
FROM order_details JOIN pizzahut
ON order_details.pizza_id = pizzahut.pizza_id; --Total Revenue = 817860



--Q3 Identify the highest price pizza.

SELECT pizza_types.name, pizzahut.price
FROM pizza_types JOIN pizzahut
ON pizza_types.pizza_type_id = pizzahut.pizza_type_id
ORDER BY pizzahut.price DESC
LIMIT 1;                                       --Highest Price pizza =   The Greek Pizza 
                                               --              Price =   35.92 



--Q4 Identify the most common order pizza size ordered.

SELECT pizzahut.size, COUNT(order_details.order_details_id) AS Order_details
FROM pizzahut JOIN order_details
ON pizzahut.pizza_id = order_details.pizza_id
GROUP BY pizzahut.size 
ORDER BY Order_details DESC ;        
                                   --M.C.S.P.O -> size  Quantity 
                                                 -- L     18526
												 -- M     15385
												 -- S     14137


--Q5 List the Top 5 Most ordered pizza types along with their quantities.

SELECT pizza_types.name, SUM(order_details.quantity) AS quantity
FROM pizza_types JOIN pizzahut
ON pizza_types.pizza_type_id = pizzahut.pizza_type_id
JOIN order_details 
ON order_details.pizza_id = pizzahut.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;                                
                                         --   NAME                      Quantity

                                          --"The Classic Deluxe Pizza"	   2453
                                          --"The Barbecue Chicken Pizza"   2432
                                          --"The Hawaiian Pizza"	       2422
                                          --"The Pepperoni Pizza"	       2418
                                          --"The Thai Chicken Pizza"       2371



----INTERMEDIATE
--Q6 Join the necessary table to find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(order_details.quantity) AS Quantity
FROM pizza_types JOIN pizzahut
ON pizza_types.pizza_type_id = pizzahut.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzahut.pizza_id
GROUP BY pizza_types.category 
ORDER BY Quantity DESC;
                      --                    Category   Quantity
					  
					                      --"Classic"	  14888
                                          --"Supreme"	  11987
                                          --"Veggie"	  11649
                                          --"Chicken"	  11050                          



--Q7 Determine the distribution of orders by hour of the day.

SELECT EXTRACT(HOUR FROM time) AS Hours, COUNT(order_id) AS order_count
FROM orders
GROUP BY EXTRACT(HOUR FROM time)
ORDER BY order_count DESC;
                            --  Hours   Order_count
								--12	2520
                                --13	2455
                                --18	2399
                                --17	2336
                                --19	2009
                                --16	1920
                                --20	1642
                                --14	1472
                                --15	1468
                                --11	1231
                                --21	1198
                                --22	663
                                --23	28
                                --10	8
                                 --9	1



--Q8 Join relevant tables to find the catrgory-wise distribution of pizzas.

SELECT category, COUNT(name) 
FROM pizza_types
GROUP BY category;
                      --       Category       Count
                             --"Supreme"	    9
                             --"Chicken"	    6
                             --"Classic"	    8
                             --"Veggie"	        9



--Q9 Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT round(AVG(pizzas_ordered), 0) AS avg_pizzas_per_day
FROM (
    SELECT orders.date,
           SUM(order_details.quantity) AS pizzas_ordered
    FROM orders
    JOIN order_details
    ON orders.order_id = order_details.order_id
    GROUP BY orders.date
) AS daily_orders;
                            --Average Pizza Ordered per day =     138



--Q10 Determine top 3 most ordered pizzas types based on revenue.

SELECT pizza_types.name, SUM(order_details.quantity * pizzahut.price) AS Revenue
FROM pizza_types JOIN pizzahut
ON pizza_types.pizza_type_id = pizzahut.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzahut.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3;
                              -----Name                          Revenue
                             --"The Thai Chicken Pizza"	         43434.25
                             --"The Barbecue Chicken Pizza"	     42768.00
                             --"The California Chicken Pizza"	 41409.50



----ADVANCE 
--Q11 Calculate the percentage contribution of each pizza type to total menu.

SELECT pizza_types.category, ROUND(SUM(order_details.quantity * pizzahut.price)/(SELECT 
ROUND(SUM(order_details.quantity * pizzahut.price))
FROM order_details JOIN pizzahut
ON order_details.pizza_id = pizzahut.pizza_id)*100, 2) AS Revenue
FROM pizza_types JOIN pizzahut
ON pizza_types.pizza_type_id = pizzahut.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzahut.pizza_id
GROUP BY pizza_types.category ORDER BY Revenue DESC;
                         --               Category        Revenue
                         --               "Classic"	       26.91
                         --               "Supreme"	       25.46
                         --               "Chicken"	       23.96
                         --               "Veggie"	       23.68



--Q12 Analyze the cumulative revenue generated over time.

SELECT date, SUM(revenue) OVER(order by date) AS cum_rev 
FROM (SELECT orders.date, SUM(order_details.quantity * pizzahut.price) AS revenue
FROM order_details JOIN pizzahut
ON order_details.pizza_id = pizzahut.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY orders.date) AS sales LIMIT 5;
                                      --Date                cum_rev
								--	  "2015-01-01"	        2713.85
                                --    "2015-01-02"	        5445.75
                                --    "2015-01-03"	        8108.15
                                --    "2015-01-04"	        9863.60
                                --    "2015-01-05"	        11929.55



--Q13 Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT name, revenue FROM
(SELECT name, category, revenue, RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
FROM
(SELECT pizza_types.name, pizza_types.category, SUM(order_details.quantity * pizzahut.price) AS revenue
FROM pizza_types JOIN pizzahut
ON pizza_types.pizza_type_id = pizzahut.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzahut.pizza_id
GROUP BY pizza_types.name, pizza_types.category) AS a) AS b
WHERE rn <=3 ;
                                           --Name                                Revenue
									  "The Thai Chicken Pizza"	                 43434.25
                                      "The Barbecue Chicken Pizza"	             42768.00
                                      "The California Chicken Pizza"	         41409.50
                                      "The Classic Deluxe Pizza"	             38180.50
                                      "The Hawaiian Pizza"	                     32273.25
                                      "The Pepperoni Pizza"	                     30161.75
                                      "The Spicy Italian Pizza"	                 34831.25
                                      "The Italian Supreme Pizza"	             33476.75
                                      "The Sicilian Pizza"	                     30940.50
                                      "The Four Cheese Pizza"	                 32265.70
                                      "The Mexicana Pizza"	                     26780.75
                                      "The Five Cheese Pizza"	                 26066.50
