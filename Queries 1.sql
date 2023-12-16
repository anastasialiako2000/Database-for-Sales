Requirements:
We currently have agreements with Toyota and General Motors (GM) car makes.
Our inventory comprises the Camry and Corolla models for Toyota and Silverado and Camaro for GM.
These car models are among the most highly demanded vehicles in our locality.
To maintain precise records of our car sales and inventory, we must constantly update
the inventory table whenever a deal is made. While it is possible to update the sales table first
and then the inventory table, this approach has the potential for errors, as there is a risk of
forgetting to update one of these tables. Consequently, if we stock our inventory,
our records may not balance properly.


CREATE TRIGGER update_inventory AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET quantity = quantity - NEW.quantity,
        last_inventory_date = NEW.sale_date
    WHERE product_id = NEW.product_id;
END;


INSERT INTO sales (sale_date, customer_id, product_id, employee_id, quantity, total_price)
VALUES
    (DATE('2023-05-01'), 1, 1, 1, 2, 56000.00),
    (DATE('2023-05-02'), 2, 2, 1, 1, 22000.00),
    (DATE('2023-05-02'), 1, 3, 2, 1, 41250.00),
    (DATE('2023-05-03'), 2, 4, 2, 2, 60000.00),
    (DATE('2023-05-03'), 1, 1, 2, 3, 84000.00);


SELECT * FROM inventory;