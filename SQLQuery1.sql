SELECT * FROM Sales.Orders

SELECT *
FROM Sales.Customertransactions
WHERE PaymentMethodID = 4

SELECT CustomerID, OrderID, OrderDate, ExpectedDeliveryDate
FROM Sales.Orders
WHERE CustomerPurchaseOrderNumber = '16374'

SELECT SalespersonPersonID, OrderDate
FROM Sales.Orders
ORDER BY SalespersonPersonID ASC, OrderDate ASC;

CREATE INDEX SalespersonPersonID_OrderDate1 ON Sales.Orders 
(SalespersonPersonID ASC, OrderDate DESC);

SELECT Orders.ContactPersonID, people.PreferredName
FROM sales.Orders
JOIN Application.People
ON People.PersonID = Orders.ContactPersonID
WHERE People.PreferredName = 'Aakriti';

CREATE NONCLUSTERED INDEX ContactPersonID_Include_OderDate_ExpectedDeliveryDate1
ON Sales.Orders (ContactPersonID)
INCLUDE (OrderDate,ExpectedDeliveryDate)
ON USERDATA;
GO


