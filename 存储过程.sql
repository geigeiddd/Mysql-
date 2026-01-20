CREATE PROCEDURE proc_add_purchase (
    IN p_product_id VARCHAR(20),
    IN p_supplier VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_quantity INT,
    IN p_purchase_time DATETIME,
    IN p_storage_time DATETIME
)
BEGIN
    DECLARE v_total_price DECIMAL(10,2);
    SET v_total_price = p_price * p_quantity;
    INSERT INTO purchase (
product_id, supplier, price,quantity,total_price,purchase_time,storage_time) 		 	 	
    VALUES (
p_product_id,p_supplier,p_price,p_quantity,v_total_price,p_purchase_time,p_storage_time );
END$$
DELIMITER ;

CREATE PROCEDURE proc_add_sales (
    IN p_order_id VARCHAR(30),
    IN p_product_id VARCHAR(20),
    IN p_price DECIMAL(10,2),
    IN p_quantity INT,
    IN p_sales_time DATETIME,
    IN p_sales_emp VARCHAR(20)
)
BEGIN
    DECLARE v_total_price DECIMAL(10,2);
    SET v_total_price = p_price * p_quantity;
    INSERT INTO sales (
order_id, product_id,price,quantity, total_price,sales_time,sales_emp ) 
    VALUES (
p_order_id, p_product_id, p_price, p_quantity, v_total_price,p_sales_time,
p_sales_emp );
END$$
DELIMITER ; 