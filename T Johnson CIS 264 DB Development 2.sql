/**********************************
Travis Johnson
CIS 264
"Database Development Assignment 2"
***********************************/

--Create database
CREATE DATABASE AdventureWorksVR_TravisJohnson
GO

--Use database AdventureWorksVR_TravisJohnson
USE AdventureWorksVR_TravisJohnson
GO

--Create three schemas
CREATE SCHEMA Person
GO
CREATE SCHEMA Production
GO
CREATE SCHEMA Purchasing
GO

--Transaction for creating user-defined data types
BEGIN TRANSACTION;
	BEGIN TRY
		CREATE TYPE [dbo].[AccountNumber] FROM [nvarchar](15) NULL
		CREATE TYPE [dbo].[Flag] FROM [bit] NOT NULL
		CREATE TYPE [dbo].[NameStyle] FROM [bit] NOT NULL
		CREATE TYPE [dbo].[Phone] FROM [nvarchar](25) NULL
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO

--Transaction for creating database tables
BEGIN TRANSACTION;
	BEGIN TRY
		--Drop any tables that exist
		DROP TABLE IF EXISTS Person.[Address]
		DROP TABLE IF EXISTS Person.AddressType
		DROP TABLE IF EXISTS Person.BusinessEntity
		DROP TABLE IF EXISTS Person.BusinessEntityAddress
		DROP TABLE IF EXISTS Person.BusinessEntityContact
		DROP TABLE IF EXISTS Person.ContactType
		DROP TABLE IF EXISTS Person.CountryRegion
		DROP TABLE IF EXISTS Person.EmailAddress
		DROP TABLE IF EXISTS Person.[Password]
		DROP TABLE IF EXISTS Person.Person
		DROP TABLE IF EXISTS Person.PersonPhone
		DROP TABLE IF EXISTS Person.PhoneNumberType
		DROP TABLE IF EXISTS Person.StateProvince
		DROP TABLE IF EXISTS Production.Product
		DROP TABLE IF EXISTS Production.ProductCategory
		DROP TABLE IF EXISTS Production.ProductModel
		DROP TABLE IF EXISTS Production.ProductSubcategory
		DROP TABLE IF EXISTS Production.UnitMeasure
		DROP TABLE IF EXISTS Purchasing.ProductVendor
		DROP TABLE IF EXISTS Purchasing.[Status]
		DROP TABLE IF EXISTS Purchasing.Vendor

		--Create tables
		CREATE TABLE Person.[Address]
		(
			AddressID INT IDENTITY(1,1) NOT NULL
			, AddressLine1 NVARCHAR(60) NOT NULL
			, AddressLine2 NVARCHAR(60)
			, City NVARCHAR(30) NOT NULL
			, StateProvinceID INT NOT NULL
			, PostalCode NVARCHAR(15) NOT NULL
			, SpatialLocation GEOGRAPHY
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.AddressType
		(
			AddressTypeID INT IDENTITY(1,1) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.BusinessEntity
		(
			BusinessEntityID INT IDENTITY(1,1) NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.BusinessEntityAddress
		(
			BusinessEntityID INT NOT NULL
			, AddressID INT NOT NULL
			, AddressTypeID INT NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.BusinessEntityContact
		(
			BusinessEntityID INT NOT NULL
			, PersonID INT NOT NULL
			, ContactTypeID INT NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.ContactType
		(
			ContactTypeID INT IDENTITY(1,1) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.CountryRegion
		(
			CountryRegionCode NVARCHAR(3) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.EmailAddress
		(
			BusinessEntityID INT NOT NULL
			, EmailAddressID INT IDENTITY(1,1) NOT NULL
			, EmailAddress NVARCHAR(50) NOT NULL
			, rowguid UNIQUEIDENTIFIER
			, ModifiedDate DATETIME
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.[Password]
		(
			BusinessEntityID INT NOT NULL
			, PasswordHash VARCHAR(128) NOT NULL
			, PasswordSalt VARCHAR(10) NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.Person
		(
			BusinessEntityID INT NOT NULL
			, PersonType NCHAR(2)
			, NameStyle dbo.NameStyle NOT NULL
			, Title NVARCHAR(8)
			, FirstName NVARCHAR(50) NOT NULL
			, MiddleName NVARCHAR(50)
			, LastName NVARCHAR(50) NOT NULL
			, Suffix NVARCHAR(10)
			, EmailPromotion INT NOT NULL
			, AdditionalContactInfo XML
			, Demographics XML
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.PersonPhone
		(
			BusinessEntityID INT NOT NULL
			, PhoneNumber dbo.Phone NOT NULL
			, PhoneNumberTypeID INT NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.PhoneNumberType
		(
			PhoneNumberTypeID INT IDENTITY(1,1) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Person.StateProvince
		(
			StateProvinceID INT IDENTITY(1,1) NOT NULL
			, StateProvinceCode NCHAR(3) NOT NULL
			, CountryRegionCode NVARCHAR(3) NOT NULL
			, IsOnlyStateProvinceFlag dbo.Flag NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, TerritoryID INT
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Production.Product
		(
			ProductID INT IDENTITY(1,1) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, ProductNumber NVARCHAR(25)
			, MakeFlag dbo.Flag
			, FinishedGoodsFlag dbo.Flag
			, Color NVARCHAR(15)
			, SafetyStockLevel SMALLINT
			, ReorderPoint SMALLINT
			, StandardCost MONEY
			, ListPrice MONEY
			, Size NVARCHAR(5)
			, SizeUnitMeasureCode NCHAR(3)
			, WeightUnitMeasureCode NCHAR(3)
			, [Weight] DECIMAL(8,2)
			, DaysToManufacture INT
			, ProductLine NCHAR(2)
			, Class NCHAR(2)
			, Style NCHAR(2)
			, ProductSubcategoryID INT
			, ProductModelID INT
			, SellStartDate DATETIME
			, SellEndDate DATETIME
			, DiscontinuedDate DATETIME
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Production.ProductCategory
		(
			ProductCategoryID INT IDENTITY(1,1) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Production.ProductModel
		(
			ProductModelID INT IDENTITY(1,1) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, CatalogDescription XML
			, Instructions XML
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Production.ProductSubcategory
		(
			ProductSubcategoryID INT IDENTITY(1,1) NOT NULL
			, ProductCategoryID INT NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, rowguid UNIQUEIDENTIFIER NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Production.UnitMeasure
		(
			UnitMeasureCode NCHAR(3) NOT NULL
			, [Name] NVARCHAR(50) NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Purchasing.ProductVendor
		(
			ProductID INT NOT NULL
			, BusinessEntityID INT NOT NULL
			, AverageLeadTime INT
			, StandardPrice MONEY
			, LastReceiptCost MONEY
			, LastReceiptDate DATETIME
			, MinOrderQty INT
			, MaxOrderQty INT
			, OnOrderQty INT
			, UnitMeasureCode NCHAR(3)
			, StatusID INT NOT NULL
			, ApprovingManagerID INT
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Purchasing.[Status]
		(
			StatusID INT IDENTITY(1,1) NOT NULL
			, [Description] NVARCHAR(15) NOT NULL
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
		CREATE TABLE Purchasing.Vendor
		(
			BusinessEntityID INT NOT NULL
			, AccountNumber dbo.AccountNumber
			, [Name] NVARCHAR(50) NOT NULL
			, CreditRating TINYINT
			, PreferredVendorStatus dbo.Flag
			, ActiveFlag dbo.Flag
			, PurchasingWebServicesURL NVARCHAR(1024)
			, StatusID INT NOT NULL
			, ApprovingManagerID INT
			, ModifiedDate DATETIME NOT NULL
			, IsActiveFlag dbo.Flag NOT NULL
		)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO

--Transaction for creating primary keys
BEGIN TRANSACTION;
	BEGIN TRY
		ALTER TABLE Person.[Address]
			ADD CONSTRAINT PK_Address_AddressID PRIMARY KEY CLUSTERED (AddressID)
		ALTER TABLE Person.AddressType
			ADD CONSTRAINT PK_AddressType_AddressTypeID PRIMARY KEY CLUSTERED (AddressTypeID)
		ALTER TABLE Person.BusinessEntity
			ADD CONSTRAINT PK_BusinessEntity_BusinessEntityID PRIMARY KEY CLUSTERED (BusinessEntityID)
		ALTER TABLE Person.BusinessEntityAddress
			ADD CONSTRAINT PK_BusinessEntityAddress_BusinessEntityID_AddressID PRIMARY KEY CLUSTERED (BusinessEntityID, AddressID)
		ALTER TABLE Person.BusinessEntityContact
			ADD CONSTRAINT PK_BusinessEntityContact_BusinessEntityID_PersonID PRIMARY KEY CLUSTERED (BusinessEntityID, PersonID)
		ALTER TABLE Person.ContactType
			ADD CONSTRAINT PK_ContactType_ContactTypeID PRIMARY KEY CLUSTERED (ContactTypeID)
		ALTER TABLE Person.CountryRegion
			ADD CONSTRAINT PK_CountryRegion_CountryRegionCode PRIMARY KEY CLUSTERED (CountryRegionCode)
		ALTER TABLE Person.EmailAddress
			ADD CONSTRAINT PK_EmailAddress_BusinessEntityID_EmailAddressID PRIMARY KEY CLUSTERED (BusinessEntityID, EmailAddressID)
		ALTER TABLE Person.[Password]
			ADD CONSTRAINT PK_Password_BusinessEntityID PRIMARY KEY CLUSTERED (BusinessEntityID)
		ALTER TABLE Person.Person
			ADD CONSTRAINT PK_Person_BusinessEntityID PRIMARY KEY CLUSTERED (BusinessEntityID)
		ALTER TABLE Person.PersonPhone
			ADD CONSTRAINT PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID PRIMARY KEY CLUSTERED (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
		ALTER TABLE Person.PhoneNumberType
			ADD CONSTRAINT PK_PhoneNumberType_PhoneNumberTypeID PRIMARY KEY CLUSTERED (PhoneNumberTypeID)
		ALTER TABLE Person.StateProvince
			ADD CONSTRAINT PK_StateProvince_StateProvinceID PRIMARY KEY CLUSTERED (StateProvinceID)
		ALTER TABLE Production.Product
			ADD CONSTRAINT PK_Product_ProductID PRIMARY KEY CLUSTERED (ProductID)
		ALTER TABLE Production.ProductCategory
			ADD CONSTRAINT PK_ProductCategory_ProductCategoryID PRIMARY KEY CLUSTERED (ProductCategoryID)
		ALTER TABLE Production.ProductModel
			ADD CONSTRAINT PK_ProductModel_ProductModelID PRIMARY KEY CLUSTERED (ProductModelID)
		ALTER TABLE Production.ProductSubcategory
			ADD CONSTRAINT PK_ProductSubcategory_ProductSubcategoryID PRIMARY KEY CLUSTERED (ProductSubcategoryID)
		ALTER TABLE Production.UnitMeasure
			ADD CONSTRAINT PK_UnitMeasure_UnitMeasureCode PRIMARY KEY CLUSTERED (UnitMeasureCode)
		ALTER TABLE Purchasing.ProductVendor
			ADD CONSTRAINT PK_ProductVendor_ProductID_BusinessEntityID PRIMARY KEY CLUSTERED (ProductID, BusinessEntityID)
		ALTER TABLE Purchasing.[Status]
			ADD CONSTRAINT PK_Status_StatusID PRIMARY KEY CLUSTERED (StatusID)
		ALTER TABLE Purchasing.Vendor
			ADD CONSTRAINT PK_Vendor_BusinessEntityID PRIMARY KEY CLUSTERED (BusinessEntityID)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO

--Transaction for creating foreign keys
BEGIN TRANSACTION;
	BEGIN TRY
		ALTER TABLE Person.[Address]
			ADD CONSTRAINT FK_Address_StateProvince_StateProvinceID FOREIGN KEY (StateProvinceID)
				REFERENCES Person.StateProvince (StateProvinceID)
		ALTER TABLE Person.BusinessEntityAddress
			ADD CONSTRAINT FK_BusinessEntityAddress_Address_AddressID FOREIGN KEY (AddressID)
				REFERENCES Person.[Address] (AddressID)
			  , CONSTRAINT FK_BusinessEntityAddress_AddressType_AddressTypeID FOREIGN KEY (AddressTypeID)
				REFERENCES Person.AddressType (AddressTypeID)
			  , CONSTRAINT FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.BusinessEntity (BusinessEntityID)
		ALTER TABLE Person.BusinessEntityContact
			ADD CONSTRAINT FK_BusinessEntityContact_BusinessEntity_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.BusinessEntity (BusinessEntityID)
			  , CONSTRAINT FK_BusinessEntityContact_ContactType_ContactTypeID FOREIGN KEY (ContactTypeID)
				REFERENCES Person.ContactType (ContactTypeID)
			  , CONSTRAINT FK_BusinessEntityContact_Person_PersonID FOREIGN KEY (PersonID)
				REFERENCES Person.Person (BusinessEntityID)
		ALTER TABLE Person.EmailAddress
			ADD CONSTRAINT FK_EmailAddress_Person_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.Person (BusinessEntityID)
		ALTER TABLE Person.[Password]
			ADD CONSTRAINT FK_Password_Person_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.Person (BusinessEntityID)
		ALTER TABLE Person.Person
			ADD CONSTRAINT FK_Person_BusinessEntity_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.BusinessEntity (BusinessEntityID)
		ALTER TABLE Person.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_Person_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.Person (BusinessEntityID)
			  , CONSTRAINT FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID FOREIGN KEY (PhoneNumberTypeID)
				REFERENCES Person.PhoneNumberType (PhoneNumberTypeID)
		ALTER TABLE Person.StateProvince
			ADD CONSTRAINT FK_StateProvince_CountryRegion_CountryRegionCode FOREIGN KEY (CountryRegionCode)
				REFERENCES Person.CountryRegion (CountryRegionCode)
		ALTER TABLE Production.Product
			ADD CONSTRAINT FK_Product_ProductModel_ProductModelID FOREIGN KEY (ProductModelID)
				REFERENCES Production.ProductModel (ProductModelID)
			  , CONSTRAINT FK_Product_ProductSubcategory_ProductSubcategoryID FOREIGN KEY (ProductSubcategoryID)
				REFERENCES Production.ProductSubcategory (ProductSubcategoryID)
			  , CONSTRAINT FK_Product_UnitMeasure_SizeUnitMeasureCode FOREIGN KEY (SizeUnitMeasureCode)
				REFERENCES Production.UnitMeasure (UnitMeasureCode)
			  , CONSTRAINT FK_Product_UnitMeasure_WeightUnitMeasureCode FOREIGN KEY (WeightUnitMeasureCode)
				REFERENCES Production.UnitMeasure (UnitMeasureCode)
		ALTER TABLE Production.ProductSubcategory
			ADD CONSTRAINT FK_ProductSubcategory_ProductCategory_ProductCategoryID FOREIGN KEY (ProductCategoryID)
				REFERENCES Production.ProductCategory (ProductCategoryID)
		ALTER TABLE Purchasing.ProductVendor
			ADD CONSTRAINT FK_ProductVendor_Product_ProductID FOREIGN KEY (ProductID)
				REFERENCES Production.Product (ProductID)
			  , CONSTRAINT FK_ProductVendor_UnitMeasure_UnitMeasureCode FOREIGN KEY (UnitMeasureCode)
				REFERENCES Production.UnitMeasure (UnitMeasureCode)
			  , CONSTRAINT FK_ProductVendor_Vendor_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Purchasing.Vendor (BusinessEntityID)
			  , CONSTRAINT FK_ProductVendor_Status_StatusID FOREIGN KEY (StatusID)
				REFERENCES Purchasing.[Status] (StatusID)
		ALTER TABLE Purchasing.Vendor
			ADD CONSTRAINT FK_Vendor_BusinessEntity_BusinessEntityID FOREIGN KEY (BusinessEntityID)
				REFERENCES Person.BusinessEntity (BusinessEntityID)
			  , CONSTRAINT FK_Vendor_Status_StatusID FOREIGN KEY (StatusID)
				REFERENCES Purchasing.[Status] (StatusID)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO

--Transaction for creating indexes
BEGIN TRANSACTION;
	BEGIN TRY
		CREATE UNIQUE NONCLUSTERED INDEX AK_Address_rowguid
			ON Person.[Address] (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode
			ON Person.[Address] (AddressLine1, AddressLine2, City, StateProvinceID, PostalCode)
		CREATE NONCLUSTERED INDEX IX_Address_StateProvinceID
			ON Person.[Address] (StateProvinceID)
		CREATE UNIQUE NONCLUSTERED INDEX AK_AddressType_Name
			ON Person.AddressType ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_AddressType_rowguid
			ON Person.AddressType (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX AK_BusinessEntity_rowguid
			ON Person.BusinessEntity (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX AK_BusinessEntityAddress_rowguid
			ON Person.BusinessEntityAddress (rowguid)
		CREATE NONCLUSTERED INDEX IX_BusinessEntityAddress_AddressID
			ON Person.BusinessEntityAddress (AddressID)
		CREATE NONCLUSTERED INDEX IX_BusinessEntityAddress_AddressTypeID
			ON Person.BusinessEntityAddress (AddressTypeID)
		CREATE UNIQUE NONCLUSTERED INDEX AK_BusinessEntityContact_rowguid
			ON Person.BusinessEntityContact (rowguid)
		CREATE NONCLUSTERED INDEX IX_BusinessEntityContact_ContactTypeID
			ON Person.BusinessEntityContact (ContactTypeID)
		CREATE NONCLUSTERED INDEX IX_BusinessEntityContact_PersonID
			ON Person.BusinessEntityContact (PersonID)
		CREATE UNIQUE NONCLUSTERED INDEX AK_ContactType_Name
			ON Person.ContactType ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_CountryRegion_Name
			ON Person.CountryRegion ([Name])
		CREATE NONCLUSTERED INDEX IX_EmailAddress_EmailAddress
			ON Person.EmailAddress (EmailAddress)
		CREATE UNIQUE NONCLUSTERED INDEX AK_Person_rowguid
			ON Person.Person (rowguid)
		CREATE NONCLUSTERED INDEX IX_Person_LastName_FirstName_MiddleName
			ON Person.Person (LastName, FirstName, MiddleName)
		CREATE PRIMARY XML INDEX PXML_Person_AddContact
			ON Person.Person (AdditionalContactInfo)
		CREATE PRIMARY XML INDEX PXML_Person_Demographics
			ON Person.Person (Demographics)
		CREATE XML INDEX XMLPATH_Person_Demographics
			ON Person.Person (Demographics)
			USING XML INDEX [PXML_Person_Demographics] FOR PATH WITH (PAD_INDEX = OFF
																	, STATISTICS_NORECOMPUTE = OFF
																	, SORT_IN_TEMPDB = OFF
																	, DROP_EXISTING = OFF
																	, ONLINE = OFF
																	, ALLOW_ROW_LOCKS = ON
																	, ALLOW_PAGE_LOCKS = ON)
		CREATE XML INDEX XMLPROPERTY_Person_Demographics
			ON Person.Person (Demographics)
			USING XML INDEX [PXML_Person_Demographics] FOR PROPERTY WITH (PAD_INDEX = OFF
																		, STATISTICS_NORECOMPUTE = OFF
																		, SORT_IN_TEMPDB = OFF
																		, DROP_EXISTING = OFF
																		, ONLINE = OFF
																		, ALLOW_ROW_LOCKS = ON
																		, ALLOW_PAGE_LOCKS = ON)
		CREATE XML INDEX XMLVALUE_Person_Demographics
			ON Person.Person (Demographics)
			USING XML INDEX [PXML_Person_Demographics] FOR VALUE WITH (PAD_INDEX = OFF
																	 , STATISTICS_NORECOMPUTE = OFF
																	 , SORT_IN_TEMPDB = OFF
																	 , DROP_EXISTING = OFF
																	 , ONLINE = OFF
																	 , ALLOW_ROW_LOCKS = ON
																	 , ALLOW_PAGE_LOCKS = ON)
		CREATE NONCLUSTERED INDEX IX_PersonPhone_PhoneNumber
			ON Person.PersonPhone (PhoneNumber)
		CREATE UNIQUE NONCLUSTERED INDEX AK_StateProvince_Name
			ON Person.StateProvince ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_StateProvince_rowguid
			ON Person.StateProvince (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX AK_StateProvince_StateProvinceCode_CountryRegionCode
			ON Person.StateProvince (StateProvinceCode, CountryRegionCode)
		CREATE UNIQUE NONCLUSTERED INDEX AK_Product_Name
			ON Production.Product ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_Product_ProductNumber
			ON Production.Product (ProductNumber)
		CREATE UNIQUE NONCLUSTERED INDEX AK_Product_rowguid
			ON Production.Product (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX AK_ProductCategory_Name
			ON Production.ProductCategory ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_ProductCategory_rowguid
			ON Production.ProductCategory (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX AK_ProductModel_Name
			ON Production.ProductModel ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_ProductModel_rowguid
			ON Production.ProductModel (rowguid)
		CREATE PRIMARY XML INDEX PXML_ProductModel_CatalogDescription
			ON Production.ProductModel (CatalogDescription)
		CREATE PRIMARY XML INDEX PXML_ProductModel_Instructions
			ON Production.ProductModel (Instructions)
		CREATE UNIQUE NONCLUSTERED INDEX AK_ProductSubcategory_Name
			ON Production.ProductSubcategory ([Name])
		CREATE UNIQUE NONCLUSTERED INDEX AK_ProductSubcategory_rowguid
			ON Production.ProductSubcategory (rowguid)
		CREATE UNIQUE NONCLUSTERED INDEX AK_UnitMeasure_Name
			ON Production.UnitMeasure ([Name])
		CREATE NONCLUSTERED INDEX IX_ProductVendor_BusinessEntityID
			ON Purchasing.ProductVendor (BusinessEntityID)
		CREATE NONCLUSTERED INDEX IX_ProductVendor_UnitMeasureCode
			ON Purchasing.ProductVendor (UnitMeasureCode)
		CREATE UNIQUE NONCLUSTERED INDEX AK_Status_Description
			ON Purchasing.[Status] ([Description])
		CREATE UNIQUE NONCLUSTERED INDEX AK_Vendor_AccountNumber
			ON Purchasing.Vendor (AccountNumber)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO

--Transaction for creating constraints
BEGIN TRANSACTION;
	BEGIN TRY
		ALTER TABLE Person.[Address]
			ADD CONSTRAINT DF_Address_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_Address_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_Address_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.AddressType
			ADD CONSTRAINT DF_AddressType_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_AddressType_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_AddressType_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.BusinessEntity
			ADD CONSTRAINT DF_BusinessEntity_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_BusinessEntity_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_BusinessEntity_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.BusinessEntityAddress
			ADD CONSTRAINT DF_BusinessEntityAddress_ModifiedDate  DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_BusinessEntityAddress_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_BusinessEntityAddress_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.BusinessEntityContact
			ADD CONSTRAINT DF_BusinessEntityContact_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_BusinessEntityContact_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_BusinessEntityContact_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.ContactType
			ADD CONSTRAINT DF_ContactType_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_ContactType_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.CountryRegion
			ADD CONSTRAINT DF_CountryRegion_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_CountryRegion_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.EmailAddress
			ADD CONSTRAINT DF_EmailAddress_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_EmailAddress_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_EmailAddress_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.[Password]
			ADD CONSTRAINT DF_Password_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_Password_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_Password_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.Person WITH CHECK
			ADD CONSTRAINT CK_Person_EmailPromotion CHECK (EmailPromotion >= 0 AND EmailPromotion <= 2)
			  , CONSTRAINT CK_Person_PersonType CHECK (PersonType IS NULL 
													OR UPPER(PersonType) = 'GC'
													OR UPPER(PersonType) = 'SP'
													OR UPPER(PersonType) = 'EM'
													OR UPPER(PersonType) = 'IN'
													OR UPPER(PersonType) = 'VC'
													OR UPPER(PersonType) = 'SC')
			  , CONSTRAINT DF_Person_EmailPromotion DEFAULT (0) FOR EmailPromotion
			  , CONSTRAINT DF_Person_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_Person_NameStyle DEFAULT (0) FOR NameStyle
			  , CONSTRAINT DF_Person_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_Person_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.PersonPhone
			ADD CONSTRAINT DF_PersonPhone_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_PersonPhone_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.PhoneNumberType
			ADD CONSTRAINT DF_PhoneNumberType_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Person.StateProvince
			ADD CONSTRAINT DF_StateProvince_IsOnlyStateProvinceFlag DEFAULT (1) FOR IsOnlyStateProvinceFlag
			  , CONSTRAINT DF_StateProvince_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_StateProvince_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_StateProvince_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Production.Product WITH CHECK
			ADD CONSTRAINT CK_Product_Class CHECK (UPPER(Class) = 'H'
												OR UPPER(Class) = 'M'
												OR UPPER(Class) = 'L'
												OR Class IS NULL)
			  , CONSTRAINT CK_Product_DaysToManufacture CHECK (DaysToManufacture >= 0)
			  , CONSTRAINT CK_Product_ListPrice CHECK (ListPrice >= 0.00)
			  , CONSTRAINT CK_Product_ProductLine CHECK (UPPER(ProductLine) = 'R'
													  OR UPPER(ProductLine) = 'M'
													  OR UPPER(ProductLine) = 'T'
													  OR UPPER(ProductLine) = 'S'
													  OR ProductLine IS NULL)
			  , CONSTRAINT CK_Product_ReorderPoint CHECK (ReorderPoint > 0)
			  , CONSTRAINT CK_Product_SafetyStockLevel CHECK (SafetyStockLevel > 0)
			  , CONSTRAINT CK_Product_SellEndDate CHECK (SellEndDate >= SellStartDate
													  OR SellEndDate IS NULL)
			  , CONSTRAINT CK_Product_StandardCost CHECK (StandardCost >= 0.00)
			  , CONSTRAINT CK_Product_Style CHECK (UPPER(Style) = 'U'
												OR UPPER(Style) = 'M'
												OR UPPER(Style) = 'W'
												OR Style IS NULL)
			  , CONSTRAINT CK_Product_Weight CHECK ([Weight] > 0.00)
			  , CONSTRAINT DF_Product_FinishedGoodsFlag DEFAULT (1) FOR FinishedGoodsFlag
			  , CONSTRAINT DF_Product_MakeFlag DEFAULT (1) FOR MakeFlag
			  , CONSTRAINT DF_Product_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_Product_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_Product_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Production.ProductCategory
			ADD CONSTRAINT DF_ProductCategory_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_ProductCategory_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_ProductCategory_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Production.ProductModel
			ADD CONSTRAINT DF_ProductModel_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_ProductModel_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_ProductModel_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Production.ProductSubcategory
			ADD CONSTRAINT DF_ProductSubcategory_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_ProductSubcategory_rowguid DEFAULT (NEWID()) FOR rowguid
			  , CONSTRAINT DF_ProductSubcategory_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Production.UnitMeasure
			ADD CONSTRAINT DF_UnitMeasure_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_UnitMeasure_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Purchasing.ProductVendor WITH CHECK
			ADD CONSTRAINT CK_ProductVendor_AverageLeadTime CHECK (AverageLeadTime >= 1)
			  , CONSTRAINT CK_ProductVendor_LastReceiptCost CHECK (LastReceiptCost > 0.00)
			  , CONSTRAINT CK_ProductVendor_MaxOrderQty CHECK (MaxOrderQty >= 1)
			  , CONSTRAINT CK_ProductVendor_MinOrderQty CHECK (MinOrderQty >= 1)
			  , CONSTRAINT CK_ProductVendor_OnOrderQty CHECK (OnOrderQty >= 0)
			  , CONSTRAINT CK_ProductVendor_StandardPrice CHECK (StandardPrice > 0.00)
			  , CONSTRAINT DF_ProductVendor_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_ProductVendor_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Purchasing.[Status]
			ADD CONSTRAINT DF_Status_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_Status_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
		ALTER TABLE Purchasing.Vendor WITH CHECK
			ADD CONSTRAINT CK_Vendor_CreditRating CHECK (CreditRating >= 1 AND CreditRating <= 5)
			  , CONSTRAINT DF_Vendor_ActiveFlag DEFAULT (1) FOR ActiveFlag
			  , CONSTRAINT DF_Vendor_ModifiedDate DEFAULT (GETDATE()) FOR ModifiedDate
			  , CONSTRAINT DF_Vendor_PreferredVendorStatus DEFAULT (1) FOR PreferredVendorStatus
			  , CONSTRAINT DF_Vendor_IsActiveFlag DEFAULT (1) FOR IsActiveFlag
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO

--Create stored procedures

-- uspPrintError prints error information about the error that caused 
-- execution to jump to the CATCH block of a TRY...CATCH construct. 
-- Should be executed from within the scope of a CATCH block otherwise 
-- it will return without printing any error information.
CREATE PROCEDURE dbo.uspPrintError
AS
BEGIN
	SET NOCOUNT ON;

	-- Print error information. 
	PRINT 'Error ' + CONVERT(varchar(50), ERROR_NUMBER()) +
			', Severity ' + CONVERT(varchar(5), ERROR_SEVERITY()) +
			', State ' + CONVERT(varchar(5), ERROR_STATE()) + 
			', Procedure ' + ISNULL(ERROR_PROCEDURE(), '-') + 
			', Line ' + CONVERT(varchar(5), ERROR_LINE());
	PRINT ERROR_MESSAGE();
END;
GO

-- uspLogError logs error information in the ErrorLog table about the 
-- error that caused execution to jump to the CATCH block of a 
-- TRY...CATCH construct. This should be executed from within the scope 
-- of a CATCH block otherwise it will return without inserting error 
-- information. 
CREATE PROCEDURE dbo.uspLogError 
	@ErrorLogID int = 0 OUTPUT -- contains the ErrorLogID of the row inserted
AS                               -- by uspLogError in the ErrorLog table
BEGIN
	SET NOCOUNT ON;

	-- Output parameter value of 0 indicates that error 
	-- information was not logged
	SET @ErrorLogID = 0;

	BEGIN TRY
		-- Return if there is no error information to log
		IF ERROR_NUMBER() IS NULL
			RETURN;

		-- Return if inside an uncommittable transaction.
		-- Data insertion/modification is not allowed when 
		-- a transaction is in an uncommittable state.
		IF XACT_STATE() = -1
		BEGIN
			PRINT 'Cannot log error since the current transaction is in an uncommittable state. ' 
				+ 'Rollback the transaction before executing uspLogError in order to successfully log error information.';
			RETURN;
		END

		INSERT dbo.ErrorLog 
			(
			UserName, 
			ErrorNumber, 
			ErrorSeverity, 
			ErrorState, 
			ErrorProcedure, 
			ErrorLine, 
			ErrorMessage
			) 
		VALUES 
			(
			CONVERT(sysname, CURRENT_USER), 
			ERROR_NUMBER(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE()
			);

		-- Pass back the ErrorLogID of the row inserted
		SET @ErrorLogID = @@IDENTITY;
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred in stored procedure uspLogError: ';
		EXECUTE dbo.uspPrintError;
		RETURN -1;
	END CATCH
END;
GO

-- #########################################################
-- Author:	www.sqlbook.com
-- Copyright:	(c) www.sqlbook.com. You are free to use and redistribute
--		this script as long as this comments section with the 
--		author and copyright details are not altered.
-- Purpose:	For a specified user defined table (or all user defined
--		tables) in the database this script generates 4 Stored 
--		Procedure definitions with different Procedure name 
--		suffixes:
--		1) List all records in the table (suffix of  _lst)
--		2) Get a specific record from the table (suffix of _sel)
--		3) UPDATE or INSERT (UPSERT) - (suffix of _ups)
--		4) DELETE a specified row - (suffix of _del)
--		e.g. For a table called location the script will create
--		procedure definitions for the following procedures:
--		dbo.udp_Location_lst
--		dbo.udp_Location_sel
--		dbo.udp_Location_ups
--		dbo.udp_Location_del
-- Notes: 	The stored procedure definitions can either be printed
--		to the screen or executed using EXEC sp_ExecuteSQL.
--		The stored proc names are prefixed with udp_ to avoid 
--		conflicts with system stored procs.
-- Assumptions:	- This script assumes that the primary key is the first
--		column in the table and that if the primary key is
--		an integer then it is an IDENTITY (autonumber) field.
--		- This script is not suitable for the link tables
--		in the middle of a many to many relationship.
--		- After the script has run you will need to add
--		an ORDER BY clause into the '_lst' procedures
--		according to your needs / required sort order.
--		- Assumes you have set valid values for the 
--		config variables in the section immediately below
-- #########################################################

-- ##########################################################
/* SET CONFIG VARIABLES THAT ARE USED IN SCRIPT */
-- ##########################################################

-- Do we want to generate the SP definitions for every user defined
-- table in the database or just a single specified table?
-- Assign a blank string - '' for all tables or the table name for
-- a single table.
DECLARE @GenerateProcsFor varchar(100)
SET @GenerateProcsFor = ''
--SET @GenerateProcsFor = ''

-- which database do we want to create the procs for?
-- Change both the USE and SET lines below to set the datbase name
-- to the required database.
USE AdventureWorksVR_TravisJohnson
DECLARE @DatabaseName varchar(100)
SET @DatabaseName = 'AdventureWorksVR_TravisJohnson'

-- do we want the script to print out the CREATE PROC statements
-- or do we want to execute them to actually create the procs?
-- Assign a value of either 'Print' or 'Execute'
DECLARE @PrintOrExecute varchar(10)
SET @PrintOrExecute = 'Execute'


-- Is there a table name prefix i.e. 'tbl_' which we don't want
-- to include in our stored proc names?
DECLARE @TablePrefix varchar(10)
SET @TablePrefix = ''

-- For our '_lst' and '_sel' procedures do we want to 
-- do SELECT * or SELECT [ColumnName,]...
-- Assign a value of either 1 or 0
DECLARE @UseSelectWildCard bit
SET @UseSelectWildCard = 0

-- ##########################################################
/* END SETTING OF CONFIG VARIABLE 
-- do not edit below this line */
-- ##########################################################


-- DECLARE CURSOR containing all columns from user defined tables
-- in the database
DECLARE TableCol Cursor FOR 
SELECT c.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.DATA_TYPE, c.CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.Columns c INNER JOIN
	INFORMATION_SCHEMA.Tables t ON c.TABLE_NAME = t.TABLE_NAME
WHERE t.Table_Catalog = @DatabaseName
	AND t.TABLE_TYPE = 'BASE TABLE'
ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION

-- Declare variables which will hold values from cursor rows
DECLARE @TableSchema varchar(100), @TableName varchar(100)
DECLARE @ColumnName varchar(100), @DataType varchar(30)
DECLARE @CharLength int

DECLARE @ColumnNameCleaned varchar(100)

-- Declare variables which will track what table we are
-- creating Stored Procs for
DECLARE @CurrentTable varchar(100)
DECLARE @FirstTable bit
DECLARE @FirstColumnName varchar(100)
DECLARE @FirstColumnDataType varchar(30)
DECLARE @ObjectName varchar(100) -- this is the tablename with the 
				-- specified tableprefix lopped off.
DECLARE @TablePrefixLength int

-- init vars
SET @CurrentTable = ''
SET @FirstTable = 1
SET @TablePrefixLength = Len(@TablePrefix)

-- Declare variables which will hold the queries we are building use unicode
-- data types so that can execute using sp_ExecuteSQL
DECLARE @LIST nvarchar(4000), @UPSERT nvarchar(4000)
DECLARE @SELECT nvarchar(4000), @INSERT nvarchar(4000), @INSERTVALUES varchar(4000)
DECLARE @UPDATE nvarchar(4000), @DELETE nvarchar(4000)


-- open the cursor
OPEN TableCol

-- get the first row of cursor into variables
FETCH NEXT FROM TableCol INTO @TableSchema, @TableName, @ColumnName, @DataType, @CharLength

-- loop through the rows of the cursor
WHILE @@FETCH_STATUS = 0 BEGIN

	SET @ColumnNameCleaned = Replace(@ColumnName, ' ', '')

	-- is this a new table?
	IF @TableName <> @CurrentTable BEGIN
		
		-- if is the end of the last table
		IF @CurrentTable <> '' BEGIN
			IF @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable BEGIN

				-- first add any syntax to end the statement
				
				-- _lst
				SET @LIST = @List + Char(13) + 'FROM ' + @CurrentTable + Char(13)
				SET @LIST = @LIST + Char(13) + Char(13) + 'SET NOCOUNT OFF' + Char(13) + Char(13)
				SET @LIST = @LIST + Char(13)
				
				-- _sel
				SET @SELECT = @SELECT + Char(13) + 'FROM ' + @CurrentTable + Char(13)
				SET @SELECT = @SELECT + 'WHERE [' + @FirstColumnName + '] = @' + Replace(@FirstColumnName, ' ', '') + Char(13)
				SET @SELECT = @SELECT + Char(13) + Char(13) + 'SET NOCOUNT OFF' + Char(13) + Char(13)
				SET @SELECT = @SELECT + Char(13)
	
	
				-- UPDATE (remove trailing comma and append the WHERE clause)
				SET @UPDATE = SUBSTRING(@UPDATE, 0, LEN(@UPDATE)- 1) + Char(13) + Char(9) + 'WHERE [' + @FirstColumnName + '] = @' + Replace(@FirstColumnName, ' ', '') + Char(13)
				
				-- INSERT
				SET @INSERT = SUBSTRING(@INSERT, 0, LEN(@INSERT) - 1) + Char(13) + Char(9) + ')' + Char(13)
				SET @INSERTVALUES = SUBSTRING(@INSERTVALUES, 0, LEN(@INSERTVALUES) -1) + Char(13) + Char(9) + ')'
				SET @INSERT = @INSERT + @INSERTVALUES
				
				-- _ups
				SET @UPSERT = @UPSERT + Char(13) + 'AS' + Char(13)
				SET @UPSERT = @UPSERT + 'SET NOCOUNT ON' + Char(13)
				IF @FirstColumnDataType IN ('int', 'bigint', 'smallint', 'tinyint', 'float', 'decimal')
				BEGIN
					SET @UPSERT = @UPSERT + 'IF @' + Replace(@FirstColumnName, ' ', '') + ' = 0 BEGIN' + Char(13)
				END ELSE BEGIN
					SET @UPSERT = @UPSERT + 'IF @' + Replace(@FirstColumnName, ' ', '') + ' = '''' BEGIN' + Char(13)	
				END
				SET @UPSERT = @UPSERT + ISNULL(@INSERT, '') + Char(13)
				SET @UPSERT = @UPSERT + Char(9) + 'SELECT SCOPE_IDENTITY() As InsertedID' + Char(13)
				SET @UPSERT = @UPSERT + 'END' + Char(13)
				SET @UPSERT = @UPSERT + 'ELSE BEGIN' + Char(13)
				SET @UPSERT = @UPSERT + ISNULL(@UPDATE, '') + Char(13)
				SET @UPSERT = @UPSERT + 'END' + Char(13) + Char(13)
				SET @UPSERT = @UPSERT + 'SET NOCOUNT OFF' + Char(13) + Char(13)
				SET @UPSERT = @UPSERT + Char(13)
	
				-- _del
				-- delete proc completed already
	
				-- --------------------------------------------------
				-- now either print the SP definitions or 
				-- execute the statements to create the procs
				-- --------------------------------------------------
				IF @PrintOrExecute <> 'Execute' BEGIN
					PRINT @LIST
					PRINT @SELECT
					PRINT @UPSERT
					PRINT @DELETE
				END ELSE BEGIN
					EXEC sp_Executesql @LIST
					EXEC sp_Executesql @SELECT
					EXEC sp_Executesql @UPSERT
					EXEC sp_Executesql @DELETE
				END
			END -- end @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable
		END
		
		-- update the value held in @CurrentTable
		SET @CurrentTable = @TableName
		SET @FirstColumnName = @ColumnName
		SET @FirstColumnDataType = @DataType
		
		IF @TablePrefixLength > 0 BEGIN
			IF SUBSTRING(@CurrentTable, 1, @TablePrefixLength) = @TablePrefix BEGIN
				--PRINT Char(13) + 'DEBUG: OBJ NAME: ' + RIGHT(@CurrentTable, LEN(@CurrentTable) - @TablePrefixLength)
				SET @ObjectName = RIGHT(@CurrentTable, LEN(@CurrentTable) - @TablePrefixLength)
			END ELSE BEGIN
				SET @ObjectName = @CurrentTable
			END
		END ELSE BEGIN
			SET @ObjectName = @CurrentTable
		END
		
		IF @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable BEGIN
		
			-- ----------------------------------------------------
			-- now start building the procedures for the next table
			-- ----------------------------------------------------
			
			-- _lst
			SET @LIST = 'CREATE PROC [dbo].[udp_' + @ObjectName + '_lst]' + Char(13)
			SET @LIST = @LIST + 'AS' + Char(13)
			SET @LIST = @LIST + 'SET NOCOUNT ON' + Char(13)
			IF @UseSelectWildcard = 1 BEGIN
				SET @LIST = @LIST + Char(13) + 'SELECT * '
			END 
			ELSE BEGIN
				SET @LIST = @LIST + Char(13) + 'SELECT [' + @ColumnName + ']'
			END
	
			-- _sel
			SET @SELECT = 'CREATE PROC [dbo].[udp_' + @ObjectName + '_sel]' + Char(13)
			SET @SELECT = @SELECT + Char(9) + '@' + @ColumnNameCleaned + ' ' + @DataType
			IF @DataType IN ('varchar', 'nvarchar', 'char', 'nchar') BEGIN
				SET @SELECT = @SELECT + '(' + CAST(@CharLength As varchar(10)) + ')'
			END
			SET @SELECT = @SELECT + Char(13) + 'AS' + Char(13)
			SET @SELECT = @SELECT + 'SET NOCOUNT ON' + Char(13)
			IF @UseSelectWildcard = 1 BEGIN
				SET @SELECT = @SELECT + Char(13) + 'SELECT * '
			END 
			ELSE BEGIN
				SET @SELECT = @SELECT + Char(13) + 'SELECT [' + @ColumnName + ']'
			END
	
			-- _ups
			SET @UPSERT = 'CREATE PROC [dbo].[udp_' + @ObjectName + '_ups]' + Char(13)
					SET @UPSERT = @UPSERT + Char(13) + Char(9) + '@' + @ColumnNameCleaned + ' ' + @DataType
			IF @DataType IN ('varchar', 'nvarchar', 'char', 'nchar') BEGIN
				SET @UPSERT = @UPSERT + '(' + CAST(@CharLength As Varchar(10)) + ')'
			END
	
			-- UPDATE
			SET @UPDATE = Char(9) + 'UPDATE ' + @TableName + ' SET ' + Char(13)
			
			-- INSERT -- don't add first column to insert if it is an
			--	     integer (assume autonumber)
			SET @INSERT = Char(9) + 'INSERT INTO ' + @TableName + ' (' + Char(13)
			SET @INSERTVALUES = Char(9) + 'VALUES (' + Char(13)
			
			IF @FirstColumnDataType NOT IN ('int', 'bigint', 'smallint', 'tinyint')
			BEGIN
				SET @INSERT = @INSERT + Char(9) + Char(9) + '[' + @ColumnName + '],' + Char(13)
				SET @INSERTVALUES = @INSERTVALUES + Char(9) + Char(9) + '@' + @ColumnNameCleaned + ',' + Char(13)
			END
	
			-- _del
			SET @DELETE = 'CREATE PROC [dbo].[udp_' + @ObjectName + '_del]' + Char(13)
			SET @DELETE = @DELETE + Char(9) + '@' + @ColumnNameCleaned + ' ' + @DataType
			IF @DataType IN ('varchar', 'nvarchar', 'char', 'nchar') BEGIN
				SET @DELETE = @DELETE + '(' + CAST(@CharLength As Varchar(10)) + ')'
			END
			SET @DELETE = @DELETE + Char(13) + 'AS' + Char(13)
			SET @DELETE = @DELETE + 'SET NOCOUNT ON' + Char(13) + Char(13)
			SET @DELETE = @DELETE + 'DELETE FROM ' + @TableName + Char(13)
			SET @DELETE = @DELETE + 'WHERE [' + @ColumnName + '] = @' + @ColumnNameCleaned + Char(13)
			SET @DELETE = @DELETE + Char(13) + 'SET NOCOUNT OFF' + Char(13)
			SET @DELETE = @DELETE + Char(13) 

		END	-- end @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable
	END
	ELSE BEGIN
		IF @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable BEGIN
		
			-- is the same table as the last row of the cursor
			-- just append the column
			
			-- _lst
			IF @UseSelectWildCard = 0 BEGIN
				SET @LIST = @LIST + ', ' + Char(13) + Char(9) + '[' + @ColumnName + ']'
			END
	
			-- _sel
			IF @UseSelectWildCard = 0 BEGIN
				SET @SELECT = @SELECT + ', ' + Char(13) + Char(9) + '[' + @ColumnName + ']'
			END
	
			-- _ups
			SET @UPSERT = @UPSERT + ',' + Char(13) + Char(9) + '@' + @ColumnNameCleaned + ' ' + @DataType
			IF @DataType IN ('varchar', 'nvarchar', 'char', 'nchar') BEGIN
				SET @UPSERT = @UPSERT + '(' + CAST(@CharLength As varchar(10)) + ')'
			END
	
			-- UPDATE
			SET @UPDATE = @UPDATE + Char(9) + Char(9) + '[' + @ColumnName + '] = @' + @ColumnNameCleaned + ',' + Char(13)
	
			-- INSERT
			SET @INSERT = @INSERT + Char(9) + Char(9) + '[' + @ColumnName + '],' + Char(13)
			SET @INSERTVALUES = @INSERTVALUES + Char(9) + Char(9) + '@' + @ColumnNameCleaned + ',' + Char(13)
	
			-- _del
			-- delete proc completed already
		END -- end @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable'
	END

	-- fetch next row of cursor into variables
	FETCH NEXT FROM TableCol INTO @TableSchema, @TableName, @ColumnName, @DataType, @CharLength
END

-- ----------------
-- clean up cursor
-- ----------------
CLOSE TableCol
DEALLOCATE TableCol

-- ------------------------------------------------
-- repeat the block of code from within the cursor
-- So that the last table has its procs completed
-- and printed / executed
-- ------------------------------------------------

-- if is the end of the last table
IF @CurrentTable <> '' BEGIN
	IF @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable BEGIN

		-- first add any syntax to end the statement
		
		-- _lst
		SET @LIST = @List + Char(13) + 'FROM ' + @CurrentTable + Char(13)
		SET @LIST = @LIST + Char(13) + Char(13) + 'SET NOCOUNT OFF' + Char(13)
		SET @LIST = @LIST + Char(13)
		
		-- _sel
		SET @SELECT = @SELECT + Char(13) + 'FROM ' + @CurrentTable + Char(13)
		SET @SELECT = @SELECT + 'WHERE [' + @FirstColumnName + '] = @' + Replace(@FirstColumnName, ' ', '') + Char(13)
		SET @SELECT = @SELECT + Char(13) + Char(13) + 'SET NOCOUNT OFF' + Char(13)
		SET @SELECT = @SELECT + Char(13)


		-- UPDATE (remove trailing comma and append the WHERE clause)
		SET @UPDATE = SUBSTRING(@UPDATE, 0, LEN(@UPDATE)- 1) + Char(13) + Char(9) + 'WHERE [' + @FirstColumnName + '] = @' + Replace(@FirstColumnName, ' ', '') + Char(13)
		
		-- INSERT
		SET @INSERT = SUBSTRING(@INSERT, 0, LEN(@INSERT) - 1) + Char(13) + Char(9) + ')' + Char(13)
		SET @INSERTVALUES = SUBSTRING(@INSERTVALUES, 0, LEN(@INSERTVALUES) -1) + Char(13) + Char(9) + ')'
		SET @INSERT = @INSERT + @INSERTVALUES
		
		-- _ups
		SET @UPSERT = @UPSERT + Char(13) + 'AS' + Char(13)
		SET @UPSERT = @UPSERT + 'SET NOCOUNT ON' + Char(13)
		IF @FirstColumnDataType IN ('int', 'bigint', 'smallint', 'tinyint', 'float', 'decimal')
		BEGIN
			SET @UPSERT = @UPSERT + 'IF @' + Replace(@FirstColumnName, ' ', '') + ' = 0 BEGIN' + Char(13)
		END ELSE BEGIN
			SET @UPSERT = @UPSERT + 'IF @' + Replace(@FirstColumnName, ' ', '') + ' = '''' BEGIN' + Char(13)	
		END
		SET @UPSERT = @UPSERT + ISNULL(@INSERT, '') + Char(13)
		SET @UPSERT = @UPSERT + Char(9) + 'SELECT SCOPE_IDENTITY() As InsertedID' + Char(13)
		SET @UPSERT = @UPSERT + 'END' + Char(13)
		SET @UPSERT = @UPSERT + 'ELSE BEGIN' + Char(13)
		SET @UPSERT = @UPSERT + ISNULL(@UPDATE, '') + Char(13)
		SET @UPSERT = @UPSERT + 'END' + Char(13) + Char(13)
		SET @UPSERT = @UPSERT + 'SET NOCOUNT OFF' + Char(13)
		SET @UPSERT = @UPSERT + Char(13)

		-- _del
		-- delete proc completed already

		-- --------------------------------------------------
		-- now either print the SP definitions or 
		-- execute the statements to create the procs
		-- --------------------------------------------------
		IF @PrintOrExecute <> 'Execute' BEGIN
			PRINT @LIST
			PRINT @SELECT
			PRINT @UPSERT
			PRINT @DELETE
		END ELSE BEGIN
			EXEC sp_Executesql @LIST
			EXEC sp_Executesql @SELECT
			EXEC sp_Executesql @UPSERT
			EXEC sp_Executesql @DELETE
		END
	END -- end @GenerateProcsFor = '' OR @GenerateProcsFor = @CurrentTable
END
GO

--Create user-defined functions
CREATE FUNCTION dbo.ufnLeadingZeros(@Value int) 
RETURNS varchar(8) 
WITH SCHEMABINDING 
AS 
BEGIN
	DECLARE @ReturnValue varchar(8);

	SET @ReturnValue = CONVERT(varchar(8), @Value);
	SET @ReturnValue = REPLICATE('0', 8 - DATALENGTH(@ReturnValue)) + @ReturnValue;

	RETURN (@ReturnValue);
END;
GO

--Create triggers
CREATE TRIGGER Person.iuPerson ON Person.Person 
AFTER INSERT, UPDATE NOT FOR REPLICATION AS 
BEGIN
	DECLARE @Count int;

	SET @Count = @@ROWCOUNT;
	IF @Count = 0 
		RETURN;

	SET NOCOUNT ON;

	IF UPDATE(BusinessEntityID) OR UPDATE(Demographics) 
	BEGIN
		UPDATE Person.Person 
		SET Person.Person.Demographics = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
			<TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
			</IndividualSurvey>' 
		FROM inserted 
		WHERE Person.Person.BusinessEntityID = inserted.BusinessEntityID
			AND inserted.Demographics IS NULL;
        
		UPDATE Person.Person 
		SET Demographics.modify(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
			insert <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
			as first 
			into (/IndividualSurvey)[1]') 
		FROM inserted 
		WHERE Person.Person.BusinessEntityID = inserted.BusinessEntityID 
			AND inserted.Demographics IS NOT NULL 
			AND inserted.Demographics.exist(N'declare default element namespace 
				"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
				/IndividualSurvey/TotalPurchaseYTD') <> 1;
	END;
END;
GO

CREATE TRIGGER Person.dAddress ON Person.[Address]
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.[Address]
	SET IsActiveFlag = 0
	WHERE AddressID IN (SELECT AddressID FROM deleted)
END
GO

CREATE TRIGGER Person.dAddressType ON Person.AddressType
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.AddressType
	SET IsActiveFlag = 0
	WHERE AddressTypeID IN (SELECT AddressTypeID FROM deleted)
END
GO

CREATE TRIGGER Person.dBusinessEntity ON Person.BusinessEntity
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.BusinessEntity
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
END
GO

CREATE TRIGGER Person.dBusinessEntityAddress ON Person.BusinessEntityAddress
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.BusinessEntityAddress
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
	  AND AddressID IN (SELECT AddressID FROM deleted)
END
GO

CREATE TRIGGER Person.dBusinessEntityContact ON Person.BusinessEntityContact
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.BusinessEntityContact
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
	  AND PersonID IN (SELECT PersonID FROM deleted)
END
GO

CREATE TRIGGER Person.dContactType ON Person.ContactType
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.ContactType
	SET IsActiveFlag = 0
	WHERE ContactTypeID IN (SELECT ContactTypeID FROM deleted)
END
GO

CREATE TRIGGER Person.dCountryRegion ON Person.CountryRegion
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.CountryRegion
	SET IsActiveFlag = 0
	WHERE CountryRegionCode IN (SELECT CountryRegionCode FROM deleted)
END
GO

CREATE TRIGGER Person.dEmailAddress ON Person.EmailAddress
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.EmailAddress
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
	  AND EmailAddressID IN (SELECT EmailAddressID FROM deleted)
END
GO

CREATE TRIGGER Person.dPassword ON Person.[Password]
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.[Password]
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
END
GO

CREATE TRIGGER Person.dPerson ON Person.Person
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.Person
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
END
GO

CREATE TRIGGER Person.dPersonPhone ON Person.PersonPhone
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.PersonPhone
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
	  AND PhoneNumber IN (SELECT PhoneNumber FROM deleted)
	  AND PhoneNumberTypeID IN (SELECT PhoneNumberTypeID FROM deleted)
END
GO

CREATE TRIGGER Person.dPhoneNumberType ON Person.PhoneNumberType
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.PhoneNumberType
	SET IsActiveFlag = 0
	WHERE PhoneNumberTypeID IN (SELECT PhoneNumberTypeID FROM deleted)
END
GO

CREATE TRIGGER Person.dStateProvince ON Person.StateProvince
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Person.StateProvince
	SET IsActiveFlag = 0
	WHERE StateProvinceID IN (SELECT StateProvinceID FROM deleted)
END
GO

CREATE TRIGGER Production.dProduct ON Production.Product
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Production.Product
	SET IsActiveFlag = 0
	WHERE ProductID IN (SELECT ProductID FROM deleted)
END
GO

CREATE TRIGGER Production.dProductCategory ON Production.ProductCategory
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Production.ProductCategory
	SET IsActiveFlag = 0
	WHERE ProductCategoryID IN (SELECT ProductCategoryID FROM deleted)
END
GO

CREATE TRIGGER Production.dProductModel ON Production.ProductModel
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Production.ProductModel
	SET IsActiveFlag = 0
	WHERE ProductModelID IN (SELECT ProductModelID FROM deleted)
END
GO

CREATE TRIGGER Production.dProductSubcategory ON Production.ProductSubcategory
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Production.ProductSubcategory
	SET IsActiveFlag = 0
	WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM deleted)
END
GO

CREATE TRIGGER Production.dUnitMeasure ON Production.UnitMeasure
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Production.UnitMeasure
	SET IsActiveFlag = 0
	WHERE UnitMeasureCode IN (SELECT UnitMeasureCode FROM deleted)
END
GO

CREATE TRIGGER Purchasing.dProductVendor ON Purchasing.ProductVendor
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Purchasing.ProductVendor
	SET IsActiveFlag = 0
	WHERE ProductID IN (SELECT ProductID FROM deleted)
	  AND BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
END
GO

CREATE TRIGGER Purchasing.dStatus ON Purchasing.[Status]
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Purchasing.[Status]
	SET IsActiveFlag = 0
	WHERE StatusID IN (SELECT StatusID FROM deleted)
END
GO

CREATE TRIGGER Purchasing.dVendor ON Purchasing.Vendor
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Purchasing.Vendor
	SET IsActiveFlag = 0
	WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
END
GO

--Transaction for creating application roles
BEGIN TRANSACTION;
	BEGIN TRY
		CREATE APPLICATION ROLE app_executive WITH PASSWORD = '1234'
		CREATE APPLICATION ROLE app_manager WITH PASSWORD = '1234'
		CREATE APPLICATION ROLE app_staffmember WITH PASSWORD = '1234'

		GRANT SELECT ON SCHEMA::Person TO app_executive
		GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Person TO app_manager
		GRANT SELECT, INSERT, UPDATE ON SCHEMA::Person TO app_staffmember

		GRANT SELECT ON SCHEMA::Production TO app_executive
		GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Production TO app_manager
		GRANT SELECT, INSERT, UPDATE ON SCHEMA::Production TO app_staffmember

		GRANT SELECT ON SCHEMA::Purchasing TO app_executive
		GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Purchasing TO app_manager
		GRANT SELECT, INSERT, UPDATE ON SCHEMA::Purchasing TO app_staffmember

		REVOKE SELECT ON Person.[Password] FROM app_executive
		REVOKE SELECT, INSERT, UPDATE ON Person.[Password] FROM app_staffmember
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
COMMIT TRANSACTION;
GO