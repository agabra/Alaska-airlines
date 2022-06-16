--INFO430 
--Group 6: Alaska Airlines
--Andrew Gabra, Allison Bennett, Wanyu Guan, Jenny Rong
USE INFO430_Proj_06
GO

--#######################################--
--############CREATE TABLES##############--
--#######################################--
CREATE TABLE tblBooking
(BookingID INTEGER IDENTITY(1,1) PRIMARY KEY,
BookingName VARCHAR(50) NOT NULL,
PassengerID INT NOT NULL,
FlightID INT NOT NULL,
FeeID INT NOT NULL,
OrderID INT NOT NULL, 
BookingAmount FLOAT NOT NULL)
GO

CREATE TABLE tblFlight
(FlightID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightNum INT NOT NULL,
AirplaneID INT NOT NULL,
FlightTypeID INT NOT NULL,
DepartureAirportID INT NOT NULL,
ArrivalAirportID INT NOT NULL,
ArrivalTime TIME NOT NULL,
DepartureTime TIME NOT NULL,
FlightHrs FLOAT NOT NULL)
GO
 
CREATE TABLE tblBooking_Fee
(BookingFeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
BookingID INT NOT NULL,
FeeID INT NOT NULL)
GO
 
CREATE TABLE tblFlight_Type
(FlightTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightTypeName VARCHAR(20) NOT NULL,
FlightTypeDescr VARCHAR(100) NOT NULL)
GO
 
CREATE TABLE tblFlight_Event
(FlightEventID INTEGER IDENTITY(1,1) PRIMARY KEY,
EventID INT NOT NULL,
FlightID INT NOT NULL)
GO

CREATE TABLE tblAirport
(AirportID INTEGER IDENTITY(1,1) PRIMARY KEY,
CityID INT NOT NULL,
AirportLetters VARCHAR(5) NOT NULL)
GO

CREATE TABLE tblAirplane_Type
(AirplaneTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneTypeName VARCHAR(50) NOT NULL,
ManufacturerID INT NOT NULL)
GO
 
CREATE TABLE tblAirplane_Manufacturer
(ManufacturerID INTEGER IDENTITY(1,1) PRIMARY KEY,
ManufacturerName VARCHAR(50) NOT NULL, 
ManufacturerDescr VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblAirplane
(AirplaneID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneName VARCHAR(50) NOT NULL,
AirplaneTypeID INT NOT NULL,
DateMade DATE NOT NULL, 
TotalFlightHrs FLOAT NOT NULL)
GO
 
CREATE TABLE tblEvent_Type
(EventTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
EventTypeName VARCHAR(50) NOT NULL, 
EventTypeDescr VARCHAR(100) NOT NULL)
GO
 
CREATE TABLE tblEvent
(EventID INTEGER IDENTITY(1,1) PRIMARY KEY,
EventTypeID INT NOT NULL,  
EventName VARCHAR(50) NOT NULL, 
EventDescr VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblEmployee
(EmployeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeFname VARCHAR(100) NOT NULL,
EmployeeLname VARCHAR(100) NOT NULL,
EmployeeDOB DATE NOT NULL,
EmployeeEmail VARCHAR(100) NOT NULL,
EmployeePhone VARCHAR(100) NOT NULL,
EmployeeAddress VARCHAR(100) NOT NULL,
EmployeeCity VARCHAR(100) NOT NULL,
EmployeeState VARCHAR(100) NOT NULL,
EmployeeZip VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblEmployee_Flight
(EmployeeFlightID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightID INT NOT NULL,
EmployeeID INT NOT NULL)
GO

CREATE TABLE tblEmployee_Position
(EmployeePositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeID INT NOT NULL,
PositionID INT NOT NULL)
GO

CREATE TABLE tblPosition
(PositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
PositionName VARCHAR(50) NOT NULL,
PositionDescr VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblCity
(CityID INTEGER IDENTITY(1,1) PRIMARY KEY,
StateID INT NOT NULL,
CityName VARCHAR(50) NOT NULL)
GO

CREATE TABLE tblState
(StateID INTEGER IDENTITY(1,1) PRIMARY KEY,
StateLetters VARCHAR(2) NOT NULL, 
StateName VARCHAR(50) NOT NULL)
GO

CREATE TABLE tblCustomer_Type
(CustomerTypeID INT IDENTITY(1,1) PRIMARY KEY,
CustomerTypeName VARCHAR(100) NOT NULL,
CustomerTypeDescr VARCHAR(100) NOT NULL)
GO 

CREATE TABLE tblCustomer
(CustomerID INT IDENTITY(1,1) PRIMARY KEY,
CustomerTypeID INT NOT NULL,
CustomerFname VARCHAR(100) NOT NULL,
CustomerLname VARCHAR(100) NOT NULL,
CustomerPhone VARCHAR(100) NOT NULL,
CustomerDOB DATE NOT NULL,
CustomerEmail VARCHAR(100) NOT NULL,
CustomerStreetAddr VARCHAR(50) NOT NULL,
CustomerCity VARCHAR(100) NOT NULL,
CustomerState VARCHAR(100) NOT NULL,
CustomerZip VARCHAR(100))   
GO
 
CREATE TABLE tblOrder
(OrderID INT IDENTITY(1,1) PRIMARY KEY,
OrderName VARCHAR(50),
CustomerID INT NOT NULL,
OrderDate DATE NOT NULL)
GO 
 
CREATE TABLE tblFee_Type
(FeeTypeID INT IDENTITY(1,1) PRIMARY KEY,
FeeTypeName VARCHAR(50) NOT NULL,
FeeTypeDescr VARCHAR(100) NOT NULL) 
GO
 
CREATE TABLE tblFee
(FeeID INT IDENTITY(1,1) PRIMARY KEY,
FeeName VARCHAR(50) NOT NULL,
FeeTypeID INT NOT NULL,
FeeAmount FLOAT NOT NULL) 
GO

CREATE TABLE tblPassenger
(PassengerID INT IDENTITY(1,1) PRIMARY KEY,
PassengerFname VARCHAR(100),
PassengerLname VARCHAR(100),
PassengerDOB DATE, 
PassengerPhone VARCHAR(100),
PassengerEmail VARCHAR(100),
PassengerStreetAddr VARCHAR(100),
PassengerCity VARCHAR(100),
PassengerState VARCHAR(100),
PassengerZip VARCHAR(50))
GO

-- create temporary table with PEEPs data
SELECT DISTINCT * INTO dbo.PEEPS_Customer_Raw 
FROM PEEPS.dbo.tblCUSTOMER
GO

--################--
--ADD FOREIGN KEY--
--################--
ALTER TABLE tblBooking
Add CONSTRAINT FK_PassengerID
 FOREIGN KEY (PassengerID) REFERENCES tblPassenger(PassengerID);
GO
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_FlightID
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID);
GO
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_OrderID
 FOREIGN KEY (OrderID) REFERENCES tblOrder(OrderID);
GO

ALTER TABLE tblFlight
Add CONSTRAINT FK_AirplaneID
 FOREIGN KEY (AirplaneID) REFERENCES tblAirplane(AirplaneID);
GO
 
ALTER TABLE tblFlight
Add CONSTRAINT FK_FlightTypeID
 FOREIGN KEY (FlightTypeID) REFERENCES tblFlight_Type(FlightTypeID);
GO

ALTER TABLE tblFlight
Add CONSTRAINT FK_DepartureAirportID
 FOREIGN KEY (DepartureAirportID) REFERENCES tblAirport(AirportID);
GO

ALTER TABLE tblFlight
Add CONSTRAINT FK_ArrivalAirportID
 FOREIGN KEY (ArrivalAirportID) REFERENCES tblAirport(AirportID);
GO
 
ALTER TABLE tblBooking_Fee
Add CONSTRAINT FK_BookingID
 FOREIGN KEY (BookingID) REFERENCES tblBooking(BookingID);
GO
 
ALTER TABLE tblBooking_Fee
Add CONSTRAINT FK_FeeID
 FOREIGN KEY (FeeID) REFERENCES tblFee(FeeID);
GO

ALTER TABLE tblFlight_Event
Add CONSTRAINT FK_EventID
 FOREIGN KEY (EventID) REFERENCES tblEvent(EventID);
GO
 
ALTER TABLE tblFlight_Event
Add CONSTRAINT FK_FlightID2
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID);
GO

ALTER TABLE tblAirport
Add CONSTRAINT FK_CityID
 FOREIGN KEY (CityID) REFERENCES tblCity(CityID);
GO
 
ALTER TABLE tblAirplane_Type
ADD CONSTRAINT FK_ManufacturerID
 FOREIGN KEY (ManufacturerID) REFERENCES tblAirplane_Manufacturer(ManufacturerID);
GO
 
ALTER TABLE tblAirplane
ADD CONSTRAINT FK_AirplaneTypeID
 FOREIGN KEY (AirplaneTypeID) REFERENCES tblAirplane_Type(AirplaneTypeID);
GO

ALTER TABLE tblEvent
ADD CONSTRAINT FK_EventTypeID
 FOREIGN KEY (EventTypeID) REFERENCES tblEvent_Type(EventTypeID);
GO

ALTER TABLE tblEmployee_Flight
ADD CONSTRAINT FK_EmployeeID
 FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO

ALTER TABLE tblEmployee_Flight
ADD CONSTRAINT FK_FlightID3
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID)
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_EmployeeID2
 FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_PositionID
 FOREIGN KEY (PositionID) REFERENCES tblPosition(PositionID)
GO

ALTER TABLE tblCity
Add CONSTRAINT FK_StateID
 FOREIGN KEY (StateID) REFERENCES tblstate(StateID);
GO

ALTER TABLE tblCustomer 
ADD CONSTRAINT FK_CustomerTypeID
    FOREIGN KEY (CustomerTypeID) REFERENCES tblCustomer_Type(CustomerTypeID);
GO

ALTER TABLE tblOrder 
ADD CONSTRAINT FK_CustomerID
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer(CustomerID);
GO

ALTER TABLE tblFee
ADD CONSTRAINT FK_FeeTypeID
    FOREIGN KEY (FeeTypeID) REFERENCES tblFee_Type(FeeTypeID);
GO

--###########################################--
--###############DATA INSERTS################--
--###########################################--
/* NOTE: data inserted for tblCity, tblAirport, and flight times 
in tblFlight were loaded into a csv and then inserted 
using Import Wizard. Data time for time has to be change to char(10)
when inserting the data with the import wizzard */ 
-- Inserts for tblState -- 
INSERT into tblState(StateLetters, StateName) values ('AL', 'Alabama'),
('AK', 'Alaska'),
('AL', 'Alabama'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');
GO

--Inserts for tblAirplane_Manufacturer
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Airbus', 'A French company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Boeing', 'An American company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Bombarier', 'A Canadian company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Embraer', 'A Brazilian company that makes airplanes')
GO

--Inserts for tblAirplane_Type
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('A320', (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Airbus'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-9 Max', (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-900ER(739)', (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-900(739)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-800(738)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-700(73G)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('Q400 (DH4)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Bombarier'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('175',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Embraer'))
GO

--inserts into tblEvent_type
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Wind Storm', 'Wind strong enough to cause more than normal turbulance')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Passenger Medical Problem', 'Passenger on flight has medical issue that needed immediate attention')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Emergency Landing', 'Had to land early due to an emergency')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Extreme Lightning', 'Lightning close to plane that caused some sort of disruptance')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Canceled Flight', 'Issue that caused flight to be canceled')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Delayed Flight', 'Issue that caused flight to be delayed')
GO

-- insert into tblFlight_type
INSERT into tblFlight_Type(FlightTypeName, FlightTypeDescr) values ('Domestic', 'Flights that are only inside of the US')
GO

-- insert into tblFee_Type
INSERT INTO tblFee_Type (FeeTypeName, FeeTypeDescr)
VALUES ('Baggage fees', 'This fee type deals with any baggage fees.'),
('Reservations and service fees', 'This fee type deals with any reservations and service fees.'),
('Change and cancellation fees', 'This fee type deals with any change and cancellation fees'),
('Inflight fees', 'This fee type deals with any inflight fees.')
GO

-- insert into tblCustomer_Type
INSERT INTO tblCustomer_Type (CustomerTypeName, CustomerTypeDescr)
VALUES ('Basic memebr', 'This is the Basic Member customer type in Alaksa Airlines.'),
('MVP', 'This is the MVP customer type in Alaska Airlines.'),
('MVP Gold', 'This is the MVP Gold customer type in Alaksa Airlines.'),
('MVP Gold 75K', 'This is the MVP Gold 75K customer type in Alaska Airlines.'),
('Club 49', 'This is the Club 49 customer type in Alaska Airlines.')
GO

-- insert into tblPosition
INSERT INTO tblPosition (PositionName, PositionDescr) 
VALUES ('Flight attendant', 'Responsible for ensuring the safety of passengers and providing excellent customer services.'),
('Airline administrative support', 'Responsible for answering phone calls, transcribing executive correspondence, and data entry.'),
('Baggage handler', 'Responsible for loading and unloading passenger baggage, mail, food supplies, or other cargos.'),
('Operations agent', 'Responsible for transmitting information from and to pilots, ground crew, and flight schedulers.'),
('Aircraft fueler', 'Responsible for operating the fueling equipment.'),
('Airframe & powerplant mechanics', 'Responsible for tunning, repairing, replacing, or upgrading aircraft engines.'),
('Avionics technician', 'Responsible for working on the electronics system of aircrraft.'),
('Cabin maintenance mechanic', 'Responsible for keeping the interior and exterior of a plane in like-new condition.'),
('Regional sales manager', 'Responsible for overseeing reservations and sale representatives of a dsitrict.'),
('Airport equipment driver', 'Responsible for operating various airfield vehicles such as food trucks and power carts.'),
('Flight dispatcher', 'Responsible for ensuring the safety of a flight for an aircraft and preparing a flight plan.'),
('Food services worker', 'Responsible for preparing and cooking food for the flights.'),
('Ground station attendant', 'Responsible for assisting passengers in the terminal with general questions.'),
('Equipment mechanic', 'Responsible for troubleshooting, repairing, and upgrading airport vehicles and equipment.'),
('Avidation meterologist', 'Responsible for providing weather information to airline flight dispatchers and pilots.'),
('Passenger service agent', 'Responsible for issuing refunds to passengers, selling tickets, and providing travel information.'),
('Ramp planner', 'Responsible for knowing arrival and departure times for each aircraft for the airline at an airport.'),
('Reservation sales agent', 'Responsible for providing travel information over the phone to customers of the airline.'),
('Sales representative', 'Responsible for making flight ticket sales for the airline.'),
('Crew schedule coordinator', 'Responsible for ensuring adequate aircrew staffing and ground support to keep flights on schedule.'),
('Station agent', 'Responsible for taking care of the overall operations of a given airline at a particular airport.'),
('Ticket agent', 'Responsible for greeting customers when they arrive at the airport.'),
('Flight instructor', 'Responsible for providing recurrent training for the pilots at an airline.'),
('Pilot', 'Responsible for operating an aircraft and ensuring the safety of passengers and crew.')

-- insert into tblCity
INSERT INTO tblCity (StateID, CityName)
SELECT StateID, CityName FROM CityAirport
GO

-- insert into tblAirport
INSERT INTO tblAirport (CityID, AirportLetters)
SELECT CityID, AirportLetters FROM CityAirport
GO

-- insert into tblAirport
INSERT INTO tblAirport (CityID, AirportLetters)
SELECT CityID, AirportLetters FROM CityAirport
GO

-- insert into tblPassenger
INSERT INTO tblPassenger (PassengerFname, PassengerLname,  PassengerDOB, PassengerPhone, PassengerEmail, PassengerStreetAddr, PassengerCity, PassengerState, PassengerZip)
SELECT TOP 1000 CustomerFname, CustomerLname, DateofBirth, PhoneNum, Email, CustomerAddress, CustomerCity, CustomerState, CustomerZIP FROM PEEPS_Customer_Raw 
GO

-- insert into tblEmployee
INSERT INTO tblEmployee (EmployeeFname, EmployeeLname,  EmployeeDOB, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeCity, EmployeeState, EmployeeZip)
SELECT TOP 1000 CustomerFname, CustomerLname, DateofBirth, Email, PhoneNum, CustomerAddress, CustomerCity, CustomerState, CustomerZIP FROM PEEPS_Customer_Raw 
GO

-- insert into tblPassenger
INSERT INTO tblPassenger (PassengerFname, PassengerLname,  PassengerDOB, PassengerPhone, PassengerEmail, PassengerStreetAddr, PassengerCity, PassengerState, PassengerZip)
SELECT TOP 1000 CustomerFname, CustomerLname, DateofBirth, PhoneNum, Email, CustomerAddress, CustomerCity, CustomerState, CustomerZIP FROM dbo.PEEPS_Customer_Raw 
GO

-- insert into tblEmployee
INSERT INTO tblEmployee (EmployeeFname, EmployeeLname,  EmployeeDOB, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeCity, EmployeeState, EmployeeZip)
SELECT TOP 1000 CustomerFname, CustomerLname, DateofBirth, Email, PhoneNum, CustomerAddress, CustomerCity, CustomerState, CustomerZIP FROM dbo.PEEPS_Customer_Raw 
GO
--###########################################--
--############GET ID PROCEDURES##############--
--###########################################--
CREATE PROCEDURE getAirplaneTypeID
@AT_Name VARCHAR(50), 
@AT_ID INT OUTPUT
AS 
SET @AT_ID = 
(SELECT AirplaneTypeID FROM tblAirplane_Type WHERE AirplaneTypeName = @AT_Name)
GO 

CREATE PROCEDURE getManufacturerID
@MFG_Name VARCHAR(50), 
@MFG_ID INT OUTPUT
AS 
SET @MFG_ID = 
(SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = @MFG_Name)
GO 
 
CREATE PROCEDURE getEventTypeID
@ET_Name VARCHAR(50), 
@ET_ID INT OUTPUT
AS 
SET @ET_ID = 
(SELECT EventTypeID FROM tblEvent_Type WHERE EventTypeName = @ET_Name)
GO 

CREATE PROCEDURE getEmployeeID
@EmployeeFnamey VARCHAR(100),
@EmployeeLnamey VARCHAR(100),
@EmployeePhoney VARCHAR(100),
@EmployeeIDy INT OUTPUT
AS
SET @EmployeeIDy = (
    SELECT TOP(1) EmployeeID
    FROM tblEmployee
    WHERE EmployeeFname = @EmployeeFnamey
       AND EmployeeLname = @EmployeeLnamey
       AND EmployeePhone = @EmployeePhoney)
GO
 
CREATE PROCEDURE getPositionID
@PositionNamey VARCHAR(50),
@PositionIDy INT OUTPUT
AS
SET @PositionIDy = 
(SELECT PositionID FROM tblPOSITION WHERE PositionName = @PositionNamey)
GO
 
CREATE PROCEDURE getStateID
@StateNamey VARCHAR(50),
@StateID INT OUTPUT
AS
SET @StateID = 
(SELECT StateID FROM tblSTATE WHERE StateName = @StateNamey)
GO

CREATE PROCEDURE getCustomerTypeID
@CustomerTname VARCHAR(50),
@CustomerT_ID INT OUTPUT
AS
SET @CustomerT_ID = 
(SELECT CustomerTypeID FROM tblCustomer_Type WHERE CustomerTypeName = @CustomerTname)
GO

CREATE PROCEDURE getCustomerID
@Customer_Fname VARCHAR(100),
@Customer_Lname VARCHAR(100),
@Customer_DOB DATE,
@Customer_ID INT OUTPUT
AS
SET @Customer_ID = 
(SELECT TOP(1) CustomerID FROM tblCustomer WHERE CustomerFname = @Customer_Fname AND CustomerLname = @Customer_Lname AND CustomerDOB = @Customer_DOB)
GO

CREATE PROCEDURE getFeeTypeID
@Fee_Type_Name VARCHAR(50),
@Fee_Type_ID INT OUTPUT
AS
SET @Fee_Type_ID = 
(SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = @Fee_Type_Name)
GO

CREATE PROCEDURE getPassengerID
@Passenger_Fname VARCHAR(100),
@Passenger_Lname VARCHAR(100),
@Passenger_Birth DATE,
@Passenger_ID INT OUTPUT
AS
SET @Passenger_ID = 
(SELECT TOP(1) PassengerID FROM tblPassenger WHERE PassengerFname = @Passenger_Fname AND PassengerLname = @Passenger_Lname AND PassengerDOB = @Passenger_Birth)
GO

CREATE PROCEDURE getFlight_TypeID
@FlightType_Name VARCHAR(20),
@FlightType_ID INT OUTPUT
AS 
SET @FlightType_ID = 
(SELECT FlightTypeID FROM tblFlight_Type WHERE FlightTypeName = @FlightType_Name)
GO 

CREATE PROCEDURE getAirportID
@AirportLtrs VARCHAR(5),
@AirportID INT OUTPUT
AS 
SET @AirportID = 
(SELECT TOP(1) AirportID FROM tblAirport WHERE AirportLetters = @AirportLtrs)
GO 

CREATE PROCEDURE getCityID
@CityName VARCHAR(20), 
@CityID INT OUTPUT
AS 
SET @CityID = 
(SELECT CityID FROM tblCity WHERE CityName = @CityName)
GO 

CREATE PROCEDURE getEventID
@EventName VARCHAR(50),
@EventID INT OUTPUT
AS 
SET @EventID = 
(SELECT TOP(1) EventID FROM tblEvent WHERE EventName = @EventName)
GO 
    
CREATE PROCEDURE getOrderID
@OrderName VARCHAR(50),
@OrderID INT OUTPUT
AS 
SET @OrderID = 
(SELECT TOP(1) OrderID FROM tblOrder WHERE OrderName = @OrderName)
GO 

CREATE PROCEDURE getFeeID 
@FeeName VARCHAR(50), 
@FeeID INT OUTPUT
AS
SET @FeeID = 
(SELECT TOP(1) FeeID FROM tblFee WHERE FeeName = @FeeName)
GO

CREATE PROCEDURE getAirplaneID 
@AName VARCHAR(50),
@AirplaneID INT OUTPUT
AS 
SET @AirplaneID = 
(SELECT AirplaneID FROM tblAirplane WHERE AirplaneName = @AName)
GO

CREATE PROCEDURE getBookingID 
@BName VARCHAR(50),
@BookingID INT OUTPUT
AS 
SET @BookingID = 
(SELECT BookingID FROM tblBooking WHERE BookingName = @BName)
GO

CREATE PROCEDURE getFlightID 
@FNum INT,
@FlightID INT OUTPUT
AS 
SET @FlightID = 
(SELECT TOP(1) FlightID FROM tblFlight WHERE FlightNum = @FNum)
GO
--###########################################--
--############INSERT PROCEDURES##############--
--###########################################--
-- insert into tblAirplane
CREATE PROCEDURE newAirplane
@A_Name VARCHAR(50), 
@AType_Name VARCHAR(50), 
@Date DATE, 
@Hrs FLOAT
AS 
DECLARE
@AType_ID INT
 
EXEC getAirplaneTypeID
@AT_Name = @AType_Name, 
@AT_ID = @AType_ID OUTPUT
 
IF @AType_ID IS NULL 
    BEGIN 
        PRINT '@AType_ID cannot be empty - will fail in transaction'; 
        THROW 51100, '@AType_ID cannot be null',1; 
    END
 
BEGIN TRAN T1
    INSERT INTO tblAirplane
    (AirplaneName, AirplaneTypeID, DateMade, TotalFlightHrs)
    VALUES 
    (@A_Name, @AType_ID, @Date, @Hrs)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO
 
CREATE PROCEDURE newEvent
@EventT_Name VARCHAR(50), 
@Event_Name VARCHAR(50), 
@Event_Descr VARCHAR(100)
AS 
DECLARE
@EventT_ID INT
 
EXEC getEventTypeID
@ET_Name = @EventT_Name, 
@ET_ID = @EventT_ID OUTPUT
 
IF @EventT_ID IS NULL 
    BEGIN 
        PRINT '@EventT_ID cannot be empty - will fail in transaction'; 
        THROW 51300, '@EventT_ID cannot be null',1; 
    END
 
BEGIN TRAN T1
    INSERT INTO tblEvent
    (EventTypeID, EventName, EventDescr)
    VALUES 
    (@EventT_ID, @Event_Name, @Event_Descr)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO

CREATE PROCEDURE newEmployeePosition
    @EF VARCHAR(100),
    @EL VARCHAR(100),
    @EP VARCHAR(100),
    @PN VARCHAR(50)
    AS
    DECLARE @E_ID INT, @P_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EF,
    @EmployeeLnamey = @EL,
    @EmployeePhoney = @EP,
    @EmployeeIDy = @E_ID OUTPUT
    IF @E_ID IS NULL 
        BEGIN 
            PRINT '@E_ID IS NULL'
            RAISERROR ('@E_ID CAN NOT BE NULL', 11, 1)
            RETURN
        END

    EXEC getPositionID
    @PositionNamey = @PN,
    @PositionIDy = @P_ID OUTPUT
    IF @P_ID IS NULL 
        BEGIN 
            PRINT '@P_ID IS NULL'
            RAISERROR ('@P_ID CAN NOT BE NULL', 11, 1)
            RETURN
        END

    BEGIN TRAN G1
        INSERT INTO tblEmployee_Position(EmployeeID, PositionID)
        VALUES (@E_ID, @P_ID)
        IF @@ERROR <> 0
            BEGIN 
                PRINT Error_Message()
                ROLLBACK TRAN T1
            END 
        ELSE 
    COMMIT TRAN T1
GO

CREATE PROCEDURE newCity
    @SN VARCHAR(50), 
    @CN VARCHAR(100)
    AS 
    DECLARE
    @S_ID INT
    
    EXEC getStateID
    @StateNamey = @SN,
    @StateID = @S_ID OUTPUT
    
    IF @S_ID IS NULL 
        BEGIN 
            PRINT '@EventT_ID cannot be empty - will fail in transaction'; 
            THROW 51300, '@EventT_ID cannot be null',1; 
        END
    
    BEGIN TRAN T1
        INSERT INTO tblCity
        (StateID, CityName)
        VALUES 
        (@S_ID, @CN)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newCustomer 
    @Customer_Fname VARCHAR(100),
    @Customer_Lname VARCHAR(100),
    @Customer_Phone VARCHAR(100),
    @Customer_DOB DATE, 
    @Customer_Email VARCHAR(100),
    @Customer_Street_Addr VARCHAR(100),
    @Customer_City VARCHAR(100),
    @Customer_State VARCHAR(100),
    @Customer_Zip VARCHAR(100),
    @CustomerTypeName VARCHAR(100)
    AS
    DECLARE @CustomerTypeID INT
    
    EXEC getCustomerTypeID
    @CustomerTName = @CustomerTypeName,
    @CustomerT_ID = @CustomerTypeID OUTPUT

    -- Error handle @CustomerTypeID in case if it's NULL/ empty
    IF @CustomerTypeID IS NULL
        BEGIN
            PRINT '@CustomerTypeID is empty and will fail in the transaction';
            THROW 51000, '@CustomerTypeID cannot be NULL', 1;
        END 
    
    BEGIN TRAN G1
        INSERT INTO tblCustomer (CustomerTypeID, CustomerFname, CustomerLname, CustomerPhone, CustomerDOB, CustomerEmail, 
                                CustomerStreetAddr, CustomerCity, CustomerState, CustomerZip)
        VALUES (@CustomerTypeID, @Customer_Fname, @Customer_Lname, @Customer_Phone, @Customer_DOB, @Customer_Email, 
                @Customer_Street_Addr, @Customer_City, @Customer_State, @Customer_Zip)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END 
        ELSE 
    COMMIT TRAN G1
GO 

CREATE PROCEDURE newOrder
    @Order_Name VARCHAR(50),
    @Customer_FirstName VARCHAR(100),
    @Customer_LastName VARCHAR(100),
    @CustomerDOB DATE,
    @Order_Date DATE
    AS
    DECLARE @CustomerID INT
    
    EXEC getCustomerID
    @Customer_Fname = @Customer_FirstName,
    @Customer_Lname = @Customer_LastName,
    @Customer_DOB = @CustomerDOB,
    @Customer_ID = @CustomerID OUTPUT 

    -- Error handle @CustomerID in case if it's NULL/ empty
    IF @CustomerID IS NULL
        BEGIN     
            PRINT '@CustomerID is empty and will fail in the transaction';
            THROW 51000, '@CustomerID cannot be  NULL', 1;
        END 
        
    BEGIN TRAN G1
        INSERT INTO tblOrder (OrderName, CustomerID, OrderDate)
        VALUES (@Order_Name, @CustomerID, @Order_Date)
        IF @@ERROR <> 0
            BEGIN
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END
        ELSE
    COMMIT TRAN G1
GO

CREATE PROCEDURE newFee
    @FeeName VARCHAR(50),
    @FeeAmount FLOAT,
    @FeeTypeName VARCHAR(50)
    AS
    DECLARE @FeeTypeID INT 
    
    EXEC getFeeTypeID
    @Fee_Type_Name = @FeeTypeName,
    @Fee_Type_ID = @FeeTypeID OUTPUT

    -- Error handle @FeeTypeID in case if it's NULL/ empty
    IF @FeeTypeID IS NULL
        BEGIN 
            PRINT '@FeeTypeID is empty and this will cause the transaction to be failed';
            THROW 51000, '@FeeTypeID cannot be NULL', 1;
        END
    
    BEGIN TRAN G1
        INSERT INTO tblFee (FeeName, FeeTypeID, FeeAmount)
        VALUES (@FeeName, @FeeTypeID, @FeeAmount)
        IF @@ERROR <> 0
            BEGIN
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END
        ELSE
    COMMIT TRAN G1
GO

CREATE PROCEDURE newFlight
    @F_Num INT, 
    @A_Namea VARCHAR(50),
    @FlightType_Name_a VARCHAR(20), 
    @AirportLtrsD VARCHAR(5),
    @AirportLtrsA VARCHAR(5),
    @ArrivalTimea TIME,
    @DepartureTimea TIME,
    @FlightHrs_a INT
    AS
    DECLARE @AID_a INT, @FLTID_a INT, @DEP_IDa INT, @ARR_IDa INT

    EXEC getAirplaneID
    @AName = @A_Namea,
    @AirplaneID = @AID_a OUTPUT

    -- Error handle @AID_a in case if it's NULL/empty
    IF @AID_a IS NULL
    BEGIN 
        PRINT '@AID_a is empty and this will cause the transaction to be failed';
        THROW 51000, '@AID_a cannot be NULL', 1;
    END

    EXEC getFlight_TypeID
    @FlightType_Name = @FlightType_Name_a,
    @FlightType_ID = @FLTID_a OUTPUT

    -- Error handle @FLTID_a in case if it's NULL/empty
    IF @FLTID_a IS NULL
    BEGIN 
        PRINT '@FLTID_a is empty and this will cause the transaction to be failed';
        THROW 51000, '@FLTID_a cannot be NULL', 1;
    END

    EXEC getAirportID
    @AirportLtrs = @AirportLtrsD,
    @AirportID = @DEP_IDa OUTPUT

    -- Error handle @DEP_ID in case if it's NULL/empty
    IF @DEP_IDa IS NULL
    BEGIN 
        PRINT '@DEP_IDa is empty and this will cause the transaction to be failed';
        THROW 51000, '@DEP_IDa cannot be NULL', 1;
    END

    EXEC getAirportID
    @AirportLtrs = @AirportLtrsA,
    @AirportID = @ARR_IDa OUTPUT

    -- Error handle @ARR_IDa in case if it's NULL/empty
    IF @ARR_IDa IS NULL
    BEGIN 
        PRINT '@ARR_IDa is empty and this will cause the transaction to be failed';
        THROW 51000, '@ARR_IDa cannot be NULL', 1;
    END

    BEGIN TRAN T1
        INSERT INTO tblFlight
        (FlightNum, AirplaneID, FlightTypeID, DepartureAirportID, ArrivalAirportID, ArrivalTime, DepartureTime, FlightHrs)
        VALUES 
        (@F_Num, @AID_a, @FLTID_a, @DEP_IDa, @ARR_IDa, @ArrivalTimea, @DepartureTimea, @FlightHrs_a)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newBooking
    @Booking_Name VARCHAR(50),
    @PassengerFname_ VARCHAR(100),
    @PassengerLname_ VARCHAR(100),
    @PassengerBirth_ DATE,
    @F_Num INT, 
    @FeeName_ VARCHAR(50),
    @O_Name VARCHAR(50),
    @bookingAmount FLOAT
    AS 
    DECLARE
    @P_ID INT, @F_ID INT, @Fe_ID INT, @O_ID INT
    
    EXEC getPassengerID
    @Passenger_Fname = @PassengerFname_, 
    @Passenger_Lname = @PassengerLname_, 
    @Passenger_Birth = @PassengerBirth_, 
    @Passenger_ID = @P_ID OUTPUT
    
    IF @P_ID IS NULL 
        BEGIN 
            PRINT '@P_ID cannot be empty - will fail in transaction'; 
            THROW 51100, '@P_ID cannot be null',1; 
        END
    
    EXEC getFlightID
    @FNum = @F_Num,
    @FlightID = @F_ID OUTPUT
    
    IF @F_ID IS NULL 
        BEGIN 
            PRINT '@F_ID cannot be empty - will fail in transaction'; 
            THROW 51200, '@F_ID cannot be null',1; 
        END

    EXEC getFeeID
    @FeeName = @FeeName_,
    @FeeID = @Fe_ID OUTPUT
    
    IF @Fe_ID IS NULL 
        BEGIN 
            PRINT '@Fe_ID cannot be empty - will fail in transaction'; 
            THROW 51200, '@Fe_ID cannot be null',1; 
        END
    
    EXEC getOrderID
    @OrderName = @O_Name,
    @OrderID = @O_ID OUTPUT
    
    IF @O_ID IS NULL 
        BEGIN 
            PRINT '@O_ID cannot be empty - will fail in transaction'; 
            THROW 51200, '@O_ID cannot be null',1; 
        END

    BEGIN TRAN T1
        INSERT INTO tblBooking
        (BookingName, PassengerID, FlightID, FeeID, OrderID, BookingAmount)
        VALUES 
        (@Booking_Name, @P_ID, @F_ID, @Fe_ID, @O_ID, @bookingAmount)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newBookingFee
@Booking_Name VARCHAR(50),
@Fee_Name VARCHAR(50)
AS
DECLARE @BID_ INT, @F_ID_ INT

EXEC getBookingID
@BName = @Booking_Name, 
@BookingID = @BID_ OUTPUT

-- Error handle @PID_ in case if it's NULL/empty
IF @BID_ IS NULL
BEGIN 
    PRINT '@BID_ is empty and this will cause the transaction to be failed';
    THROW 51000, '@BID_ cannot be NULL', 1;
END

EXEC getFeeID
@FeeName = @Fee_Name,
@FeeID = @F_ID_ OUTPUT

-- Error handle @F_ID_ in case if it's NULL/empty
IF @F_ID_ IS NULL
BEGIN 
    PRINT '@F_ID_ is empty and this will cause the transaction to be failed';
    THROW 51000, '@F_ID_ cannot be NULL', 1;
END

BEGIN TRAN T1
    INSERT INTO tblBooking_Fee
    (BookingID, FeeID)
    VALUES 
    (@BID_, @F_ID_)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO

--insert into tblFlight_event--
CREATE PROCEDURE newFlight_Event
    @EventName_ VARCHAR(50), 
    @F_Num INT
    AS
    DECLARE @EID INT, @FID INT

    EXEC getEventID
    @EventName = @EventName_,
    @EventID = @EID OUTPUT

    -- Error handle @EID in case if it's NULL/empty
    IF @EID IS NULL
    BEGIN 
        PRINT '@EID is empty and this will cause the transaction to be failed';
        THROW 51000, '@EID cannot be NULL', 1;
    END

    EXEC getFlightID
    @FNum = @F_Num,
    @FlightID = @FID OUTPUT

    -- Error handle @FID in case if it's NULL/empty
    IF @FID IS NULL
    BEGIN 
        PRINT '@FID is empty and this will cause the transaction to be failed';
        THROW 51000, '@FID cannot be NULL', 1;
    END

    BEGIN TRAN T1
        INSERT INTO tblFlight_Event
        (EventID, FlightID)
        VALUES 
        (@EID, @FID)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newEmployee_Flight
    @EmFname VARCHAR(20), 
    @EmLname VARCHAR(20),
    @EmployeePho VARCHAR(100),
    @Flight_Num_ INT
    AS
    DECLARE @EmID INT, @F_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EmFname,
    @EmployeeLnamey = @EmLname,
    @EmployeePhoney = @EmployeePho,
    @EmployeeIDy = @EmID OUTPUT

    -- Error handle @EmID in case if it's NULL/empty
    IF @EmID IS NULL
    BEGIN 
        PRINT '@EmID is empty and this will cause the transaction to be failed';
        THROW 51000, '@EmID cannot be NULL', 1;
    END

    EXEC getFlightID
    @FNum = @Flight_Num_,
    @FlightID = @F_ID OUTPUT

    -- Error handle @F_ID in case if it's NULL/empty
    IF @F_ID IS NULL
    BEGIN 
        PRINT '@F_ID is empty and this will cause the transaction to be failed';
        THROW 51000, '@F_ID cannot be NULL', 1;
    END

    BEGIN TRAN T1
        INSERT INTO tblEmployee_Flight
        (FlightID, EmployeeID)
        VALUES 
        (@F_ID, @EmID)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO
--###############################################--
--############SYNTHETIC TRANSACTION##############--
--###############################################--
-- wrapper to insert into tblAirplane
CREATE PROCEDURE uspWRAPPER_newAirplane
@Run INT 
AS
DECLARE @ATypeCount INT = (SELECT COUNT(*) FROM tblAirplane_Type)

DECLARE @AName VARCHAR(50), @ATName VARCHAR(50), @Date_Made DATE, @T_Hrs FLOAT

DECLARE @PK INT
DECLARE @Rand INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @ATypeCount + 1)
    SET @AName = (SELECT CONCAT(AM.ManufacturerName,' ', A.AirplaneTypeName, CONVERT(VARCHAR, RAND())) 
                    FROM tblAirplane_Manufacturer AM 
                        JOIN tblAirplane_Type A ON A.ManufacturerID = AM.ManufacturerID
                    WHERE A.AirplaneTypeID = @PK)

    SET @PK = (SELECT RAND() * @ATypeCount + 1)
    SET @ATName = (SELECT AirplaneTypeName FROM tblAirplane_Type WHERE AirplaneTypeID = @PK)

    SET @Date_Made = (SELECT GetDate() - (SELECT Rand() * 1000))

    SET @T_Hrs = (SELECT Rand() * 100000)

    EXEC [newAirplane]
    @A_Name = @AName,
    @AType_Name = @ATName, 
    @Date = @Date_Made, 
    @Hrs = @T_Hrs

    SET @Run = @Run - 1
    END
GO

-- wrapper for customer
CREATE PROCEDURE usp_wrapper_NewCustomer
@Run INT
AS 
DECLARE @CustomerTypeCount INT = (SELECT COUNT(*) FROM tblCustomer_Type)
DECLARE @PeepsCount INT = (SELECT COUNT(*) FROM dbo.PEEPS_Customer_Raw)

DECLARE @CustomerType_Name VARCHAR(100)

DECLARE @CustomerFname VARCHAR(100), @CustomerLname VARCHAR(100), @CustomerPhone VARCHAR(100),
        @CustomerEmail VARCHAR(100), @CustomerStreetAddr VARCHAR(100), @CustomerCity VARCHAR(100),
        @CustomerState VARCHAR(100), @CustomerZip VARCHAR(100), @CustomerDOB DATE

DECLARE @PK INT 
DECLARE @Rand INT

WHILE @Run > 0 
    BEGIN
        SET @PK = (SELECT RAND()* @CustomerTypeCount + 1)
        SET @CustomerType_Name = (SELECT CustomerTypeName FROM tblCustomer_Type WHERE CustomerTypeID = @PK)

        SET @Rand = (SELECT RAND() * 100)
        SET @CustomerFname = (SELECT CustomerFName FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerLname = (SELECT CustomerLName FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerPhone = (SELECT PhoneNum FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerEmail = (SELECT Email FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerStreetAddr = (SELECT CustomerAddress FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerCity = (SELECT CustomerCity FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerState = (SELECT CustomerState FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerZip = (SELECT CustomerZIP FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerDOB = (SELECT DateOfBirth FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)

    EXEC [newCustomer]
    @Customer_Fname = @CustomerFname,
    @Customer_Lname = @CustomerLname,
    @Customer_Phone = @CustomerPhone, 
    @Customer_DOB = @CustomerDOB,
    @Customer_Email = @CustomerEmail,
    @Customer_Street_Addr = @CustomerStreetAddr, 
    @Customer_City = @CustomerCity,
    @Customer_State = @CustomerState,
    @Customer_Zip = @CustomerZip, 
    @CustomerTypeName = @CustomerType_Name

    SET @Run = @Run - 1
END
GO

CREATE PROCEDURE uspWRAPPER_rongtNewEmployeePosition
    @Run INT
    AS
    DECLARE @EMPLCount INT = (SELECT COUNT(*) FROM tblEMPLOYEE)
    DECLARE @POSITIONCount INT = (SELECT COUNT(*) FROM tblPOSITION)

    DECLARE @EmployeeFnamey VARCHAR(100),
            @EmployeeLnamey VARCHAR(100),
            @EmployeePhoney VARCHAR(100)
    DECLARE @PositionNamey VARCHAR(100)

    DECLARE @PK INT, @Rand INT

    WHILE @Run > 0
        BEGIN
            SET @PK = (SELECT RAND() * @EMPLCount + 1)
            SET @EmployeeFnamey = (SELECT EmployeeFname FROM tblEMPLOYEE WHERE EmployeeID = @PK)
            SET @EmployeeLnamey = (SELECT EmployeeLname FROM tblEMPLOYEE WHERE EmployeeID = @PK)
            SET @EmployeePhoney = (SELECT EmployeePhone FROM tblEMPLOYEE WHERE EmployeeID = @PK)

            SET @PK = (SELECT RAND() * @POSITIONCount + 1)
            SET @PositionNamey = (SELECT PositionName FROM tblPOSITION WHERE PositionID = @PK)

            EXEC newEmployeePosition
            @EF = @EmployeeFnamey,
            @EL = @EmployeeLnamey,
            @EP = @EmployeePhoney,
            @PN = @PositionNamey

            SET @Run = @Run - 1
    END
GO

CREATE PROCEDURE uspWRAPPER_newEvent
    @Run INT
    AS
    DECLARE @ETCount INT = (SELECT COUNT(*) FROM tblEvent_Type)

    DECLARE @ETName VARCHAR(50),
            @EDesc VARCHAR(100), 
            @EName VARCHAR(50)

    DECLARE @PK INT, @Rand INT

    WHILE @Run > 0
        BEGIN
            SET @PK = (SELECT RAND() * @ETCount + 1)
            SET @ETName = (SELECT EventTypeName FROM tblEvent_Type WHERE EventTypeID = @PK)
            SET @EDesc = (SELECT EventTypeDescr FROM tblEvent_Type WHERE EventTypeID = @PK)

            SET @EName = CONCAT(@ETName, ' ', CONVERT(VARCHAR, RAND() + 100))

            EXEC [newEvent]
            @EventT_Name = @ETName,
            @Event_Name = @EName,
            @Event_Descr = @EDesc

            SET @Run = @Run - 1
    END
GO

CREATE PROCEDURE uspWrapper_NewOrder
    @Run INT 
    AS
    DECLARE @CustCount INT =  (SELECT COUNT(*) FROM tblCustomer)
    DECLARE @CustomerFirstName VARCHAR(100), @CustomerLastName VARCHAR(100), @CustomerBirthdate DATE 
    DECLARE @OrderDate DATE, @OrderName VARCHAR(50)

    DECLARE @PK INT 
    DECLARE @Rand INT  

    WHILE @Run > 0 
    BEGIN 
        SET @PK = (SELECT RAND() * @CustCount + 1)
        SET @CustomerFirstName = (SELECT CustomerFname FROM tblCustomer WHERE CustomerID = @PK)
        SET @CustomerLastName = (SELECT CustomerLname FROM tblCustomer WHERE CustomerID = @PK)
        SET @CustomerBirthdate = (SELECT CustomerDOB FROM tblCustomer WHERE CustomerID = @PK)
    
        SET @OrderDate = (SELECT GetDate() - (SELECT Rand() * 10000))
        SET @OrderName = CONCAT(@CustomerLastName, @OrderDate)

    EXEC [newOrder]
    @Order_Name = @OrderName,
    @Customer_FirstName = @CustomerFirstName,
    @Customer_LastName = @CustomerLastName,
    @CustomerDOB = @CustomerBirthdate,
    @Order_Date = @OrderDate 

    SET @Run = @Run - 1
END
GO

CREATE PROCEDURE usp_Wrapper_NewFee
@Run INT 
AS 
DECLARE @FeeTypeCount INT = (SELECT COUNT(*) FROM tblFee_Type)
DECLARE @FeeType_Name VARCHAR(100)

DECLARE @Fee_Name VARCHAR(100), @Fee_Amount FLOAT

DECLARE @PK INT
DECLARE @Rand INT

WHILE @Run > 0
BEGIN 
    SET @PK = (SELECT RAND()* @FeeTypeCount + 1)
    SET @FeeType_Name = (SELECT FeeTypeName FROM tblFee_Type WHERE FeeTypeID = @PK)

    SET @Rand = (SELECT RAND()* 100)

    SET @Fee_Amount = (SELECT ROUND(RAND() * 100, 2))

    SET @Fee_Name = (CASE 
    WHEN @Rand < 10 THEN 'Additional checked bag'
    WHEN @Rand BETWEEN 11 AND 15 THEN 'Overweight bag'
    WHEN @Rand BETWEEN 16 AND 20 THEN 'Oversize bag'
    WHEN @Rand BETWEEN 21 AND 25 THEN 'Call center service charge'
    WHEN @Rand BETWEEN 26 AND 30 THEN 'Paper itinerary mailing service charge'
    WHEN @Rand BETWEEN 31 AND 35 THEN 'Partner award booking fee'
    WHEN @Rand BETWEEN 36 AND 40 THEN 'Unaccompanied minor service fee'
    WHEN @Rand BETWEEN 41 AND 45 THEN 'Pet travel fee'
    WHEN @Rand BETWEEN 46 AND 50 THEN 'Ticket receipt research fee'
    WHEN @Rand BETWEEN 51 AND 55 THEN 'Same day confirmed changes'
    WHEN @Rand BETWEEN 56 AND 60 THEN 'Cancellation fee'
    WHEN @Rand BETWEEN 61 AND 65 THEN 'Premium class seats'
    WHEN @Rand BETWEEN 66 AND 70 THEN 'First class paid upgrades'
    WHEN @Rand BETWEEN 71 AND 75 THEN 'Inflight meals and snack boxes'
    WHEN @Rand BETWEEN 76 AND 80 THEN 'Beer, wine, and cocktails'
    WHEN @Rand BETWEEN 81 AND 85 THEN 'Inflight WiFi'
    WHEN @Rand BETWEEN 86 AND 90 THEN 'Left on board item return fee'
    ELSE 'No fee'
    END)

EXEC [newFee]
@FeeName = @Fee_Name,
@FeeAmount = @Fee_Amount,
@FeeTypeName = @FeeType_Name

SET @Run = @Run - 1
END
GO 

--wrapper for Flight
CREATE PROCEDURE uspWRAPPER_newFlight
@Run INT 
AS
DECLARE @AirplaneCount INT = (SELECT COUNT(*) FROM tblAirplane)
DECLARE @FTypeCount INT = (SELECT COUNT(*) FROM tblFlight_Type)
DECLARE @airCount INT = (SELECT COUNT(*) FROM tblAirport)
DECLARE @TimeCount INT = (SELECT COUNT(*) FROM FlightTime)

DECLARE @FL_Num INT, @Air_Name VARCHAR(50), @FlightTypeName VARCHAR(20), @AirportLtrs_D VARCHAR(5),
@AirportLtrs_A VARCHAR(5), @ArrTime CHAR(10), @DepTime CHAR(10), @FltHours FLOAT

DECLARE @PK INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @AirplaneCount + 1)
    SET @Air_Name = (SELECT AirplaneName FROM tblAirplane WHERE AirplaneID = @PK)
    SET @PK = (SELECT RAND() * @FTypeCount + 1)
    SET @FlightTypeName = (SELECT FlightTypeName FROM tblFlight_Type WHERE FlightTypeID = @PK)

    SET @PK = (SELECT RAND() * @airCount + 1)
    SET @AirportLtrs_D = 'SEA'
    SET @AirportLtrs_A = (SELECT AirportLetters FROM tblAirport WHERE AirportID = @PK)
    SET @FL_Num = (SELECT AreaCode FROM dbo.PEEPS_Customer_Raw  WHERE CustomerID = @PK)

    SET @PK = (SELECT RAND() * @TimeCount + 1)
    SET @ArrTime = (SELECT ArrivalTime FROM FlightTime WHERE RowID = @PK)
    SET @DepTime = (SELECT DepartureTime FROM FlightTime WHERE RowID = @PK)
    SET @FltHours = (SELECT RAND() * 9 + 1)

    EXEC [newFlight]
    @F_Num = @FL_Num,
    @A_Namea = @Air_Name,
    @FlightType_Name_a = @FlightTypeName,
    @AirportLtrsD = @AirportLtrs_D,
    @AirportLtrsA = @AirportLtrs_A,
    @ArrivalTimea = @ArrTime,
    @DepartureTimea = @DepTime,
    @FlightHrs_a = @FltHours

SET @Run = @Run - 1
END
GO 

--wrapper for booking
CREATE PROCEDURE uspWRAPPER_newBooking
@Run INT 
AS
DECLARE @PassengerCount INT = (SELECT COUNT(*) FROM tblPassenger)
DECLARE @FlightCount INT = (SELECT COUNT(*) FROM tblFlight)
DECLARE @FeeCount INT = (SELECT COUNT(*) FROM tblFee)
DECLARE @OrderCount INT = (SELECT COUNT(*) FROM tblOrder)

DECLARE @BName VARCHAR(50), @PFname VARCHAR(20), @PLname VARCHAR(20), @PDOB DATE, @FNum INT, @FeeN VARCHAR(50), 
@OName VARCHAR(50), @BAmount FLOAT

DECLARE @PK INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @PassengerCount + 1)
    SET @PFname = (SELECT PassengerFname FROM tblPassenger WHERE PassengerID = @PK)
    SET @PLname = (SELECT PassengerLname FROM tblPassenger WHERE PassengerID = @PK)
    SET @PDOB = (SELECT PassengerDOB FROM tblPassenger WHERE PassengerID = @PK)

    SET @PK = (SELECT RAND() * @FlightCount + 1)
    SET @FNum = (SELECT FlightNum FROM tblFlight WHERE FlightID = @PK)

    SET @PK = (SELECT RAND() * @FeeCount + 1)
    SET @FeeN = (SELECT FeeName FROM tblFee WHERE FeeID = @PK)

    SET @PK = (SELECT RAND() * @OrderCount + 1)
    SET @OName = (SELECT OrderName FROM tblOrder WHERE OrderID = @PK)
    SET @BAmount = (SELECT AreaCode FROM PEEPS_Customer_Raw WHERE CustomerID = @PK)

    SET @BName = CONCAT(@PLname, ' ', CONVERT(VARCHAR, @BAmount))

    EXEC [newBooking]
    @Booking_Name = @BName,
    @PassengerFname_ = @PFname,
    @PassengerLname_ = @PLname,
    @PassengerBirth_ = @PDOB,
    @F_Num = @FNum,
    @FeeName_ = @FeeN,
    @O_Name = @OName,
    @bookingAmount = @BAmount

    SET @Run = @Run - 1
END
GO

CREATE PROCEDURE uspWRAPPER_newBookingFee
@Run INT 
AS
DECLARE @BookingCount INT = (SELECT COUNT(*) FROM tblBooking)
DECLARE @FeeCount INT = (SELECT COUNT(*) FROM tblFee)

DECLARE @Booking_N VARCHAR(50), @Fee_N VARCHAR(50)

DECLARE @PK INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @BookingCount + 1)
    SET @Booking_N = (SELECT BookingName FROM tblBooking WHERE BookingID = @PK)

    SET @PK = (SELECT RAND() * @FeeCount + 1)
    SET @Fee_N = (SELECT FeeName FROM tblFee WHERE FeeID = @PK)

    EXEC [newBookingFee]
    @Booking_Name = @Booking_N, 
    @Fee_Name = @Fee_N

    SET @Run = @Run - 1
END
GO 

--wrapper for Flight_event
CREATE PROCEDURE uspWRAPPER_newFlight_Event
    @Run INT 
    AS
    DECLARE @EventCount INT = (SELECT COUNT(*) FROM tblEvent)
    DECLARE @FlightCount INT = (SELECT COUNT(*) FROM tblFlight)

    DECLARE @EName VARCHAR(50), @Fli_Num INT

    DECLARE @PK INT

    WHILE @Run > 0 
        BEGIN

        SET @PK = (SELECT RAND() * @EventCount + 1)
        SET @EName = (SELECT EventName FROM tblEvent WHERE EventID = @PK)

        SET @PK = (SELECT RAND() * @FlightCount + 1)
        SET @Fli_Num = (SELECT FlightNum FROM tblFlight WHERE FlightID = @PK)

        EXEC [newFlight_Event]
        @EventName_ = @EName, 
        @F_Num = @Fli_Num

        SET @Run = @Run - 1
    END
GO

CREATE PROCEDURE uspWRAPPER_newemployee_flight
@Run INT 
AS
DECLARE @EmployeeCount INT = (SELECT COUNT(*) FROM tblEmployee)
DECLARE @FlightCount INT = (SELECT COUNT(*) FROM tblFlight)

DECLARE @EmFname_ VARCHAR(20), @EmLname_ VARCHAR(20), @EmployeePho_ VARCHAR(100), @FlightNum_ INT


DECLARE @PK INT

    WHILE @Run > 0 
        BEGIN

        SET @PK = (SELECT RAND() * @EmployeeCount + 1)
        SET @EmFname_ = (SELECT EmployeeFname FROM tblEmployee WHERE EmployeeID = @PK)
        SET @EmLname_ = (SELECT EmployeeLname FROM tblEmployee WHERE EmployeeID = @PK)
        SET @EmployeePho_ = (SELECT EmployeePhone FROM tblEmployee WHERE EmployeeID = @PK)

        SET @PK = (SELECT RAND() * @FlightCount + 1)
        SET @FlightNum_ = (SELECT flightnum FROM tblFlight WHERE FlightID = @PK)

        EXEC [newEmployee_Flight]
        @EmFname = @EmFname_,
        @EmLname = @EmLname_,
        @EmployeePho = @EmployeePho_,
        @Flight_Num_ = @Flightnum_
        
        SET @Run = @Run - 1
END
GO

-- insert 100 rows into tblAirplane
EXEC uspWRAPPER_newAirplane @Run = 100;

-- insert 100 rows into tblCustomer
EXEC usp_wrapper_NewCustomer @Run = 100; 

-- insert into tblEmployee_Position
EXEC uspWRAPPER_rongtNewEmployeePosition @Run = 100;

-- insert into tblEvent
EXEC uspWRAPPER_newEvent @Run = 100;

-- insert into tblOrder
EXEC uspWrapper_NewOrder @Run = 100;

-- insert into tblFee
EXEC usp_Wrapper_NewFee @Run = 50;

-- insert into tblFlight
EXEC uspWRAPPER_newFlight @Run = 500;

-- insert into tblBooking
EXEC uspWRAPPER_newBooking @Run = 100;

-- insert into tblBookingFee
EXEC uspWRAPPER_newBookingFee @Run = 100;


-- insert into tblFlight_Event
EXEC uspWRAPPER_newFlight_Event @Run = 100;


EXEC uspWRAPPER_newemployee_flight @Run = 100;

go
--###########################################--
--############CHECK CONSTRAINTS##############--
--###########################################--
-- must be 18 by order date to make an order if from Washington
CREATE FUNCTION fn_CheckAgeAndState() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT O.OrderID
        FROM tblOrder O
            JOIN tblCustomer C ON C.CustomerID = O.CustomerID
        WHERE C.CustomerState = 'Washington'
            AND C.CustomerDOB < DATEADD(Year, -18, O.OrderDate)
        GROUP BY O.OrderID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblOrder with nocheck 
ADD CONSTRAINT CK_CheckAgeAndState
CHECK (dbo.fn_CheckAgeAndState() = 0)
GO

-- departure airport must be Seattle
CREATE FUNCTION fn_DepAiportSeattle() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT F.DepartureAirportID
        FROM tblFlight F
            JOIN tblAirport A ON A.AirportID = f.DepartureAirportID
        WHERE A.AirportLetters = 'SEA'
        GROUP BY F.DepartureAirportID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblFlight with nocheck 
ADD CONSTRAINT CK_DepAirportSeattle
CHECK (dbo.fn_DepAiportSeattle() = 0)
GO

--Passengers who are younger than 14 years old cannot be in a flight going to Alaska for the Airbus airplane manufacturer. */
CREATE FUNCTION fn_No14YearOldPassengersInAirbusFlightToAlaska()
RETURNS INT
AS 
BEGIN 

DECLARE @RET INT = 0
    IF EXISTS (SELECT P.PassengerID, P.PassengerFname, P.PassengerLname, P.PassengerDOB
        FROM tblPassenger P 
            JOIN tblBooking B ON P.PassengerID  = B.PassengerID
            JOIN tblFlight F ON B.FlightID = F.FlightID
            JOIN tblAirport A ON F.ArrivalAirportID = A.AirportID
            JOIN tblAirplane AP ON F.AirplaneID = AP.AirplaneID
            JOIN tblAirplane_Type AT ON AP.AirplaneTypeID = AT.AirplaneTypeID
            JOIN tblAirplane_Manufacturer AM ON AT.ManufacturerID = AM.ManufacturerID
    WHERE AirportLetters = 'ANC'
    AND AM.ManufacturerName = 'Airbus'
    AND P.PassengerDOB < DATEADD(Year, -14, GETDATE()) )
    BEGIN 
        SET @RET = 1
    END 
RETURN @RET 
END 
GO 

ALTER TABLE tblBooking with NOCHECK
ADD CONSTRAINT CK_No14YearOldPassengers
CHECK (dbo.fn_No14YearOldPassengersInAirbusFlightToAlaska()=0)
GO

--Employees whose last names start with A through H cannot serve on a flight flying to Alaska. (working) */
CREATE FUNCTION fn_EmployeesCannotServeFlightToAlaska()
RETURNS INT
AS 
BEGIN 

DECLARE @RET INT = 0
    IF EXISTS (SELECT E.EmployeeFname, E.EmployeeLname 
        FROM tblEmployee_Flight EF
            JOIN tblFlight F ON EF.FlightID = F.FlightID
            JOIN tblAirport A ON F.ArrivalAirportID = A.AirportID
            JOIN tblEmployee E ON EF.EmployeeID = E.EmployeeID
    WHERE E.EmployeeLname BETWEEN 'A' AND 'H'   
    AND A.AirportLetters = 'ANC')
    BEGIN 
        SET @RET = 1
    END 
RETURN @RET 
END 
GO 

ALTER TABLE tblEmployee_Flight with NOCHECK
ADD CONSTRAINT CK_EmployeesCannotServeFlightToAlaskaDueToLastName
CHECK (dbo.fn_EmployeesCannotServeFlightToAlaska()=0)
GO 

--Arival time must be greater than departure time
CREATE FUNCTION fn_arivallAndDept() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT f.FlightID FROM tblflight f
        WHERE f.DepartureTime > f.ArrivalTime
        GROUP BY f.FlightID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblflight with nocheck 
ADD CONSTRAINT CK_arivallAndDept
CHECK (dbo.fn_arivallAndDept() = 0)
GO

--booking amount must be larger than fee amount
CREATE FUNCTION fn_bookingAndFee() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT b.bookingID
        FROM tblBooking b
            JOIN tblFee f ON f.FeeID = b.feeID
        WHERE f.FeeAmount > b.BookingAmount
        GROUP BY b.bookingID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblbooking with nocheck 
ADD CONSTRAINT CK_fn_arivallAndDept
CHECK (dbo.fn_arivallAndDept() = 0)
GO

--Checks employees age
CREATE FUNCTION fn_CheckEmployeeAge() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT E.EmployeeDOB
        FROM tblEmployee E WHERE E.EmployeeDOB < DATEADD(Year, -16, GetDate()))
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblEMPLOYEE with nocheck 
ADD CONSTRAINT CK_CheckEmployeeAge
CHECK (dbo.fn_CheckEmployeeAge() = 0)
GO

-- check if the employee age is above 16
CREATE FUNCTION fn_CheckOrderinBooking() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT *
        FROM tblBooking B
            join tblORDER O ON O.OrderID = B.OrderID
            having COUNT(*) > 1000)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblOrder with nocheck 
ADD CONSTRAINT CK_CheckOrderinBooking
CHECK (dbo.fn_CheckOrderinBooking() = 0)
GO
--###########################################--
--############COMPUTED COLUMNS###############--
--###########################################--
-- number of bookings for each order
CREATE FUNCTION fn_numBookingsPerOrder()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT COUNT(B.BookingID) 
    FROM tblBooking B 
        JOIN tblOrder O ON O.OrderID = B.BookingID
    GROUP BY O.OrderID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblOrder 
ADD BookingsInOrder AS (dbo.fn_numBookingsPerOrder())
GO

-- total number of passengers on a flight
CREATE FUNCTION fn_numPassengers()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(B.PassengerID) 
    FROM tblBooking B 
        JOIN tblFlight F ON F.FlightID = B.FlightID
    GROUP BY F.FlightID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblFlight
ADD numPassengers AS (dbo.fn_numPassengers())
GO

--Total number of customers booking Airbus flights in each state. */
CREATE FUNCTION fn_TotalNumCustomersOrderAirbusFlightsInEachState(@PK INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT COUNT(C.CustomerID) AS TotalNumCustomers
    FROM tblCustomer C
        JOIN tblOrder O ON C.CustomerID = O.OrderID
        JOIN tblBooking B ON O.OrderID = B.OrderID
        JOIN tblFlight F ON B.FlightID = F.FlightID
        JOIN tblAirplane A ON F.AirplaneID = A.AirplaneID
        JOIN tblAirplane_Type AT ON A.AirplaneTypeID = AT.AirplaneTypeID
        JOIN tblAirplane_Manufacturer AM ON AT.ManufacturerID = AM.ManufacturerID
    WHERE O.OrderID = @PK
    AND AM.ManufacturerName = 'Airbus'
    GROUP BY C.CustomerID, C.CustomerState) 
RETURN @RET
END 
GO 

ALTER TABLE tblOrder
ADD TotalNumCustomers AS (dbo.fn_TotalNumCustomersOrderAirbusFlightsInEachState(OrderID))
GO

--Total booking amount per order for the order table for customers whose last names start with A through H. */
CREATE FUNCTION fn_TotalBookingAmount_ForCustomersLastNamesStartWithAThroughH(@PK INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT SUM(B.BookingAmount) AS TotalBookingAmount
    FROM tblBooking B
        JOIN tblOrder O ON B.OrderID = B.OrderID
        JOIN tblCustomer C ON O.CustomerID = C.CustomerID
    WHERE O.OrderID = @PK
    AND C.CustomerLname BETWEEN 'A' AND 'H')
RETURN @RET
END 
GO

ALTER TABLE tblOrder
ADD TotalBookingAmount AS (dbo.fn_TotalBookingAmount_ForCustomersLastNamesStartWithAThroughH(OrderID))
GO

--Amount of cancelliation and delays
CREATE FUNCTION fn_DelaysAndCancelled()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(FE.FlightEventID) 
    FROM tblFlight_Event fe
        JOIN tblEvent e ON e.EventID = fe.EventID
        JOIN tblEvent_Type et ON et.EventTypeID = e.EventTypeID
    GROUP BY e.EventTypeID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblEvent_Type
ADD numCancelledAndDelayed AS (dbo.fn_DelaysAndCancelled())
GO

--Amount of Airplanes per manufacture
CREATE FUNCTION fn_numAirplanesType()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(a.AirplaneID) 
    FROM tblAirplane a
        JOIN tblAirplane_Type att ON att.AirplaneTypeID = a.AirplaneTypeID
    GROUP BY att.AirplaneTypeID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblAirplane_Type
ADD Airplanes_per_tpye AS (dbo.fn_numAirplanesType())
GO

-- number of flights per city 
CREATE FUNCTION fn_Amount_Flight_per_City(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
    SELECT Count(F.FlightID) 
        FROM tblFlight F
            JOIN tblAirport A ON A.AirportID = F.ArrivalAirportID
            JOIN tblCity C ON A.CityID = C.CityID
            WHERE C.CityID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblCity
ADD Amount_Flight AS (dbo.fn_Amount_Flight_per_City(CityID))
GO

-- number of employees per position 
CREATE FUNCTION fn_Amount_Employee_per_Position(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
    SELECT Count(EP.EmployeeID) 
        FROM tblEmployee_Position EP
            JOIN tblPosition P ON P.PositionID = EP.PositionID
            JOIN tblEmployee E ON E.EmployeeID = EP.EmployeeID
            WHERE P.PositionID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblPosition
ADD Amount_Employee AS (dbo.fn_Amount_Employee_per_Position(PositionID))
GO

--###########################################--
--###################VIEWS###################--
--###########################################--
-- top 100 airplanes whose planes have flown the most hours their type and manufacturer
CREATE VIEW vwManu_Airplane_Hrs
AS
SELECT TOP (100) Aty.AirplaneTypeName, M.ManufacturerName, A.TotalFlightHrs,
RANK() OVER (ORDER BY A.TotalFlightHrs DESC) AS RankFlightHrs
FROM tblAirplane_Manufacturer M
    JOIN tblAirplane_Type ATy ON Aty.ManufacturerID = M.ManufacturerID
    JOIN tblAirplane A ON A.AirplaneTypeID = Aty.AirplaneTypeID
GROUP BY M.ManufacturerName, A.TotalFlightHrs, Aty.AirplaneTypeName, A.TotalFlightHrs
ORDER BY RankFlightHrs 
GO 
 
-- top 100 customers based on money spent booking flights
CREATE VIEW vwCustomer_Spending
AS
SELECT TOP (100) CONCAT(C.CustomerFname, ' ', C.CustomerLname) AS CustomerName, SUM(B.BookingAmount) AS TotalSpending
FROM tblBooking B 
    JOIN tblOrder O ON O.OrderID = B.OrderID
    JOIN tblCustomer C ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
ORDER BY TotalSpending DESC
GO 

--Get the total number of orders by each customer type.
CREATE VIEW vwTotalNum_Orders_By_Customer_Type
AS 
SELECT CT.CustomerTypeID, CT.CustomerTypeName, COUNT(O.OrderID) AS NumTotalOrders
FROM tblCustomer_Type CT
    JOIN tblCustomer C ON CT.CustomerTypeID = C.CustomerTypeID
    JOIN tblOrder O ON C.CustomerID = O.CustomerID
GROUP BY CT.CustomerTypeID, CT.CustomerTypeName
GO

--Get how many of the delays are related to severe weather condition.
CREATE ViEW vwSevere_Weather_Conditions_Delays
AS
SELECT E.EventID, E.EventName, COUNT(FE.FlightID) AS NumDelays
FROM tblFlight_Event FE
    JOIN tblFlight F ON FE.FlightID = F.FlightID
    JOIN tblEvent E ON FE.EventID = E.EventID
    JOIN tblEvent_Type ET ON E.EventTypeID = ET.EventTypeID
WHERE ET.EventTypeName = 'Delayed Flight'
GROUP BY E.EventID, E.EventName
GO

--Most frequent event to happen
CREATE VIEW vwMost_Frequent_Events
AS
SELECT TOP(5) E.eventName, COUNT(*) AS EventAmount
FROM tblEvent E
    JOIN tblFlight_Event FE ON FE.EventID = E.EventID
GROUP BY E.eventName
ORDER BY EventAmount DESC
GO 

-- what airports fly most frequently into Seattle
CREATE VIEW vwMost_Frequent_To_Seattle
AS
SELECT TOP(10) A.AirportLetters, COUNT(*) AS NumFlights
FROM tblAirport A
    JOIN tblFlight F ON F.DepartureAirportID = A.AirportID
GROUP BY A.AirportLetters
ORDER BY NumFlights DESC
GO 

-- which states fly to Hawaii
CREATE VIEW view_flight_to_Hawaii
AS
SELECT C.CityName, S.StateName, COUNT(*) AS NUM_FLIGHT
    FROM tblFlight F
        JOIN tblAirport A ON A.AirportID = F.ArrivalAirportID
        JOIN tblCity C ON A.CityID = C.CityID
        JOIN tblState S ON S.StateID = C.StateID
        WHERE S.StateName = 'Hawaii'
    GROUP BY S.StateName,  C.CityName
GO

-- Number of each type of airplanes for each manufacturer
CREATE VIEW view_airplanes_per_manufacture
AS
SELECT AM.ManufacturerName, ATP.AirplaneTypeName, COUNT(A.AirplaneID) AS airplane_count
    FROM tblAirplane A
    JOIN tblAirplane_Type ATP ON A.AirplaneTypeID = ATP.AirplaneTypeID
    JOIN tblAirplane_Manufacturer AM ON ATP.ManufacturerID = AM.ManufacturerID
    GROUP BY AM.ManufacturerName, ATP.AirplaneTypeName
GO