-- Customer Table
CREATE TABLE [Customer] (
    [CustomerKey] INT IDENTITY(1,1)  NOT NULL ,
    [customer_id] INT  NOT NULL ,
    [city] VARCHAR(100)  NOT NULL ,
    [province] VARCHAR(100)  NOT NULL ,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED (
        [CustomerKey] ASC
    )
)
-- Insert Data for Customer Table
INSERT INTO Customer (customer_id, city, province)
SELECT DISTINCT
    customer_id,
    city,
    province
FROM retail_table_cleaned;

-- Product Table
CREATE TABLE [Product] (
    [product_id] VARCHAR(20)  NOT NULL ,
    [brand] VARCHAR(100)  NOT NULL ,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED (
        [product_id] ASC
    )
)
-- Insert Data for Product Table
INSERT INTO Product (product_id, brand)
SELECT DISTINCT
    product_id,
    brand
FROM retail_table_cleaned;

-- Order Table
CREATE TABLE [Order] (
    [OrderKey] INT IDENTITY(1,1)  NOT NULL ,
    [order_id] INT  NOT NULL ,
    [order_date] DATE  NOT NULL ,
    [CustomerKey] INT  NOT NULL ,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED (
        [OrderKey] ASC
    )
)
-- Insert Data for Order Table
INSERT INTO [Order] (order_id, order_date, CustomerKey)
SELECT DISTINCT
    r.order_id,
    r.order_date,
    c.CustomerKey
FROM retail_table_cleaned r
JOIN Customer c
  ON r.customer_id = c.customer_id
 AND r.city        = c.city
 AND r.province    = c.province;

-- Order Detail Table
CREATE TABLE [Order_Detail] (
    [OrderDetailKey] INT IDENTITY(1,1)  NOT NULL ,
    [OrderKey] INT  NOT NULL,
    [product_id] VARCHAR(20)  NOT NULL,
    [quantity] DECIMAL(12,2)  NOT NULL,
    [item_price] DECIMAL(12,2)  NOT NULL,
    [total_price] DECIMAL(12,2)  NOT NULL,
    CONSTRAINT [PK_Order_Detail] PRIMARY KEY CLUSTERED (
        OrderDetailKey ASC
    )
)
-- Insert Data for Order Detail Table
INSERT INTO Order_Detail (
    OrderKey,
    product_id,
    quantity,
    item_price,
    total_price
)
SELECT
    o.OrderKey,
    r.product_id,
    r.quantity,
    r.item_price,
    r.total_price
FROM retail_table_cleaned r
JOIN [Order] o
  ON r.order_id   = o.order_id
 AND r.order_date = o.order_date;

-- Foreign Key using Alter Table
ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT [FK_Order_CustomerKey] FOREIGN KEY([CustomerKey])
REFERENCES [Customer] ([CustomerKey])
ALTER TABLE [Order] CHECK CONSTRAINT [FK_Order_CustomerKey]

ALTER TABLE [Order_Detail] WITH CHECK ADD CONSTRAINT [FK_Order_Detail_order_id] FOREIGN KEY([OrderKey])
REFERENCES [Order] ([OrderKey])
ALTER TABLE [Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_order_id]

ALTER TABLE [Order_Detail] WITH CHECK ADD CONSTRAINT [FK_Order_Detail_product_id] FOREIGN KEY([product_id])
REFERENCES [Product] ([product_id])
ALTER TABLE [Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_product_id]

-- Data Validation Check
--- counts
SELECT COUNT(*) FROM retail_table_cleaned;
SELECT COUNT(*) FROM Order_Detail;
--- FK integrity
SELECT *
FROM Order_Detail od
LEFT JOIN [Order] o ON od.OrderKey = o.OrderKey
WHERE o.OrderKey IS NULL;

-- Table Query for Dashboard Consumption
SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.city,
    c.province,
    p.product_id,
    p.brand,
    od.quantity,
    od.item_price,
    od.total_price
FROM Order_Detail od
JOIN [Order] o
  ON od.OrderKey = o.OrderKey
JOIN Customer c
  ON o.CustomerKey = c.CustomerKey
JOIN Product p
  ON od.product_id = p.product_id
ORDER BY o.order_date;
