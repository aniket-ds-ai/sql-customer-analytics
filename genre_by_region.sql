-- 🎞️ Genre Popularity by Region
SELECT 
  l.city, 
  c.name AS genre,
  COUNT(*) AS rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN customer cust ON r.customer_id = cust.customer_id
JOIN location l ON cust.location_id = l.location_id
GROUP BY l.city, genre
ORDER BY l.city, rentals DESC;
