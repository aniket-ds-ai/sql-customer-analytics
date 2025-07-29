-- ⚠️ Churn Risk Detection (Last Rental + Complaints)
WITH last_rentals AS (
  SELECT customer_id,
         MAX(rental_date) AS last_rental
  FROM rental
  GROUP BY customer_id
)

SELECT 
  c.customer_id,
  CONCAT(first_name, ' ', last_name) AS customer_name,
  DATEDIFF(CURDATE(), lr.last_rental) AS days_inactive,
  COALESCE(s.ticket_count, 0) AS ticket_count,
  CASE
    WHEN DATEDIFF(CURDATE(), lr.last_rental) > 90 OR COALESCE(s.ticket_count, 0) > 3 THEN 'High Risk'
    ELSE 'Low Risk'
  END AS churn_risk
FROM customer c
JOIN last_rentals lr ON c.customer_id = lr.customer_id
LEFT JOIN (
  SELECT customer_id, COUNT(*) AS ticket_count
  FROM support_tickets
  GROUP BY customer_id
) s ON c.customer_id = s.customer_id;
