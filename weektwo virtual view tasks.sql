CREATE VIEW OrderDetails AS
SELECT OrderID, TotalCost
FROM Orders
WHERE TotalCost > 250;


SELECT c.CustomerID,c.FullName,o.OrderID,o.TotalCost,m.MenuName,mi.CourseName,mi.StarterName
FROM Customers AS c INNER JOIN  Orders AS o ON c.CustomerID=o.CustomerID
INNER JOIN Menu AS m ON o.MenuID = m.MenuID
INNER JOIN MenuItems as mi ON m.MenuItemsID = mi.MenuItemsID
ORDER BY o.TotalCost ASC;

SELECT MenuName FROM Menu
WHERE MenuID = ANY (
    SELECT MenuID
    FROM Orders
    WHERE TotalCost > 250
);


