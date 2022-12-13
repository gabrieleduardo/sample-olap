USE SalesDW
GO

CREATE TABLE TD_Country (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL
)

CREATE TABLE TD_State (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	CountryId INT NOT NULL
)

CREATE TABLE TD_City (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	StateId INT NOT NULL
)


CREATE TABLE TD_Corporation (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	CityId INT NOT NULL
)

CREATE TABLE TD_ClientCategory (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
)

CREATE TABLE TD_Client (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	CityId INT NOT NULL,
	ClientCategoryId INT NOT NULL
)

CREATE TABLE TD_ProductCategory (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
)

CREATE TABLE TD_Manufacturer (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	CountryId INT NOT NULL 
)

CREATE TABLE TD_Product (
	Id INT IDENTITY PRIMARY KEY,
	Description VARCHAR(255) NOT NULL,
	SKU UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	ProductCategoryId INT NOT NULL,
	ManufacturerId INT NOT NULL
)

CREATE TABLE TD_ProductPrice (
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

ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ProductPrice FOREIGN KEY (ProductPriceId) REFERENCES TD_ProductPrice(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_Product	FOREIGN KEY (ProductId) REFERENCES TD_Product(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ProductCategory FOREIGN KEY (ProductCategoryId) REFERENCES TD_ProductCategory(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_Manufacturer FOREIGN KEY (ManufacturerId) REFERENCES TD_Manufacturer(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ManufacturerCountry FOREIGN KEY (ManufacturerCountryId) REFERENCES TD_Country(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_Client FOREIGN KEY (ClientId) REFERENCES TD_Client(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ClientCity FOREIGN KEY (ClientCityId) REFERENCES TD_City(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ClientState FOREIGN KEY (ClientStateId) REFERENCES TD_State(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ClientCountry FOREIGN KEY (ClientCountryId) REFERENCES TD_Country(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_ClientCategory FOREIGN KEY (ClientCategoryId) REFERENCES TD_ClientCategory(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_Corporation FOREIGN KEY (CorporationId) REFERENCES TD_Corporation(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_CorporationCity FOREIGN KEY (CorporationCityId) REFERENCES TD_City(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_CorporationState FOREIGN KEY (CorporationStateId) REFERENCES TD_State(Id)
ALTER TABLE TF_Sales ADD CONSTRAINT FK_Sales_CorporationCountry FOREIGN KEY (CorporationCountryId) REFERENCES TD_Country(Id)

/*
DROP TABLE TD_ProductPrice
DROP TABLE TD_Product
DROP TABLE TD_ProductCategory
DROP TABLE TD_Client
DROP TABLE TD_ClientCategory
DROP TABLE TD_Corporation
DROP TABLE TD_Manufacturer
DROP TABLE TD_City
DROP TABLE TD_State
DROP TABLE TD_Country
DROP TABLE TF_Sales
*/

