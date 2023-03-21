-- Listar todas las ventas de internet (FactInternetSales) cuya orden fue realizada en Enero 2011.

SELECT * 
FROM FactInternetSales fis
WHERE OrderDate between '20110101' and '20110131'

-- Listar todas las ventas de Internet cuyo precio unitario sea mayor 3500.

SELECT * 
FROM FactInternetSales
WHERE UnitPrice > 3500

-- Listar los Nombres y Apellidos de los clientes que realizaron las ventas listadas en el primer punto.

SELECT dc.FirstName, dc.LastName, fis.CustomerKey
FROM DimCustomer dc
INNER JOIN FactInternetSales fis on dc.CustomerKey = fis.CustomerKey
WHERE fis.OrderDate between '20110101' and '20110131'

-- Listar los Nombres y Apellidos de los clientes que NO hayan realizado una compra en Enero 2011

SELECT dc.FirstName, dc.LastName, dc.CustomerKey
FROM DimCustomer dc
WHERE dc.CustomerKey not in (SELECT fis.CustomerKey FROM FactInternetSales fis WHERE OrderDate between '20110101' and '20110131')


