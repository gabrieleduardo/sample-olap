USE SalesDB
GO

DECLARE @CorporationId INT = 2
DECLARE @Sales INT = 1000000
DECLARE @NumberOfSales INT
DECLARE @ProductId INT
DECLARE @ProductPriceId INT 
DECLARE @ClientId INT
DECLARE @Amount INT

WHILE @CorporationId > 0
BEGIN
	SET @NumberOfSales = @Sales
	WHILE @NumberOfSales > 0
		BEGIN
			SELECT @ProductId = CEILING(rand() * MAX(Id)) FROM Product

			SELECT @ProductPriceId = Id
			FROM ProductPrice 
			WHERE CorporationId = @CorporationId
				AND ProductId = @ProductId

			SELECT TOP 1 @ClientId = Client.Id
			FROM Client AS Client
			INNER JOIN City AS ClientCity ON ClientCity.Id = Client.CityId
			WHERE StateId = (
				SELECT StateId
				FROM Corporation Corp
				INNER JOIN City AS CorporationCity ON CorporationCity.Id = Corp.CityId
				WHERE Corp.Id = @CorporationId
			)
			ORDER BY NEWID()

			SELECT @Amount = CEILING(rand() * 11)
			
			INSERT INTO Sales ( SaleDate, ProductPriceId, ClientId, Amount )
			VALUES (GETDATE(), @ProductPriceId, @ClientId, @Amount)

			SET @NumberOfSales = @NumberOfSales - 1

		END

	SET @CorporationId = @CorporationId - 1
END