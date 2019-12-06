CREATE VIEW Sales.Orders10YearsMultipleItems
AS
SELECT OrderId, CustomerId, SalespersonPersonId, OrderDate, ExpectedDeliveryDate
FROM Sales.Orders
WHERE OrderDate >= DATEADD(Year, -10, SYSDATETIME())
AND (SELECT COUNT (*)
FROM Sales.OrderLines
WHERE OrderLines.OrderID =Orders.OrderID) > 1

SELECT TOP 5 *
FROM Sales.Orders10yearsMultipleItems
ORDER BY ExpectedDeliVeryDate DESC

SELECT PersonId, IsPermittedToLogon, IsEmployee, IsSalesPerson
FROM Application.People

CREATE VIEW Application.PeopleEmployeeStatusS
AS
SELECT PersonId, FullName,
IsPermittedToLogon, IsEmployee, IsSalesPerson,
CASE WHEN IsPermittedToLogon = 1 THEN 'Can Logon'
ELSE 'Cant''t Logon' END AS LogonRights,
CASE WHEN IsEmployee =1 AND isSalesPerson =1
THEN 'Regular' 
WHEN IsEmployee =1
ELSE 'Not Employee' END AS EmployeeType
FROM Application.People


SELECT PersonId, LogonRights, EmployeeType
FROM Application.PeopleEmployeeStatusS

CREATE VIEW
Reports.InvoiceSummaryBasis
AS
Select Invoices.InvoiceId, CustomerCategories.CustomerCategoryName,
Cities.CityName, StateProvinces.StateProvinceName,
StateProvinces.SalesTerritory,
Invoices.InvoiceDate,
--the grain of the report is at the invoice, so total
--the amounts for invoice
SUM (InvoiceLines.LineProfit) as InvoiceProfit,
SUM (InvoiceLines.ExtendedPrice) as InvoiceExtendedPrice
FROM Sales.Invoices 
JOIN Sales.InvoicesLines
ON Invoices.InvoiceID = InvoiceLines.InvoiceID
JOIN Sales.Customers
ON Customers.CustomerID = Invoices.CustomerID
JOIN Sales.CustomerCategories
ON Customer.CustomerCategories = CustomerCategories.CustomerCategoryID
JOIN Application.Cities
ON CustomerDeliveryCityID =Cities.CityID
JOIN Application.StateProvinces
ON StateProvinces.StateProvinceID = Cities.StateProvinceID
GROUP BY Invoices.InvoiceId
CustomerCategories.CustomerCategoryName,
Cities.CityName, StateProvinces.StateProvinceName,
StateProvinces.SalesTerritory,
Invoices.InvoiceDate;


SELECT TOP 5 SalesTerritory, SUM(InvoiceProfit) AS InvoiceProfitTotal
FROM Reports.InvoiceSummaryBasis
WHERE InvoiceDate > '2016-05-01'
GROUP BY SalesTerritory
ORDER BY InvoiceProfitTotal DESC;
