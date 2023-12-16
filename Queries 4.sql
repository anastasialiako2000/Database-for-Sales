Requirements:
Suppose we have equivalent profit margins for each car model and similar levels of
customer satisfaction. In this scenario, the sales manager intends to use the sales inventory ratio
to determine which car models to select. The sales inventory ratio is calculated by dividing
the total sales per car model by its corresponding inventory. The manager will raise the percentage
of models with a high sales inventory ratio and their reorder level.

WITH SaleInventory AS (
    SELECT
        p.model,
        MAX(p.price) AS price,
        SUM(s.quantity * p.price) AS total_sale_per_model,
        MAX(i.quantity) AS inventory_per_model
    FROM
        products p
    JOIN
        sales s ON p.product_id = s.product_id
    JOIN
        inventory i ON i.product_id = p.product_id
    GROUP BY
        p.model
)

SELECT
    model,
    price,
    total_sale_per_model,
    inventory_per_model,
    CASE
        WHEN inventory_per_model = 0 THEN NULL
        ELSE total_sale_per_model / inventory_per_model
    END AS sales_inventory_ratio
FROM
    SaleInventory
ORDER BY
    sales_inventory_ratio DESC;