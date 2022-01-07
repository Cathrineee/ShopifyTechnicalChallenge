--- Question 1 How many orders are shipped by Speedy Express?

SELECT COUNT(OrderID) as SpeedyExpressOrders
FROM Orders INNER JOIN
(SELECT ShipperID FROM Shippers WHERE ShipperName = "Speedy Express") as Ship
ON Orders.ShipperID = Ship.ShipperID

--- Question 2 What is the last name of the employee with the most orders?

SELECT LastName FROM Employees INNER JOIN
(SELECT TOP 1 EmployeeID FROM Orders
GROUP BY EmployeeID
ORDER BY COUNT(OrderID) DESC
) AS MostOrders
ON Employees.EmployeeID = MostOrders.EmployeeID

--- Question 3 What product was ordered the most by customers in Germany?

SELECT ProductName FROM Products INNER JOIN
(SELECT TOP 1 ProductID FROM OrderDetails INNER JOIN
  (SELECT OrderID FROM Orders INNER JOIN
    (SELECT CustomerID FROM Customers WHERE Country = "Germany"
    ) AS c
   ON Orders.CustomerID = c.CustomerID
  ) AS o
ON OrderDetails.OrderID = o.OrderID
GROUP BY ProductID
ORDER BY COUNT(ProductID) DESC
) AS MostOrders
ON Products.ProductID = MostOrders.ProductID

