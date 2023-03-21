-- Listar los 2 Reseller que más vendieron (FactResellerSales - SalesAmount) en Diciembre 2010

SELECT TOP 2
   frs.OrderDate as AñoyMes,
   SUM(frs.SalesAmount) as CantidadVentas,
   dr.ResellerName as Revendedor
FROM FactResellerSales frs
INNER JOIN DimReseller dr on frs.ResellerKey = dr.ResellerKey
WHERE frs.OrderDate between '20101201' and '20101231'
GROUP BY frs.OrderDate, dr.ResellerName
ORDER BY 2 desc

-- Cuánto fue el total vendido por el Reseller “Bike Dealers Association”? 

SELECT 
   SUM(frs.SalesAmount) AS TotalVendido,
   dr.ResellerName AS Revendedor
FROM FactResellerSales frs
JOIN DimReseller dr on frs.ResellerKey = dr.ResellerKey
WHERE dr.ResellerName = 'Bike Dealers Association'
GROUP BY dr.ResellerName

-- Listar adicionalmente el monto vendido por año para dicho Reseller.

SELECT 
   dd.CalendarYear as Año,
   frs.SalesAmount as CantidadVentas,
   dr.ResellerName as Revendedor,
   SUM(frs.SalesAmount) over(partition by dd.CalendarYear) as GranTotal
FROM FactResellerSales frs
JOIN DimReseller dr on frs.ResellerKey = dr.ResellerKey
JOIN DimDate dd on frs.OrderDateKey = dd.DateKey
WHERE dr.ResellerName = 'Bike Dealers Association' 
GROUP BY frs.SalesAmount, frs.OrderDate, dr.ResellerName, dd.CalendarYear
ORDER BY 1 asc

-- Listar la cantidad de Productos vendidos por Reseller en el 2011.

SELECT
   SUM(frs.OrderQuantity) as CantidadProductosVendidos,
   dr.ResellerName as Revendedor,
   dd.CalendarYear as Año
FROM FactResellerSales frs
JOIN DimDate dd on frs.OrderDateKey = dd.DateKey
JOIN DimReseller dr on frs.ResellerKey = dr.ResellerKey
WHERE dd.CalendarYear = '2011'
GROUP BY dr.ResellerName, dd.CalendarYear
ORDER BY 1 desc


-- Detallar solo los Resellers cuya cantidad vendida en el mes haya superado las 400 unidades. Mostrar primero el mes y Reseller que más vendió.

SELECT
   dr.ResellerName as Revendedor,
   dd.EnglishMonthName as Mes,
   Sum(fs.OrderQuantity) as Cantidad
FROM FactResellerSales fs
JOIN DimDate dd on fs.OrderDateKey = dd.DateKey
JOIN DimReseller dr on fs.ResellerKey = dr.ResellerKey
GROUP BY dr.ResellerName, dd.EnglishMonthName
HAVING Sum(fs.OrderQuantity) > 400
ORDER BY 3 asc

-- Listar el Ranking de Productos Vendidos por Reseller.

SELECT 
  dp.EnglishProductName as Producto,
  dr.ResellerName as Revendedor,
  fs.SalesAmount as CantidadVendida,
  RANK() OVER(PARTITION BY dr.ResellerName ORDER BY fs.SalesAmount DESC) as "Ranking"
FROM FactResellerSales fs
INNER JOIN DimReseller dr on fs.ResellerKey = dr.ResellerKey
INNER JOIN DimProduct dp on fs.ProductKey = dp.ProductKey

-- Cuál fue la venta más alta y que Reseller la realizó, para el producto: “Mountain-100 Black, 42”

SELECT TOP 1
   SUM(frs.SalesAmount) as VentaMasAlta,
   dr.ResellerName as Revendedor,
   dp.EnglishProductName as Producto
FROM FactResellerSales frs
JOIN DimProduct dp on frs.ProductKey = dp.ProductKey
JOIN DimReseller dr on frs.ResellerKey = dr.ResellerKey
WHERE dp.EnglishProductName = 'Mountain-100 Black, 42'
GROUP BY  dr.ResellerName, dp.EnglishProductName
ORDER BY 1 desc

