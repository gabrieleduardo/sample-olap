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
INNER JOIN SalesDB.dbo.Manufacturer M ON M.Id = P.ManufacturerId
-- Joins from Corporation
INNER JOIN SalesDB.dbo.Corporation CP ON CP.Id = PP.CorporationId
-- Joins from Client
INNER JOIN SalesDB.dbo.Client CL ON CL.Id = S.ClientId
WHERE
	M.CountryId = 2
	AND CL.CityId <> CP.CityId

-- Total Chinese product sales for clients from another city (not in corporation city)
-- Analyse plan cost

SELECT
	SUM(SalesValue) AS SalesValue
FROM SalesDW.dbo.TF_Sales
WHERE ManufacturerCountryId = 2
	AND ClientCityId <> CorporationCityId