DROP PROCEDURE IF EXISTS GetMaxQuantity
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(TotalCost) FROM Orders;
END;//
CALL GetMaxQuantity

PREPARE GetOrderDetail FROM
'SELECT OrderID,TotalCost FROM Orders WHERE CustomerID=?' ;
SET @id=1;
EXECUTE GetOrderDetail USING @id;

DROP PROCEDURE IF EXISTS CancelOrder
DELIMITER //
CREATE PROCEDURE CancelOrder(order_id INT)
BEGIN
DELETE FROM orders WHERE OrderID = order_id;
SELECT CONCAT('Order', 'order_id','is cancelled') AS Confirmation;
END;//
CALL CancelOrder
