1. 
SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

2. 
SELECT COUNT(*) AS ProductsInSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

3. 
SELECT ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID;

4. 
SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

5. 
SELECT SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory;

6. 
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

7. 
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100;

8. 
SELECT AVG(Quantity) AS AverageQuantity
FROM Production.ProductInventory
WHERE LocationID = 10;

9. 
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf;

10. 
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf;

11. 
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;

12. 
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c
JOIN Person.StateProvince s
  ON c.CountryRegionCode = s.CountryRegionCode;

13. 
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c
JOIN Person.StateProvince s
  ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada');

14. 
SELECT DISTINCT p.ProductName
FROM Products AS p
JOIN [Order Details] AS od ON p.ProductID = od.ProductID
JOIN Orders AS o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE());

15. 
SELECT TOP 5 o.ShipPostalCode, COUNT(od.OrderID) AS OrdersCount
FROM Orders AS o
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY o.ShipPostalCode
ORDER BY OrdersCount DESC;

16. 
SELECT TOP 5 o.ShipPostalCode, COUNT(od.OrderID) AS OrdersCount
FROM Orders AS o
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY o.ShipPostalCode
ORDER BY OrdersCount DESC;

17. 
SELECT c.City, COUNT(c.CustomerID) AS NumberOfCustomers
FROM Customers AS c
GROUP BY c.City;

18. 
SELECT c.City, COUNT(c.CustomerID) AS NumberOfCustomers
FROM Customers AS c
GROUP BY c.City
HAVING COUNT(c.CustomerID) > 2;

19. 
SELECT c.ContactName, o.OrderDate
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

20. 
SELECT c.ContactName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

21. 
SELECT c.ContactName, COUNT(od.ProductID) AS ProductsBought
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY c.ContactName;

22. 
SELECT c.CustomerID, COUNT(od.ProductID) AS ProductsBought
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.ProductID) > 100;

23. 
SELECT s.CompanyName AS SupplierCompanyName, sh.CompanyName AS ShippingCompanyName
FROM Suppliers AS s
JOIN Products AS p ON s.SupplierID = p.SupplierID
JOIN [Order Details] AS od ON p.ProductID = od.ProductID
JOIN Orders AS o ON od.OrderID = o.OrderID
JOIN Shippers AS sh ON o.ShipVia = sh.ShipperID
GROUP BY s.CompanyName, sh.CompanyName;

24. 
SELECT o.OrderDate, p.ProductName
FROM Orders AS o
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
JOIN Products AS p ON od.ProductID = p.ProductID;

25. 
SELECT e1.EmployeeID AS EmployeeID1, e2.EmployeeID AS EmployeeID2, e1.Title
FROM Employees AS e1
JOIN Employees AS e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID;

26. 
SELECT e.ManagerID, COUNT(e.EmployeeID) AS NumberOfEmployees
FROM Employees AS e
WHERE e.ManagerID IS NOT NULL
GROUP BY e.ManagerID
HAVING COUNT(e.EmployeeID) > 2;

27. 
SELECT c.City, c.CompanyName AS Name, c.ContactName, 'Customer' AS Type
FROM Customers AS c
UNION ALL
SELECT s.City, s.CompanyName AS Name, s.ContactName, 'Supplier' AS Type
FROM Suppliers AS s;
