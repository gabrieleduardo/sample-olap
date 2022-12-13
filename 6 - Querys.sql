USE SalesDB
GO

-- Total Chinese product sales for clients from another city (not in corporation city)
-- Analyse Execution plan cost

SELECT 
	SUM(S.Amount * PP.Price) AS SalesValue
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
-- Joins from Client
INNER JOIN SalesDB.dbo.Client CL ON CL.Id = S.ClientId
INNER JOIN SalesDB.dbo.ClientCategory CC ON CC.Id = CL.ClientCategoryId
INNER JOIN SalesDB.dbo.City ClientCity ON ClientCity.Id = CL.CityId
WHERE
	M.CountryId = 2
	AND ClientCity.Id <> CorporationCity.Id

-- Total Chinese product sales for clients from another city (not in corporation city)
-- Analyse plan cost

SELECT
	SUM(SalesValue) AS SalesValue
FROM SalesDW.dbo.TF_Sales
WHERE ManufacturerCountryId = 2
	AND ClientCityId <> CorporationCityId