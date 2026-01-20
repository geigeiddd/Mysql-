CREATE TABLE admin (
    admin_id VARCHAR(20) PRIMARY KEY COMMENT '管理员工号',
    admin_password VARCHAR(100) NOT NULL COMMENT '管理员密码'
) ;

CREATE TABLE employee (
    emp_id VARCHAR(20) PRIMARY KEY COMMENT '员工工号',
    emp_name VARCHAR(50) NOT NULL COMMENT '员工姓名',
    birth_date DATE COMMENT '出生日期',
    gender ENUM("男","女") COMMENT '性别',
    phone VARCHAR(20) COMMENT '手机号码',
    id_card VARCHAR(20) COMMENT '身份证号',
    emp_password VARCHAR(100) NOT NULL COMMENT '员工密码',
    email VARCHAR(100) COMMENT '邮箱'
) ;

CREATE TABLE product (
    product_id VARCHAR(20) PRIMARY KEY COMMENT '商品编号',
    product_category VARCHAR(50) COMMENT '商品类别',
    product_name VARCHAR(100) NOT NULL COMMENT '商品名称',
    price DECIMAL(10,2) NOT NULL COMMENT '价格',
    quantity INT DEFAULT 0 COMMENT '数量',
    storage_time DATETIME COMMENT '入库时间'
) ;

CREATE TABLE supplier (
    supplier_name VARCHAR(100) PRIMARY KEY COMMENT '供应商名称',
    legal_person VARCHAR(50) COMMENT '供应商法人',
    phone VARCHAR(20) COMMENT '电话号码',
    address VARCHAR(255) COMMENT '公司地址'
) ;

CREATE TABLE inventory (
    product_id VARCHAR(20) PRIMARY KEY COMMENT '商品编号',
    total_quantity INT DEFAULT 0 COMMENT '商品总量',
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
) ;

CREATE TABLE employee_sales (
    emp_id VARCHAR(20) PRIMARY KEY COMMENT '员工工号',
    emp_name VARCHAR(50) COMMENT '员工姓名',
    sales_amount DECIMAL(10,2) DEFAULT 0 COMMENT '员工销售金额',
    CONSTRAINT fk_emp_sales_emp
        FOREIGN KEY (emp_id)
        REFERENCES employee(emp_id)
);

CREATE TABLE purchase (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '进货ID',
    product_id VARCHAR(20) COMMENT '商品编号',
    supplier VARCHAR(100) COMMENT '供应商',
    price DECIMAL(10,2) COMMENT '价格',
    quantity INT COMMENT '数量',
    total_price DECIMAL(10,2) COMMENT '总价',
    purchase_time DATETIME COMMENT '进货时间',
    storage_time DATETIME COMMENT '入库时间',
    CONSTRAINT fk_purchase_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id),
    CONSTRAINT fk_purchase_supplier
        FOREIGN KEY (supplier)
        REFERENCES supplier(supplier_name)
) ;

CREATE TABLE return_info (
    return_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '退货ID',
    product_id VARCHAR(20) COMMENT '商品编号',
    supplier VARCHAR(100) COMMENT '供应商',
    price DECIMAL(10,2) COMMENT '价格',
    quantity INT COMMENT '数量',
    total_price DECIMAL(10,2) COMMENT '总价',
    return_time DATETIME COMMENT '退货时间',
    return_reason VARCHAR(255) COMMENT '退货原因',
    storage_time DATETIME COMMENT '入库时间',
    CONSTRAINT fk_return_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id),
    CONSTRAINT fk_return_supplier
        FOREIGN KEY (supplier)
        REFERENCES supplier(supplier_name)
);

CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '购物车ID',
    emp_id VARCHAR(20) COMMENT '员工工号',
    product_id VARCHAR(20) COMMENT '商品编号',
    product_name VARCHAR(100) COMMENT '商品',
    CONSTRAINT fk_cart_emp
        FOREIGN KEY (emp_id)
        REFERENCES employee(emp_id),
    CONSTRAINT fk_cart_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
) ;

CREATE TABLE sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '销售ID',
    order_id VARCHAR(30) COMMENT '购物单号',
    product_id VARCHAR(20) COMMENT '商品编号',
    price DECIMAL(10,2) COMMENT '价格',
    quantity INT COMMENT '数量',
    total_price DECIMAL(10,2) COMMENT '总价',
    sales_time DATETIME COMMENT '销售时间',
    sales_emp VARCHAR(20) COMMENT '销售员工',
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id),
    CONSTRAINT fk_sales_emp
        FOREIGN KEY (sales_emp)
        REFERENCES employee(emp_id)
) ;

CREATE TABLE customer_return (
    return_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '退货ID',
    order_id VARCHAR(30) COMMENT '购物单号',
    product_id VARCHAR(20) COMMENT '商品编号',
    price DECIMAL(10,2) COMMENT '价格',
    quantity INT COMMENT '数量',
    total_price DECIMAL(10,2) COMMENT '总价',
    return_reason VARCHAR(255) COMMENT '退货原因',
    return_time DATETIME COMMENT '退货时间',
    CONSTRAINT fk_customer_return_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

