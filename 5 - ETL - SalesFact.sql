USE SalesDW
GO

MERGE SalesDW.dbo.TD_Country AS T
USING (
	SELECT Id, Description
	FROM SalesDB.dbo.Country 
) AS S (Id, Description)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description
WHEN NOT MATCHED THEN INSERT (Description) VALUES (Description);

MERGE SalesDW.dbo.TD_State AS T
USING (
	SELECT Id, Description, CountryId
	FROM SalesDB.dbo.State 
) AS S (Id, Description, CountryId)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description,
	T.CountryId = S.CountryId
WHEN NOT MATCHED THEN INSERT (Description, CountryId) VALUES (Description, CountryId);

MERGE SalesDW.dbo.TD_City AS T
USING (
	SELECT Id, Description, StateId
	FROM SalesDB.dbo.City 
) AS S (Id, Description, StateId)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description,
	T.StateId = S.StateId
WHEN NOT MATCHED THEN INSERT (Description, StateId) VALUES (Description, StateId);

MERGE SalesDW.dbo.TD_Corporation AS T
USING (
	SELECT Id, Description, Address, CityId
	FROM SalesDB.dbo.Corporation 
) AS S (Id, Description, Address, CityId)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description,
	T.Address = S.Address,
	T.CityId = S.CityId
WHEN NOT MATCHED THEN INSERT (Description, Address, CityId) VALUES (Description, Address, CityId);

MERGE SalesDW.dbo.TD_ClientCategory AS T
USING (
	SELECT Id, Description
	FROM SalesDB.dbo.ClientCategory 
) AS S (Id, Description)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description
WHEN NOT MATCHED THEN INSERT (Description) VALUES (Description);

MERGE SalesDW.dbo.TD_Client AS T
USING (
	SELECT Id, Description, Address, CityId, ClientCategoryId
	FROM SalesDB.dbo.Client 
) AS S (Id, Description, Address, CityId, ClientCategoryId)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description,
	T.Address = S.Address,
	T.CityId = S.CityId,
	T.ClientCategoryId = S.ClientCategoryId
WHEN NOT MATCHED THEN INSERT (Description, Address, CityId, ClientCategoryId) VALUES (Description, Address, CityId, ClientCategoryId);

MERGE SalesDW.dbo.TD_ProductCategory AS T
USING (
	SELECT Id, Description
	FROM SalesDB.dbo.ProductCategory 
) AS S (Id, Description)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description
WHEN NOT MATCHED THEN INSERT (Description) VALUES (Description);

MERGE SalesDW.dbo.TD_Manufacturer AS T
USING (
	SELECT Id, Description, CountryId
	FROM SalesDB.dbo.Manufacturer 
) AS S (Id, Description, CountryId)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description,
	T.CountryId = S.CountryId
WHEN NOT MATCHED THEN INSERT (Description, CountryId) VALUES (Description, CountryId);

MERGE SalesDW.dbo.TD_Product AS T
USING (
	SELECT Id, Description, SKU, ProductCategoryId, ManufacturerId
	FROM SalesDB.dbo.Product 
) AS S (Id, Description, SKU, ProductCategoryId, ManufacturerId)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.Description = S.Description,
	T.SKU = S.SKU, 
	T.ProductCategoryId = S.ProductCategoryId,
	T.ManufacturerId = S.ManufacturerId
WHEN NOT MATCHED THEN INSERT (Description, SKU, ProductCategoryId, ManufacturerId) VALUES (Description, SKU, ProductCategoryId, ManufacturerId);

MERGE SalesDW.dbo.TD_ProductPrice AS T
USING (
	SELECT Id, CorporationId, ProductId, Price
	FROM SalesDB.dbo.ProductPrice 
) AS S (Id, CorporationId, ProductId, Price)  
     ON T.Id = S.Id
WHEN MATCHED THEN UPDATE SET T.CorporationId = S.CorporationId,
	T.ProductId = S.ProductId,
	T.Price = S.Price
WHEN NOT MATCHED THEN INSERT (CorporationId, ProductId, Price) VALUES (CorporationId, ProductId, Price);

DELETE FROM TF_Sales

-- EXTRACT AND TRANSFORM
SELECT 
	S.Amount * PP.Price AS SalesValue,
	S.Amount AS Amount,
	YEAR(SaleDate) AS SaleYear,
	MONTH(SaleDate) AS SaleMonth, 
	PP.Id AS ProductPriceId,
	P.Id AS ProductId,
	PC.Id AS ProductCategoryId,
	M.Id AS ManufacturerId,
	ManufacturerCountry.Id AS ManufacturerCountryId ,
	CL.Id AS ClientId,
	ClientCity.Id AS ClientCityId,
	ClientState.Id AS ClientStateId,
	ClientCountry.Id AS ClientCountryId,
	CC.Id AS ClientCategoryId,
	CP.Id AS CorporationId,
	CorporationCity.Id AS CorporationCityId,
	CorporationState.Id AS CorporationStateId,
	CorporationCountry.Id AS CorporationCountryId
INTO #Extract
FROM SalesDB.dbo.Sales S
INNER JOIN SalesDB.dbo.ProductPrice PP ON PP.Id = S.ProductPriceId
-- Joins from product
INNER JOIN SalesDB.dbo.Product P ON P.Id = PP.ProductId
INNER JOIN SalesDB.dbo.ProductCategory PC ON PC.Id = P.ProductCategoryId
INNER JOIN SalesDB.dbo.Manufacturer M ON M.Id = P.ManufacturerId
INNER JOIN SalesDB.dbo.Country ManufacturerCountry ON ManufacturerCountry.Id = M.CountryId
-- Joins from Corporation
INNER JOIN SalesDB.dbo.Corporation CP ON CP.Id = PP.CorporationId
INNER JOIN SalesDB.dbo.City CorporationCity ON CorporationCity.Id = CP.CityId
INNER JOIN SalesDB.dbo.State CorporationState ON CorporationState.Id = CorporationCity.StateId
INNER JOIN SalesDB.dbo.Country CorporationCountry ON CorporationCountry.Id = CorporationState.CountryId
-- Joins from Client
INNER JOIN SalesDB.dbo.Client CL ON CL.Id = S.ClientId
INNER JOIN SalesDB.dbo.ClientCategory CC ON CC.Id = CL.ClientCategoryId
INNER JOIN SalesDB.dbo.City ClientCity ON ClientCity.Id = CL.CityId
INNER JOIN SalesDB.dbo.State ClientState ON ClientState.Id = ClientCity.StateId
INNER JOIN SalesDB.dbo.Country ClientCountry ON ClientCountry.Id = CorporationState.CountryId

-- Transform
SELECT 
	SUM(SalesValue) AS SalesValue,
	SUM(Amount) AS Amount,
	SaleYear,
	SaleMonth, 
	ProductPriceId,
	ProductId,
	ProductCategoryId,
	ManufacturerId,
	ManufacturerCountryId,
	ClientId,
	ClientCityId,
	ClientStateId,
	ClientCountryId,
	ClientCategoryId,
	CorporationId,
	CorporationCityId,
	CorporationStateId,
	CorporationCountryId
INTO #Transform
FROM #Extract
GROUP BY 
	SaleYear,
	SaleMonth, 
	ProductPriceId,
	ProductId,
	ProductCategoryId,
	ManufacturerId,
	ManufacturerCountryId,
	ClientId,
	ClientCityId,
	ClientStateId,
	ClientCountryId,
	ClientCategoryId,
	CorporationId,
	CorporationCityId,
	CorporationStateId,
	CorporationCountryId

-- LOAD
INSERT INTO TF_Sales(
	SalesValue,
	Amount,
	SaleYear,
	SaleMonth,
	ProductPriceId,
	ProductId,
	ProductCategoryId,
	ManufacturerId,
	ManufacturerCountryId,
	ClientId,
	ClientCityId,
	ClientStateId,
	ClientCountryId,
	ClientCategoryId,
	CorporationId,
	CorporationCityId,
	CorporationStateId,
	CorporationCountryId 
)
SELECT 
	SalesValue,
	Amount,
	SaleYear,
	SaleMonth,
	ProductPriceId,
	ProductId,
	ProductCategoryId,
	ManufacturerId,
	ManufacturerCountryId,
	ClientId,
	ClientCityId,
	ClientStateId,
	ClientCountryId,
	ClientCategoryId,
	CorporationId,
	CorporationCityId,
	CorporationStateId,
	CorporationCountryId 
FROM #Transform

DROP TABLE #Extract
DROP TABLE #Transform