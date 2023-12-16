Requirements:
To appreciate the commitment, the manager intends to implement a sales incentive program based
on the total sales of each associate in comparison to the total sales for the month:

WITH percent_revenue AS (SELECT
                         sale_id,
                         DATE_FORMAT(sale_date, '%M %Y') AS month_year,
                         total_price / (SELECT SUM(total_price)
                                        FROM sales
                                        WHERE DATE_FORMAT(sale_date, '%M %Y') = month_year) AS percent
                         FROM sales)
SELECT
    CONCAT(first_name, ' ', last_name) AS employee_name,
    position,
    month_year,
    CASE
        WHEN SUM(percent) < 0.05 THEN 0
        WHEN SUM(percent) < 0.1 THEN 2000
        WHEN SUM(percent) < 0.2 THEN 5000
        WHEN SUM(percent) < 0.3 THEN 10000
        WHEN SUM(percent) < 0.4 THEN 15000
        ELSE 25000
    END AS employee_bonus
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id AND e.position = 'Sales Associate'
JOIN percent_revenue pr ON s.sale_id = pr.sale_id
GROUP BY employee_name, e.position, month_year;