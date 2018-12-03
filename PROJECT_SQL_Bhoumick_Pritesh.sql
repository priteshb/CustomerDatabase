-- Pritesh Bhoumick
-- 113292019
-- DSA 4513 DATA BASE MANAGEMENT (ONLINE FALL 2018)
-- PROJECT


-- Create Tables
-----------------
CREATE TABLE Employees
(
  EName VARCHAR2(25),
  Address VARCHAR2(40) NOT NULL,
  PRIMARY KEY (EName)
);

CREATE TABLE Tech_Staff
(
  EName VARCHAR2(25),
  Education VARCHAR2(10) NOT NULL,
  Position VARCHAR2(10) NOT NULL,
  FOREIGN KEY (EName) REFERENCES Employees(EName) ON DELETE CASCADE,
  PRIMARY KEY (EName)
);

CREATE TABLE Qual_Cont
(
  EName VARCHAR2(25),
  Product_Type VARCHAR2(10) NOT NULL,
  FOREIGN KEY (EName) REFERENCES Employees(EName) ON DELETE CASCADE,
  PRIMARY KEY (EName)
);

CREATE TABLE Worker
(
  EName VARCHAR2(25),
  Max_no_Product INT NOT NULL,
  FOREIGN KEY (EName) REFERENCES Employees(EName) ON DELETE CASCADE,
  PRIMARY KEY (EName)
);

CREATE TABLE Product
(
  PID INT,
  Date DATE NOT NULL,
  Time_Spent INT NOT NULL,
  Worker_EName VARCHAR2(25) NOT NULL,
  Qual_Cont_EName VARCHAR2(25) NOT NULL,
  Tech_Staff_EName VARCHAR2(25) NOT NULL,
  FOREIGN KEY (Worker_EName) REFERENCES Worker(EName),
  FOREIGN KEY (Qual_Cont_EName) REFERENCES Qual_Cont(EName),
  FOREIGN KEY (Tech_Staff_EName) REFERENCES Tech_Staff(EName),
  PRIMARY KEY (PID)
);

CREATE TABLE Product1
(
  PID INT,
  Size VARCHAR2(8) NOT NULL,
  Software VARCHAR2(25) NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  PRIMARY KEY (PID)
);

CREATE TABLE Product2
(
  PID INT,
  Size VARCHAR2(8) NOT NULL,
  Color VARCHAR2(10) NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  PRIMARY KEY (PID)
);

CREATE TABLE Product3
(
  PID INT,
  Size VARCHAR2(8) NOT NULL,
  Weight INT NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  PRIMARY KEY (PID)
);

CREATE TABLE Customer
(
  CName VARCHAR2(25),
  Address VARCHAR2(40) NOT NULL,
  PRIMARY KEY (CName)
);

CREATE TABLE Account
(
  Ac_No INT,
  Date DATE NOT NULL,
  PRIMARY KEY (Ac_No)
);

CREATE TABLE Acc_P1
(
  Ac_No INT,
  Cost FLOAT NOT NULL,
  FOREIGN KEY (Ac_No) REFERENCES Account(Ac_No) ON DELETE CASCADE,
  PRIMARY KEY (Ac_No)
);

CREATE TABLE Acc_P2
(
  Ac_No INT,
  Cost FLOAT NOT NULL,
  FOREIGN KEY (Ac_No) REFERENCES Account(Ac_No) ON DELETE CASCADE,
  PRIMARY KEY (Ac_No)
);

CREATE TABLE Acc_P3
(
  Ac_No INT,
  Cost FLOAT NOT NULL,
  FOREIGN KEY (Ac_No) REFERENCES Account(Ac_No) ON DELETE CASCADE,
  PRIMARY KEY (Ac_No)
);

CREATE TABLE Complaint
(
  CID INT,
  Date DATE NOT NULL,
  Detail VARCHAR2(40),
  Treatment VARCHAR2(25),
  PRIMARY KEY (CID)
);

CREATE TABLE Accident_Rec
(
  Acc_No INT,
  Date DATE NOT NULL,
  Days_Lost INT,
  EName VARCHAR2(25) NOT NULL,
  PID INT NOT NULL,
  FOREIGN KEY (EName) REFERENCES Employees(EName) ON DELETE CASCADE,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  PRIMARY KEY (Acc_No)
);

CREATE TABLE Test
(
  PID INT,
  Qual_Cont_EName VARCHAR2(25) NOT NULL,
  Cert INT NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  FOREIGN KEY (Qual_Cont_EName) REFERENCES Qual_Cont(EName) ON DELETE CASCADE,
  PRIMARY KEY (PID)
);

CREATE TABLE Purchase
(
  PID INT,
  CName VARCHAR2(25) NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  FOREIGN KEY (CName) REFERENCES Customer(CName) ON DELETE CASCADE,
  PRIMARY KEY (PID, CName)
);

CREATE TABLE Track
(
  PID INT,
  Ac_No INT NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID),
  FOREIGN KEY (Ac_No) REFERENCES Account(Ac_No),
  PRIMARY KEY (PID)
);

CREATE TABLE Defect
(
  PID INT,
  CID INT NOT NULL,
  CName VARCHAR2(25) NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  FOREIGN KEY (CID) REFERENCES Complaint(CID) ON DELETE CASCADE,
  FOREIGN KEY (CName) REFERENCES Customer(CName) ON DELETE CASCADE,
  PRIMARY KEY (PID)
);

CREATE TABLE Repair_QC
(
  PID INT,
  Qual_Cont_EName VARCHAR2(25) NOT NULL,
  Tech_Staff_EName VARCHAR2(25) NOT NULL,
  Date DATE NOT NULL,
  FOREIGN KEY (PID) REFERENCES Product(PID) ON DELETE CASCADE,
  FOREIGN KEY (Qual_Cont_EName) REFERENCES Qual_Cont(EName),
  FOREIGN KEY (Tech_Staff_EName) REFERENCES Tech_Staff(EName),
  PRIMARY KEY (PID)
);

CREATE TABLE Repair_Com
(
  CID INT,
  Tech_Staff_EName VARCHAR2(25) NOT NULL,
  Date DATE NOT NULL,
  FOREIGN KEY (CID) REFERENCES Complaint(CID) ON DELETE CASCADE,
  FOREIGN KEY (Tech_Staff_EName) REFERENCES Tech_Staff(EName) ON DELETE CASCADE,
  PRIMARY KEY (CID)
);


-- Create index for non-primary key attributes
-----------------------------------------------
CREATE INDEX EName_index ON Product(EName)
CREATE INDEX Date_index ON Product1(Date)
CREATE INDEX Color_index ON Product2(Color)
CREATE INDEX Date_index ON Accident_Rec(Date)
CREATE INDEX EName_index2 ON Test(EName)
CREATE INDEX EName_index3 ON Repair_QC(EName)
CREATE INDEX EName_index4 ON Repair_Com(EName)


-- PL/SQL Procedures for queries
--------------------------------

-- Query 1 (Enter a new employee)
DROP PROCEDURE IF EXISTS Q1_T
GO

CREATE PROCEDURE Q1_T
  @EName VARCHAR2(25),
  @Address VARCHAR2(40),
  @Education VARCHAR2(10),
  @Position VARCHAR2(10)
AS 
INSERT INTO Employees VALUES(@EName, @Address)
INSERT INTO Tech_Staff VALUES(@EName, @Education, @Position)
GO

DROP PROCEDURE IF EXISTS Q1_Q
GO

CREATE PROCEDURE Q1_Q
  @EName VARCHAR2(25),
  @Address VARCHAR2(40),
  @P_Type VARCHAR2(2)
AS 
INSERT INTO Employees VALUES(@EName, @Address)
INSERT INTO Qual_Cont VALUES(@EName, @P_type)
GO

DROP PROCEDURE IF EXISTS Q1_W
GO

CREATE PROCEDURE Q1_W
  @EName VARCHAR2(25),
  @Address VARCHAR2(40),
  @Max INT
AS 
INSERT INTO Employees VALUES(@EName, @Address)
INSERT INTO Worker VALUES(@EName, @Max)
GO

-- Query 2 (Enter a new product associated with the person who made the product, 
-- repaired the product if it is repaired, or checked the product)
DROP PROCEDURE IF EXISTS Q2_P1
GO

CREATE PROCEDURE Q2_P1
  @PID INT,
  @Date DATE,
  @Time_Spent INT,
  @WName VARCHAR2(25),
  @QName VARCHAR2(25),
  @TName VARCHAR2(25),
  @Size VARCHAR2(8),
  @Software VARCHAR2(25),
  @Cert INT,
  @Date2 DATE = "2017-01-01" -- set default value
AS
INSERT INTO Product VALUES(@PID, @Date, @Time_Spent, @WName, @QName, @TName)
INSERT INTO Product1 VALUES(@PID, @Size, @Software)
INSERT INTO Test VALUES(@PID, @QName, @Cert)
IF @Cert = 0
  INSERT INTO Repair_QC VALUES(@PID, @QName, @TName, @Date2)
GO

DROP PROCEDURE IF EXISTS Q2_P2
GO

CREATE PROCEDURE Q2_P2
  @PID INT,
  @Date DATE,
  @Time_Spent INT,
  @WName VARCHAR2(25),
  @QName VARCHAR2(25),
  @TName VARCHAR2(25),
  @Size VARCHAR2(8),
  @Color VARCHAR2(10),
  @Cert INT,
  @Date2 DATE = "2017-01-01" -- set default value
AS
INSERT INTO Product VALUES(@PID, @Date, @Time_Spent, @WName, @QName, @TName)
INSERT INTO Product2 VALUES(@PID, @Size, @Color)
INSERT INTO Test VALUES(@PID, @QName, @Cert)
IF @Cert = 0
  INSERT INTO Repair_QC VALUES(@PID, @QName, @TName, @Date2)
GO

DROP PROCEDURE IF EXISTS Q2_P3
GO

CREATE PROCEDURE Q2_P3
  @PID INT,
  @Date1 DATE,
  @Time_Spent INT,
  @WName VARCHAR2(25),
  @QName VARCHAR2(25),
  @TName VARCHAR2(25),
  @Size VARCHAR2(8),
  @Weight INT,
  @Cert INT,
  @Date2 DATE = "2017-01-01" -- set default value
AS
INSERT INTO Product VALUES(@PID, @Date1, @Time_Spent, @WName, @QName, @TName)
INSERT INTO Product3 VALUES(@PID, @Size, @Weight)
INSERT INTO Test VALUES(@PID, @QName, @Cert)
IF @Cert = 0
  INSERT INTO Repair_QC VALUES(@PID, @QName, @TName, @Date2)
GO

-- Query 3 (Enter a customer associated with some products)
DROP PROCEDURE IF EXISTS Q3
GO

CREATE PROCEDURE Q3
  @CName VARCHAR2(25),
  @Address VARCHAR2(40),
  @PID INT
AS
INSERT INTO Customer VALUES(@CName, @Address)
INSERT INTO Purchase VALUES(@PID, @CName)
GO

-- Query 4 (Create a new account associated with a product)
DROP PROCEDURE IF EXISTS Q4
GO

CREATE PROCEDURE Q4
  @Ac INT,
  @Date DATE,
  @Cost FLOAT,
  @A_Type VARCHAR2(2),
  @PID INT
AS
INSERT INTO Account VALUES(@Ac, @Date)
IF @A_Type = 'P1'
  INSERT INTO Acc_P1 VALUES(@Ac, @Cost)
ELSE IF @A_Type = 'P2'
  INSERT INTO Acc_P2 VALUES(@Ac, @Cost)
ELSE INSERT INTO Acc_P3 VALUES(@Ac, @Cost)
INSERT INTO Track VALUES(@PID, @Ac)
GO

-- Query 5 (Enter a complaint associated with a customer and product)
DROP PROCEDURE IF EXISTS Q5
GO

CREATE PROCEDURE Q5
  @CID INT,
  @Date1 DATE,
  @Detail VARCHAR2(40),
  @Treatment VARCHAR2(25),
  @PID INT,
  @CName VARCHAR2(25),
  @TName VARCHAR2(25),
  @Date2 DATE
AS
INSERT INTO Complaint VALUES(@CID, @Date1, @Detail, @Treatment)
INSERT INTO Defect VALUES(@PID, @CID, @CName)
INSERT INTO Repair_Com VALUES(@CID, @TName, @Date2)
GO

-- Query 6 (Enter an accident associated with appropriate employee and product)
DROP PROCEDURE IF EXISTS Q6
GO

CREATE PROCEDURE Q6
  @Ac INT,
  @Date DATE,
  @Days_Lost INT,
  @EName VARCHAR2(25),
  @PID INT
AS
INSERT INTO Accident_Rec VALUES(@Ac, @Date, @Days_Lost, @EName, @PID)
GO

-- Query 7 (Retrieve the date produced and time spent to produce a particular product)
DROP PROCEDURE IF EXISTS Q7
GO

CREATE PROCEDURE Q7
  @PID INT,
  @Date DATE OUTPUT,
  @Time_Spent INT OUTPUT
AS
SELECT @Date = Date, @Time_Spent = Time_Spent FROM Product
WHERE PID = @PID
GO

-- Query 8 (Retrieve all products made by a particular worker)
DROP PROCEDURE IF EXISTS Q8
GO

CREATE PROCEDURE Q8
  @WName VARCHAR2(25),
  @PID INT OUTPUT
AS
SELECT @PID = PID FROM Product
WHERE Worker_EName = @WName
GO

-- Query 9 (Retrieve the total number of errors a particular quality controller made. 
-- This is the total number of products certified by this controller and got some complaints)
DROP PROCEDURE IF EXISTS Q9
GO

CREATE PROCEDURE Q9
  @QName VARCHAR2(25),
  @Total INT OUTPUT
AS
DECLARE @Comp_Count INT
SELECT @Comp_Count = COUNT(*) FROM Repair_QC
WHERE Qual_Cont_Ename = @QName
SELECT @Total = SUM(Cert)-@Comp_Count FROM Test
WHERE Qual_Cont_EName = @QName
GO

-- Query 10 (Retrieve the total costs of the products in the product3 category which were 
-- repaired at the request of a particular quality controller)
DROP PROCEDURE IF EXISTS Q10
GO

CREATE PROCEDURE Q10
  @QName VARCHAR2(25),
  @TCost FLOAT OUTPUT
AS
SELECT @TCost = SUM(Cost) FROM Acc_P3
WHERE Ac_No IN
(
  SELECT Ac_No FROM Track WHERE PID IN
  (
    SELECT PID FROM Repair_QC
    WHERE Qual_Cont_EName = @QName
  )
)
GO

-- Query 11 (Retrieve all customers who purchased all products of a particular color)
DROP PROCEDURE IF EXISTS Q11
GO

CREATE PROCEDURE Q11
  @Color VARCHAR2(25),
  @CName VARCHAR2(25) OUTPUT
AS
SELECT @CName = CName FROM Purchase
WHERE PID IN
(
  SELECT PID FROM Product2
  WHERE Color = @Color
)
GO

-- Query 12 (Retrieve the total number of work days lost due to accidents in repairing 
-- the products which got complaints)
DROP PROCEDURE IF EXISTS Q12
GO

CREATE PROCEDURE Q12
  @Days_Lost INT OUTPUT
AS
SELECT @Days_Lost = SUM(Days_Lost) FROM Accident_Rec 
WHERE EName IN
(
  SELECT EName FROM Repair_Com
)
GO

-- Query 13 (Retrieve all customers who are also workers)
DROP PROCEDURE IF EXISTS Q13
GO

CREATE PROCEDURE Q13
  @CName VARCHAR2(25) OUTPUT
AS
SELECT @CName = C.CName FROM Customer C, Worker W
WHERE C.CName = W.EName
GO

-- Query 14 (Retrieve all the customers who have purchased the products made or certified or 
-- repaired by themselves)
DROP PROCEDURE IF EXISTS Q14
GO

CREATE PROCEDURE Q14
  @CName VARCHAR2(25) OUTPUT
AS
SELECT @CName = C.CName FROM Customer C, Product P
WHERE C.CName = P.Worker_EName OR C.CName = P.Qual_Cont_EName OR C.CName = P.Tech_Staff_EName
GO

-- Query 15 (Retrieve the average cost of all products made in a particular year)
DROP PROCEDURE IF EXISTS Q15
GO

CREATE PROCEDURE Q15
  @Year VARCHAR2(5),
  @ACost FLOAT OUTPUT
AS
DECLARE @ACost1 FLOAT
DECLARE @ACost2 FLOAT
DECLARE @ACost3 FLOAT
DECLARE @Row1 INT
DECLARE @Row2 INT
DECLARE @Row3 INT

SELECT @ACost1 = SUM(Cost), @Row1 = COUNT(*) FROM Acc_P1
WHERE Ac_No IN
(
  SELECT Ac_No FROM Track
  WHERE PID IN
  (
    SELECT PID FROM Product
    WHERE YEAR(Date) = @Year
  )
)
SELECT @ACost2 = SUM(Cost), @Row2 = COUNT(*) FROM Acc_P2
WHERE Ac_No IN
(
  SELECT Ac_No FROM Track
  WHERE PID IN
  (
    SELECT PID FROM Product
    WHERE YEAR(Date) = @Year
  )
)
SELECT @ACost3 = SUM(Cost), @Row3 = COUNT(*) FROM Acc_P3
WHERE Ac_No IN
(
  SELECT Ac_No FROM Track
  WHERE PID IN
  (
    SELECT PID FROM Product
    WHERE YEAR(Date) = @Year
  )
)
SET @ACost = (@ACost1 + @ACost2 + @ACost3)/(@Row1 + @Row2 + @Row3)
GO

-- Query 16 (Switch the position between a technical staff and a quality controller)
DROP PROCEDURE IF EXISTS Q16
GO

CREATE PROCEDURE Q16
  @TName VARCHAR2(25),
  @QName VARCHAR2(25)
AS
DECLARE @Dummy VARCHAR2(25) = 'Dummy'
UPDATE Employees
SET EName = @Dummy
WHERE EName = @TName;
UPDATE Employees
SET EName = @TName
WHERE EName = @QName;
UPDATE Employees
SET EName = @QName
WHERE EName = @Dummy;
GO

-- Query 17 (Delete all accidents whose dates are in some range)
DROP PROCEDURE IF EXISTS Q17
GO

CREATE PROCEDURE Q17
  @Start DATE,
  @End DATE
AS
DELETE FROM Accident_Rec
WHERE Date > @Start AND Date < @End
GO

-- Query 18 is same as query 3

-- Query 19 Export: Retrieve all customers (in same order) and output them to a data file instead of screen
-- (the user must be asked to enter the output file name)
DROP PROCEDURE IF EXISTS Q19
GO

CREATE PROCEDURE Q19
  @CName VARCHAR2(25) OUTPUT,
  @Address VARCHAR2(40) OUTPUT
AS
SELECT @CName = CName, @Address = Address FROM Customer
GO