--1)	ѕоказать количество разнообразных цветов товара (Color) из таблицы Production.Product

SELECT 
	 COUNT(DISTINCT Color) AS CountColors
FROM Production.Product;


--2)	Ќайти суммарную цену (ListPrice) товара размера M из таблицы Production.Product, не учитывать пустые и нулевые значени¤.

SELECT 
	 AVG(ListPrice) AS AvgPrice
   , SUM(ListPrice) AS SumPrice
FROM Production.Product
WHERE ListPrice > 0;


--3)	Ќайти количество номеров телефона разного типа (PhoneNumberTypeID) из таблицы Person.PersonPhone,
--      где номер начинаетс¤ с 819. —ортировать по возрастанию.

SELECT COUNT(PhoneNumber)
FROM Person.PersonPhone
GROUP BY PhoneNumberTypeID,PhoneNumber
HAVING PhoneNumber LIKE '819%'
ORDER BY COUNT(PhoneNumber) ASC;

SELECT *
FROM Person.PersonPhone
WHERE PhoneNumber LIKE '819%';

--4)	¬ывести пол, где средний возраст больше 42 лет из таблицы HumanResources.Employee (не учитывать пустые значени¤).
SELECT *
FROM HumanResources.Employee;

SELECT Gender
FROM HumanResources.Employee
GROUP BY Gender, DATEDIFF(YEAR, BirthDate, GETDATE())
HAVING AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) > 42;

SELECT TOP 1 Gender
FROM HumanResources.Employee
GROUP BY Gender, DATEDIFF(YEAR, BirthDate, GETDATE())
HAVING AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) > 42
ORDER BY AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) DESC;

SELECT Gender
FROM HumanResources.Employee
WHERE 
	(
	SELECT TOP 1 AVG(DATEDIFF(YEAR, BirthDate, GETDATE()))
	FROM HumanResources.Employee
	GROUP BY Gender
	ORDER BY AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) DESC
	)>42;


--5)	¬ывести EmployeeID, ShipDate и среднее по SubTotal дл¤ всевозможных EmployeeID с одинаковой ShipDate,
--      предусмотреть вывод общего среднего StandardPrice за ShipDate из таблицы Purchasing.PurchaseOrderHeader. (»спользовать CUBE).
SELECT 
	EmployeeID
  , ShipDate
  , AVG(SubTotal) AS StandardPrice
FROM Purchasing.PurchaseOrderHeader
GROUP BY CUBE (ShipDate,EmployeeID);