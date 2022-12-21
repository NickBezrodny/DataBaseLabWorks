--1.	Показать самый тяжелый товар (наименование и вес) (Таблица Production.Product).

SELECT [Name], [Weight]
FROM Production.Product
WHERE [Weight] = 
	(
		SELECT MAX([Weight])
		FROM Production.Product
		WHERE [Weight]>0
	);
		-- ИЛИ --
SELECT Top 1 [Name], MAX([Weight])
FROM Production.Product
GROUP BY [Weight],[Name]
HAVING [Weight] > 0
ORDER BY [Weight] DESC;



--2.	Показать количество продуктов и подкатегорию продуктов, для которой представлено минимальное (больше нуля) 
--		количество продуктов (Таблица Production.Product).

SELECT TOP 1 COUNT(ProductID) AS MinCount ,ProductSubcategoryID
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID IS NOT NULL AND COUNT(ProductID)>0
ORDER BY COUNT(ProductSubcategoryID) ASC;

SELECT *
FROM Production.Product;


--3.	Показать товары, для которых существует более 3 Линии продуктов, в одном стиле (стиль определен) (Таблица Production.Product). 
--		Показать поля [Name], Style и ProductLine.

SELECT *
FROM Production.Product;

SELECT p.[Name], p.ProductLine, p.Style
FROM Production.Product AS p
WHERE p.Style IS NOT NULL AND
	(
		SELECT COUNT(DISTINCT r.ProductLine)
		FROM Production.Product AS r
		WHERE p.Style = r.Style
		GROUP BY r.Style
	)> 3
ORDER BY p.[Name];



--4.	Показать товары, цена которых равна максимальной цене товара того же цвета (цвет определен) (Таблица Production.Product). 
--		Показать поля [Name], ListPrice и Color.

SELECT p.[Name], p.ListPrice, p.Color
FROM Production.Product AS p
WHERE p.Color IS NOT NULL AND ListPrice = ALL 
	(
		SELECT MAX(r.ListPrice)
		FROM Production.Product AS r
		WHERE r.ListPrice > 0 AND r.Color=p.Color
	)
ORDER BY ListPrice;


--5.	Показать товары, цена которых меньше средней цены в любой подкатегории (ProductSubcategoryID IS NOT NULL) 
--		(Таблица Production.Product). Показать поля [Name], ListPrice и ProductSubcategoryID.

SELECT [Name], ListPrice, ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND ListPrice < ANY
	(
		SELECT AVG(ListPrice)
		FROM Production.Product
		GROUP BY ProductSubcategoryID
	)
ORDER BY ListPrice;
