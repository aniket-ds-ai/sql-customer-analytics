# 📊 Customer Behavior Analytics Using SQL – MavenMovies Extended

This project contains **real-world SQL queries** for customer behavior analysis using the **MavenMovies** dataset, extended with custom fields like customer location and churn tickets.

🎯 Goal: Use SQL to extract **actionable business insights** — just like a Data Analyst would in a media/rental company.

---

## 🧠 Business Problems Solved

| Use Case | SQL Concepts |
|----------|--------------|
| 🔝 Top 10 customers by total payment | JOIN, SUM(), GROUP BY, ORDER BY |
| 📅 Monthly rental trends | DATE_FORMAT, COUNT(), GROUP BY |
| 🎞️ Genre popularity by region | CASE, JOINs, GROUP BY |
| ⚠️ Churn risk prediction | CTE, CASE WHEN, DATEDIFF |
| 💸 Discount eligibility logic | RANK(), DENSE_RANK(), OVER() |

---

## 📂 Folder Structure

```
sql-customer-analytics/
├── queries/                  # All SQL query files
│   ├── top_customers.sql
│   ├── rental_trends.sql
│   ├── genre_by_region.sql
│   ├── churn_risk.sql
│   └── discount_eligibility.sql
├── output/                   # Screenshot of result tables (optional)
│   ├── top_customers.png
│   └── rental_trends.png
├── mavenmovies_latest_db/
│   ├── mavenmovies_actor.sql
│   ├── mavenmovies_actor_award.sql
│   ├── mavenmovies_address.sql
│   ├── mavenmovies_advisor.sql
│   ├── mavenmovies_category.sql
│   ├── mavenmovies_city.sql
│   ├── mavenmovies_country.sql
│   ├── mavenmovies_customer.sql
│   ├── mavenmovies_film.sql
│   ├── mavenmovies_film_actor.sql
│   ├── mavenmovies_film_category.sql
│   ├── mavenmovies_film_text.sql
│   ├── mavenmovies_inventory.sql
│   ├── mavenmovies_investor.sql
│   ├── mavenmovies_language.sql
│   ├── mavenmovies_location.sql
│   ├── mavenmovies_payment.sql
│   ├── mavenmovies_rental.sql
│   ├── mavenmovies_routines.sql
│   ├── mavenmovies_staff.sql
│   ├── mavenmovies_store.sql
│   └── mavenmovies_support_tickets.sql
├── README.md
```

---

## 💻 SQL Query Examples

### 1️⃣ Top 10 Paying Customers

```sql
SELECT c.customer_id, CONCAT(first_name, ' ', last_name) AS customer_name,
       SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, first_name, last_name
ORDER BY total_paid DESC
LIMIT 10;
```

---

### 2️⃣ Monthly Rental Trends

```sql
SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS month,
       COUNT(*) AS total_rentals
FROM rental r
GROUP BY month
ORDER BY month;
```

---

### 3️⃣ Genre Popularity by Region

```sql
SELECT l.city, c.name AS genre,
       COUNT(*) AS rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN customer cust ON r.customer_id = cust.customer_id
JOIN location l ON cust.location_id = l.location_id
GROUP BY l.city, genre
ORDER BY l.city, rentals DESC;
```

---

### 4️⃣ Churn Risk Detection (Last Rental + Complaints)

```sql
WITH last_rentals AS (
  SELECT customer_id,
         MAX(rental_date) AS last_rental
  FROM rental
  GROUP BY customer_id
)

SELECT c.customer_id,
       CONCAT(first_name, ' ', last_name) AS customer_name,
       DATEDIFF(CURDATE(), lr.last_rental) AS days_inactive,
       s.ticket_count,
       CASE
         WHEN DATEDIFF(CURDATE(), lr.last_rental) > 90 OR s.ticket_count > 3
         THEN 'High Risk'
         ELSE 'Low Risk'
       END AS churn_risk
FROM customer c
JOIN last_rentals lr ON c.customer_id = lr.customer_id
LEFT JOIN (
  SELECT customer_id, COUNT(*) AS ticket_count
  FROM support_tickets
  GROUP BY customer_id
) s ON c.customer_id = s.customer_id;
```

---

### 5️⃣ Discount Recommendation – Top 5 Repeat Renters

```sql
WITH rental_counts AS (
  SELECT c.customer_id,
         CONCAT(c.first_name, ' ', c.last_name) AS name,
         COUNT(r.rental_id) AS total_rentals
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  GROUP BY c.customer_id
)

SELECT *,
       RANK() OVER (ORDER BY total_rentals DESC) AS rental_rank
FROM rental_counts
WHERE total_rentals > 10
LIMIT 5;
```

---

## 🛠️ Technologies Used

```
- SQL (MySQL/PostgreSQL compatible)
- IDE: DBeaver / MySQL Workbench / PgAdmin
- Dataset: MavenMovies (extended)
```

---

## 🔧 Setup Instructions

1. Import `database/mavenmovies_extended_schema.sql` in your SQL IDE  
2. Run any query from the `/queries/` folder  
3. (Optional) Add screenshots to `/output/` for better visuals

---

## 💬 Why This Project?

This project simulates how a real Data Analyst thinks and works — from writing advanced SQL to extracting meaningful customer insights that drive business decisions.

---

## ✅ Perfect For:

- 💼 Job Interview Portfolios  
- 📈 LinkedIn or Kaggle Showcases  
- 🧠 Active Recall SQL Practice

---

