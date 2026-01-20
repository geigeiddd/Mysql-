CREATE VIEW view_inventory_summary AS
SELECT
    p.product_id AS 商品编号,
    p.product_name AS 商品名称,
    p.product_category AS 商品类别,
    i.total_quantity AS 当前库存
FROM product p
JOIN inventory i
    ON p.product_id = i.product_id;
    
    
CREATE VIEW view_product_sales AS
SELECT
    p.product_id AS 商品编号,
    p.product_name AS 商品名称,
    SUM(s.quantity) AS 销售数量,
    SUM(s.total_price) AS 销售总金额
FROM sales s
JOIN product p
    ON s.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name;

CREATE VIEW view_employee_sales AS
SELECT
    e.emp_id AS 员工工号,
    e.emp_name AS 员工姓名,
    SUM(s.total_price) AS 销售总金额
FROM sales s
JOIN employee e
    ON s.sales_emp = e.emp_id
GROUP BY
    e.emp_id,
    e.emp_name;
