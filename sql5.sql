-- Crear una tabla igual a la fuente original con el nombre Data_destino. (NOTA: LA TABLA DE VENTAS SE LLAMA TABLA PRACTICA)

USE [Practica]
GO

/****** Object:  Table [dbo].[PRACTICA]    Script Date: 30/06/2022 23:41:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Data_Destino]
(
	[Segment] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[Product] [nvarchar](255) NULL,
	[Discount Band] [nvarchar](255) NULL,
	[Units Sold] [float] NULL,
	[Manufacturing Price] [money] NULL,
	[Sale Price] [money] NULL,
	[Gross Sales] [money] NULL,
	[Discounts] [money] NULL,
	[Sales] [money] NULL,
	[COGS] [money] NULL,
	[Profit] [money] NULL,
	[Date] [datetime] NULL,
	[Month Number] [float] NULL,
	[Month Name] [nvarchar](255) NULL,
	[Year] [nvarchar](255) NULL
) ON [PRIMARY]
GO

-- Insertar en dicha tabla todos los registros cuya venta se haya realizado en México o el producto sea Paseo. -- 

INSERT INTO Data_Destino
SELECT *
FROM PRACTICA
WHERE Country = 'Mexico' or Product = 'Paseo'

-- Insertar en dicha tabla todas las ventas realizadas en el segundo semestre del 2014.

INSERT INTO Data_Destino
SELECT * 
FROM PRACTICA
WHERE Year = '2014' and [Month Number] > '6'


-- Modificar el segmento MidMarket de las ventas de México  por Enterprise.

UPDATE Data_Destino
SET Segment = 'Enterprise'                          -- 56 rows existentes de enterprise
WHERE Segment = 'Midmarket' and Country = 'Mexico'  -- 56 rows de midmarket se modifican y pasan a ser enterprise

SELECT * FROM Data_Destino
WHERE Segment = 'Enterprise' and Country = 'Mexico'  -- 112 rows de enterprise hay ahora (56+56)

-- Insertar todas las Carreteras vendidas en Canadá, sumándole 1 a la cantidad vendida original.

SELECT * FROM PRACTICA
WHERE Product = 'Carretera' and Country = 'Canada'
Order by [Units Sold] desc

INSERT INTO Data_Destino
SELECT 
Segment, Country, Product, [Discount Band], ([Units Sold] + 1), [Manufacturing Price], [Sale Price], [Gross Sales], 
Discounts,[ Sales], COGS, Profit, [Date],
[Month Number], [Month Name], [Year]
FROM PRACTICA
WHERE Product = 'Carretera' and Country = 'Canada'


-- Eliminar las ventas cuyo precio sea menor a 20.

select * from Data_Destino  --- 538 ventas menores a 20
WHERE [Sale Price] < 20

DELETE FROM Data_Destino   --- 538 ventas eliminadas
WHERE [Sale Price] < 20


-- Eliminar las ventas de Enero 2014 que se hayan realizado Canadá.

select * from Data_Destino
WHERE Year = '2014' and [Month Name] = 'January'  and Country = 'Canada'  

DELETE FROM Data_Destino
WHERE Year = '2014' and [Month Name] = 'January' and Country = 'Canada' 

