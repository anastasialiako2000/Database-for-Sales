Requirements:
The sales manager requires data on the number of cars sold for each brand to achieve this.
As our database grows, the time to execute the query that outputs this information to the
sales manager increases. The sales manager also finds it frustrating to connect the
tables required to get this information over the ERD. Since it is a query the sales manager
runs very often, the manager would like this process to be simplified.

CREATE INDEX customer_sales_product ON sales (customer_id,product_id);


create view sales_summary as
    select p.model, sum(s.quantity) as total_sold
    from sales s
    join products p on p.product_id = s.product_id
    group by p.model
    ORDER BY SUM(s.quantity) DESC;

select * from sales_summary;