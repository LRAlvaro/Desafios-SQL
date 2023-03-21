-- Listar los Nombres y Apellidos concatenados de los clientes que NO hayan realizado una compra en Enero 2011 y que sean de Sydney  
-- > Tablas (DimCustomer, FactInternetSales, DimGeography)

SELECT * FROM 
(
Select distinct dc.FirstName, dc.LastName, CONCAT (FirstName, ' ', LastName) as FullName, dc.GeographyKey
from DimCustomer dc
where dc.CustomerKey not in (select fis.CustomerKey from FactInternetSales fis
                              where fis.OrderDate between '20110101' and '20110131')) A
INNER JOIN DimGeography dg on dg.GeographyKey = A.GeographyKey
WHERE dg.City = 'Sydney'

-- Mostrar todos los empleados que se encuentren en el departamento de manufactura (Production) y de Aseguramiento de Calidad (Quality Assurance) 
-- > Tablas (DimEmployee)

SELECT *
FROM DimEmployee
WHERE DepartmentName = 'Quality Assurance' or DepartmentName = 'Production'


-- Listar todos los empleados que se encuentren en el departamento de manufactura (Production) y de Aseguramiento de Calidad (Quality Assurance) y que además o sean Hombres (M) o se encuentren Solteros (S) 
-- > Tablas (DimEmployee)

SELECT *
FROM DimEmployee
WHERE DepartmentName = 'Quality Assurance' or DepartmentName = 'Production' and Gender = 'M' and MaritalStatus = 'S'

-- Listar los empleados cuyo apellido empiece con S o su Nombre termine con A 
-- > Tablas (DimEmployee)

SELECT * 
FROM DimEmployee
WHERE FirstName LIKE '%a' or LastName LIKE 's%'

-- Obtener la lista de los empleados cuya edad es mayor que 40. Listar Nombre, Apellido, Sexo, Fecha de Nacimiento, Edad 
-- > Tablas (DimEmployee)

SELECT FirstName, LastName, Gender, BirthDate, DATEDIFF(year, BirthDate, getdate()) as Age
FROM DimEmployee 
WHERE BirthDate < '1983'
ORDER BY BirthDate desc

