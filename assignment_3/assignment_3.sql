1. 
SELECT DISTINCT c.City
FROM Customers AS c
JOIN Employees AS e ON c.City = e.City;

2a. 
SELECT DISTINCT c.City
FROM Customers AS c
WHERE c.City NOT IN (SELECT DISTINCT City FROM Employees);

2b. 
SELECT DISTINCT c.City
FROM Customers AS c
LEFT JOIN Employees AS e ON c.City = e.City
WHERE e.City IS NULL;

3. 
SELECT p.ProductName, SUM(od.Quantity) AS TotalOrderQuantity
FROM Products AS p
JOIN [Order Details] AS od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

4. 
SELECT c.City, SUM(od.Quantity) AS TotalProductsOrdered
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY c.City;

5a. 
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2;

5b. 
SELECT DISTINCT c.City
FROM Customers AS c
WHERE (SELECT COUNT(*) FROM Customers AS c2 WHERE c2.City = c.City) >= 2;

6. 
SELECT c.City
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

7. 
SELECT DISTINCT c.CustomerID, c.CompanyName, c.City AS CustomerCity, o.ShipCity
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity;

8. 
SELECT TOP 5 p.ProductName, AVG(od.UnitPrice) AS AveragePrice, c.City AS CustomerCity, SUM(od.Quantity) AS TotalQuantity
FROM Products AS p
JOIN [Order Details] AS od ON p.ProductID = od.ProductID
JOIN Orders AS o ON od.OrderID = o.OrderID
JOIN Customers AS c ON o.CustomerID = c.CustomerID
GROUP BY p.ProductName, c.City
ORDER BY TotalQuantity DESC;

9a. 
SELECT DISTINCT e.City
FROM Employees AS e
WHERE e.City NOT IN (
    SELECT DISTINCT o.ShipCity
    FROM Orders AS o
);

9b. 
SELECT DISTINCT e.City
FROM Employees AS e
LEFT JOIN Orders AS o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL;

10. 
WITH EmployeeCityOrders AS (
    SELECT e.City, COUNT(o.OrderID) AS OrdersCount
    FROM Employees AS e
    JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
),
CustomerCityOrders AS (
    SELECT c.City, SUM(od.Quantity) AS TotalQuantity
    FROM Customers AS c
    JOIN Orders AS o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] AS od ON o.OrderID = od.OrderID
    GROUP BY c.City
)
SELECT e.City
FROM (
    SELECT TOP 1 City, OrdersCount
    FROM EmployeeCityOrders
    ORDER BY OrdersCount DESC
) AS e
JOIN (
    SELECT TOP 1 City, TotalQuantity
    FROM CustomerCityOrders
    ORDER BY TotalQuantity DESC
) AS c ON e.City = c.City;

11. 

DELETE FROM TableName
WHERE ID NOT IN (
    SELECT MIN(ID)
    FROM TableName
    GROUP BY DuplicateColumn1, DuplicateColumn2, etc
);
