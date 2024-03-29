CREATE TABLE Examples.GadgetType
(
GadgetType varchar (10) NOT NULL CONSTRAINT PKGadgetType1 PRIMARY KEY,
Description varchar (200) NOT NULL
)
GO

INSERT INTO Examples.GadgetType (GadgetType, Description)
VALUES ('Manual','No Bateries'),
('Electronic','Lots of bats');
GO

ALTER TABLE Examples.Gadget
ADD CONSTRAINT FKGadget$ref$Examples_GadgetType1
FOREIGN KEY (GadgetType) REFERENCES Examples.GadgetType (GadgetType);
GO

CREATE VIEW Examples.GadgetExtension
AS
SELECT Gadget.GadgetId, Gadget.GadgetNumber,Gadget.GadgetType, GadgetType.GadgetType AS DomainGadgetType, GadgetType.Description as GadgetTypeDescription
FROM Examples.Gadget
JOIN Examples.GadgetType
ON Gadget.GadgetType = GadgetType.GadgetType;
GO

SELECT * FROM Examples.GadgetExtension

INSERT INTO Examples.GadgetExtension (GadgetId, GadgetNumber, GadgetType, DomainGadgetType, GadgetTypeDescription)
VALUES ('7', '00000007', 'Acoustic', 'Acoustic', 'sound');
GO

INSERT INTO Examples.GadgetExtension (DomainGadgetType, GadgetTypeDescription)
VALUES ('Acuostic', 'Sound');
GO

SELECT * FROM Examples.Gadget
SELECT * FROM Examples.GadgetType

UPDATE Examples.GadgetExtension
SET GadgetTypeDescription = 'Uses Batteries'
WHERE GadgetId = 1;
GO

CREATE TABLE Examples.Invoices_Region1
( 
InvoiceId int NOT NULL
CONSTRAINT PKInvoives_Region1 PRIMARY KEY,
CONSTRAINT CHKInvoices_Region1_Partkey
CHECK (InvoiceId BETWEEN 1 and 10000),
CustomerId int NOT NULL,
InvoiceDate date NOT NULL
);
GO

CREATE TABLE Examples.Invoices_Region2
(
InvoiceId  int NOT NULL
CONSTRAINT PKInvoices_Region2 PRIMARY KEY
CONSTRAINT CHKInvoices_Region2_PartKey
CHECK (InvoiceId BETWEEN 10001 and 20000),
CustomerId int NOT NULL,
InvoiceDate date NOT NULL
);
GO

INSERT INTO	Examples.Invoices_Region1 
(InvoiceId, CustomerId, InvoiceDate)
SELECT InvoiceId, CustomerId, InvoiceDate
FROM WideWorldImporters_ALBERTO.Sales.Invoices
WHERE InvoiceId BETWEEN 1 and 10000;

INSERT INTO Examples.Invoices_Region2
(InvoiceId, CustomerId, InvoiceDate)
SELECT InvoiceId, CustomerId, InvoiceDate
FROM WideWorldImporters_ALBERTO.Sales.Invoices
WHERE InvoiceId BETWEEN 10001 and 20000;

CREATE VIEW Examples.InvoicesPartitioned
AS
SELECT InvoiceId, CustomerId, InvoiceDate
FROM Examples.Invoices_Region1
UNION ALL
SELECT InvoiceId, CustomerID, InvoiceDate
FROM Examples.Invoices_Region2;
GO

SELECT *
FROM Examples.InvoicesPartitioned
WHERE InvoiceId = 1;
GO

SELECT InvoiceId
FROM Examples.InvoicesPartitioned
WHERE InvoiceDate = '2013-01-01';
GO

CREATE VIEW Sales.InvoiceCustomerInvoiceAggregates
WITH SCHEMABINDING
AS
SELECT Invoices.CustomerId,
SUM(ExtendedPrice * Quantity) AS SumCost,
SUM (LineProfit) AS SumProfit,
COUNT_BIG(*) AS TotalItemCount
FROM Sales.Invoices
JOIN Sales.InvoiceLines
ON Invoices.InvoiceID = InvoiceLines.InvoiceId
GROUP BY Invoices.CustomerID;
GO

SELECT *
FROM Sales.InvoiceCustomerInvoiceAggregates;
GO

CREATE UNIQUE CLUSTERED INDEX XPKInvoiceCustomerInvoiceAggregates on Sales.InvoiceCustomerInvoiceAggregates(CustomerID);
GO

