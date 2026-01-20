
CREATE TRIGGER trg_after_purchase_insert
AFTER INSERT ON purchase
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET total_quantity = total_quantity + NEW.quantity
    WHERE product_id = NEW.product_id;
END$$
DELIMITER ;


CREATE TRIGGER trg_after_sales_insert
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET total_quantity = total_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$
DELIMITER ;


CREATE TRIGGER trg_after_customer_return_insert
AFTER INSERT ON customer_return
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET total_quantity = total_quantity + NEW.quantity
    WHERE product_id = NEW.product_id;
END$$
DELIMITER ;


CREATE TRIGGER trg_after_sales_employee
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    UPDATE employee_sales
    SET sales_amount = sales_amount + NEW.total_price
    WHERE emp_id = NEW.sales_emp;
END$$
DELIMITER ;