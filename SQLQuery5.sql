CREATE SCHEMA Examples;
GO 

CREATE TABLE Examples.UniquenessConstraint
(
PirmayuniqueValue int NOT NULL,
AlternateUniqueValue1 int NULL,
AlternateUniqueValue2 int NULL

);

ALTER TABLE Examples.UniquenessConstraint
ADD CONSTRAINT PKUniquenessConstraint PRIMARY KEY
(PrimaryUniqueValue);


CREATE TABLE Examples.Invoice
(
InvoiceId int NOT NULL CONSTRAINT PKInvoice PRIMARY KEY,
--Other columns Omitted 
);

CREATE TABLE Examples.DiscountType
(
DiscountTypeId int NOT NULL CONSTRAINT PKDiscountType PRIMARY KEY,
--Other columns Omited
)

CREATE TABLE Examples.InvoiceLineItem
(
InvoiceLineItemId int NOT NULL CONSTRAINT PKInvoiceLineItem primary key,
InvoiceId int NOT NULL
CONSTRAINT FKInvoiceLineItem$Ref$Invoice
REFERENCES Examples.Invoice (InvoiceId),
DiscountTypeId int NOT NULL
CONSTRAINT FKInvoiceLineItem$Ref$DiscountType
REFERENCES Examples.DiscountType (DiscountTypeId)
--Other Colums Omitted
);

CREATE INDEX InvoiceId ON Examples.InvoiceLineItem (InvoiceID);