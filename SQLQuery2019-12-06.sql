CREATE SCHEMA Examples;

CREATE TABLE Examples.Widget
(
WidgetId INT PRIMARY KEY,
RowLastModifiedTime DATETIME2(0) NOT NULL
);
GO

INSERT INTO Examples.Widget VALUES (2);
UPDATE Examples.Widget SET RowLastModifiedTime = DEFAULT
SELECT * FROM  Examples.Widget

ALTER TABLE Examples.Widget
ADD CONSTRAINT DFLT_Widget_RowLastModifiedtime
DEFAULT (SYSDATETIME()) FOR RowLastModifiedTime;



DROP TABLE Examples.Widget