CREATE TABLE DimSegmentos
(
     [IdSegmentos] [int] IDENTITY (1,1) NOT NULL,
	 [Segmentos] [varchar] NOT NULL,
	 
)

CREATE TABLE DimPais
(
     [IdCountry] [int] IDENTITY (1,1) NOT NULL, 
     [Country] [varchar] (25) NOT NULL,

)

CREATE TABLE DimProducto
(
     [IdProducto] [int] IDENTITY (1,1) NOT NULL,
	 [Producto] [varchar] NOT NULL,
)

CREATE TABLE DimTiempo
(
     [IdTiempo] [int] IDENTITY (1,1) NOT NULL,
	 [Fecha] [date] NOT NULL,
	 [Numero de Mes] [int] NULL,
	 [Mes] [varchar] NULL, 
	 [Año] [int] NULL,
)

CREATE TABLE DimBandaDescuento
(
     [IdBandaDescuento] [int] IDENTITY (1,1) NOT NULL,
	 [BandaDescuento] [varchar] NULL,
)

CREATE TABLE FactsVentas
(
     [IdVentas] [int] IDENTITY (1,1) NOT NULL,
	 [UnidadesVendidas] [float] NOT NULL,
	 [Facturacion] [money] NOT NULL,
	 [Precio de Venta] [money] NOT NULL,
	 [VentasBrutas] [money] NULL,
	 [Descuentos] [money] NULL,
	 [Ventas] [money] NOT NULL,
	 [COGS] [money] NOT NULL,
	 [Beneficios] [money] NULL,
	
)

