USE SalesDW
GO

CREATE TABLE Country (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL
)

CREATE TABLE State (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	CountryId INT NOT NULL
)

CREATE TABLE City (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	StateId INT NOT NULL
)


CREATE TABLE Corporation (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	CityId INT NOT NULL
)

CREATE TABLE ClientCategory (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
)

CREATE TABLE Client (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	CityId INT NOT NULL,
	ClientCategoryId INT NOT NULL
)

CREATE TABLE ProductCategory (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
)

CREATE TABLE Manufacturer (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	CountryId INT NOT NULL 
)

CREATE TABLE Product (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	SKU UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	ProductCategoryId INT NOT NULL,
	ManufacturerId INT NOT NULL
)

CREATE TABLE ProductPrice (
	Id INT IDENTITY PRIMARY KEY,
	CorporationId INT NOT NULL,
	ProductId INT NOT NULL,
	Price DECIMAL(13,2) NOT NULL
)

CREATE TABLE TF_Sales(
	SalesValue DECIMAL(13,2) NOT NULL,
	Amount INT NOT NULL,
	SaleYear INT NOT NULL,
	SaleMonth INT NOT NULL,
	ProductPriceId INT NOT NULL,
	ProductId INT NOT NULL,
	ProductCategoryId INT NOT NULL,
	ManufacturerId INT NOT NULL,
	ManufacturerCountryId INT NOT NULL,
	ClientId INT NOT NULL,
	ClientCityId INT NOT NULL,
	ClientStateId INT NOT NULL,
	ClientCountryId INT NOT NULL,
	ClientCategoryId INT NOT NULL,
	CorporationId INT NOT NULL,
	CorporationCityId INT NOT NULL,
	CorporationStateId INT NOT NULL,
	CorporationCountryId INT NOT NULL
)

/*
-- FK Dilema 

-- Do you need to use FKs in DW?
-- Use when you need to ensure referential integrity, when your database will receive loads from another source.
-- When you have control of loads, you can avoid insertion overhead by skipping constraints.
-- The choise is yours.

ALTER TABLE State ADD CONSTRAINT FK_State_Country FOREIGN KEY (CountryId) REFERENCES Country(Id)
ALTER TABLE City ADD CONSTRAINT FK_City_State FOREIGN KEY (StateId) REFERENCES State(Id)
ALTER TABLE Corporation ADD CONSTRAINT FK_Corporation_City FOREIGN KEY (CityId) REFERENCES City(Id)

ALTER TABLE Client ADD CONSTRAINT FK_Client_City FOREIGN KEY (CityId) REFERENCES City(Id)
ALTER TABLE Client ADD CONSTRAINT FK_Client_ClientCategory FOREIGN KEY (ClientCategoryId) REFERENCES ClientCategory(Id)

ALTER TABLE Manufacturer ADD CONSTRAINT FK_Manufacturer_Country FOREIGN KEY (CountryId) REFERENCES Country(Id)

ALTER TABLE Product ADD CONSTRAINT FK_Product_ProductCategory FOREIGN KEY (ProductCategoryId) REFERENCES ProductCategory(Id)
ALTER TABLE Product ADD CONSTRAINT FK_Product_Manufacturer FOREIGN KEY (ManufacturerId) REFERENCES Manufacturer(Id)

ALTER TABLE ProductPrice ADD CONSTRAINT FK_ProductPrice_Corporation FOREIGN KEY (CorporationId) REFERENCES Corporation(Id)
ALTER TABLE ProductPrice ADD CONSTRAINT FK_ProductPrice_Product FOREIGN KEY (ProductId) REFERENCES Product(Id)
*/

ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ProductPrice FOREIGN KEY (ProductPriceId) REFERENCES ProductPrice(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_Product	FOREIGN KEY (ProductId) REFERENCES Product(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ProductCategory FOREIGN KEY (ProductCategoryId) REFERENCES ProductCategory(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_Manufacturer FOREIGN KEY (ManufacturerId) REFERENCES Manufacturer(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ManufacturerCountry FOREIGN KEY (ManufacturerCountryId) REFERENCES Country(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_Client FOREIGN KEY (ClientId) REFERENCES Client(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ClientCity FOREIGN KEY (ClientCityId) REFERENCES City(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ClientState FOREIGN KEY (ClientStateId) REFERENCES State(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ClientCountry FOREIGN KEY (ClientCountryId) REFERENCES Country(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_ClientCategory FOREIGN KEY (ClientCategoryId) REFERENCES ClientCategory(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_Corporation FOREIGN KEY (CorporationId) REFERENCES Corporation(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_CorporationCity FOREIGN KEY (CorporationCityId) REFERENCES City(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_CorporationState FOREIGN KEY (CorporationStateId) REFERENCES State(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_TF_Sales_CorporationCountry FOREIGN KEY (CorporationCountryId) REFERENCES Country(Id)

/*
DROP TABLE ProductPrice
DROP TABLE Product
DROP TABLE ProductCategory
DROP TABLE Client
DROP TABLE ClientCategory
DROP TABLE Corporation
DROP TABLE Manufacturer
DROP TABLE City
DROP TABLE State
DROP TABLE Country
DROP TABLE TF_Sales
*/

