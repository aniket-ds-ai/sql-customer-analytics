-- 📅 Monthly Rental Trends
SELECT 
  DATE_FORMAT(r.rental_date, '%Y-%m') AS month,
  COUNT(*) AS total_rentals
FROM rental r
GROUP BY month
ORDER BY month;
