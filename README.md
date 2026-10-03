# 🍕 Pizza Sales Analysis using SQL

A SQL project that analyzes pizza sales data to uncover business insights such as total revenue, best-selling pizzas, peak ordering hours, and category-wise performance.

## 📌 Project Overview

This project answers **13 business questions** using SQL, ranging from basic aggregations to advanced queries with subqueries and window functions. The goal is to understand customer ordering patterns and which products drive the most revenue.

## 🗂️ Database Structure

| Table | Description |
|---|---|
| `orders` | Order ID, date and time of each order |
| `order_details` | Pizzas in each order and their quantity |
| `pizzahut` | Pizza ID, pizza type, size and price |
| `pizza_types` | Pizza name, category and ingredients |

## 🛠️ Tools & Concepts Used

- **Database:** PostgreSQL
- **Concepts:** `JOIN`, `GROUP BY`, `ORDER BY`, `LIMIT`, aggregate functions (`SUM`, `COUNT`, `AVG`, `ROUND`), `EXTRACT`, subqueries, window functions (`SUM() OVER`, `RANK() OVER`)

## ❓ Questions Solved

### Beginner
1. Total number of orders placed
2. Total revenue from pizza sales
3. Highest priced pizza
4. Most commonly ordered pizza size
5. Top 5 most ordered pizza types with quantities

### Intermediate
6. Total quantity ordered for each pizza category
7. Distribution of orders by hour of the day
8. Category-wise distribution of pizzas
9. Average number of pizzas ordered per day
10. Top 3 pizza types by revenue

### Advanced
11. Percentage contribution of each pizza category to total revenue
12. Cumulative revenue generated over time
13. Top 3 pizza types by revenue within each category

## 📊 Key Insights

- **Total orders:** 21,350
- **Total revenue:** ~817,860
- **Highest priced pizza:** The Greek Pizza (35.92)
- **Most popular size:** Large (L), followed by Medium and Small
- **Best-selling pizza (by quantity):** The Classic Deluxe Pizza (2,453 units)
- **Top revenue pizza:** The Thai Chicken Pizza (43,434.25)
- **Best-selling category:** Classic (14,888 pizzas ordered)
- **Revenue share by category:** Classic 26.91%, Supreme 25.46%, Chicken 23.96%, Veggie 23.68%
- **Peak ordering hours:** 12 PM–1 PM (lunch) and 5 PM–7 PM (evening)
- **Average pizzas ordered per day:** ~138

## 📁 Repository Structure

```
├── Pizza_Sales_project.sql   # All SQL queries with results as comments
└── README.md                 # Project description
```

## ▶️ How to Run

1. Create a database and load the four tables (`orders`, `order_details`, `pizzahut`, `pizza_types`).
2. Open `Pizza_Sales_project.sql` in PostgreSQL (pgAdmin, DBeaver, or `psql`).
3. Run the queries one by one. The result of each query is written beside it as a comment.

## 🚀 Conclusion

The analysis shows that customers prefer large pizzas, ordering peaks around lunch and dinner time, and the Classic category leads in both volume and revenue. These insights can help a pizza business plan its menu, staffing and promotions.

## 👤 Author

**Your Name**
[LinkedIn](https://www.linkedin.com/) | [GitHub](https://github.com/)
