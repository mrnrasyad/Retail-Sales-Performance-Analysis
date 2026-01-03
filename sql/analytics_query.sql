-- Revenue, Orders, Units by Month
SELECT 
    YEAR(o.order_date)  AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(od.total_price) AS gmv,
    COUNT(DISTINCT o.order_id) AS order_volume,
    SUM(od.quantity) AS units_sold,
    SUM(od.total_price) * 1.0 / COUNT(DISTINCT o.order_id) AS aov
FROM Order_Detail od
JOIN [Order] o ON od.OrderKey = o.OrderKey
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;

-- Average Order Size (Units per Order) by Month
SELECT
    YEAR(o.order_date)  AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(od.quantity) * 1.0
        / COUNT(DISTINCT o.order_id) AS avg_order_size
FROM Order_Detail od
JOIN [Order] o ON od.OrderKey = o.OrderKey
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;

-- Monthly Active Customers (MAC)
SELECT
    YEAR(o.order_date)  AS order_year,
    MONTH(o.order_date) AS order_month,
    COUNT(DISTINCT o.CustomerKey) AS active_customers
FROM [Order] o
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;

-- Brand-Level Performance
SELECT TOP 5
    p.brand,
    SUM(od.quantity) AS units_sold,
    SUM(od.total_price) AS gmv,
    SUM(od.total_price) * 1.0 / SUM(od.quantity) AS avg_selling_price
FROM Order_Detail od
JOIN Product p ON od.product_id = p.product_id
GROUP BY p.brand
ORDER BY gmv DESC;

-- Brand Contribution Percentage
SELECT TOP 10
    p.brand,
    SUM(od.total_price) AS gmv,
    SUM(od.total_price) * 1.0
        / SUM(SUM(od.total_price)) OVER () AS gmv_contribution_pct
FROM Order_Detail od
JOIN Product p ON od.product_id = p.product_id
GROUP BY p.brand
ORDER BY gmv DESC;

-- Province-Level Performance
SELECT TOP 10
    c.province,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS units_sold,
    SUM(od.total_price) AS gmv,
    SUM(od.total_price) * 1.0 / COUNT(DISTINCT o.order_id) AS aov
FROM Order_Detail od
JOIN [Order] o ON od.OrderKey = o.OrderKey
JOIN Customer c ON o.CustomerKey = c.CustomerKey
WHERE
    c.province IS NOT NULL
    AND c.province <> 'Unknown'
GROUP BY c.province
ORDER BY gmv DESC;

