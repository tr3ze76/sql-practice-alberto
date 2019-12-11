CREATE TABlE Examples.Parent(
ParentId int NOT NULL CONSTRAINT PKParent PRIMARY KEY
);


CREATE TABLE Examples.child(
ChildId int NOT NULL CONSTRAINT PKChild PRIMARY KEY,
ParentId int NULL
); 


ALTER TABLE Examples.child
ADD CONSTRAINT FKchild_Ref_ExamplesParent
FOREIGN KEY (ParentId) REFERENCES Examples.Parent (ParentId);

INSERT INTO Examples.Parent VALUES (10);

INSERT INTO Examples.child VALUES (1, 10);


SELECT * FROM Examples.Parent;
SELECT *FROM Examples.child;

CREATE TABLE Examples.TwoPartKey(
KeyColumn1 int NOT NULL,
KeyColumn2 int NOT NULL,
CONSTRAINT PKTwoPartKey PRIMARY KEY (KeyColumn1, KeyColumn2)
);

INSERT INTO Examples.TwoPartKey VALUES (10, 10);
DROP TABLE IF EXISTS Examples.TwoPartKeyReference;

CREATE TABLE Examples.TwoPartKeyReference(
KeyColumn1 int NOT NULL,
KeyColumn2 int NOT NULL,
CONSTRAINT FKTwoPartKeyReference_Ref_ExamplesTwoPartKey
FOREIGN KEY (KeyColumn1, KeyColumn2)
REFERENCES Examples.TwoPartKey (KeyColumn1, KeyColumn2)
);

INSERT INTO Examples.TwoPartKeyReference VALUES (10, 10); 
INSERT INTO Examples.TwoPartKeyReference VALUES (null, null);

SELECT * FROM Examples.TwoPartKeyReference;
SELECT * FROM Examples.TwoPartKey;


CREATE TABLE Examples.Invoice(
InvoiceId int NOT NULL CONSTRAINT PKInvoiCe PRIMARY KEY
);

CREATE TABLE Examples.InvoiceLineItem(
InvoiceLineItemId int NOT NULL CONSTRAINT PKInvoiceLineItem PRIMARY KEY,
InvoiceLineNumber smallint NOT NULL,
InvoiceId int NOT NULL CONSTRAINT FKInvoicesLineItem_RefEsamplesInvoice REFERENCES Examples.Invoice (invoiceId)
ON DELETE CASCADE
ON UPDATE NO ACTION,
CONSTRAINT AKInvoiceLineItem UNIQUE (InvoiceId, InvoiceLineNumber)
);

INSERT INTO Examples.Invoice(InvoiceId)
VALUES (1),(2),(3);
INSERT INTO Examples.InvoiceLineItem (InvoiceLineItemId,InvoiceId,InvoiceLineNumber)
VALUES (1,1,1),(2,1,2), (3,2,1);

SELECT Invoice.InvoiceId, InvoiceLineItem.InvoiceLineItemId
FROM Examples.Invoice
FULL OUTER JOIN Examples.InvoiceLineItem
ON Invoice.InvoiceId = InvoiceLineItem.InvoiceId;

DELETE Examples.Invoice
WHERE InvoiceId =1;


CREATE TABLE Examples.code
(
code varcHAR (10) NOT NULL CONSTRAINT PKCode PRIMARY KEY
);

CREATE TABLE Examples.CodeItem(
Code varchar (10) NOT NULL
CONSTRAINT FKCodeitem_Ref_ExamplesCode
REFERENCES Examples.Code (code)
ON UPDATE CASCADE
);

INSERT INTO Examples.code (code)
VALUES ('Blacke');
INSERT INTO Examples.CodeItem (Code)
VALUES ('Blacke');

SELECT Code.Code, CodeItem.Code AS CodedItemCode
FROM Examples.code
FULL OUTER JOIN Examples.CodeItem
ON Code.code = CodeItem.Code;

UPDATE Examples.code
SET Code = 'Black';

DROP TABLE Examples.Attendee;

CREATE TABLE Examples.Attendee(
shirtSize varchar (10) NULL
);

ALTER TABLE Examples.Attendee
ADD CONSTRAINT CHKAttendee_shirtSizeDomain
CHECK (shirtSize  IN ('S', 'M', 'L', 'XL', 'XXL'));

INSERT INTO Examples.Attendee (shirtSize)
VALUES ('XS');

CREATE TABLE Examples.ShirtSize(
ShirtSize varchar (10) NOT NULL  CONSTRAINT PKShirtSize PRIMARY KEY
);

INSERT INTO Examples.ShirtSize(ShirtSize)
VALUES ('S'), ('M'), ('L'), ('XL'), ('XXL');

SELECT * FROM Examples.ShirtSize;

ALTER TABLE Examples.Attendee
DROP CONSTRAINT CHKAttendee_shirtSizedomain;

ALTER TABLE Examples.Attendee
ADD CONSTRAINT Attendee_Ref_ExamplesshirtSize
FOREIGN KEY (shirtSize) REFERENCES Examples.shirtSize(shirtSize);

INSERT INTO Examples.Attendee
VALUES ('S');

INSERT INTO Examples.Attendee
VALUES ('XS')