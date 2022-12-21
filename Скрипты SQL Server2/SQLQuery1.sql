--1.	Показать все поля из таблицы Production.WorkOrderRouting.
SELECT *
FROM Production.WorkOrderRouting;

--2.	Показать поля  ProductDescriptionID, [Description] из таблицы Production.ProductDescription.
SELECT 
	ProductDescriptionID
	, [Description]
FROM Production.ProductDescription;


--3.	Показать поля BusinessEntityID, RateChangeDate, Rate из таблицы HumanResources.EmployeePayHistory.
--Показать только те записи, для которых почасовая ставка заработной платы (Rate) больше $15 и меньше $20. Использовать оператор BETWEEN.

SELECT 
	BusinessEntityID
	, RateChangeDate
	, Rate
FROM HumanResources.EmployeePayHistory AS HR
WHERE HR.Rate BETWEEN 15 AND 20;

--4.	Из таблицы Production.ProductModel показать ID модели товара (ProductModelID), название товара (Name),
--      описание товара в каталоге (CatalogDescription) и инструкцию товара (Instructions). 
--      Показать только те товары, у которых есть инструкция.


SELECT 
	ProductModelID
	, [Name]
	, CatalogDescription
	, Instructions
FROM Production.ProductModel 
WHERE Instructions IS NOT NULL;

--5.	Показать поля ProductCategoryID и Name из таблицы Production.ProductCategory. 
--      Показать только те товары, название которых начинается на букву 'C'.

SELECT [Name]
FROM Production.ProductCategory AS PP
WHERE PP.[Name] LIKE 'C%';

--6.	Из таблицы Sales.Store показать ID сотрудника (BusinessEntityID), название магазина (Name)
--      и ID продавца (SalesPersonID). Показать только значения поля Name,
--      принадлежащие списку ('Next-Door Bike Store', 'Area Bike Accessories', 'Top of the Line Bikes', 'Valley Toy Store', 
--      'Global Plaza'). Использовать оператор IN.

SELECT 
	BusinessEntityID
	, [Name]
	, SalesPersonID
FROM Sales.Store
WHERE [Name] IN ('Next-Door Bike Store', 'Area Bike Accessories', 'Top of the Line Bikes', 'Valley Toy Store', 'Global Plaza' );

--7.	Показать поля BusinessEntityID, AccountNumber, Name, PurchasingWebServiceURL из таблицы Purchasing.Vendor.
--      Неизвестные адреса сайтов магазинов (PurchasingWebServiceURL) заменить значением 'not available'.
--      Названия полей оставить без изменений.

SELECT 
	BusinessEntityID
	, ISNULL(CAST(PurchasingWebServiceURL AS VARCHAR(100)),'not available') AS PurchasingWebServiceURL
	, AccountNumber
	, [Name]
FROM Purchasing.Vendor;

--8.	Показать поля ProductID, Name из таблицы Production.Product с применением функции COALESCE().
--      Показать поле Meauserement, так, чтобы, если значение в поле Style известно, то показать его, а иначе,
--      показать значение в поле Color. Если и в поле Color значение неизвестно, то вывести значение 'UNKNOWN'.

SELECT 
	ProductID
	, [Name]
	, COALESCE(Style, Color,'UNKNOWN') AS Measurement
FROM Production.Product;

--9.	Из таблицы Production.Culture показать значения поля Name в алфавитном порядке.

SELECT *
FROM Production.Culture
ORDER BY [Name] ASC;

--10.	Показать название (Name) и размер (Size) товара из таблицы Production.Product, если имеются товары только размера 'M'.
--      Заменить размер товара на NULL, если он имеет значение 'M'. Названия поля Size заменить на Class.


SELECT 
	[Name]
	, NULLIF(CAST(Size AS VARCHAR(10)), 'M') AS Size
FROM Production.Product;