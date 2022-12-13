USE SalesDB
GO

INSERT INTO Country (Description) VALUES ('Brasil')
INSERT INTO Country (Description) VALUES ('China')
INSERT INTO Country (Description) VALUES ('Estados Unidos')
INSERT INTO State (Description, CountryId) VALUES ('Minas Gerais', 1)
INSERT INTO State (Description, CountryId) VALUES ('São Paulo', 1)
INSERT INTO City (Description, StateId) VALUES ('Uberlândia',1)
INSERT INTO City (Description, StateId) VALUES ('Belo Horizonte',1)
INSERT INTO City (Description, StateId) VALUES ('Juiz de Fora',1)
INSERT INTO City (Description, StateId) VALUES ('São Paulo',2)
INSERT INTO City (Description, StateId) VALUES ('Campinas',2)
INSERT INTO City (Description, StateId) VALUES ('São José do Rio Preto',2)

INSERT INTO Corporation(Description, Address, CityId ) VALUES ('Matriz Uberlândia', 'João Naves de Ávila, 1234', 1)
INSERT INTO Corporation(Description, Address, CityId ) VALUES ('Filial São Paulo', 'Brigadeiro Faria Lima, 1234', 4)

INSERT INTO ClientCategory (Description) VALUES ('Ouro')
INSERT INTO ClientCategory (Description) VALUES ('Prata')
INSERT INTO ClientCategory (Description) VALUES ('Bronze')

INSERT INTO Client (Description, Address, CityId, ClientCategoryId) VALUES ('Cliente Ouro - Uberlândia', 'Rua Principal, 1234', 1, 1);
INSERT INTO Client (Description, Address, CityId, ClientCategoryId) VALUES ('Cliente Prata - Belo Horizonte', 'Rua Principal, 1234', 2, 2);
INSERT INTO Client (Description, Address, CityId, ClientCategoryId) VALUES ('Cliente Bronze - Juiz de Fora', 'Rua Principal, 1234', 3, 3);
INSERT INTO Client (Description, Address, CityId, ClientCategoryId) VALUES ('Cliente Ouro - São Paulo', 'Rua Principal, 1234', 4, 1);
INSERT INTO Client (Description, Address, CityId, ClientCategoryId) VALUES ('Cliente Prata - Campinas', 'Rua Principal, 1234', 5, 2);
INSERT INTO Client (Description, Address, CityId, ClientCategoryId) VALUES ('Cliente Bronze - São José do Rio Preto', 'Rua Principal, 1234', 6, 3);

INSERT INTO ProductCategory(Description) VALUES ('Brinquedos')
INSERT INTO ProductCategory(Description) VALUES ('Roupas')

INSERT INTO Manufacturer (Description, CountryId) VALUES ('Fabricante Brasileiro',1)
INSERT INTO Manufacturer (Description, CountryId) VALUES ('Fabricante Chinês',2)
INSERT INTO Manufacturer (Description, CountryId) VALUES ('Fabricante Norte Americano',3)

INSERT INTO Product (Description, SKU, ProductCategoryId, ManufacturerId) VALUES ('Brinquedo Brasileiro', NEWID(), 1, 1)
INSERT INTO Product (Description, SKU, ProductCategoryId, ManufacturerId) VALUES ('Brinquedo Chinês', NEWID(), 1, 2)
INSERT INTO Product (Description, SKU, ProductCategoryId, ManufacturerId) VALUES ('Brinquedo Norte Americano', NEWID(), 1, 3)
INSERT INTO Product (Description, SKU, ProductCategoryId, ManufacturerId) VALUES ('Roupa Brasileira', NEWID(), 2, 1)
INSERT INTO Product (Description, SKU, ProductCategoryId, ManufacturerId) VALUES ('Roupa Chinesa', NEWID(), 2, 2)
INSERT INTO Product (Description, SKU, ProductCategoryId, ManufacturerId) VALUES ('Roupa Norte Americana', NEWID(), 2, 3)

INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (1,1,22.50)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (2,1,15.75)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (1,2,14.99)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (2,2,15.99)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (1,3,10.00)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (2,3,19.90)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (1,4,122.50)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (2,4,99.90)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (1,5,35)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (2,5,35)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (1,6,199.99)
INSERT INTO ProductPrice (CorporationId, ProductId, Price) VALUES (2,6,189.99)