USE MASTER;

GO

DROP DATABASE IF EXISTS CoastAndCanopy;

GO

CREATE DATABASE CoastAndCanopy;

GO

USE CoastAndCanopy;

DROP PROCEDURE IF EXISTS create_tables

GO

CREATE PROCEDURE create_tables
AS
	BEGIN

		DROP TABLE IF EXISTS Address;

			CREATE TABLE [Address]
			(
				AddressId		INT				PRIMARY KEY,
				StreetAddress	VARCHAR(50)		NOT NULL,
				Suburb			VARCHAR(50)		,
				City			VARCHAR(50)		NOT NULL,
				PostCode		VARCHAR(50)		NOT NULL
			);

		DROP TABLE IF EXISTS ContactInfo;

			CREATE TABLE ContactInfo
			(
				ContactInfoId	INT				PRIMARY KEY,
				Phone			VARCHAR(50)		NOT NULL,
				Email			VARCHAR(50)		NOT NULL
			);

		DROP TABLE IF EXISTS Subscriber;

			CREATE TABLE Subscriber
			(
				SubscriberId	INT				PRIMARY KEY,
				Organisation	VARCHAR(50)		NOT NULL,
				AddressId		INT				NOT NULL,
				ContactInfoId	INT				NOT NULL,
			);

		DROP TABLE IF EXISTS [Zone];

			CREATE TABLE [Zone]
			(
				ZoneId			INT				PRIMARY KEY,
				ContractId		INT				NOT NULL,
				[Name]			VARCHAR(50)		,
				Hectares		DECIMAL(10,2)	NOT NULL,
				Latitude		DECIMAL(8, 6)	NOT NULL,
				Longitude		DECIMAL(9, 6)	NOT NULL
			);

		DROP TABLE IF EXISTS SensorReading;

			CREATE TABLE SensorReading
			(
				HarvId			INT				NOT NULL,
				[TimeStamp]		DateTime		NOT NULL,
				ContractId		INT						,
				Latitude		DECIMAL(8, 6)	NOT NULL,
				Longitude		DECIMAL(9, 6)	NOT NULL,
				Altitude		DECIMAL(10,2)	NOT NULL,
				Humidity		DECIMAL(5, 2)	,
				Salinity		DECIMAL(5, 2)	,
				Turbidity		DECIMAL(10, 4)	,
				Temperature		DECIMAL(5, 2)	,
				OrganicSpectral	VARCHAR(255)	,
				AmbientLight	DECIMAL(10, 2)	,
				PRIMARY KEY		(HarvId, [TimeStamp])
			);

		DROP TABLE IF EXISTS HarvContract;

			CREATE TABLE HarvContract
			(
				HarvId			INT				NOT NULL,
				ContractId		INT				NOT NULL,
				AllocatedOn		DATE			NOT NULL,
				ServiceType		VARCHAR(50)		NOT NULL,
				PRIMARY KEY		(HarvId, ContractId)
			);

		DROP TABLE IF EXISTS HarvZone;

			CREATE TABLE HarvZone
			(
				HarvId			INT				NOT NULL,
				ZoneId			INT				NOT NULL,
				LastVisited		DATE			,
				PRIMARY KEY		(HarvId, ZoneId)
			);

		DROP TABLE IF EXISTS Supplier;

			CREATE TABLE Supplier
			(
				SupplierId		INT				PRIMARY KEY,
				AddressId		INT				NOT NULL,
				ContactInfoId	INT				NOT NULL,
				[Name]			VARCHAR(50)		NOT NULL
			);

		DROP TABLE IF EXISTS Employee;

			CREATE TABLE Employee
			(
				EmployeeId		INT				PRIMARY KEY,
				AddressId		INT				NOT NULL,
				ContactInfoId	INT				NOT NULL,
				FirstName		VARCHAR(50)		NOT NULL,
				LastName		VARCHAR(50)		NOT NULL,
				StartDate		DATE			NOT NULL
			);

		DROP TABLE IF EXISTS Director;

			CREATE TABLE Director
			(
				EmployeeId		INT				PRIMARY KEY,
				BoardPosition	VARCHAR(50)		
			);

		DROP TABLE IF EXISTS Salesperson;

			CREATE TABLE Salesperson
			(
				EmployeeId		INT				PRIMARY KEY,
				BoothLocation	VARCHAR(50)
			);

		DROP TABLE IF EXISTS AdminExecutive;

			CREATE TABLE AdminExecutive
			(
				EmployeeId		INT				PRIMARY KEY,
				DateAppotinted	DATE
			);

		DROP TABLE IF EXISTS TechnicalEngineer;

			CREATE TABLE TechnicalEngineer
			(
				EmployeeId		INT				PRIMARY KEY,
				Specialization	VARCHAR(50)
			);	
	
		DROP TABLE IF EXISTS ThirdPartyMaintainer;

			CREATE TABLE ThirdPartyMaintainer
			(
				EmployeeId		INT				PRIMARY KEY,
				Certification	VARCHAR(50)		,
				CompanyName		VARCHAR(50)		NOT NULL
			);

		DROP TABLE IF EXISTS [Contract];

			CREATE TABLE [Contract]
			(
				ContractId		INT				PRIMARY KEY,
				SubscriberId	INT				NOT NULL,
				BaseMonthlyFee	DECIMAL(10, 2)	NOT NULL,
				PayFrequency	VARCHAR(50)		NOT NULL,
				DiscountPct		DECIMAL(5, 2)	,
				StartDate		DATE			NOT NULL
			);

		DROP TABLE IF EXISTS [Standard];

			CREATE TABLE [Standard]
			(
				ContractId		INT				PRIMARY KEY,
				EmployeeId		INT				NOT NULL
			);

		DROP TABLE IF EXISTS Gold;

			CREATE TABLE Gold
			(
				ContractId		INT				PRIMARY KEY,
				EmployeeId		INT				NOT NULL
			);

		DROP TABLE IF EXISTS Platinum;

			CREATE TABLE Platinum
			(
				ContractId		INT				PRIMARY KEY,
				EmployeeId		INT				NOT NULL
			);

		DROP TABLE IF EXISTS SuperPlatinum;

			CREATE TABLE SuperPlatinum
			(
				ContractId		INT				PRIMARY KEY,
				EmployeeId		INT				NOT NULL
			);

		DROP TABLE IF EXISTS Harv;

			CREATE TABLE Harv
			(
				HarvId			INT				PRIMARY KEY,
				ContractId		INT				,
				[Configuration]	VARCHAR(50)		NOT NULL,
				DeploymentDate	DATE			,
				DecomissionDate	DATE			,
				EmployeeId		INT				NOT NULL
			);

		DROP TABLE IF EXISTS SupplierPart;

			CREATE TABLE SupplierPart
			(
				SupplierId		INT				NOT NULL,
				PartId			INT				NOT NULL,
				PurchaseCost	DECIMAL(10, 2)	NOT NULL,
				PRIMARY KEY	(SupplierId, PartId)
			);

		DROP TABLE IF EXISTS Part;

			CREATE TABLE Part
			(
				PartId			INT				PRIMARY KEY,
				[Name]			VARCHAR(50)		NOT NULL,
				MaintenanceSch	VARCHAR(50)		NOT NULL
			);

		DROP TABLE IF EXISTS PartHarv;

			CREATE TABLE PartHarv
			(
				PartId			INT				NOT NULL,
				HarvId			INT				NOT NULL,
				LastMaintenance	DATE			,
				PRIMARY KEY (PartId, HarvId)
			);

		DROP TABLE IF EXISTS MaintenanceRecord;

			CREATE TABLE MaintenanceRecord
			(
				HarvId			INT				NOT NULL,
				PartId			INT				NOT NULL,
				EmployeeId		INT				NOT NULL,
				[TimeStamp]		DATETIME		NOT NULL,
				ReplacementCost	DECIMAL(10, 2)	,
				SupplierId		INT				,
				PRIMARY KEY (HarvId, PartId, EmployeeId, [TimeStamp])
			);

	END;
GO

DROP PROCEDURE IF EXISTS create_foreign_keys

GO

CREATE PROCEDURE create_foreign_keys
AS
	BEGIN

		ALTER TABLE Subscriber
			ADD CONSTRAINT fk_Subscriber
				FOREIGN KEY (AddressId)		REFERENCES [Address](AddressID),
				FOREIGN KEY (ContactInfoID) REFERENCES ContactInfo(ContactInfoID);

		ALTER TABLE [Zone]
			ADD CONSTRAINT fk_Zone
				FOREIGN KEY (ContractId)	REFERENCES [Contract](ContractID);

		ALTER TABLE SensorReading
			ADD CONSTRAINT fk_SensorReading
				FOREIGN KEY (HarvId)     REFERENCES Harv(HarvId),
				FOREIGN KEY (ContractId) REFERENCES [Contract](ContractId);
					
		ALTER TABLE HarvContract
			ADD CONSTRAINT fk_HarvContract
				FOREIGN KEY (HarvId)		REFERENCES Harv(HarvID),
				FOREIGN KEY (ContractId)	REFERENCES [Contract](ContractID);
		
		ALTER TABLE HarvZone
			ADD CONSTRAINT fk_HarvZone
				FOREIGN KEY (HarvId)		REFERENCES Harv(HarvID),
				FOREIGN KEY (ZoneId)		REFERENCES [Zone](ZoneID);

		ALTER TABLE Supplier
			ADD CONSTRAINT fk_Supplier
				FOREIGN KEY (AddressId)		REFERENCES [Address](AddressID),
				FOREIGN KEY (ContactInfoID) REFERENCES ContactInfo(ContactInfoID);

		ALTER TABLE Employee
			ADD CONSTRAINT fk_Employee
				FOREIGN KEY (AddressId)		REFERENCES [Address](AddressID),
				FOREIGN KEY (ContactInfoID) REFERENCES ContactInfo(ContactInfoID);

		ALTER TABLE Director
			ADD CONSTRAINT fk_Director
				FOREIGN KEY (EmployeeId)	REFERENCES Employee(EmployeeId);

		ALTER TABLE Salesperson
			ADD CONSTRAINT fk_Salesperson
				FOREIGN KEY (EmployeeId)	REFERENCES Employee(EmployeeId);

		ALTER TABLE AdminExecutive
			ADD CONSTRAINT fk_adminExecutive
				FOREIGN KEY (EmployeeId)	REFERENCES Employee(EmployeeId);

		ALTER TABLE TechnicalEngineer
			ADD CONSTRAINT fk_TechnicalEngineer
				FOREIGN KEY (EmployeeId)	REFERENCES Employee(EmployeeId);

		ALTER TABLE ThirdPartyMaintainer
			ADD CONSTRAINT fk_ThirdPartyMaintainer
				FOREIGN KEY (EmployeeId)	REFERENCES Employee(EmployeeId);

		ALTER TABLE [Contract]
			ADD CONSTRAINT fk_Contract
				FOREIGN KEY (SubscriberId)	REFERENCES Subscriber(SubscriberId);

		--Constraints for which type of employee can negotiate which contract are enforced here. e.g. standard contracts employee id references a salesperson employee and
		--platinums references and AdminExecutive

		ALTER TABLE [Standard]
			ADD CONSTRAINT fk_Standard
				FOREIGN KEY	(ContractId)	REFERENCES [Contract](ContractId),
				FOREIGN KEY (EmployeeId)	REFERENCES Salesperson(EmployeeId);

		ALTER TABLE Gold
			ADD CONSTRAINT fk_Gold
				FOREIGN KEY	(ContractId)	REFERENCES [Contract](ContractId),
				FOREIGN KEY (EmployeeId)	REFERENCES Salesperson(EmployeeId);

		ALTER TABLE Platinum
			ADD CONSTRAINT fk_Platinum
				FOREIGN KEY	(ContractId)	REFERENCES [Contract](ContractId),
				FOREIGN KEY (EmployeeId)	REFERENCES AdminExecutive(EmployeeId);


		ALTER TABLE SuperPlatinum
			ADD CONSTRAINT fk_SuperPlatinum
				FOREIGN KEY	(ContractId)	REFERENCES [Contract](ContractId),
				FOREIGN KEY (EmployeeId)	REFERENCES AdminExecutive(EmployeeId);

		ALTER TABLE Harv
			ADD CONSTRAINT fk_Harv
				FOREIGN KEY	(ContractId)	REFERENCES SuperPlatinum(ContractId),
				FOREIGN KEY (EmployeeId)	REFERENCES TechnicalEngineer(EmployeeId);

		ALTER TABLE SupplierPart
			ADD CONSTRAINT fk_SupplierPart
				FOREIGN KEY (SupplierId)	REFERENCES Supplier(SupplierId),
				FOREIGN KEY (PartId)		REFERENCES Part(PartId);

		ALTER TABLE PartHarv
			ADD CONSTRAINT fk_PartHarv
				FOREIGN KEY (HarvId)		REFERENCES Harv(HarvId),
				FOREIGN KEY (PartId)		REFERENCES Part(PartId);

		ALTER TABLE MaintenanceRecord
			ADD CONSTRAINT fk_MaintenanceRecord
				FOREIGN KEY (PartId, HarvId)REFERENCES PartHarv(PartId, HarvId),
				FOREIGN KEY (EmployeeId)	REFERENCES ThirdPartyMaintainer(EmployeeId),
				FOREIGN KEY (SupplierId)	REFERENCES Supplier(SupplierId);

	END;
GO

DROP PROCEDURE IF EXISTS create_business_constraints

GO

--Check constraints here

CREATE PROCEDURE create_business_constraints
AS
	BEGIN

	ALTER TABLE [Contract]
		ADD CONSTRAINT chk_DiscountPct
			CHECK (DiscountPct IS NULL OR DiscountPct <= 10.00);

	END;

GO

--Tables and foreign key constraints created here before triggers can be added

EXECUTE create_tables;
EXECUTE create_foreign_keys;

--Secondary Indexes, CREATE INDEX is non clustered by defualt

CREATE INDEX IX_SensorReading_ContractId
	ON SensorReading (ContractId);

CREATE INDEX IX_SensorReading_HarvId
	ON SensorReading (HarvId);

CREATE INDEX IX_MaintenanceRecord_HarvId_TimeStamp
	ON MaintenanceRecord (HarvId, [TimeStamp])
	INCLUDE (ReplacementCost);

CREATE INDEX IX_HarvZone_LastVisited
	ON HarvZone (LastVisited);

CREATE INDEX IX_HarvContract_ContractId
	ON HarvContract (ContractId);

CREATE INDEX IX_Contract_SubscriberId
	ON [Contract] (SubscriberId);

GO

--Triggers here

--Triggers for preventing contract zones from exceeding the limit of their contract type

CREATE TRIGGER trg_Zone_StandardHectares
ON [Zone]
AFTER INSERT, UPDATE
AS
	BEGIN

		IF EXISTS (
			SELECT 1
			FROM inserted i
			INNER JOIN [Standard] s ON i.ContractId = s.ContractId
			WHERE i.Hectares > 10
		)
		BEGIN
			ROLLBACK TRANSACTION;
			THROW 50001, 'Standard subscription zones cannot exceed 10 hectares.', 1;

		END

END;

GO

CREATE TRIGGER trg_Zone_GoldHectares
ON [Zone]
AFTER INSERT, UPDATE
AS
	BEGIN

		IF EXISTS (
			SELECT 1
			FROM inserted i
			INNER JOIN Gold g ON i.ContractId = g.ContractId
			GROUP BY i.ContractId
			HAVING SUM(i.Hectares) > 100
		)
		BEGIN
			ROLLBACK TRANSACTION;
			THROW 50002, 'Gold subscription zones cannot exceed 100 hectares in total.', 1;

		END

	END;
GO

--Trigger to ensure gold contracts have exactly 3 zones, triggers on delete also

CREATE TRIGGER trg_Zone_GoldCount
ON [Zone]
AFTER INSERT, UPDATE, DELETE
AS
	BEGIN
		IF EXISTS (
			SELECT 1
			FROM [Zone] z
			INNER JOIN Gold g ON z.ContractId = g.ContractId
			GROUP BY z.ContractId
			HAVING COUNT(z.ZoneId) <> 3
		)
		BEGIN
			ROLLBACK TRANSACTION;
			THROW 50003, 'Gold subscription must have exactly 3 zones.', 1;
		END
	END;

GO

--Trigger to ensure gold contracts always have exactly 3 HARVS. also triggers on delete

CREATE TRIGGER trg_HarvContract_GoldCount
ON HarvContract
AFTER INSERT, UPDATE, DELETE
AS
	BEGIN
		IF EXISTS (
			SELECT 1
			FROM HarvContract hc
			INNER JOIN Gold g ON hc.ContractId = g.ContractId
			GROUP BY hc.ContractId
			HAVING COUNT(hc.HarvId) <> 3
		)
		BEGIN
			ROLLBACK TRANSACTION;
			THROW 50004, 'Gold subscription must have exactly 3 HARVs.', 1;
		END
	END;

GO

--Trigger to ensure contracts that pay anually have a 10% discount

CREATE TRIGGER trg_Contract_AnnualDiscount
ON [Contract]
AFTER INSERT, UPDATE
AS
	BEGIN
		IF EXISTS (
			SELECT 1
			FROM inserted i
			WHERE i.PayFrequency = 'Annual'
			AND i.DiscountPct <> 10.00
			AND (
				EXISTS (SELECT 1 FROM [Standard] s WHERE s.ContractId = i.ContractId)
				OR
				EXISTS (SELECT 1 FROM Gold g WHERE g.ContractId = i.ContractId)
			)
		)
		BEGIN
			ROLLBACK TRANSACTION;
			THROW 50005, 'Annual Standard and Gold subscriptions must have a 10% discount.', 1;
		END
	END;

GO

EXECUTE create_business_constraints;

--SAMPLE DATA INSERT STATEMENTS
--All tables must have at least 5 rows
--at least 100 total rows across the database

--Harv and zone counts triggers temporarily disabled to allow bulk sample data

DISABLE TRIGGER trg_Zone_GoldCount ON [Zone];
DISABLE TRIGGER trg_HarvContract_GoldCount ON HarvContract;

-- Disable all foreign key constraints to prevent errors

EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

--Insert statements

--Address inserts, NZ and international. 35 rows to account for each row that references one

INSERT INTO [Address] (AddressId, StreetAddress, Suburb, City, PostCode) VALUES
	--Subscriber addresses (1-5)
	(1,  '12 Trafalgar Street',  'Richmond',     'Nelson',       '7010'),
	(2,  '45 Manners Street',    'Te Aro',       'Wellington',   '6011'),
	(3,  '88 Queen Street',      'CBD',          'Auckland',     '1010'),
	(4,  '23 Tuam Street',       NULL,           'Christchurch', '8011'),
	(5,  '7 George Street',      NULL,           'Dunedin',      '9016'),
	--Supplier addresses (6-10)
	(6,  '100 Farm Road',        NULL,           'Blenheim',     '7201'),
	(7,  '55 Harbour View',      'Tasman',       'Nelson',       '7011'),
	(8,  '300 Pacific Highway',  'Chatswood',    'Sydney',       '2067'),
	(9,  '22 Sakura Lane',       'Shibuya',      'Tokyo',        '150-0002'),
	(10, '9 Industrial Park',    NULL,           'Singapore',    '627628'),
	--Employee addresses (11-35)
	(11, '14 Rue de Rivoli',     NULL,           'Paris',        '75001'),
	(12, '87 Ocean Drive',       NULL,           'Miami',        '33139'),
	(13, '41 Main Street',       'Silverstream', 'Wellington',   '5018'),
	(14, '3 Vineyard Road',      NULL,           'Marlborough',  '7273'),
	(15, '60 Tech Boulevard',    'Newmarket',    'Auckland',     '1023'),
	(16, '18 Wakefield Street',  'CBD',          'Nelson',       '7010'),
	(17, '72 Cuba Street',       'Te Aro',       'Wellington',   '6011'),
	(18, '5 Shortland Street',   'CBD',          'Auckland',     '1010'),
	(19, '99 Riccarton Road',    NULL,           'Christchurch', '8041'),
	(20, '31 Stuart Street',     NULL,           'Dunedin',      '9016'),
	(21, '4 Hardy Street',       NULL,           'Nelson',       '7010'),
	(22, '10 Lambton Quay',      'CBD',          'Wellington',   '6011'),
	(23, '200 Dominion Road',    'Mt Eden',      'Auckland',     '1024'),
	(24, '15 Fitzgerald Avenue', NULL,           'Christchurch', '8001'),
	(25, '8 Princes Street',     NULL,           'Dunedin',      '9016'),
	(26, '6 Bridge Street',      NULL,           'Nelson',       '7010'),
	(27, '33 Dixon Street',      'Te Aro',       'Wellington',   '6011'),
	(28, '77 Parnell Road',      'Parnell',      'Auckland',     '1052'),
	(29, '50 Papanui Road',      NULL,           'Christchurch', '8053'),
	(30, '19 Moray Place',       NULL,           'Dunedin',      '9016'),
	(31, '2 Nile Street',        NULL,           'Nelson',       '7010'),
	(32, '88 Thorndon Quay',     'Thorndon',     'Wellington',   '6011'),
	(33, '14 Ponsonby Road',     'Ponsonby',     'Auckland',     '1011'),
	(34, '301 Colombo Street',   NULL,           'Christchurch', '8023'),
	(35, '45 Water Street',      NULL,           'Dunedin',      '9016');

--ContactInfo inserts, also NZ and international. also 35 rows to account for each row that is referencing
--the table

INSERT INTO ContactInfo (ContactInfoId, Phone, Email) VALUES
	--Subscriber contact info (1-5)
	(1,  '03-548-1234', 'contact@greenvalefarms.co.nz'),
	(2,  '04-472-5678', 'admin@pacificaqua.co.nz'),
	(3,  '09-309-8765', 'info@northlandvineyard.co.nz'),
	(4,  '03-379-4321', 'operations@canterburyfarms.co.nz'),
	(5,  '03-477-6543', 'manager@southernresearch.co.nz'),
	--Supplier contact info (6-10)
	(6,  '03-578-9012', 'supply@marlboroughparts.co.nz'),
	(7,  '03-546-3456', 'orders@nelsonmarine.co.nz'),
	(8,  '+61-2-9876-5432', 'procurement@sydneytech.com.au'),
	(9,  '+81-3-5678-9012', 'info@tokyosupply.jp'),
	(10, '+65-6234-5678', 'orders@singaporeparts.sg'),
	--Employee contact info (11-35)
	(11, '03-548-2345', 'j.harrington@coastcanopy.com'),
	(12, '04-472-3456', 's.mitchell@coastcanopy.com'),
	(13, '09-309-4567', 'd.chen@coastcanopy.com'),
	(14, '03-379-5678', 'e.thompson@coastcanopy.com'),
	(15, '03-477-6789', 'm.anderson@coastcanopy.com'),
	(16, '03-578-7890', 'r.williams@coastcanopy.com'),
	(17, '03-546-8901', 't.brown@coastcanopy.com'),
	(18, '+61-2-9876-9012', 'j.taylor@coastcanopy.com'),
	(19, '+33-1-4567-0123', 'd.wilson@coastcanopy.com'),
	(20, '+1-305-987-1234', 'l.martin@coastcanopy.com'),
	(21, '+81-3-5678-2345', 'c.roberts@coastcanopy.com'),
	(22, '+65-6234-3456', 'a.jackson@coastcanopy.com'),
	(23, '04-528-4567', 'n.white@coastcanopy.com'),
	(24, '03-572-5678', 'o.harris@coastcanopy.com'),
	(25, '09-524-6789', 's.clark@coastcanopy.com'),
	(26, '03-548-3456', 'b.nguyen@coastcanopy.com'),
	(27, '04-472-4567', 'k.patel@coastcanopy.com'),
	(28, '09-309-5678', 'l.kim@coastcanopy.com'),
	(29, '03-379-6789', 'p.jones@coastcanopy.com'),
	(30, '03-477-7890', 'h.smith@coastcanopy.com'),
	(31, '03-578-8901', 'g.lee@coastcanopy.com'),
	(32, '04-472-9012', 'm.wong@coastcanopy.com'),
	(33, '09-309-0123', 'r.patel@coastcanopy.com'),
	(34, '03-379-1234', 'c.kumar@coastcanopy.com'),
	(35, '03-477-2345', 'f.zhao@coastcanopy.com');

--Supplier inserts, referencing existing address and contactinfo entries

INSERT INTO Supplier (SupplierId, AddressId, ContactInfoId, Name) VALUES
	(1, 6,  6,  'Marlborough Parts Co'),
	(2, 7,  7,  'Nelson Marine Supplies'),
	(3, 8,  8,  'Sydney Tech Components'),
	(4, 9,  9,  'Tokyo Supply Co'),
	(5, 10, 10, 'Singapore Parts Ltd');

--Subscriber inserts, also referenceing exisitng address and contactinfo entries

INSERT INTO Subscriber (SubscriberId, Organisation, AddressId, ContactInfoId) VALUES
	(1, 'Greenvale Farms Ltd',        1, 1),
	(2, 'Pacific Aquaculture Co',     2, 2),
	(3, 'Northland Vineyard Group',   3, 3),
	(4, 'Canterbury Farms Ltd',       4, 4),
	(5, 'Southern Research Centre',   5, 5);

--Employee inserts. 25 rows to alklow for  of each employee type

INSERT INTO Employee (EmployeeId, AddressId, ContactInfoId, FirstName, LastName, StartDate) VALUES
	--Directors (1-5)
	(1,  11, 11, 'James',    'Harrington', '2015-03-01'),
	(2,  12, 12, 'Sarah',    'Mitchell',   '2016-06-15'),
	(3,  13, 13, 'David',    'Chen',       '2017-09-20'),
	(4,  14, 14, 'Emma',     'Thompson',   '2018-01-10'),
	(5,  15, 15, 'Michael',  'Anderson',   '2019-04-22'),
	--Salespersons (6-10)
	(6,  16, 16, 'Rachel',   'Williams',   '2014-07-08'),
	(7,  17, 17, 'Thomas',   'Brown',      '2020-02-14'),
	(8,  18, 18, 'Jessica',  'Taylor',     '2018-11-30'),
	(9,  19, 19, 'Daniel',   'Wilson',     '2021-05-19'),
	(10, 20, 20, 'Laura',    'Martin',     '2016-08-03'),
	-- AdminExecutives (11-15)
	(11, 21, 21, 'Chris',    'Roberts',    '2019-12-01'),
	(12, 22, 22, 'Amy',      'Jackson',    '2022-03-15'),
	(13, 23, 23, 'Nathan',   'White',      '2020-07-27'),
	(14, 24, 24, 'Olivia',   'Harris',     '2017-10-05'),
	(15, 25, 25, 'Samuel',   'Clark',      '2023-01-09'),
	--TechnicalEngineers (16-20)
	(16, 26, 26, 'Ben',      'Nguyen',     '2018-05-12'),
	(17, 27, 27, 'Karen',    'Patel',      '2019-08-23'),
	(18, 28, 28, 'Lucas',    'Kim',        '2020-11-04'),
	(19, 29, 29, 'Priya',    'Jones',      '2021-02-17'),
	(20, 30, 30, 'Henry',    'Smith',      '2022-06-30'),
	--ThirdPartyMaintainers (21-25)
	(21, 31, 31, 'Grace',    'Lee',        '2019-03-08'),
	(22, 32, 32, 'Marcus',   'Wong',       '2020-09-14'),
	(23, 33, 33, 'Rita',     'Patel',      '2021-12-20'),
	(24, 34, 34, 'Carlos',   'Kumar',      '2022-04-05'),
	(25, 35, 35, 'Fiona',    'Zhao',       '2023-07-11');

--Employee subtype inserts. min 5 of each

INSERT INTO Director (EmployeeId, BoardPosition) VALUES
	(1, 'Chief Executive Officer'),
	(2, 'Chief Financial Officer'),
	(3, 'Chief Operations Officer'),
	(4, 'Chief Technology Officer'),
	(5, 'Chief Marketing Officer');

INSERT INTO Salesperson (EmployeeId, BoothLocation) VALUES
	(6,  'Nelson CBD Booth'),
	(7,  'Wellington CBD Booth'),
	(8,  'Auckland CBD Booth'),
	(9,  'Christchurch CBD Booth'),
	(10, 'Online Store');

INSERT INTO AdminExecutive (EmployeeId, DateAppotinted) VALUES
	(11, '2019-12-01'),
	(12, '2022-03-15'),
	(13, '2020-07-27'),
	(14, '2017-10-05'),
	(15, '2023-01-09');

INSERT INTO TechnicalEngineer (EmployeeId, Specialization) VALUES
	(16, 'Aquatic Systems'),
	(17, 'Aerial Systems'),
	(18, 'Sensor Integration'),
	(19, 'Mechanical Engineering'),
	(20, 'Software Systems');

INSERT INTO ThirdPartyMaintainer (EmployeeId, CompanyName, Certification) VALUES
	(21, 'Southern Field Services',   'ISO 9001'),
	(22, 'Pacific Maintenance Ltd',   'AS/NZS 4024'),
	(23, 'Nelson Tech Services',      'ISO 9001'),
	(24, 'Canterbury Field Solutions','AS/NZS 4024'),
	(25, 'Otago Robotics Services',   NULL);

--Contract inserts 20 rows to allow for 5 of each contract type. 10% discount enforced for annual payment

INSERT INTO [Contract] (ContractId, SubscriberId, BaseMonthlyFee, PayFrequency, DiscountPct, StartDate) VALUES
	--Standard contracts (1-5)
	(1,  1, 500.00,  'Monthly', 2.00, '2023-01-15'),
	(2,  2, 500.00,  'Annual',  10.00,'2023-03-01'),
	(3,  3, 500.00,  'Monthly', 1.50, '2023-05-20'),
	(4,  4, 500.00,  'Annual',  10.00,'2023-07-10'),
	(5,  5, 500.00,  'Monthly', NULL, '2023-09-05'),
	--Gold contracts (6-10)
	(6,  1, 1500.00, 'Monthly', 3.00, '2022-01-15'),
	(7,  2, 1500.00, 'Annual',  10.00,'2022-03-01'),
	(8,  3, 1500.00, 'Monthly', 2.50, '2022-05-20'),
	(9,  4, 1500.00, 'Annual',  10.00,'2022-07-10'),
	(10, 5, 1500.00, 'Monthly', NULL, '2022-09-05'),
	--Platinum contracts (11-15)
	(11, 1, 5000.00, 'Monthly', NULL, '2021-01-15'),
	(12, 2, 6000.00, 'Annual',  NULL, '2021-03-01'),
	(13, 3, 5500.00, 'Monthly', NULL, '2021-05-20'),
	(14, 4, 7000.00, 'Annual',  NULL, '2021-07-10'),
	(15, 5, 5000.00, 'Monthly', NULL, '2021-09-05'),
	--SuperPlatinum contracts (16-20)
	(16, 1, 15000.00,'Monthly', NULL, '2020-01-15'),
	(17, 2, 18000.00,'Annual',  NULL, '2020-03-01'),
	(18, 3, 16000.00,'Monthly', NULL, '2020-05-20'),
	(19, 4, 20000.00,'Annual',  NULL, '2020-07-10'),
	(20, 5, 15000.00,'Monthly', NULL, '2020-09-05');

--Contract subtype tables. 5 of each type.

INSERT INTO [Standard] (ContractId, EmployeeId) VALUES
	(1,  6),
	(2,  7),
	(3,  8),
	(4,  9),
	(5,  10);

INSERT INTO Gold (ContractId, EmployeeId) VALUES
	(6,  6),
	(7,  7),
	(8,  8),
	(9,  9),
	(10, 10);

INSERT INTO Platinum (ContractId, EmployeeId) VALUES
	(11, 11),
	(12, 12),
	(13, 13),
	(14, 14),
	(15, 15);

INSERT INTO SuperPlatinum (ContractId, EmployeeId) VALUES
	(16, 11),
	(17, 12),
	(18, 13),
	(19, 14),
	(20, 15);

--Part inserts. 20 rows

INSERT INTO Part (PartId, Name, MaintenanceSch) VALUES
	(1,  'Aquatic Thruster',        '5 years'),
	(2,  'Pruning Blade',           '5 years'),
	(3,  'Sensor Array',            '5 years'),
	(4,  'Navigation Controller',   '5 years'),
	(5,  'Communication Module',    '5 years'),
	(6,  'GPS Receiver',            '5 years'),
	(7,  'Battery Pack',            '5 years'),
	(8,  'Solar Panel',             '5 years'),
	(9,  'Weed Sprayer Nozzle',     '5 years'),
	(10, 'Frost Mitigation Unit',   '5 years'),
	(11, 'Bio-fouling Remover',     '5 years'),
	(12, 'Irrigation Controller',   '5 years'),
	(13, 'Aeration Pump',           '5 years'),
	(14, 'Camera Module',           '5 years'),
	(15, 'LIDAR Sensor',            '5 years'),
	(16, 'Hull Plating',            '5 years'),
	(17, 'Robotic Arm Joint',       '5 years'),
	(18, 'Canopy Pruning Shear',    '5 years'),
	(19, 'Net Inspection Probe',    '5 years'),
	(20, 'Satellite Uplink Module', '5 years');

--SupplierPart inserts, parts can be supplied by multiple suppliers

INSERT INTO SupplierPart (SupplierId, PartId, PurchaseCost) VALUES
	--Marlborough Parts Co (1)
	(1, 1,  450.00),
	(1, 2,  120.00),
	(1, 3,  890.00),
	(1, 4,  670.00),
	(1, 5,  340.00),
	--Nelson Marine Supplies (2)
	(2, 1,  480.00),
	(2, 6,  220.00),
	(2, 7,  560.00),
	(2, 8,  310.00),
	(2, 16, 780.00),
	--Sydney Tech Components (3)
	(3, 3,  920.00),
	(3, 4,  700.00),
	(3, 9,  180.00),
	(3, 10, 950.00),
	(3, 14, 430.00),
	--Tokyo Supply Co (4)
	(4, 5,  360.00),
	(4, 11, 540.00),
	(4, 15, 1200.00),
	(4, 17, 290.00),
	(4, 20, 1500.00),
	--Singapore Parts Ltd (5)
	(5, 12, 210.00),
	(5, 13, 175.00),
	(5, 18, 320.00),
	(5, 19, 410.00),
	(5, 6,  240.00);

--HARV inserts. HARVs with a contractId are exclusive to suplerPlatinum contarcts

INSERT INTO Harv (HarvId, ContractId, Configuration, DeploymentDate, DecomissionDate, EmployeeId) VALUES
	-- SuperPlatinum exclusive HARVs (ContractId set directly)
	(1,  16, 'Terraced Vineyard',        '2020-02-01', NULL, 16),
	(2,  16, 'Coastal Net-Pen',          '2020-02-01', NULL, 17),
	(3,  17, 'Deep-Sea Aquaculture Grid','2020-04-01', NULL, 18),
	(4,  17, 'Flat Orchard',             '2020-04-01', NULL, 19),
	(5,  18, 'Estuary',                  '2020-06-01', NULL, 20),
	(6,  18, 'Terraced Vineyard',        '2020-06-01', NULL, 16),
	(7,  19, 'Coastal Net-Pen',          '2020-08-01', NULL, 17),
	(8,  19, 'Flat Orchard',             '2020-08-01', NULL, 18),
	(9,  20, 'Deep-Sea Aquaculture Grid','2020-10-01', NULL, 19),
	(10, 20, 'Estuary',                  '2020-10-01', NULL, 20),
	--Non-exclusive HARVs (ContractId NULL)
	(11, NULL, 'Terraced Vineyard',      '2021-01-15', NULL, 16),
	(12, NULL, 'Coastal Net-Pen',        '2021-03-20', NULL, 17),
	(13, NULL, 'Flat Orchard',           '2021-06-10', NULL, 18),
	(14, NULL, 'Estuary',                '2021-09-05', NULL, 19),
	(15, NULL, 'Deep-Sea Aquaculture Grid','2022-01-20',NULL, 20),
	(16, NULL, 'Terraced Vineyard',      '2022-04-15', NULL, 16),
	(17, NULL, 'Coastal Net-Pen',        '2022-07-01', NULL, 17),
	(18, NULL, 'Flat Orchard',           '2022-10-12', NULL, 18),
	(19, NULL, 'Estuary',                '2023-02-28', NULL, 19),
	(20, NULL, 'Deep-Sea Aquaculture Grid','2023-05-15',NULL, 20);

--Zone inserts, 3 rows to fulfil constraints for zone numbers. Zone size limits followed

INSERT INTO [Zone] (ZoneId, ContractId, Name, Hectares, Latitude, Longitude) VALUES
	--Standard zones (1-5), one per contract, max 10 hectares
	(1,  1,  'Greenvale North Block',      8.00,  -41.2706, 173.2840),
	(2,  2,  'Pacific Bay Section A',      9.50,  -41.5000, 173.9500),
	(3,  3,  'Northland Vineyard East',    7.00,  -36.0900, 174.5000),
	(4,  4,  'Canterbury Plains Block 1',  10.00, -43.5321, 172.6362),
	(5,  5,  'Southern Research Zone A',   6.50,  -45.8788, 170.5028),
	--Gold zones (6-20), three per contract, total max 100 hectares
	(6,  6,  'Greenvale Gold Zone A',      30.00, -41.2800, 173.2900),
	(7,  6,  'Greenvale Gold Zone B',      35.00, -41.2900, 173.3000),
	(8,  6,  'Greenvale Gold Zone C',      30.00, -41.3000, 173.3100),
	(9,  7,  'Pacific Gold Section A',     25.00, -41.5100, 173.9600),
	(10, 7,  'Pacific Gold Section B',     40.00, -41.5200, 173.9700),
	(11, 7,  'Pacific Gold Section C',     30.00, -41.5300, 173.9800),
	(12, 8,  'Northland Gold East A',      20.00, -36.1000, 174.5100),
	(13, 8,  'Northland Gold East B',      45.00, -36.1100, 174.5200),
	(14, 8,  'Northland Gold East C',      30.00, -36.1200, 174.5300),
	(15, 9,  'Canterbury Gold Block A',    33.00, -43.5400, 172.6400),
	(16, 9,  'Canterbury Gold Block B',    33.00, -43.5500, 172.6500),
	(17, 9,  'Canterbury Gold Block C',    34.00, -43.5600, 172.6600),
	(18, 10, 'Southern Gold Zone A',       25.00, -45.8900, 170.5100),
	(19, 10, 'Southern Gold Zone B',       40.00, -45.9000, 170.5200),
	(20, 10, 'Southern Gold Zone C',       30.00, -45.9100, 170.5300),
	--Platinum zones (21-30), two per contract
	(21, 11, 'Greenvale Platinum Zone A',  50.00, -41.3100, 173.3200),
	(22, 11, 'Greenvale Platinum Zone B',  60.00, -41.3200, 173.3300),
	(23, 12, 'Pacific Platinum Section A', 80.00, -41.5400, 173.9900),
	(24, 12, 'Pacific Platinum Section B', 70.00, -41.5500, 174.0000),
	(25, 13, 'Northland Platinum East A',  55.00, -36.1300, 174.5400),
	(26, 13, 'Northland Platinum East B',  65.00, -36.1400, 174.5500),
	(27, 14, 'Canterbury Platinum Zone A', 90.00, -43.5700, 172.6700),
	(28, 14, 'Canterbury Platinum Zone B', 85.00, -43.5800, 172.6800),
	(29, 15, 'Southern Platinum Zone A',   70.00, -45.9200, 170.5400),
	(30, 15, 'Southern Platinum Zone B',   75.00, -45.9300, 170.5500),
	--SuperPlatinum zones (31-35), one per contract
	(31, 16, 'Greenvale Super Zone A',     200.00, -41.3300, 173.3400),
	(32, 17, 'Pacific Super Section A',    250.00, -41.5600, 174.0100),
	(33, 18, 'Northland Super East A',     180.00, -36.1500, 174.5600),
	(34, 19, 'Canterbury Super Zone A',    300.00, -43.5900, 172.6900),
	(35, 20, 'Southern Super Zone A',      220.00, -45.9400, 170.5600);

--HarvContract inserts. following HARV limits for differetn contracts

INSERT INTO HarvContract (HarvId, ContractId, AllocatedOn, ServiceType) VALUES
	--Standard contracts (1 HARV each)
	(11, 1,  '2023-01-20', 'Track Clearing'),
	(12, 2,  '2023-03-10', 'Canopy Pruning'),
	(13, 3,  '2023-05-25', 'Weed Spraying'),
	(14, 4,  '2023-07-15', 'Irrigation Maintenance'),
	(15, 5,  '2023-09-10', 'Frost Mitigation'),
	--Gold contract 6 (exactly 3 HARVs)
	(11, 6,  '2022-01-20', 'Track Clearing'),
	(12, 6,  '2022-01-20', 'Canopy Pruning'),
	(13, 6,  '2022-01-20', 'Weed Spraying'),
	--Gold contract 7 (exactly 3 HARVs)
	(13, 7,  '2022-03-10', 'Irrigation Maintenance'),
	(14, 7,  '2022-03-10', 'Canopy Pruning'),
	(15, 7,  '2022-03-10', 'Frost Mitigation'),
	--Gold contract 8 (exactly 3 HARVs)
	(15, 8,  '2022-05-25', 'Bio-fouling Removal'),
	(16, 8,  '2022-05-25', 'Net-Pen Inspection'),
	(17, 8,  '2022-05-25', 'Track Clearing'),
	-- Gold contract 9 (exactly 3 HARVs)
	(17, 9,  '2022-07-15', 'Weed Spraying'),
	(18, 9,  '2022-07-15', 'Irrigation Maintenance'),
	(19, 9,  '2022-07-15', 'Canopy Pruning'),
	--Gold contract 10 (exactly 3 HARVs)
	(19, 10, '2022-09-10', 'Frost Mitigation'),
	(20, 10, '2022-09-10', 'Bio-fouling Removal'),
	(11, 10, '2022-09-10', 'Track Clearing'),
	--Platinum contract 11 (3 HARVs)
	(11, 11, '2021-02-01', 'Full Service'),
	(12, 11, '2021-02-01', 'Data Sensing'),
	(13, 11, '2021-02-01', 'Canopy Pruning'),
	--Platinum contract 12 (3 HARVs)
	(14, 12, '2021-04-01', 'Full Service'),
	(15, 12, '2021-04-01', 'Data Sensing'),
	(16, 12, '2021-04-01', 'Net-Pen Inspection'),
	--Platinum contract 13 (3 HARVs)
	(17, 13, '2021-06-01', 'Full Service'),
	(18, 13, '2021-06-01', 'Data Sensing'),
	(19, 13, '2021-06-01', 'Weed Spraying'),
	--Platinum contract 14 (3 HARVs)
	(20, 14, '2021-08-01', 'Full Service'),
	(11, 14, '2021-08-01', 'Data Sensing'),
	(12, 14, '2021-08-01', 'Irrigation Maintenance'),
	--Platinum contract 15 (3 HARVs)
	(13, 15, '2021-10-01', 'Full Service'),
	(14, 15, '2021-10-01', 'Data Sensing'),
	(15, 15, '2021-10-01', 'Frost Mitigation');

--HarvZone inserts

INSERT INTO HarvZone (HarvId, ZoneId, LastVisited) VALUES
	--Standard HARVs to their zones (1 zone each)
	(11, 1,  '2026-04-20'),
	(12, 2,  '2026-06-10'),
	(13, 3,  NULL),
	(14, 4,  '2026-06-01'),
	(15, 5,  NULL),
	--Gold contract 6 zones (exactly 3 zones)
	(11, 6,  '2026-06-20'),
	(12, 7,  '2026-06-10'),
	(13, 8,  NULL),
	--Gold contract 7 zones (exactly 3 zones)
	(13, 9,  '2026-06-15'),
	(14, 10, '2026-06-01'),
	(15, 11, NULL),
	-- Gold contract 8 zones (exactly 3 zones)
	(15, 12, '2026-06-20'),
	(16, 13, '2026-06-10'),
	(17, 14, NULL),
	--Gold contract 9 zones (exactly 3 zones)
	(17, 15, '2026-06-01'),
	(18, 16, '2026-06-15'),
	(19, 17, NULL),
	--Gold contract 10 zones (exactly 3 zones)
	(19, 18, '2026-06-20'),
	(20, 19, '2026-06-10'),
	(11, 20, NULL),
	-- Platinum zones
	(11, 21, '2026-06-20'),
	(12, 22, '2026-06-01'),
	(14, 23, NULL),
	(15, 24, '2026-06-15'),
	(17, 25, '2026-06-10'),
	(18, 26, NULL),
	(20, 27, '2026-06-01'),
	(11, 28, '2026-06-20'),
	(13, 29, NULL),
	(14, 30, '2026-06-10'),
	--SuperPlatinum zones
	(1,  31, '2026-06-20'),
	(3,  32, '2026-06-01'),
	(5,  33, NULL),
	(7,  34, '2026-06-15'),
	(9,  35, NULL);

--PartHarv inserts

INSERT INTO PartHarv (PartId, HarvId, LastMaintenance) VALUES
	--HARV 1
	(1,  1,  '2024-01-15'),
	(3,  1,  '2023-06-20'),
	(5,  1,  '2022-11-10'),
	--HARV 2
	(2,  2,  '2024-02-20'),
	(4,  2,  '2023-07-15'),
	(6,  2,  '2022-12-05'),
	--HARV 3
	(7,  3,  '2024-03-10'),
	(8,  3,  '2023-08-20'),
	(9,  3,  '2023-01-15'),
	--HARV 11
	(1,  11, '2024-04-05'),
	(3,  11, '2023-09-10'),
	(10, 11, '2022-05-20'),
	--HARV 12
	(2,  12, '2024-05-15'),
	(4,  12, '2023-10-25'),
	(11, 12, '2022-06-15'),
	--HARV 13
	(5,  13, '2024-06-01'),
	(6,  13, '2023-11-30'),
	(12, 13, '2022-07-20'),
	-- HARV 14
	(7,  14, '2024-01-20'),
	(8,  14, '2023-12-15'),
	(13, 14, '2022-08-10'),
	--HARV 15
	(9,  15, '2024-02-28'),
	(10, 15, '2024-01-10'),
	(14, 15, '2022-09-05');

--SensorReading inserts. realistically would have far more rows

INSERT INTO SensorReading (HarvId, [TimeStamp], ContractId, Latitude, Longitude, Altitude, Humidity, Salinity, Turbidity, Temperature, OrganicSpectral, AmbientLight) VALUES
	-- HARV 1, SuperPlatinum contract 16
	(1,  '2026-06-01 08:00:00', 16, -41.2706, 173.2840,  12.50, 65.20, NULL,  NULL,   18.50, 'Low botrytis', 850.00),
	(1,  '2026-06-01 09:00:00', 16, -41.2710, 173.2845,  12.60, 64.80, NULL,  NULL,   18.60, 'Low botrytis', 860.00),
	(1,  '2026-06-01 10:00:00', 16, -41.2715, 173.2850,  12.70, 64.50, NULL,  NULL,   18.70, 'Low botrytis', 870.00),
	--HARV 3, SuperPlatinum contract 17
	(3,  '2026-06-02 08:00:00', 17, -41.5000, 173.9500, -15.00, NULL,  32.50, 4.20,   12.30, 'Algal bloom',  NULL),
	(3,  '2026-06-02 09:00:00', 17, -41.5010, 173.9510, -15.20, NULL,  32.60, 4.30,   12.40, 'Algal bloom',  NULL),
	(3,  '2026-06-02 10:00:00', 17, -41.5020, 173.9520, -15.40, NULL,  32.70, 4.40,   12.50, 'Algal bloom',  NULL),
	--HARV 11, Platinum contract 11 (Transaction D)
	(11, '2026-06-10 08:00:00', 11, -41.3100, 173.3200,  5.00,  72.30, NULL,  NULL,   16.20, 'Clear',        920.00),
	(11, '2026-06-10 09:00:00', 11, -41.3110, 173.3210,  5.10,  71.90, NULL,  NULL,   16.30, 'Clear',        930.00),
	(11, '2026-06-10 10:00:00', 11, -41.3120, 173.3220,  5.20,  71.50, NULL,  NULL,   16.40, 'Clear',        940.00),
	(11, '2026-06-11 08:00:00', 11, -41.3130, 173.3230,  5.30,  71.20, NULL,  NULL,   16.50, 'Clear',        950.00),
	-- HARV 12, Platinum contract 11 (Transaction D)
	(12, '2026-06-10 08:00:00', 11, -41.3200, 173.3300,  6.00,  70.10, NULL,  NULL,   15.80, 'Trace spores', 900.00),
	(12, '2026-06-10 09:00:00', 11, -41.3210, 173.3310,  6.10,  69.80, NULL,  NULL,   15.90, 'Trace spores', 910.00),
	(12, '2026-06-10 10:00:00', 11, -41.3220, 173.3320,  6.20,  69.50, NULL,  NULL,   16.00, 'Trace spores', 920.00),
	--HARV 13, Standard contract 3 (Transaction H - these will be deleted)
	(13, '2026-06-15 08:00:00', 3,  -36.0900, 174.5000,  8.00,  68.20, NULL,  NULL,   17.10, 'Clear',        880.00),
	(13, '2026-06-15 09:00:00', 3,  -36.0910, 174.5010,  8.10,  67.90, NULL,  NULL,   17.20, 'Clear',        890.00),
	(13, '2026-06-15 10:00:00', 3,  -36.0920, 174.5020,  8.20,  67.60, NULL,  NULL,   17.30, 'Clear',        900.00),
	--HARV 14, Gold contract 7
	(14, '2026-06-18 08:00:00', 7,  -41.5100, 173.9600,  10.00, 66.50, NULL,  NULL,   19.00, 'Clear',        840.00),
	(14, '2026-06-18 09:00:00', 7,  -41.5110, 173.9610,  10.10, 66.20, NULL,  NULL,   19.10, 'Clear',        850.00),
	(14, '2026-06-18 10:00:00', 7,  -41.5120, 173.9620,  10.20, 65.90, NULL,  NULL,   19.20, 'Clear',        860.00),
	--HARV 15, Gold contract 7
	(15, '2026-06-20 08:00:00', 7,  -41.5200, 173.9700,  11.00, 65.10, NULL,  NULL,   20.00, 'Clear',        820.00);

--MaintenanceRecord inserts, spanning 10 years to simluate trnasaction J effectively

INSERT INTO MaintenanceRecord (HarvId, PartId, EmployeeId, [TimeStamp], ReplacementCost, SupplierId) VALUES
	--HARV 1 maintenance history (spanning 10+ years)
	(1,  1,  21, '2015-03-15 09:00:00', 450.00, 1),
	(1,  3,  21, '2016-06-20 10:00:00', 890.00, 3),
	(1,  5,  22, '2018-09-10 11:00:00', 340.00, 4),
	(1,  1,  21, '2020-11-25 09:00:00', 480.00, 2),
	(1,  3,  22, '2022-04-15 10:00:00', 920.00, 3),
	(1,  5,  21, '2024-01-15 11:00:00', 360.00, 4),
	--HARV 2 maintenance history
	(2,  2,  22, '2016-05-10 09:00:00', 120.00, 1),
	(2,  4,  23, '2018-08-20 10:00:00', 670.00, 3),
	(2,  6,  22, '2020-10-15 11:00:00', 220.00, 2),
	(2,  2,  23, '2022-03-20 09:00:00', 120.00, 1),
	(2,  4,  22, '2024-02-20 10:00:00', 700.00, 3),
	--HARV 11 maintenance history
	(11, 1,  23, '2017-04-05 09:00:00', 450.00, 1),
	(11, 3,  24, '2019-07-10 10:00:00', NULL,   NULL),
	(11, 10, 23, '2021-05-20 11:00:00', 950.00, 3),
	(11, 1,  24, '2023-09-10 09:00:00', 480.00, 2),
	(11, 3,  23, '2024-04-05 10:00:00', NULL,   NULL),
	-- HARV 12 maintenance history
	(12, 2,  24, '2018-03-15 09:00:00', 120.00, 1),
	(12, 4,  25, '2020-06-25 10:00:00', 670.00, 3),
	(12, 11, 24, '2022-08-15 11:00:00', 540.00, 4),
	(12, 2,  25, '2024-05-15 09:00:00', NULL,   NULL);

--Triggers re-enabled

ENABLE TRIGGER trg_Zone_GoldCount ON [Zone];
ENABLE TRIGGER trg_HarvContract_GoldCount ON HarvContract;

-- Re-enable and verify all foreign key constraints

EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';

--TRANSACTIONS FROM PROJECT BRIEF

--Transaction A

--A salesperson subscribes a new standard subscription to a HARV. The transaction
--receives the salesperson Id, a discount %, all subscriber details, and a HARV ID.

DROP PROCEDURE IF EXISTS NewStandardContract;

GO

CREATE PROCEDURE NewStandardContract
	--Declare the required variables for the transaction
	--ID of salesperosn that sold the contract and the discount that was negotiated
    @SalespersonId      INT,
    @DiscountPct        DECIMAL(5,2),
	--Subscriber details, will be seperated into entries for subscriber, address, and contactInfo
    @Organisation       VARCHAR(50),
    @StreetAddress      VARCHAR(50),
    @Suburb             VARCHAR(50),
    @City               VARCHAR(50),
    @PostCode           VARCHAR(50),
    @Phone              VARCHAR(50),
    @Email              VARCHAR(50),
	--ID for new HarvContractEntry
    @HarvId             INT,
	--Contract details
    @BaseMonthlyFee     DECIMAL(10,2),
    @PayFrequency       VARCHAR(50)
AS

BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
		--IDs for new table entries use the next available number
        --Insert new Address
        DECLARE @AddressId INT = (SELECT ISNULL(MAX(AddressId), 0) + 1 FROM [Address]);
        INSERT INTO [Address] (AddressId, StreetAddress, Suburb, City, PostCode)
        VALUES (@AddressId, @StreetAddress, @Suburb, @City, @PostCode);

        --Insert new ContactInfo
        DECLARE @ContactInfoId INT = (SELECT ISNULL(MAX(ContactInfoId), 0) + 1 FROM ContactInfo);
        INSERT INTO ContactInfo (ContactInfoId, Phone, Email)
        VALUES (@ContactInfoId, @Phone, @Email);

        -- Insert new Subscriber
        DECLARE @SubscriberId INT = (SELECT ISNULL(MAX(SubscriberId), 0) + 1 FROM Subscriber);
        INSERT INTO Subscriber (SubscriberId, Organisation, AddressId, ContactInfoId)
        VALUES (@SubscriberId, @Organisation, @AddressId, @ContactInfoId);

        --Insert new Contract
        DECLARE @ContractId INT = (SELECT ISNULL(MAX(ContractId), 0) + 1 FROM [Contract]);
        INSERT INTO [Contract] (ContractId, SubscriberId, BaseMonthlyFee, PayFrequency, DiscountPct, StartDate)
        VALUES (@ContractId, @SubscriberId, @BaseMonthlyFee, @PayFrequency, @DiscountPct, GETDATE());

        -- Insert Standard subtype record
        INSERT INTO [Standard] (ContractId, EmployeeId)
        VALUES (@ContractId, @SalespersonId);

        --Insert HarvContract allocation
        INSERT INTO HarvContract (HarvId, ContractId, AllocatedOn, ServiceType)
        VALUES (@HarvId, @ContractId, GETDATE(), 'Standard Service');

        COMMIT TRANSACTION;
		--Message indicating successful transaction
        PRINT 'New standard contract created successfully.';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH

END;

GO

--Test execution for transaction A

EXECUTE NewStandardContract
    @SalespersonId  = 6,
    @DiscountPct    = 2.50,
    @Organisation   = 'Appleby Orchards Ltd',
    @StreetAddress  = '14 Orchard Road',
    @Suburb         = NULL,
    @City           = 'Nelson',
    @PostCode       = '7011',
    @Phone          = '03-547-6677',
    @Email          = 'admin@applebyorchards.co.nz',
    @HarvId         = 20,
    @BaseMonthlyFee = 500.00,
    @PayFrequency   = 'Monthly';

--Test statement, Ensures there is a Contract entry with the details
--from above with StartDate as todays date

SELECT *
	FROM [Contract]
	WHERE ContractId IN
		(
		SELECT ContractId 
			FROM [Standard]
			WHERE EmployeeId = 6
		);

GO

--Transaction B — For each salesperson list the subscribers they have sold a subscription to

--For each salesperson list the subscribers they have sold a subscription to. The
--transaction receives the salesperson's name as input, and presents each subscriber's
--name, address, and the % they were discounted.

DROP PROCEDURE IF EXISTS GetSalespersonSubscribers;

GO

CREATE PROCEDURE GetSalespersonSubscribers
    @SalespersonName VARCHAR(50)
AS
BEGIN
    SELECT
		--Select relevant columns with proper column names
        e.FirstName + ' ' + e.LastName   AS SalespersonName,
        s.Organisation                    AS SubscriberName,
        a.StreetAddress                   AS Address,
        a.Suburb                          AS Suburb,
        a.City                            AS City,
        a.PostCode                        AS PostCode,
        c.DiscountPct                     AS DiscountPct
    FROM Salesperson sp
	--Join with the employee table to get the employee name, used to filter later
    INNER JOIN Employee e       ON sp.EmployeeId = e.EmployeeId
	--Join with all contracts that are standard or gold as the transaction is for a salesperson
    INNER JOIN [Contract] c     ON c.ContractId IN (
		--Union used within the subquery to create list of all Gold and Standard contracts
        SELECT ContractId FROM [Standard] WHERE EmployeeId = sp.EmployeeId
        UNION
        SELECT ContractId FROM Gold WHERE EmployeeId = sp.EmployeeId
    )
	--Join to subscriber table to get subscriber details
    INNER JOIN Subscriber s     ON c.SubscriberId = s.SubscriberId
	--Finally join with address for the remaining subscriber details
    INNER JOIN [Address] a      ON s.AddressId = a.AddressId
	--Filter by the given employee name
    WHERE e.FirstName + ' ' + e.LastName = @SalespersonName;
END;

GO

--Test execution for transaction B, should return 3 rows based off of the sample data

EXECUTE GetSalespersonSubscribers
    @SalespersonName = 'Rachel Williams';

--Transaction C

--Write a query to be used to insert data from a HARV to its stored data on the Coast
--& Canopy database. The transaction receives the HARV ID and all the data from a
--data stream. That is made up of one or more records of Temperature,
--Humidity/Salinity, Ambient light strength, and organic spectral data, time, longitude,
--latitude, altitude/depth and date time.

DROP PROCEDURE IF EXISTS InsertSensorReading;

GO

CREATE PROCEDURE InsertSensorReading
	--Sensor reading columns as parameters with correct data types
    @HarvId             INT,
    @TimeStamp          DATETIME,
    @ContractId         INT,
    @Latitude           DECIMAL(8,6),
    @Longitude          DECIMAL(9,6),
    @Altitude           DECIMAL(10,2),
    @Humidity           DECIMAL(5,2),
    @Salinity           DECIMAL(5,2),
    @Turbidity          DECIMAL(10,4),
    @Temperature        DECIMAL(5,2),
    @OrganicSpectral    VARCHAR(255),
    @AmbientLight       DECIMAL(10,2)
AS
BEGIN

    BEGIN TRANSACTION;
    BEGIN TRY
		--Insert statement that takes all the parameters
        INSERT INTO SensorReading (HarvId, [TimeStamp], ContractId, Latitude, Longitude, Altitude, Humidity, Salinity, Turbidity, Temperature, OrganicSpectral, AmbientLight)
        VALUES (@HarvId, @TimeStamp, @ContractId, @Latitude, @Longitude, @Altitude, @Humidity, @Salinity, @Turbidity, @Temperature, @OrganicSpectral, @AmbientLight);

        COMMIT TRANSACTION;
		--Message on successful insert
        PRINT 'Sensor reading inserted successfully.';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH

END;

GO

--Test execute for transaction C with sample data

EXECUTE InsertSensorReading
    @HarvId          = 1,
    @TimeStamp       = '2026-06-23 08:00:00',
    @ContractId      = 16,
    @Latitude        = -41.2706,
    @Longitude       = 173.2840,
    @Altitude        = 12.80,
    @Humidity        = 64.20,
    @Salinity        = NULL,
    @Turbidity       = NULL,
    @Temperature     = 18.80,
    @OrganicSpectral = 'Low botrytis',
    @AmbientLight    = 880.00;

--Test query to check that the entry was created successfully

SELECT *
	FROM
		SensorReading
	WHERE TimeStamp = '2026-06-23 08:00:00';

--Transaction D

--For a Platinum subscription list all the data collected. The transaction receives the
--contracting organisation's name and presents for each collected data record: the
--contracting organisation's name, a HARV ID, Temperature, Humidity/Salinity, Ambient
--light strength, and organic spectral data, Latitude, Longitude, Altitude/Depth, Date
--and time of the data sample.

DROP PROCEDURE IF EXISTS GetPlatinumSensorData;

GO

CREATE PROCEDURE GetPlatinumSensorData
	--Organisation name as parameter, used to filter results later
    @OrganisationName VARCHAR(50)
AS
BEGIN

    SELECT
		--Columns to return with proper column names
        s.Organisation                      AS ContractingOrganisation,
        sr.HarvId                           AS HarvId,
        sr.Temperature                      AS Temperature,
        sr.Humidity                         AS Humidity,
        sr.Salinity                         AS Salinity,
        sr.AmbientLight                     AS AmbientLight,
        sr.OrganicSpectral                  AS OrganicSpectralData,
        sr.Latitude                         AS Latitude,
        sr.Longitude                        AS Longitude,
        sr.Altitude                         AS Altitude,
        sr.[TimeStamp]                      AS DateAndTime
    FROM SensorReading sr
    INNER JOIN [Contract] c     ON sr.ContractId = c.ContractId
	--Join to platinum to ensure only readings from the susbcribers platinum contracts
    INNER JOIN Platinum p       ON c.ContractId = p.ContractId
	--Join to subscriber in order to get the organisation name for filtering
    INNER JOIN Subscriber s     ON c.SubscriberId = s.SubscriberId
	--Filter results to only inlcude those of the given subscriber
    WHERE s.Organisation = @OrganisationName
	--Sort by HARV and the time of the sensor reading
    ORDER BY sr.HarvId, sr.[TimeStamp];

END;

GO

--Test execution for transaction D, should return 7 readings if sample data used

EXECUTE GetPlatinumSensorData
    @OrganisationName = 'Greenvale Farms Ltd';

--Transaction E

--For each subscription produce an invoice for the current month. The transaction
--produces an output from separate queries that lists the Date, Subscriber Name,
--Address, the subscription level (Standard, Gold, Platinum, or Super Platinum), followed
--by the list of Zones, services provided in the last month, and the total exclusive of
--GST, the total inclusive of GST, and the total tax. NOTE: In SQL Server you should use
--a series of PRINT commands within at least one CURSOR.

DROP PROCEDURE IF EXISTS GenerateMonthlyInvoices;

GO

CREATE PROCEDURE GenerateMonthlyInvoices
AS
BEGIN

	--Declare the variables and their data types that will be used in the invoices
    DECLARE @ContractId         INT
    DECLARE @Organisation       VARCHAR(50)
    DECLARE @StreetAddress      VARCHAR(50)
    DECLARE @Suburb             VARCHAR(50)
    DECLARE @City               VARCHAR(50)
    DECLARE @PostCode           VARCHAR(50)
    DECLARE @SubscriptionLevel  VARCHAR(20)
    DECLARE @BaseMonthlyFee     DECIMAL(10,2)
    DECLARE @DiscountPct        DECIMAL(5,2)
    DECLARE @PayFrequency       VARCHAR(50)
    DECLARE @ZoneName           VARCHAR(50)
    DECLARE @ServiceType        VARCHAR(50)
    DECLARE @ExclGST            DECIMAL(10,2)
    DECLARE @GSTAmount          DECIMAL(10,2)
    DECLARE @InclGST            DECIMAL(10,2)

    --Cursor for iterating over every existing contract
    DECLARE contract_cursor CURSOR FOR
        SELECT
            c.ContractId,
            s.Organisation,
            a.StreetAddress,
            a.Suburb,
            a.City,
            a.PostCode,
            CASE
				--Cases to print the contract types
                WHEN sp.ContractId IS NOT NULL THEN 'Super Platinum'
                WHEN p.ContractId  IS NOT NULL THEN 'Platinum'
                WHEN g.ContractId  IS NOT NULL THEN 'Gold'
                ELSE 'Standard'
            END AS SubscriptionLevel,
            c.BaseMonthlyFee,
            c.DiscountPct,
            c.PayFrequency
        FROM [Contract] c
		--Joins to find the subscriber details and address details
        INNER JOIN Subscriber s     ON c.SubscriberId = s.SubscriberId
        INNER JOIN [Address] a      ON s.AddressId = a.AddressId
		--Joins to each contract subtype, left join so nulls are returned and
		--can be used to print the contract type
        LEFT JOIN [Standard] st     ON c.ContractId = st.ContractId
        LEFT JOIN Gold g            ON c.ContractId = g.ContractId
        LEFT JOIN Platinum p        ON c.ContractId = p.ContractId
        LEFT JOIN SuperPlatinum sp  ON c.ContractId = sp.ContractId;

    OPEN contract_cursor;
    FETCH NEXT FROM contract_cursor INTO
		--Order of these variables has to match the above selects
        @ContractId, @Organisation, @StreetAddress, @Suburb, @City, @PostCode,
        @SubscriptionLevel, @BaseMonthlyFee, @DiscountPct, @PayFrequency;
	--Loops while there is another row for the cursor to read
    WHILE @@FETCH_STATUS = 0
    BEGIN

        --Calculate GST amounts
        SET @ExclGST  = @BaseMonthlyFee * (1 - ISNULL(@DiscountPct, 0) / 100);
        SET @GSTAmount = @ExclGST * 0.15;
        SET @InclGST  = @ExclGST + @GSTAmount;

        --Print invoice header
        PRINT '====================================================';
        PRINT 'COAST AND CANOPY ROBOTICS - MONTHLY INVOICE';
        PRINT '====================================================';
        PRINT 'Date: ' + CONVERT(VARCHAR, GETDATE(), 103);
        PRINT 'Subscriber: ' + @Organisation;
        PRINT 'Address: ' + @StreetAddress + ', ' + ISNULL(@Suburb + ', ', '') + @City + ', ' + @PostCode;
        PRINT 'Subscription Level: ' + @SubscriptionLevel;
        PRINT 'Payment Frequency: ' + @PayFrequency;
        PRINT '----------------------------------------------------';
        PRINT 'Zones and Services:';

        --Cursor for iterating over zones and services for each contract
        DECLARE zone_cursor CURSOR FOR
            SELECT DISTINCT
                z.Name,
                hc.ServiceType
            FROM [Zone] z
			--Joins to HarvContract to get the service type
            INNER JOIN HarvContract hc ON hc.ContractId = z.ContractId
            WHERE z.ContractId = @ContractId;

        OPEN zone_cursor;
        FETCH NEXT FROM zone_cursor INTO @ZoneName, @ServiceType;
		--Loops while there is another row for the cursor to read
        WHILE @@FETCH_STATUS = 0
        BEGIN

            PRINT '  Zone: ' + ISNULL(@ZoneName, 'Unnamed') + ' | Service: ' + @ServiceType;
            FETCH NEXT FROM zone_cursor INTO @ZoneName, @ServiceType;

        END;

        CLOSE zone_cursor;
        DEALLOCATE zone_cursor;

        --Print invoice totals at the bottom, decimal values casted to VARCHAR
        PRINT '----------------------------------------------------';
        PRINT 'Total (excl. GST): $' + CAST(@ExclGST AS VARCHAR(20));
        PRINT 'GST (15%):         $' + CAST(@GSTAmount AS VARCHAR(20));
        PRINT 'Total (incl. GST): $' + CAST(@InclGST AS VARCHAR(20));
        PRINT '====================================================';
        PRINT '';

        FETCH NEXT FROM contract_cursor INTO
            @ContractId, @Organisation, @StreetAddress, @Suburb, @City, @PostCode,
            @SubscriptionLevel, @BaseMonthlyFee, @DiscountPct, @PayFrequency;

    END;

    CLOSE contract_cursor;
    DEALLOCATE contract_cursor;

END;

GO

--Test execute statement for transaction E
EXECUTE GenerateMonthlyInvoices;

--Transaction F

--For a given HARV list all the suppliers of parts and the last time they were
--maintained. The transaction receives the HARV ID, and presents the Supplier Name,
--Part Name, Last Maintenance.

DROP PROCEDURE IF EXISTS GetHarvPartSuppliers;
GO

CREATE PROCEDURE GetHarvPartSuppliers
    @HarvId INT
AS
BEGIN

    SELECT
        su.Name             AS SupplierName,
        p.Name              AS PartName,
		--Having the LastMaintenace column in PartHarv 
		--greatly simplifies this procedure
        ph.LastMaintenance  AS LastMaintenance
    FROM PartHarv ph
    INNER JOIN Part p           ON ph.PartId = p.PartId
    INNER JOIN SupplierPart sp  ON p.PartId = sp.PartId
    INNER JOIN Supplier su      ON sp.SupplierId = su.SupplierId
    WHERE ph.HarvId = @HarvId
    ORDER BY su.Name, p.Name;

END;

GO

--Test execute for transaction F

EXECUTE GetHarvPartSuppliers
    @HarvId = 1;

--Transaction G

--Find the locations and Zones that a HARV is contracted to, that have not been
--visited to service in the last 5 days. The transaction receives the HARV ID. The
--transaction lists the HARV ID, Contracting Organisation's Name, Zone, and Service
--that has not been undertaken.

DROP PROCEDURE IF EXISTS GetUnservicedZones;

GO

CREATE PROCEDURE GetUnservicedZones
	--Take HArvId as a parameter
    @HarvId INT
AS
BEGIN

    SELECT
		--Selects and column names
        h.HarvId                        AS HarvId,
        s.Organisation                  AS ContractingOrganisation,
        z.Name                          AS Zone,
        hc.ServiceType                  AS Service,
        hz.LastVisited                  AS LastVisited
    FROM HarvZone hz
    INNER JOIN [Zone] z         ON hz.ZoneId = z.ZoneId
	--Joiin HarvContract where the HArvId and ContractId are the same
	--jsut HarvId returns HARVs that are assigned to other contracts
    INNER JOIN HarvContract hc  ON hz.HarvId = hc.HarvId
                                AND z.ContractId = hc.ContractId
    INNER JOIN [Contract] c     ON hc.ContractId = c.ContractId
    INNER JOIN Subscriber s     ON c.SubscriberId = s.SubscriberId
    INNER JOIN Harv h           ON hz.HarvId = h.HarvId
	--Filter by the given HarvId and only zones not visited in the last five days
	--or not yet visited(value will be NULL)
    WHERE hz.HarvId = @HarvId
    AND (hz.LastVisited IS NULL OR hz.LastVisited < DATEADD(DAY, -5, GETDATE()))
	--Order by the last visit date
    ORDER BY hz.LastVisited ASC;

END;

GO

--Test execute for transaction G

EXECUTE GetUnservicedZones
    @HarvId = 11;

--Transaction H

--Delete the data collected for a given Contract. The transaction receives a Contract
--ID; the data collected for a Contract is deleted.

DROP PROCEDURE IF EXISTS DeleteContractData;

GO

CREATE PROCEDURE DeleteContractData
    @ContractId INT
AS
BEGIN

    BEGIN TRANSACTION;
    BEGIN TRY

        DELETE FROM SensorReading
		--SensorReadings ContractId column refers to the platijnum subscription the data is for
        WHERE ContractId = @ContractId;

        COMMIT TRANSACTION;
		--Message on successful deletion
        PRINT 'Sensor data for contract ' + CAST(@ContractId AS VARCHAR) + ' deleted successfully.';

    END TRY
    BEGIN CATCH
		--Rollback on any errors to prevent partial data loss
        ROLLBACK TRANSACTION;
        THROW;

    END CATCH

END;

GO

--Query to check successful deletion, run before and after executing transaction H

SELECT *
	FROM SensorReading
WHERE ContractId = 3;

--Test execute for transaction H

EXECUTE DeleteContractData
    @ContractId = 3;

--Transaction I

--Write a query that displays the total cost of all parts replaced in maintenance of a
--HARV in the last ten years. The transaction displays the HARV ID, the name of the
--Engineer who built the HARV, the beginning date, end date and Total Cost of replaced
--parts, for every HARV.

DROP PROCEDURE IF EXISTS GetHarvPartReplacementCosts;

GO

CREATE PROCEDURE GetHarvPartReplacementCosts
AS
BEGIN

    SELECT
		--Selects and column names
        h.HarvId                                AS HarvId,
        e.FirstName + ' ' + e.LastName          AS EngineerName,
        h.DeploymentDate						AS DateDeployed,
        h.DecomissionDate                       AS DateDecomissioned,
        SUM(mr.ReplacementCost)                 AS TotalCost
    FROM Harv h
	--Join techincal engineer and employee to get the name of the engineer that built the HARV
    INNER JOIN TechnicalEngineer te     ON h.EmployeeId = te.EmployeeId
    INNER JOIN Employee e               ON te.EmployeeId = e.EmployeeId
	--Join maintenance records to get replacement costs
    LEFT JOIN MaintenanceRecord mr      ON h.HarvId = mr.HarvId
										--Filter replacement costs in the last 10 years
                                       AND mr.[TimeStamp] >= DATEADD(YEAR, -10, GETDATE())
									   --NULL replacement cost indicates the part has never been replaced
                                       AND mr.ReplacementCost IS NOT NULL
	--Group on HarvId and name in order to get the sum of costs
    GROUP BY h.HarvId, e.FirstName, e.LastName, h.DeploymentDate, h.DecomissionDate
    ORDER BY h.HarvId;

END;

GO

--Test Execute for trnsaction I

EXECUTE GetHarvPartReplacementCosts;

--Transaction J



DROP PROCEDURE IF EXISTS LogScheduledMaintenance;

GO

CREATE PROCEDURE LogScheduledMaintenance
	--Parameters for insert, decided date could be entered and not always todays date
    @HarvId         INT,
    @MaintainerId   INT,
    @PartId         INT,
    @SupplierId     INT,
    @MaintenanceDate DATETIME
AS
BEGIN

    BEGIN TRANSACTION;
    BEGIN TRY

        -- Get the replacement cost from SupplierPart
        DECLARE @ReplacementCost DECIMAL(10,2);
		--Replacement cost is calculated from the current purchase cost of the given
		--part from the given supplier
        SET @ReplacementCost = (
            SELECT PurchaseCost
            FROM SupplierPart
            WHERE SupplierId = @SupplierId
            AND PartId = @PartId
        );

        --Insert new MaintenanceRecord
        INSERT INTO MaintenanceRecord (HarvId, PartId, EmployeeId, [TimeStamp], ReplacementCost, SupplierId)
        VALUES (@HarvId, @PartId, @MaintainerId, @MaintenanceDate, @ReplacementCost, @SupplierId);

        --Update LastMaintenance in PartHarv, important for other transactions to work
        UPDATE PartHarv
        SET LastMaintenance = @MaintenanceDate
        WHERE HarvId = @HarvId
        AND PartId = @PartId;

        COMMIT TRANSACTION;
        PRINT 'Maintenance record logged successfully for HARV ' + CAST(@HarvId AS VARCHAR) + '.';

    END TRY
    BEGIN CATCH
		--Rollback on error to prevent partieal data
        ROLLBACK TRANSACTION;
        THROW;

    END CATCH

END;

GO

--Test execute for transaction J

EXECUTE LogScheduledMaintenance
    @HarvId          = 1,
    @MaintainerId    = 21,
    @PartId          = 1,
    @SupplierId      = 1,
    @MaintenanceDate = '2026-06-23 09:00:00';

--Test query for transaction J

SELECT *
	FROM MaintenanceRecord
WHERE EmployeeId = 21;

--ROLES AND PERMISSIONS

--Drop the roles if they exist, only works for testing when no users are assigned to the roles
IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'DirectorRole' AND type = 'R')
    DROP ROLE DirectorRole;

IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'AdminExecutiveRole' AND type = 'R')
    DROP ROLE AdminExecutiveRole;

IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'SalespersonRole' AND type = 'R')
    DROP ROLE SalespersonRole;

IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'TechnicalEngineerRole' AND type = 'R')
    DROP ROLE TechnicalEngineerRole;

IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'ThirdPartyMaintainerRole' AND type = 'R')
    DROP ROLE ThirdPartyMaintainerRole;

--Create the 5 roles
CREATE ROLE DirectorRole;
CREATE ROLE AdminExecutiveRole;
CREATE ROLE SalespersonRole;
CREATE ROLE TechnicalEngineerRole;
CREATE ROLE ThirdPartyMaintainerRole;

--Director permissions

--can set and change base monthly and annual subscription fees
GRANT SELECT, UPDATE ON [Contract] TO DirectorRole;

--AdminExecutive permissions

--can enter and modify all contract details including Platinum and SuperPlatinum pricing
GRANT SELECT, INSERT, UPDATE ON [Contract]       TO AdminExecutiveRole;
GRANT SELECT, INSERT, UPDATE ON Platinum         TO AdminExecutiveRole;
GRANT SELECT, INSERT, UPDATE ON SuperPlatinum    TO AdminExecutiveRole;
GRANT SELECT                 ON Subscriber       TO AdminExecutiveRole;
GRANT SELECT                 ON [Zone]           TO AdminExecutiveRole;
GRANT SELECT                 ON Harv             TO AdminExecutiveRole;

--Salesperson permissions

--can sell Standard and Gold subscriptions only
GRANT SELECT, INSERT         ON [Standard]       TO SalespersonRole;
GRANT SELECT, INSERT         ON Gold             TO SalespersonRole;
GRANT SELECT, INSERT         ON [Contract]       TO SalespersonRole;
GRANT SELECT, INSERT         ON Subscriber       TO SalespersonRole;
GRANT SELECT, INSERT         ON [Address]        TO SalespersonRole;
GRANT SELECT, INSERT         ON ContactInfo      TO SalespersonRole;
GRANT SELECT                 ON Harv             TO SalespersonRole;

--TechnicalEngineer permissions

--can view HARV details for HARVs they built
GRANT SELECT                 ON Harv             TO TechnicalEngineerRole;
GRANT SELECT                 ON Part             TO TechnicalEngineerRole;
GRANT SELECT                 ON PartHarv         TO TechnicalEngineerRole;
GRANT SELECT                 ON MaintenanceRecord TO TechnicalEngineerRole;

--ThirdPartyMaintainer permission

--can log maintenance records and supplier data
GRANT SELECT, INSERT, UPDATE ON MaintenanceRecord TO ThirdPartyMaintainerRole;
GRANT SELECT, INSERT, UPDATE ON PartHarv          TO ThirdPartyMaintainerRole;
GRANT SELECT, INSERT         ON SupplierPart      TO ThirdPartyMaintainerRole;
GRANT SELECT                 ON Part              TO ThirdPartyMaintainerRole;
GRANT SELECT                 ON Supplier          TO ThirdPartyMaintainerRole;
GRANT SELECT                 ON Harv              TO ThirdPartyMaintainerRole;