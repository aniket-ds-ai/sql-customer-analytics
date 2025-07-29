-- 💸 Discount Eligibility – Top 5 Repeat Renters
WITH rental_counts AS (
  SELECT 
    c.customer_id,
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
