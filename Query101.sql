
1.	List the top 2 customers (by name) who have placed the most orders for products supplied by suppliers located outside the country, but only for orders where none of the items were returned. Display their total spent amount.
SELECT TOP 2 c.name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN Suppliers s ON p.supplier_id = s.supplier_id
WHERE s.country != 'USA'
  AND NOT EXISTS (
      SELECT 1 FROM Returns r WHERE r.order_id = o.order_id
  )
GROUP BY c.name
ORDER BY COUNT(DISTINCT o.order_id) DESC;

2.	Find the names of customers who have returned more than 50% of the items they ever ordered, and whose average order value is above the average order value of all customers.
WITH CustomerStats AS (
    SELECT c.customer_id, c.name,
           SUM(od.quantity) AS total_ordered,
           COUNT(r.return_id) AS total_returned,
           AVG(o.total_amount) AS avg_order_value
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Order_Details od ON o.order_id = od.order_id
    LEFT JOIN Returns r ON r.order_id = o.order_id AND r.product_id = od.product_id
    GROUP BY c.customer_id, c.name
),
AvgValue AS (
    SELECT AVG(total_amount) AS avg_all_value FROM Orders
)
SELECT cs.name
FROM CustomerStats cs, AvgValue av
WHERE cs.total_returned > 0.5 * cs.total_ordered
  AND cs.avg_order_value > av.avg_all_value;

3.	Display the names of products that are currently out of stock, were ordered at least 5 times in the last 6 months, and have never been returned by any customer.
SELECT p.product_name
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
WHERE p.stock_qty = 0
  AND o.order_date >= DATEADD(MONTH, -6, GETDATE())
  AND p.product_id NOT IN (SELECT product_id FROM Returns)
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT o.order_id) >= 5;

4.	List the suppliers whose supplied products generated over $5000 in total revenue last year but whose average selling price is below the overall average product price. Include total revenue and average selling price per supplier.
WITH RevenuePerSupplier AS (
    SELECT s.supplier_id, s.name,
           SUM(od.unit_price * od.quantity) AS total_revenue,
           AVG(od.unit_price) AS avg_price
    FROM Suppliers s
    JOIN Products p ON s.supplier_id = p.supplier_id
    JOIN Order_Details od ON p.product_id = od.product_id
    JOIN Orders o ON o.order_id = od.order_id
    WHERE YEAR(o.order_date) = YEAR(GETDATE()) - 1
    GROUP BY s.supplier_id, s.name
),
OverallAvg AS (
    SELECT AVG(price) AS avg_product_price FROM Products
)
SELECT rps.name, rps.total_revenue, rps.avg_price
FROM RevenuePerSupplier rps, OverallAvg oa
WHERE rps.total_revenue > 5000
  AND rps.avg_price < oa.avg_product_price;

5.	Show the list of customers who ordered at least 3 different products from 3 different categories in a single order and have not returned any of them in the past year. Display the order ID and total amount.
SELECT DISTINCT c.name, o.order_id, o.total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE o.order_id NOT IN (SELECT order_id FROM Returns WHERE return_date >= DATEADD(YEAR, -1, GETDATE()))
GROUP BY c.name, o.order_id, o.total_amount
HAVING COUNT(DISTINCT p.product_id) >= 3
   AND COUNT(DISTINCT p.category) >= 3;


WITH MonthlyOrders AS (
    SELECT customer_id, FORMAT(order_date, 'yyyy-MM') AS ym
    FROM Orders
    WHERE order_date >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY customer_id, FORMAT(order_date, 'yyyy-MM')
    HAVING COUNT(order_id) > 2
),
ValidCustomers AS (
    SELECT customer_id
    FROM MonthlyOrders
    GROUP BY customer_id
    HAVING COUNT(ym) = 6
),
UniqueProducts AS (
    SELECT o.customer_id
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    GROUP BY o.customer_id, od.product_id
    HAVING COUNT(*) = 1
),
CustomerAvgPrice AS (
    SELECT o.customer_id, AVG(od.unit_price) AS avg_item_price
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    GROUP BY o.customer_id
),
GlobalAvg AS (
    SELECT AVG(unit_price) AS global_avg FROM Order_Details
)
SELECT c.name
FROM Customers c
JOIN ValidCustomers vc ON c.customer_id = vc.customer_id
JOIN CustomerAvgPrice cap ON c.customer_id = cap.customer_id
JOIN GlobalAvg g ON 1=1
WHERE cap.avg_item_price > g.global_avg;

7.	Find the names of products that were ordered by customers from more than 3 cities, never returned, and were supplied by more than one supplier over time. Include the total quantity sold.
SELECT p.product_name, SUM(od.quantity) AS total_qty
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE p.product_id NOT IN (SELECT product_id FROM Returns)
  AND p.product_id IN (
      SELECT product_id FROM Products GROUP BY product_id HAVING COUNT(DISTINCT supplier_id) > 1
  )
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT c.city) > 3;

8.	Show the top 3 products (by total revenue generated) that have never been ordered by Platinum-tier members but were returned at least once by a Gold-tier member.
WITH Revenue AS (
    SELECT p.product_id, p.product_name, SUM(od.unit_price * od.quantity) AS total_revenue
    FROM Order_Details od
    JOIN Products p ON od.product_id = p.product_id
    JOIN Orders o ON od.order_id = o.order_id
    WHERE p.product_id NOT IN (
        SELECT product_id FROM Orders o2
        JOIN Customers c ON o2.customer_id = c.customer_id
        JOIN Order_Details od2 ON o2.order_id = od2.order_id
        WHERE c.membership_tier = 'Platinum'
    )
    AND p.product_id IN (
        SELECT r.product_id FROM Returns r
        JOIN Orders o3 ON r.order_id = o3.order_id
        JOIN Customers c ON o3.customer_id = c.customer_id
        WHERE c.membership_tier = 'Gold'
    )
    GROUP BY p.product_id, p.product_name
)
SELECT TOP 3 * FROM Revenue ORDER BY total_revenue DESC;
9.	Identify customers who have ordered all products from the "Smartphones" category at least once but never placed any order containing a "Tablet" product.
WITH SmartphoneProducts AS (
    SELECT product_id FROM Products WHERE category = 'Smartphones'
),
TabletOrders AS (
    SELECT DISTINCT o.customer_id
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
    WHERE p.category = 'Tablet'
),
CustomerSmartphones AS (
    SELECT o.customer_id, sp.product_id
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN SmartphoneProducts sp ON od.product_id = sp.product_id
),
SmartphoneCount AS (
    SELECT customer_id
    FROM CustomerSmartphones
    GROUP BY customer_id
    HAVING COUNT(DISTINCT product_id) = (SELECT COUNT(*) FROM SmartphoneProducts)
)
SELECT c.name
FROM Customers c
JOIN SmartphoneCount sc ON c.customer_id = sc.customer_id
WHERE c.customer_id NOT IN (SELECT customer_id FROM TabletOrders);

10.	List the suppliers whose products are most frequently returned but still contribute to at least 10% of the total sales revenue. Include return count and total revenue per supplier.
WITH SupplierStats AS (
    SELECT s.supplier_id, s.name,
           COUNT(r.return_id) AS return_count,
           SUM(od.unit_price * od.quantity) AS total_revenue
    FROM Suppliers s
    JOIN Products p ON s.supplier_id = p.supplier_id
    JOIN Order_Details od ON p.product_id = od.product_id
    LEFT JOIN Returns r ON r.product_id = p.product_id
    GROUP BY s.supplier_id, s.name
),
TotalRevenue AS (
    SELECT SUM(od.unit_price * od.quantity) AS total_sales FROM Order_Details od
)
SELECT ss.name, ss.return_count, ss.total_revenue
FROM SupplierStats ss, TotalRevenue tr
WHERE ss.total_revenue >= 0.1 * tr.total_sales
ORDER BY ss.return_count DESC;

11.	Display the product(s) with the highest return rate (returns/total sold quantity), but only consider those sold in the last year and exclude products ordered in less than 3 unique orders.
WITH SalesData AS (
    SELECT p.product_id, p.product_name,
           SUM(od.quantity) AS total_sold,
           COUNT(DISTINCT od.order_id) AS order_count
    FROM Products p
    JOIN Order_Details od ON p.product_id = od.product_id
    JOIN Orders o ON o.order_id = od.order_id
    WHERE YEAR(o.order_date) = YEAR(GETDATE()) - 1
    GROUP BY p.product_id, p.product_name
),
ReturnData AS (
    SELECT product_id, COUNT(*) AS return_count
    FROM Returns
    GROUP BY product_id
),
ReturnRates AS (
    SELECT sd.product_id, sd.product_name,
           sd.total_sold, rd.return_count,
           CAST(rd.return_count AS FLOAT) / NULLIF(sd.total_sold, 0) AS return_rate
    FROM SalesData sd
    LEFT JOIN ReturnData rd ON sd.product_id = rd.product_id
    WHERE sd.order_count >= 3
)
SELECT product_name, return_rate
FROM ReturnRates
WHERE return_rate IS NOT NULL
ORDER BY return_rate DESC
FETCH FIRST 1 ROWS ONLY;
12.	Find all customers who placed their most expensive order (by total value) in the same month they registered, and that order included at least one item that is now out of stock.
WITH MaxOrderPerCustomer AS (
    SELECT o.customer_id, MAX(o.total_amount) AS max_amount
    FROM Orders o
    GROUP BY o.customer_id
),
MaxOrders AS (
    SELECT o.order_id, o.customer_id, o.total_amount, o.order_date
    FROM Orders o
    JOIN MaxOrderPerCustomer m ON o.customer_id = m.customer_id AND o.total_amount = m.max_amount
),
OutOfStockItems AS (
    SELECT DISTINCT od.order_id
    FROM Order_Details od
    JOIN Products p ON od.product_id = p.product_id
    WHERE p.stock_qty = 0
)
SELECT DISTINCT c.name
FROM Customers c
JOIN MaxOrders mo ON c.customer_id = mo.customer_id
JOIN OutOfStockItems osi ON mo.order_id = osi.order_id
WHERE MONTH(mo.order_date) = MONTH(c.registration_date

13. For each category, list the product that generated the most revenue, but exclude products that were returned more than 2 times. Sort the result by revenue in descending order.

sql
Copy code
WITH ProductRevenue AS (
    SELECT 
        p.product_id, 
        p.product_name, 
        p.category, 
        SUM(od.quantity * od.unit_price) AS total_revenue
    FROM Products p
    JOIN Order_Details od ON p.product_id = od.product_id
    GROUP BY p.product_id, p.product_name, p.category
),
ReturnCounts AS (
    SELECT product_id, COUNT(*) AS return_count
    FROM Returns
    GROUP BY product_id
),
FilteredProducts AS (
    SELECT pr.*
    FROM ProductRevenue pr
    LEFT JOIN ReturnCounts rc ON pr.product_id = rc.product_id
    WHERE ISNULL(rc.return_count, 0) <= 2
),
RankedProducts AS (
    SELECT *,
           RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS revenue_rank
    FROM FilteredProducts
)
SELECT category, product_name, total_revenue
FROM RankedProducts
WHERE revenue_rank = 1
ORDER BY total_revenue DESC;
14. List orders where the total value was above the average monthly revenue for the store and contained at least two items from different suppliers with a combined stock of less than 10.

sql
Copy code
WITH MonthlyRevenue AS (
    SELECT 
        YEAR(order_date) AS yr, 
        MONTH(order_date) AS mon, 
        SUM(total_amount) AS monthly_total
    FROM Orders
    GROUP BY YEAR(order_date), MONTH(order_date)
),
AvgMonthlyRevenue AS (
    SELECT AVG(monthly_total) AS avg_revenue
    FROM MonthlyRevenue
),
OrderSupplierStock AS (
    SELECT 
        o.order_id,
        COUNT(DISTINCT p.supplier_id) AS supplier_count,
        SUM(p.stock_qty) AS total_stock
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
    GROUP BY o.order_id
)
SELECT o.order_id, o.total_amount
FROM Orders o
JOIN OrderSupplierStock oss ON o.order_id = oss.order_id
JOIN AvgMonthlyRevenue avgm ON 1 = 1
WHERE o.total_amount > avgm.avg_revenue
  AND oss.supplier_count >= 2
  AND oss.total_stock < 10;
15. Identify customers who have increasing order values in each of the last 3 orders they placed and never ordered the same product in those 3 orders. Show order IDs and total value.

sql
Copy code
WITH OrderedList AS (
    SELECT 
        o.customer_id, 
        o.order_id, 
        o.total_amount,
        o.order_date,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
    FROM Orders o
),
Last3Orders AS (
    SELECT *
    FROM OrderedList
    WHERE rn <= 3
),
OrderCheck AS (
    SELECT customer_id,
           MIN(total_amount) AS min_amt,
           MAX(total_amount) AS max_amt,
           COUNT(DISTINCT total_amount) AS distinct_values
    FROM Last3Orders
    GROUP BY customer_id
    HAVING COUNT(*) = 3 AND MIN(total_amount) < MAX(total_amount) AND COUNT(DISTINCT total_amount) = 3
),
NoRepeatProducts AS (
    SELECT lo.customer_id
    FROM Last3Orders lo
    JOIN Order_Details od ON lo.order_id = od.order_id
    GROUP BY lo.customer_id, od.product_id
    HAVING COUNT(*) = 1
    GROUP BY lo.customer_id
    HAVING COUNT(*) = 3 -- 3 unique products from 3 unique orders
)
SELECT lo.customer_id, lo.order_id, lo.total_amount
FROM Last3Orders lo
JOIN OrderCheck oc ON lo.customer_id = oc.customer_id
JOIN NoRepeatProducts nrp ON lo.customer_id = nrp.customer_id
ORDER BY lo.customer_id, lo.order_date;

