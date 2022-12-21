--1. Показать цену за штуку (UnitPrice) и поля Name, ProductNumber из таблиц Production.Product, Sales.SalesOrderDetail.
SELECT *
FROM Production.Product;
SELECT *
FROM Sales.SalesOrderDetail;

SELECT P.[Name], P.ProductNumber,S.UnitPrice
FROM Production.Product AS P
INNER JOIN Sales.SalesOrderDetail AS S
ON P.ProductID = S.ProductID;


--2. Показать список людей (поля FirstName, LastName), в котором указан уровень человека в организации (OrganizationLevel) или нет,
--	 из таблиц Person.Person, HumanResources.Employee, используя LEFT OUTER JOIN.
SELECT *
FROM Person.Person;
SELECT *
FROM HumanResources.Employee;

SELECT P.LastName,P.FirstName, H.OrganizationLevel
FROM Person.Person AS P
LEFT OUTER JOIN HumanResources.Employee AS H
ON P.BusinessEntityID= H.BusinessEntityID;



--3. Показать список товаров (поле Name), в котором указан, есть ли у товара дата начала отслеживания цены (StartDate) или нет, 
--	 из таблицы Production.ProductListPriceHistory, Production.Product, используя RIGHT OUTER JOIN.
SELECT *
FROM Production.Product;
SELECT *
FROM Production.ProductListPriceHistory;

SELECT P.[Name],H.StartDate
FROM Production.Product AS P
RIGHT OUTER JOIN Production.ProductListPriceHistory AS H
ON P.ProductID= H.ProductID;


--4. Показать список продуктов (ProductID), которые имеют несколько различных остатков на складах (Quantity), из таблицы 
--	 Production.ProductInventory, используя SELF JOIN.

SELECT DISTINCT P1.ProductID
FROM Production.ProductInventory AS P1
INNER JOIN Production.ProductInventory AS P2
ON P1.ProductID = P2.ProductID
WHERE P1.Quantity <> P2.Quantity;



--5. Показать список остатков на складах (Quantity), которые соответствуют нескольким продуктам (ProductID), из таблицы 
--	 Production.ProductInventory, используя SELF JOIN.

SELECT DISTINCT P1.Quantity
FROM Production.ProductInventory AS P1
INNER JOIN Production.ProductInventory AS P2
ON P1.Quantity = P2.Quantity
WHERE P1.ProductID <> P2.ProductID;



--6. Показать список покупателей (CustomerID), которые имеют несколько сумм налога (TaxAmt), из таблицы Sales.SalesOrderHeader, 
--	 используя SELF JOIN. Сумма налога меньше 100.

SELECT DISTINCT S1.CustomerID
FROM Sales.SalesOrderHeader AS S1
INNER JOIN Sales.SalesOrderHeader AS S2
ON S1.CustomerID = S2.CustomerID
WHERE S1.TaxAmt <> S2.TaxAmt AND S1.TaxAmt < 100;



--7. Показать комбинированный список таблиц Person.Address, Person.BusinessEntityAddress по полям AddressID, ModifiedDate, 
--	 используя UNION.

SELECT *
FROM Person.[Address];
SELECT *
FROM Person.BusinessEntityAddress;

SELECT A.AddressID, A.ModifiedDate
FROM Person.[Address] AS A
UNION
SELECT B.AddressID, B.ModifiedDate
FROM Person.BusinessEntityAddress AS B;



--8. Показать список ProductID, которые содержатся в таблице Production.Product, но не содержатся в таблице Production.WorkOrder

SELECT P.ProductID
FROM Production.Product AS P
EXCEPT
SELECT S.ProductID
FROM Production.WorkOrder AS S;
		-- ИЛИ --
SELECT P.ProductID
FROM Production.Product AS P
LEFT JOIN Production.WorkOrder AS S
ON P.ProductID = S.ProductID
WHERE S.ProductID IS NULL;



SELECT P.ProductID
FROM Production.Product AS P;
SELECT P.ProductID
FROM Production.WorkOrder AS P;
