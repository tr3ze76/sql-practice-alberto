DROP TABLE Examples.Parameter1
go
CREATE TABLE Examples.Parameter1(
ParameterId int IDENTITY (1,1) PRIMARY KEY not null,
Value1 varchar(20) not null,
Value2 varchar(20) not null
);

CREATE PROCEDURE Examples.Parameter1_Insert
@Value1 varchar(20) = 'No entry given',
@Value2 varchar(20) = 'No entry given'
AS 

SET NOCOUNT ON;
INSERT INTO Examples.Parameter1 (Value1,Value2)
VALUES (@Value1, @Value2);
GO

--USING ALL DEFAULTS
EXEC Examples.Parameter1_Insert;

--BY POSITION, @Value1 Parameter only
EXEC Examples.Parameter1_Insert 'Some entry';

--BOTH COLUMNS BY POSITION
EXEC Examples.Parameter1_Insert 'More entry', 'More entry';

EXEC Examples.Parameter1_Insert @Value1 = 'Other entry';

--lets see how to use parameters
SELECT * FROM Examples.Parameter1;

ALTER PROCEDURE Examples.Parameter1_Insert
@Value1 varchar(20) = 'No entry given',
@Value2 varchar(20) ='no entry given' OUTPUT,
@NewParameterId int =NULL OUTPUT
AS
SET NOCOUNT ON;
SET @Value1 = UPPER(@Value1);
SET @Value2 = LOWER(@Value2);

INSERT INTO Examples.Parameter1(Value1,Value2)
VALUES (@Value1, @Value2);

SET @NewParameterId = SCOPE_IDENTITY();
GO

DECLARE 
@Value1 varchar(20) = 'Test',
@Value2 varchar(20) = 'Test',
@NewParameterId int = 200;

EXEC Examples.Parameter1_Insert 
@Value1 = @Value1,
@Value2 = @Value2 OUTPUT,
@NewParameterId = @NewParameterId OUTPUT

SELECT @Value1 as Val1, @Value2 as Val2, @NewParameterId as NewParamId;

SELECT * FROM Examples.Parameter1
WHERE ParameterId = @NewParameterId;

CREATE PROCEDURE SimplyReturnValue
AS 
DECLARE @NoOp int;

DECLARE @Returncode int;
EXEC @Returncode = SimplyReturnValue;
SELECT @Returncode as DefaultReturncode;


CREATE PROCEDURE DoOperation
(
--prcedure returns via return code:
--1 - successful excution, with 0 entered
--0 - successful execution
-- -1 - invalid, NULL input
@Value int
)
AS 
IF @Value = 0
RETURN 1;
ELSE IF @Value IS NULL
RETURN -1;
ELSE RETURN 0

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation NULL;
SELECT @ReturnCode;

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation 10;
SELECT @ReturnCode;

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation 0;
SELECT @ReturnCode;
