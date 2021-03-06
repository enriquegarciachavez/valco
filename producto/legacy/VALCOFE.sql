USE [master]
GO
/****** Object:  Database [Valco_FE]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE DATABASE [Valco_FE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Valco_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Valco_FE.MDF' , SIZE = 1951552KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Valco_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Valco_FE.LDF' , SIZE = 1024KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [Valco_FE] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Valco_FE].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [Valco_FE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Valco_FE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Valco_FE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Valco_FE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Valco_FE] SET ARITHABORT OFF 
GO
ALTER DATABASE [Valco_FE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Valco_FE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Valco_FE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Valco_FE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Valco_FE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Valco_FE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Valco_FE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Valco_FE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Valco_FE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Valco_FE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Valco_FE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Valco_FE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Valco_FE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Valco_FE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Valco_FE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Valco_FE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Valco_FE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Valco_FE] SET RECOVERY FULL 
GO
ALTER DATABASE [Valco_FE] SET  MULTI_USER 
GO
ALTER DATABASE [Valco_FE] SET PAGE_VERIFY TORN_PAGE_DETECTION  
GO
ALTER DATABASE [Valco_FE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Valco_FE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Valco_FE] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Valco_FE] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Valco_FE', N'ON'
GO
USE [Valco_FE]
GO
/****** Object:  UserDefinedTableType [dbo].[TablaUnSplit]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE TYPE [dbo].[TablaUnSplit] AS TABLE(
	[Contenido] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[Fmt_Espacios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Fmt_Espacios] (@Parametro varchar(700))
	RETURNS varchar(700)
AS

BEGIN
	
	SET @Parametro = Replace(Replace(Replace(ltrim(rtrim(@Parametro)),CHAR(10),''),char(13),''),'|','')

	WHILE ( charindex('  ', @Parametro ) ) > 1
	BEGIN

		SET @Parametro = replace( @Parametro , '  ', ' ' )

	END

	WHILE ( charindex('--', @Parametro ) ) > 1
	BEGIN

		SET @Parametro = replace( @Parametro , '--', '' )

	END

	RETURN @Parametro

END 

GO
/****** Object:  UserDefinedFunction [dbo].[fnSplit]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnSplit](    
	@sInputList VARCHAR(8000),
	@sDelimiter VARCHAR(8000) = ','
)
RETURNS @List TABLE (item VARCHAR(8000))

BEGIN
	DECLARE @sItem VARCHAR(8000)
	
	WHILE CHARINDEX(@sDelimiter,@sInputList,0) <> 0 
	BEGIN 
		SELECT  @sItem = RTRIM(LTRIM(SUBSTRING(@sInputList,1,CHARINDEX(@sDelimiter,@sInputList,0)-1))),  
				@sInputList = RTRIM(LTRIM(SUBSTRING(@sInputList,CHARINDEX(@sDelimiter,@sInputList,0)+LEN(@sDelimiter),LEN(@sInputList)))) 
				
		IF LEN(@sItem) > 0  
			INSERT INTO @List 
			SELECT @sItem 
	END
				
	IF LEN(@sInputList) > 0 
		INSERT INTO @List 
		SELECT @sInputList
				
	RETURN
END





GO
/****** Object:  UserDefinedFunction [dbo].[fObtenerNombreMes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fObtenerNombreMes]
(
	@Fecha smalldatetime
)
RETURNS varchar(20)
AS
BEGIN
	DECLARE @Mes varchar(20)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Mes = CASE WHEN MONTH(@Fecha) = 1 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 2 THEN 'Febrero' 
					   WHEN MONTH(@Fecha) = 3 THEN 'Marzo' 
					   WHEN MONTH(@Fecha) = 4 THEN 'Abril' 
					   WHEN MONTH(@Fecha) = 5 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 6 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 7 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 8 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 9 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 10 THEN 'Enero' 
					   WHEN MONTH(@Fecha) = 11 THEN 'Noviembre' 
					   WHEN MONTH(@Fecha) = 12 THEN 'Diciembre' 
		    END
	-- Return the result of the function
	RETURN @Mes

END

GO
/****** Object:  UserDefinedFunction [dbo].[ISOweek]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[ISOweek]  (@DATE datetime)
RETURNS int
AS
BEGIN
   DECLARE @ISOweek int
   SET @ISOweek= DATEPART(wk,@DATE)+1
      -DATEPART(wk,CAST(DATEPART(yy,@DATE) as CHAR(4))+'0104')

--Special cases: Jan 1-3 may belong to the previous year
   IF (@ISOweek=0) 
      SET @ISOweek=dbo.ISOweek(CAST(DATEPART(yy,@DATE)-1 
         AS CHAR(4))+'12'+ CAST(24+DATEPART(DAY,@DATE) AS CHAR(2)))+1

--Special case: Dec 29-31 may belong to the next year
   IF ((DATEPART(mm,@DATE)=12) AND 
      ((DATEPART(dd,@DATE)-DATEPART(dw,@DATE))>= 28))
      SET @ISOweek=1
   RETURN(@ISOweek)
END
GO
/****** Object:  UserDefinedFunction [dbo].[UnSplit]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[UnSplit] (@Tabla TablaUnSplit READONLY,@Delimitador Varchar(1))
returns varchar(Max)
as
begin

Declare @Cont Varchar(Max)
Declare @Result Varchar(Max)
Set @Result = ''


declare curBarre cursor for
	Select Contenido From @Tabla
open curBarre 
	fetch next from curBarre into @Cont
		While @@FETCH_STATUS =0 Begin
			Set @Result = @Result + @Cont + @Delimitador
			fetch next from curBarre into @Cont
		End
	close curBarre
Deallocate curBarre

return @Result
end 

GO
/****** Object:  Table [dbo].[Agrupacion_Productos_Facturacion]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agrupacion_Productos_Facturacion](
	[intAgrupacion_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
 CONSTRAINT [PK_Agrupacion_Productos_Facturacion] PRIMARY KEY CLUSTERED 
(
	[intAgrupacion_ID] ASC,
	[intProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Almacenes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Almacenes](
	[intAlmacen_ID] [int] NOT NULL,
	[vchNombre] [varchar](50) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Almacenes_bitActivo]  DEFAULT (1),
	[BaseDatos] [varchar](20) NOT NULL CONSTRAINT [DF_Almacenes_BaseDatos]  DEFAULT (''),
 CONSTRAINT [PK_Almacenes] PRIMARY KEY CLUSTERED 
(
	[intAlmacen_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_ClaveProdServ]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_ClaveProdServ](
	[c_ClaveProdServ] [varchar](50) NULL,
	[Descripcion] [varchar](500) NULL,
	[FechaInicioVigencia] [datetime] NULL,
	[FechaFinVigencia] [varchar](50) NULL,
	[Incluir_IVA_Trasladado] [varchar](50) NULL,
	[Incluir_IEPS_Trasladado] [varchar](50) NULL,
	[Complemento] [varchar](50) NULL,
	[Seleccionado] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_ClaveUnidad]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[c_ClaveUnidad](
	[Clave_Unidad] [varchar](10) NULL,
	[Nombre] [varchar](120) NULL,
	[Descripción] [varchar](300) NULL,
	[Nota] [varchar](250) NULL,
	[Fecha_Inicio_Vigencia] [datetime] NULL,
	[Fecha_Fin_Vigencia] [varchar](50) NULL,
	[Simbolo] [varchar](50) NULL,
	[Seleccionado] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_CodigoPostal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_CodigoPostal](
	[c_CodigoPostal] [varchar](50) NULL,
	[c_Estado] [varchar](50) NULL,
	[c_Municipio] [varchar](50) NULL,
	[c_Localidad] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_FormaPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_FormaPago](
	[Codigo] [varchar](10) NULL,
	[Descripcion] [varchar](100) NULL,
	[Bancarizado] [varchar](50) NULL,
	[No_Operacion] [varchar](50) NULL,
	[RFC_Cta_Ordenante] [varchar](100) NULL,
	[Cta_Ordenante] [varchar](50) NULL,
	[Patron_Cta_Ordenante] [varchar](100) NULL,
	[RFC_Cta_Beneficiario] [varchar](50) NULL,
	[Cuenta_Beneficiario] [varchar](50) NULL,
	[Patron_Cta_Beneficiaria] [varchar](100) NULL,
	[Tipo_Cadena_Pago] [varchar](50) NULL,
	[Nombre_Banco_Emisor] [varchar](200) NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Terminacion] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_Impuesto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_Impuesto](
	[Impuesto] [varchar](10) NULL,
	[Descripción] [varchar](50) NULL,
	[Retención] [varchar](10) NULL,
	[Traslado] [varchar](10) NULL,
	[Local_Federal] [varchar](20) NULL,
	[Entidad_Aplica] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_MetodoPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_MetodoPago](
	[Metodo_Pago] [varchar](10) NULL,
	[Descripcion] [varchar](50) NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Terminacion] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_Moneda]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_Moneda](
	[Tipo_Moneda] [varchar](10) NULL,
	[Descripcion] [varchar](50) NULL,
	[Decimales] [varchar](10) NULL,
	[Factor_Conversion] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_Pais]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_Pais](
	[Pais] [varchar](10) NULL,
	[Descripcion] [varchar](50) NULL,
	[Formato_Codigo_Postal] [varchar](100) NULL,
	[Formato_Identidad__Tributaria] [varchar](100) NULL,
	[Validacion_Identidad_Tributaria] [varchar](50) NULL,
	[Agrupaciones] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_RegimenFiscal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_RegimenFiscal](
	[Regimen_Fiscal] [varchar](10) NULL,
	[Descripción] [varchar](200) NULL,
	[Aplica_Persona_Fisica] [varchar](10) NULL,
	[Aplica_Persona_Moral] [varchar](10) NULL,
	[Fecha_Inicio_Vigencia] [datetime] NULL,
	[Fecha_Fin_Vigencia] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_TasaOCuota]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_TasaOCuota](
	[Rango_Fijo] [varchar](10) NULL,
	[TasaCuota_ValMin] [varchar](20) NULL,
	[TasaCuota_ValMax] [float] NULL,
	[Impuesto] [varchar](10) NULL,
	[Factor] [varchar](10) NULL,
	[Traslado] [varchar](10) NULL,
	[Retención] [varchar](10) NULL,
	[Fecha_Inicio_Vigencia] [datetime] NULL,
	[Fecha_Fin_Vigencia] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_TipoDeComprobante]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_TipoDeComprobante](
	[Tipo_Comprobante] [varchar](10) NULL,
	[Descripción] [varchar](50) NULL,
	[Valor_Maximo_Ini] [varchar](50) NULL,
	[Valor_Maxinmo_Fin] [float] NULL,
	[Fecha_Inicio_Vigencia] [datetime] NULL,
	[Fecha_Fin_Vigencia] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_TipoFactor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_TipoFactor](
	[Tipo_Factor] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_UsoCFDI]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_UsoCFDI](
	[Uso_CFDI] [varchar](10) NULL,
	[Descripción] [varchar](100) NULL,
	[Aplica_Persona_Fisica] [varchar](10) NULL,
	[Aplica_Persona_Moral] [varchar](10) NULL,
	[Fecha_Inicio_Vigencia] [datetime] NULL,
	[Fecha_Fin_Vigencia] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cab_Notas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cab_Notas_Credito](
	[intNota_Credito_ID] [int] NOT NULL,
	[dtmFecha] [smalldatetime] NOT NULL,
	[dtmFecha_Registro] [smalldatetime] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_dtmFecha_Registro]  DEFAULT (getdate()),
	[intCliente_ID] [int] NOT NULL,
	[vchMotivo] [varchar](100) NULL,
	[dtmFecha_Cancelacion] [smalldatetime] NULL,
	[vchTipo_Pago] [varchar](10) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchTipo_Pago]  DEFAULT (' '),
	[mnySubTotal] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnySubTotal]  DEFAULT ((0)),
	[mnyIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyIVA]  DEFAULT ((0)),
	[mnyRetIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyRetIVA]  DEFAULT ((0)),
	[mnyRetISR] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyRetISR]  DEFAULT ((0)),
	[mnyTotal] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyTotal]  DEFAULT ((0)),
	[mnyPIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyPIVA]  DEFAULT ((0)),
	[mnyPRetIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyPRetIVA]  DEFAULT ((0)),
	[mnyPRetISR] [money] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_mnyPRetISR]  DEFAULT ((0)),
	[vchCadena_Original] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchCadena_Original]  DEFAULT (''),
	[vchSello] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchSello]  DEFAULT (''),
	[txtXMLFE] [text] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_txtXMLFE]  DEFAULT (''),
	[vchSerie_Cert_SAT] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchSerie_Cert_SAT]  DEFAULT (''),
	[dtmFecha_Timbrado] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_dtmFecha_Timbrado]  DEFAULT (''),
	[vchFolio_Fiscal] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchFolio_Fiscal]  DEFAULT (''),
	[vchSello_SAT] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchSello_SAT]  DEFAULT (''),
	[vchSello_CFD] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchSello_CFD]  DEFAULT (''),
	[vchCadena_Original_CFDI] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchCadena_Original_CFDI]  DEFAULT (''),
	[vchXML_Timbre] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_vchXML_Timbre]  DEFAULT (''),
	[txtXML_CFDI] [text] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_txtXML_CFDI]  DEFAULT (''),
	[bitCancelada] [bit] NOT NULL CONSTRAINT [DF_Cab_Notas_Credito_bitCancelada]  DEFAULT ((0)),
 CONSTRAINT [PK_Cab_Notas_Credito] PRIMARY KEY NONCLUSTERED 
(
	[intNota_Credito_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cab_Pagos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cab_Pagos](
	[intPago_ID] [int] NOT NULL,
	[dtmFecha_Registro] [smalldatetime] NOT NULL,
	[dtmFecha_Pago] [datetime] NOT NULL,
	[vchClaveProdServ] [varchar](50) NOT NULL,
	[mnyCantidad] [money] NOT NULL,
	[vchDescripcion] [varchar](100) NOT NULL,
	[vchUnidad] [varchar](10) NOT NULL,
	[mnyPrecio] [money] NOT NULL,
	[mnyImporte] [money] NOT NULL,
	[mnyTotal] [money] NOT NULL,
	[vchCadena_Original] [varchar](8000) NULL,
	[vchSello] [varchar](8000) NULL,
	[txtXMLFE] [text] NULL,
	[vchSerie_Cert_SAT] [varchar](8000) NULL,
	[dtmFecha_Timbrado] [varchar](8000) NULL,
	[vchFolio_Fiscal_UUID] [varchar](8000) NULL,
	[vchSello_SAT] [varchar](8000) NULL,
	[vchSello_CFD] [varchar](8000) NULL,
	[vchCadena_Original_CFDI] [varchar](8000) NULL,
	[vchVersion_Timbre] [varchar](10) NULL,
	[vchXML_Timbre] [varchar](8000) NULL,
	[txtXML_CFDI] [text] NULL,
	[vchRfcProvCertifSAT] [varchar](8000) NULL,
	[bitCancelada] [bit] NOT NULL,
	[vchMotivo] [varchar](100) NULL,
	[dtmFecha_Cancelacion] [smalldatetime] NULL,
	[vchNotas] [varchar](200) NULL,
 CONSTRAINT [PK_Pagos_1] PRIMARY KEY CLUSTERED 
(
	[intPago_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cab_Ventas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cab_Ventas](
	[intFactura_ID] [int] NOT NULL,
	[dtmFecha_Registro] [datetime] NOT NULL CONSTRAINT [DF_Cab_Ventas_dtmFecha_Registro]  DEFAULT (getdate()),
	[vchTipo_Pago] [varchar](10) NOT NULL,
	[intCliente_ID] [int] NOT NULL,
	[mnySubTotal] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnySubTotal]  DEFAULT ((0)),
	[mnyIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyIVA]  DEFAULT ((0)),
	[mnyRetIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyRetIVA]  DEFAULT ((0)),
	[mnyRetISR] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyRetISR]  DEFAULT ((0)),
	[mnyTotal] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyTotal]  DEFAULT ((0)),
	[mnyPIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyPIVA]  DEFAULT ((0)),
	[mnyPRetIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyPRetIVA]  DEFAULT ((0)),
	[mnyPRetISR] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyPRetISR]  DEFAULT ((0)),
	[vchCadena_Original] [text] NOT NULL CONSTRAINT [DF_Cab_Ventas_vchCadena_Original]  DEFAULT (''),
	[vchSello] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSello]  DEFAULT (''),
	[txtXMLFE] [text] NOT NULL CONSTRAINT [DF_Cab_Ventas_txtXMLFE]  DEFAULT (''),
	[vchSerie_Cert_SAT] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSerie_Cert_SAT]  DEFAULT (''),
	[dtmFecha_Timbrado] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_dtmFecha_Timbrado]  DEFAULT (''),
	[vchFolio_Fiscal] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchFolio_Fiscal]  DEFAULT (''),
	[vchSello_SAT] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSello_SAT]  DEFAULT (''),
	[vchSello_CFD] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSello_CFD]  DEFAULT (''),
	[vchCadena_Original_CFDI] [text] NOT NULL CONSTRAINT [DF_Cab_Ventas_vchCadena_Original_CFDI]  DEFAULT (''),
	[vchXML_Timbre] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchXML_Timbre]  DEFAULT (''),
	[txtXML_CFDI] [text] NOT NULL CONSTRAINT [DF_Cab_Ventas_txtXML_CFDI]  DEFAULT (''),
	[bitCancelada] [bit] NOT NULL CONSTRAINT [DF_Cab_Ventas_bitCancelada]  DEFAULT ((0)),
	[vchAddenda] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchAddenda]  DEFAULT (''),
 CONSTRAINT [PK_Cab_Ventas] PRIMARY KEY NONCLUSTERED 
(
	[intFactura_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cierre_Inventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cierre_Inventario](
	[intCierre_ID] [int] IDENTITY(1,1) NOT NULL,
	[dtmFechaCierre] [datetime] NULL,
	[intUsuario_ID] [int] NULL,
 CONSTRAINT [PK_Cierre_Inventario] PRIMARY KEY CLUSTERED 
(
	[intCierre_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[intCliente_ID] [int] NOT NULL,
	[vchRazonSocial] [varchar](80) NULL,
	[vchNombre] [varchar](50) NULL,
	[vchApellidoPaterno] [varchar](50) NULL,
	[vchApellidoMaterno] [varchar](50) NULL,
	[vchDireccion] [varchar](60) NULL,
	[vchCiudad] [varchar](20) NULL,
	[vchEstado] [varchar](20) NULL,
	[vchCodigoPostal] [varchar](5) NULL,
	[vchTelefono] [varchar](30) NULL,
	[vchRFC] [varchar](20) NULL,
	[mnyLimiteCredito] [money] NULL CONSTRAINT [DF_Clientes_mnyLimiteCredito]  DEFAULT (0),
	[bitCobrar] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitCobrar]  DEFAULT (1),
	[bitFacturar] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitFacturar]  DEFAULT (1),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitActivo]  DEFAULT (1),
	[bitForaneo] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitForaneo]  DEFAULT (0),
	[intPlazo] [int] NULL,
	[vchCuentaContable] [varchar](10) NULL,
	[vchColonia] [varchar](50) NULL,
	[vchNoExterior] [varchar](10) NULL,
	[vchNoInterior] [varchar](10) NULL,
	[vchPais] [varchar](10) NULL,
	[vchReferencia] [varchar](50) NULL,
	[bitEnviarCorreo] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitEnviarCorreo]  DEFAULT ((0)),
	[vchEmail] [varchar](40) NULL,
	[bitOrdenCompra] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitOrdenCompra]  DEFAULT ((0)),
	[vchAddenda] [varchar](50) NOT NULL CONSTRAINT [DF_Clientes_vchAddenda]  DEFAULT (''),
	[vchMetodoPago] [varchar](30) NULL,
	[vchCuentaBancaria] [varchar](20) NOT NULL CONSTRAINT [DF_Clientes_vchCuentaBancaria]  DEFAULT (''),
	[vchBanco] [varchar](20) NOT NULL CONSTRAINT [DF_Clientes_vchBanco]  DEFAULT (''),
	[bitIncobrable] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitIncobrable]  DEFAULT ((0)),
	[vchUso_CFDI] [varchar](10) NOT NULL CONSTRAINT [DF_Clientes_Uso_CFDI]  DEFAULT (''),
	[vchFormaPago] [varchar](10) NOT NULL CONSTRAINT [DF_Clientes_vchFormaPago]  DEFAULT (''),
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[intCliente_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CodigoBarras_Proveedor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CodigoBarras_Proveedor](
	[vchCodigoBarras_Proveedor] [varchar](20) NOT NULL,
	[vchDescripcion] [varchar](40) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comparativo]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comparativo](
	[chrTipo] [char](1) NULL,
	[intCliente_ID] [int] NULL,
	[intFactura_ID] [int] NULL,
	[dtmFecha] [datetime] NULL,
	[mnyImporte] [money] NULL CONSTRAINT [DF_Comparativo_mnyImporte]  DEFAULT (0),
	[mnyAbonado] [money] NULL CONSTRAINT [DF_Comparativo_mnyAbonado]  DEFAULT (0),
	[mnySaldo] [money] NULL CONSTRAINT [DF_Comparativo_mnySaldo]  DEFAULT (0),
	[intRemisionNo] [int] NULL CONSTRAINT [DF_Comparativo_intRemisionNo]  DEFAULT (0)
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Conceptos_Poliza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Conceptos_Poliza](
	[dtmFecha] [smalldatetime] NOT NULL,
	[vchConcepto] [varchar](30) NOT NULL,
	[mnyDebe] [money] NULL CONSTRAINT [DF_Conceptos_Poliza_mnyDebe]  DEFAULT ((0)),
	[mnyHaber] [money] NULL CONSTRAINT [DF_Conceptos_Poliza_mnyHaber]  DEFAULT ((0)),
	[vchCuentaContable] [varchar](15) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Configuracion_Correo]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Configuracion_Correo](
	[vchServidor] [varchar](20) NULL,
	[vchPuerto] [varchar](10) NULL,
	[vchCorreo] [varchar](30) NULL,
	[vchContrasena] [varchar](30) NULL,
	[vchCon_Copia_A] [varchar](40) NULL,
	[vchTitulo] [varchar](50) NULL,
	[vchMensaje] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Control_Cajas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Cajas](
	[intContador_Cajas] [bigint] NULL CONSTRAINT [DF_Control_Cajas_intContador_Cajas]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Deshueses]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Deshueses](
	[intContador_Deshueses] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Facturas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Facturas](
	[intContador_Facturas] [int] NULL CONSTRAINT [DF_Control_Facturas_intFactura_ID]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Folios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Control_Folios](
	[intFolio_ID] [int] NOT NULL,
	[chrTipo_Documento] [char](1) NOT NULL,
	[vchSerie] [varchar](10) NOT NULL,
	[intFolioInicial] [int] NOT NULL,
	[intFolioFinal] [int] NOT NULL,
	[intNumero_Aprobacion] [bigint] NOT NULL,
	[intAno_Aprobacion] [int] NOT NULL,
	[intUltimo_Folio_Usado] [int] NOT NULL,
	[bitDisponible] [bit] NOT NULL,
 CONSTRAINT [PK_Control_Folios_1] PRIMARY KEY CLUSTERED 
(
	[intFolio_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Control_Folios_Remisiones]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Folios_Remisiones](
	[intConsecutivo] [int] NOT NULL,
	[intRepartidor_ID] [int] NULL,
	[intFolio_Inicial] [int] NULL CONSTRAINT [DF_Control_Folios_Remisiones_intFolioInicial]  DEFAULT (0),
	[intFolio_Final] [int] NULL CONSTRAINT [DF_Control_Folios_Remisiones_intFolioFinal]  DEFAULT (0),
 CONSTRAINT [PK_Control_Folios_Remisiones] PRIMARY KEY CLUSTERED 
(
	[intConsecutivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Inventarios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Inventarios](
	[intContador_Inventarios] [int] NULL CONSTRAINT [DF_Control_Inventarios_intContador_Inventarios]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Notas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Notas_Credito](
	[intContador_Notas] [int] NULL CONSTRAINT [DF_Control_NotasCredito_intContador_Notas]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Ordenes_Compra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Ordenes_Compra](
	[intContador_Ordenes] [int] NULL CONSTRAINT [DF_Control_Ordenes_Compra_intContador_Ordenes]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Pagos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Pagos](
	[intContador_Pagos] [int] NULL CONSTRAINT [DF_Control_Pagos_intPago_ID]  DEFAULT ((0))
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control_Remisiones]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Remisiones](
	[intContador_Remisiones] [int] NULL CONSTRAINT [DF_Control_Remisiones_intContador_Remisiones]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Correcion_Pesos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Correcion_Pesos](
	[intCorreccion_ID] [int] NOT NULL CONSTRAINT [DF_Correcion_Pesos_intCorreccion_ID]  DEFAULT (0),
	[intProducto_ID] [int] NOT NULL CONSTRAINT [DF_Correcion_Pesos_intProducto_ID]  DEFAULT (0),
	[dtmFecha] [datetime] NOT NULL CONSTRAINT [DF_Correcion_Pesos_dtmFecha]  DEFAULT (getdate()),
	[intCanalNo] [bigint] NULL CONSTRAINT [DF_Correcion_Pesos_intCanalNo]  DEFAULT (0),
	[intOrdenCompra_ID] [int] NULL CONSTRAINT [DF_Correcion_Pesos_intOrdenCompra_ID]  DEFAULT (0),
	[intMatanza_ID] [int] NULL CONSTRAINT [DF_Correcion_Pesos_intM0atanza_ID]  DEFAULT (0),
	[mnyPeso_Anterior] [money] NULL CONSTRAINT [DF_Correcion_Pesos_mnyPeso_Anterior]  DEFAULT (0),
	[mnyPeso_Nuevo] [money] NULL CONSTRAINT [DF_Correcion_Pesos_mnyPeso_Nuevo]  DEFAULT (0),
 CONSTRAINT [PK_Correcion_Pesos] PRIMARY KEY CLUSTERED 
(
	[intCorreccion_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CtasXCobrar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CtasXCobrar](
	[intCtaXCobrar_ID] [int] NOT NULL,
	[intAlmacen_ID] [int] NOT NULL CONSTRAINT [DF_CtasXCobrar_intAlmacen_ID]  DEFAULT (0),
	[dtmFecha] [datetime] NULL,
	[intCliente_ID] [int] NULL CONSTRAINT [DF_CtasXCobrar_intCliente_ID]  DEFAULT (0),
	[intRemisionNo] [int] NULL CONSTRAINT [DF_CtasXCobrar_intRemisionNo]  DEFAULT (0),
	[intFactura_ID] [int] NULL CONSTRAINT [DF_CtasXCobrar_intFactura_ID]  DEFAULT (0),
	[mnyImporte] [money] NULL CONSTRAINT [DF_CtasXCobrar_mnyImporte]  DEFAULT (0),
	[mnyAbonado] [money] NULL CONSTRAINT [DF_CtasXCobrar_mnyAbonado]  DEFAULT (0),
	[mnySaldo] [money] NULL CONSTRAINT [DF_CtasXCobrar_mnySaldo]  DEFAULT (0),
	[bitCancelado] [bit] NULL CONSTRAINT [DF_CtasXCobrar_bitCancelado]  DEFAULT (0),
	[vchOrden_Compra] [varchar](20) NOT NULL CONSTRAINT [DF_CtasXCobrar_vchOrden_Compra]  DEFAULT (''),
 CONSTRAINT [PK_CtasXCobrar] PRIMARY KEY CLUSTERED 
(
	[intCtaXCobrar_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CtasXPagar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CtasXPagar](
	[intCtaXPagar_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NULL CONSTRAINT [DF_CtasXPagar_dtmFecha]  DEFAULT (getdate()),
	[intProveedor_ID] [int] NULL CONSTRAINT [DF_CtasXPagar_intProveedor_ID]  DEFAULT (0),
	[mnyImporte] [money] NULL CONSTRAINT [DF_CtasXPagar_mnyImporte]  DEFAULT (0),
	[mnyAbonado] [money] NULL CONSTRAINT [DF_CtasXPagar_mnyAbonado]  DEFAULT (0),
	[mnySaldo] [money] NULL CONSTRAINT [DF_CtasXPagar_mnySaldo]  DEFAULT (0),
	[bitCancelado] [bit] NULL CONSTRAINT [DF_CtasXPagar_bitCancelado]  DEFAULT (0),
	[intOrdenCompra_ID] [int] NULL CONSTRAINT [DF_CtasXPagar_intOrdenCompra_ID]  DEFAULT (0),
 CONSTRAINT [PK_CtasXPagar] PRIMARY KEY CLUSTERED 
(
	[intCtaXPagar_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cuentas_Contables]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cuentas_Contables](
	[intCtaContable_ID] [int] NOT NULL,
	[vchNoCuenta] [varchar](15) NOT NULL,
	[vchDescripcion] [varchar](30) NOT NULL,
	[bitBanco] [bit] NOT NULL CONSTRAINT [DF_Cuentas_Contables_bitbanco]  DEFAULT (0),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Cuentas_Contables_bitActivo]  DEFAULT (1),
 CONSTRAINT [PK_Cuentas_Contables] PRIMARY KEY CLUSTERED 
(
	[intCtaContable_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Cuentas_Contables] UNIQUE NONCLUSTERED 
(
	[vchNoCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Datos_CFDI]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Datos_CFDI](
	[vchCodigo_Usuario] [varchar](50) NOT NULL CONSTRAINT [DF_Datos_CFDI_vchCodigo_Usuario]  DEFAULT (''),
	[vchClave] [varchar](1000) NOT NULL CONSTRAINT [DF_Datos_CFDI_vchClave]  DEFAULT (''),
	[vchCodigo_Proveedor] [varchar](50) NOT NULL CONSTRAINT [DF_Datos_CFDI_vchCodigo_Proveedor]  DEFAULT (''),
	[intSucursal_CFDI] [int] NOT NULL CONSTRAINT [DF_Datos_CFDI_intSucursal_CFDI]  DEFAULT ((0)),
	[intPAC_ID] [int] NOT NULL CONSTRAINT [DF_Datos_CFDI_intPAC_ID]  DEFAULT ((0)),
	[vchVersion] [varchar](10) NOT NULL CONSTRAINT [DF_Datos_CFDI_vchVersion]  DEFAULT ('')
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Datos_FacturaElectronica]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Datos_FacturaElectronica](
	[imgCedula] [image] NULL,
	[vchVersion] [varchar](5) NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_Version]  DEFAULT (''),
	[dtmFecha_IniCertificado] [smalldatetime] NULL,
	[dtmFecha_FinCertificado] [smalldatetime] NULL,
	[vchCertificadoPEM] [varchar](4000) NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_CertificadoPEM]  DEFAULT (''),
	[vchCertificadoPublico] [varchar](max) NULL,
	[vchNo_Serie_Certificado] [varchar](50) NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_No_Serie_Certificado]  DEFAULT (''),
	[vchCertificado_Key_Pwd] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Deposito_Bancario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deposito_Bancario](
	[dtmFecha] [smalldatetime] NULL,
	[mnyDeposito] [money] NULL CONSTRAINT [DF_Deposito_Bancario_mnyDeposito]  DEFAULT (0)
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Deshueses]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deshueses](
	[intDeshuese_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NOT NULL,
	[mnyTotal_Peso] [money] NOT NULL,
	[bitProcesado] [bit] NOT NULL CONSTRAINT [DF_Deshueses_bitProcesado]  DEFAULT (0),
	[dtmFecha_Procesado] [datetime] NULL,
 CONSTRAINT [PK_Deshueses] PRIMARY KEY CLUSTERED 
(
	[intDeshuese_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Det_Notas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Det_Notas_Credito](
	[intNota_Credito_ID] [int] NOT NULL,
	[intRenglon] [int] NOT NULL,
	[intFactura_ID] [int] NOT NULL,
	[intRemisionNo] [int] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_intRemisionNo]  DEFAULT ((0)),
	[vchNotas] [varchar](300) NOT NULL,
	[mnyImporte] [money] NOT NULL,
	[mnyCantidad] [money] NULL,
	[vchClaveProdServ] [varchar](50) NULL CONSTRAINT [DF_Det_Notas_Credito_vchClaveProdServ]  DEFAULT (''),
	[vchNoIdentificacion] [varchar](50) NULL CONSTRAINT [DF_Det_Notas_Credito_vchNoIdentificacion]  DEFAULT (''),
	[vchUnidad] [varchar](10) NULL,
	[mnyPIVA] [money] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_mnyPIVA]  DEFAULT ((0)),
	[mnyPRetISR] [money] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_mnyPRetISR]  DEFAULT ((0)),
	[mnyPRetIVA] [money] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_mnyPRetIVA]  DEFAULT ((0)),
	[mnyIVA] [money] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_mnyIVA]  DEFAULT ((0)),
	[mnyRetISR] [money] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_mnyRetISR]  DEFAULT ((0)),
	[mnyRetIVA] [money] NOT NULL CONSTRAINT [DF_Det_Notas_Credito_mnyRetIVA]  DEFAULT ((0)),
 CONSTRAINT [PK_Det_Notas_Credito] PRIMARY KEY NONCLUSTERED 
(
	[intNota_Credito_ID] ASC,
	[intRenglon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Det_Pagos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Det_Pagos](
	[intPago_ID] [int] NOT NULL,
	[intFactura_ID] [int] NOT NULL,
	[intParcialidad] [smallint] NOT NULL,
	[mnySaldo_Anterior] [money] NOT NULL,
	[mnySaldo_Pendiente] [money] NOT NULL,
	[mnyMonto_Pagado] [money] NOT NULL,
 CONSTRAINT [PK_Det_Pagos] PRIMARY KEY CLUSTERED 
(
	[intPago_ID] ASC,
	[intFactura_ID] ASC,
	[intParcialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Det_Ventas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Det_Ventas](
	[intFactura_ID] [int] NOT NULL,
	[intRenglon] [smallint] NOT NULL,
	[mnyCantidad] [money] NULL,
	[vchUnidad] [varchar](20) NOT NULL,
	[intCodigo] [int] NULL,
	[vchProducto] [varchar](2000) NULL,
	[mnyPrecio] [money] NULL,
	[mnyPeso] [money] NULL,
	[mnyImporte] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyImporte]  DEFAULT ((0)),
	[vchCodigo_Barras] [varchar](20) NOT NULL CONSTRAINT [DF_Det_Ventas_vchCodigo_Barras]  DEFAULT (''),
	[intNo_Cajas] [int] NOT NULL CONSTRAINT [DF_Det_Ventas_intNo_Cajas]  DEFAULT ((0)),
	[vchClaveProdServ] [varchar](50) NULL CONSTRAINT [DF_Det_Ventas_vchClaveProdServ]  DEFAULT (''),
	[vchNoIdentificacion] [varchar](50) NULL CONSTRAINT [DF_Det_Ventas_vchNoIdentificacion]  DEFAULT (''),
	[mnyPIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyPIVA]  DEFAULT ((0)),
	[mnyPRetISR] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyPRetISR]  DEFAULT ((0)),
	[mnyPRetIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyPRetIVA]  DEFAULT ((0)),
	[mnyIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyIVA]  DEFAULT ((0)),
	[mnyRetISR] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyRetISR]  DEFAULT ((0)),
	[mnyRetIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyRetIVA]  DEFAULT ((0)),
 CONSTRAINT [PK_Det_Ventas] PRIMARY KEY NONCLUSTERED 
(
	[intFactura_ID] ASC,
	[intRenglon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Detalle_Cierre_Inventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Cierre_Inventario](
	[intCierre_ID] [int] NULL,
	[intAlmacen_ID] [int] NULL,
	[intProducto_ID] [int] NULL,
	[intOrdenCompra_ID] [int] NULL,
	[intCanalNo] [bigint] NULL,
	[intExistencia] [int] NULL,
	[mnyPeso] [money] NULL,
	[intMatanza_ID] [int] NULL,
	[intIdentificador_Unico] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalle_CtasXCobrar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_CtasXCobrar](
	[intCtaXCobrar_ID] [int] NOT NULL,
	[dtmFecha_Abono] [datetime] NOT NULL,
	[mnyAbono] [money] NULL CONSTRAINT [DF_Detalle_CtasXCobrar_mnyAbono]  DEFAULT (0),
	[bitAplicada_NC] [bit] NULL CONSTRAINT [DF_Detalle_CtasXCobrar_bitAplicada_NC]  DEFAULT (0),
	[Identificador] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Detalle_CtasXCobrar] PRIMARY KEY CLUSTERED 
(
	[Identificador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalle_CtasXPagar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Detalle_CtasXPagar](
	[intCtaXPagar_ID] [int] NOT NULL,
	[dtmFecha_Abono] [datetime] NOT NULL,
	[mnyAbono] [money] NULL,
	[vchObservaciones] [varchar](100) NULL,
	[Identificador] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Detalle_Deshueses]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Deshueses](
	[intDeshuese_ID] [int] NOT NULL,
	[intOrdenCompra_ID] [int] NOT NULL,
	[intMatanza_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
	[intCanalNo] [bigint] NOT NULL,
	[mnyPeso] [money] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalle_Facturas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Facturas](
	[intFactura_ID] [int] NOT NULL CONSTRAINT [DF_Detalle_Facturas_intFactura_ID]  DEFAULT (0),
	[intRenglon] [smallint] NOT NULL CONSTRAINT [DF_Detalle_Facturas_intRenglon]  DEFAULT (0),
	[intRemisionNo] [int] NOT NULL CONSTRAINT [DF_Detalle_Facturas_intRemisionNo]  DEFAULT (0),
 CONSTRAINT [PK_Detalle_Facturas] PRIMARY KEY CLUSTERED 
(
	[intFactura_ID] ASC,
	[intRenglon] ASC,
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalle_Inventario_Fisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Detalle_Inventario_Fisico](
	[intInventario_ID] [int] NULL,
	[intLinea] [int] NULL,
	[intProducto_ID] [int] NULL,
	[vchDescripcion] [varchar](100) NULL,
	[mnyPeso] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Detalle_Notas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Notas_Credito](
	[intNota_Credito_ID] [int] NOT NULL,
	[intRemisionNo] [int] NOT NULL,
	[mnyImporte] [money] NOT NULL,
	[bitAplicada] [bit] NOT NULL CONSTRAINT [DF_Detalle_Notas_Credito_bitAplicada]  DEFAULT (0),
	[bitCancelada] [bit] NOT NULL CONSTRAINT [DF_Detalle_Notas_Credito_bitCancelada]  DEFAULT (0),
 CONSTRAINT [PK_Detalle_Notas_Credito] PRIMARY KEY CLUSTERED 
(
	[intNota_Credito_ID] ASC,
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalle_Orden_Compra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Orden_Compra](
	[intOrdenCompra_ID] [int] NOT NULL CONSTRAINT [DF_Detalle_Orden_Compra_intOrden_Compra]  DEFAULT (0),
	[intRenglon] [int] NOT NULL CONSTRAINT [DF_Detalle_Orden_Compra_intRenglon]  DEFAULT (0),
	[intProducto_ID] [int] NOT NULL CONSTRAINT [DF_Detalle_Orden_Compra_intProducto_ID]  DEFAULT (0),
	[intCantidad] [int] NULL CONSTRAINT [DF_Detalle_Orden_Compra_intCantidad]  DEFAULT (0),
	[intCantidad_Recibida] [int] NULL CONSTRAINT [DF_Detalle_Orden_Compra_intCantidad_Recibida]  DEFAULT (0),
	[mnyPeso] [money] NULL CONSTRAINT [DF_Detalle_Orden_Compra_mnyPeso]  DEFAULT (0),
	[mnyDescuento] [money] NULL CONSTRAINT [DF_Detalle_Orden_Compra_mnyDescuento]  DEFAULT (0),
	[mnyPrecio] [money] NULL CONSTRAINT [DF_Detalle_Orden_Compra_mnyPrecio]  DEFAULT (0),
	[mnyImporte] [money] NULL CONSTRAINT [DF_Detalle_Orden_Compra_mnyImporte]  DEFAULT (0),
 CONSTRAINT [PK_Detalle_Orden_Compra] PRIMARY KEY CLUSTERED 
(
	[intOrdenCompra_ID] ASC,
	[intRenglon] ASC,
	[intProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalle_Remisiones]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Remisiones](
	[intRemisionNo] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
	[intCantidad] [int] NOT NULL,
	[mnyPeso] [money] NOT NULL,
	[mnyPrecio] [money] NOT NULL,
	[mnyFlete] [money] NOT NULL,
	[mnyImporte] [money] NOT NULL,
	[intMovimiento_ID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Errores]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Errores](
	[intConsecutivo] [int] NOT NULL,
	[dtmFecha] [datetime] NULL,
	[intNoError] [int] NULL,
	[vchDescripcion] [varchar](100) NULL,
	[vchForma] [varchar](30) NULL,
	[vchProcedimiento] [varchar](30) NULL,
 CONSTRAINT [PK_Errores] PRIMARY KEY CLUSTERED 
(
	[intConsecutivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Existencias]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Existencias](
	[intAlmacen_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
	[intOrdenCompra_ID] [int] NOT NULL CONSTRAINT [DF_Existencias_intOrdenCompra_ID]  DEFAULT (0),
	[intCanalNo] [bigint] NOT NULL CONSTRAINT [DF_Existencias_intCanalNo]  DEFAULT (0),
	[intExistencia] [int] NULL CONSTRAINT [DF_Existencias_intCantidad]  DEFAULT (0),
	[mnyPeso] [money] NOT NULL CONSTRAINT [DF_Existencias_mnyPeso]  DEFAULT (0),
	[intMatanza_ID] [int] NULL CONSTRAINT [DF_Existencias_intMatanza_ID]  DEFAULT (0),
	[intIdentificador_Unico] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Existencias] PRIMARY KEY CLUSTERED 
(
	[intIdentificador_Unico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facturar_Terceros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturar_Terceros](
	[intCliente_ID] [int] NOT NULL CONSTRAINT [DF_Facturar_Terceros_intCliente_ID]  DEFAULT (0),
	[intCliente_Tercero_ID] [int] NOT NULL CONSTRAINT [DF_Facturar_Terceros_intCliente_Tercero_ID]  DEFAULT (0),
	[vchRazonSocial] [varchar](80) NULL,
	[vchNombre] [varchar](50) NULL,
	[vchApellidoPaterno] [varchar](50) NULL,
	[vchApellidoMaterno] [varchar](50) NULL,
	[vchDireccion] [varchar](60) NULL,
	[vchCiudad] [varchar](20) NULL,
	[vchEstado] [varchar](20) NULL,
	[vchCodigoPostal] [varchar](5) NULL,
	[vchTelefono] [varchar](30) NULL,
	[vchRFC] [varchar](20) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Facturar_Terceros_bitActivo]  DEFAULT (1),
	[vchColonia] [varchar](50) NULL,
	[vchNoExterior] [varchar](10) NULL,
	[vchNoInterior] [varchar](10) NULL,
	[vchPais] [varchar](10) NULL,
	[vchReferencia] [varchar](50) NULL,
	[bitEnviarCorreo] [bit] NOT NULL CONSTRAINT [DF_Facturar_Terceros_bitEnviarCorreo]  DEFAULT ((0)),
	[vchEmail] [varchar](40) NULL,
	[vchMetodoPago] [varchar](30) NULL,
	[vchCuentaBancaria] [varchar](20) NOT NULL CONSTRAINT [DF_Facturar_Terceros_vchCuentaBancaria]  DEFAULT (''),
	[vchBanco] [varchar](20) NOT NULL CONSTRAINT [DF_Facturar_Terceros_vchBanco]  DEFAULT (''),
	[vchUso_CFDI] [varchar](10) NOT NULL CONSTRAINT [DF_Facturar_Terceros_Uso_CFDI]  DEFAULT (''),
	[vchFormaPago] [varchar](10) NOT NULL CONSTRAINT [DF_Facturar_Terceros_vchFormaPago]  DEFAULT (''),
 CONSTRAINT [PK_Facturar_Terceros] PRIMARY KEY CLUSTERED 
(
	[intCliente_ID] ASC,
	[intCliente_Tercero_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturas](
	[intFactura_ID] [int] NOT NULL CONSTRAINT [DF_Facturas_intFactura_ID]  DEFAULT (0),
	[dtmFecha] [datetime] NULL,
	[intCliente_ID] [int] NULL CONSTRAINT [DF_Facturas_intCliente_ID]  DEFAULT (0),
	[mnyImporte] [money] NULL CONSTRAINT [DF_Facturas_mnyImporte]  DEFAULT (0),
	[mnySaldo] [money] NULL CONSTRAINT [DF_Facturas_mnySaldo]  DEFAULT (0),
	[vchObservaciones] [varchar](100) NULL CONSTRAINT [DF_Facturas_vchObservaciones]  DEFAULT (' '),
	[intTipoPago] [smallint] NULL CONSTRAINT [DF_Facturas_intTipoPago]  DEFAULT (0),
	[intCliente_Tercero] [int] NULL CONSTRAINT [DF_Facturas_intCliente_Tercero]  DEFAULT (0),
	[bitCancelada] [bit] NULL CONSTRAINT [DF_Facturas_bitCancelada]  DEFAULT (0),
	[dtmFecha_Cancelada] [datetime] NULL,
	[vchMotivo] [varchar](100) NULL,
	[mnyPIva] [money] NULL,
	[mnyIVA] [money] NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[intFactura_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Hoja1$]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hoja1$](
	[EQUINO ] [nvarchar](255) NULL,
	[vchClaveProdServ] [float] NULL,
	[intProducto_ID] [float] NULL,
	[F4] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HojaInv]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HojaInv](
	[Codigo] [float] NULL,
	[Desc] [nvarchar](255) NULL,
	[Peso] [float] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[INV_DIC_2017]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INV_DIC_2017](
	[CODIGO ] [float] NULL,
	[PRODUCTO ] [nvarchar](255) NULL,
	[KILOS ] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[inventario$]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventario$](
	[ID] [float] NULL,
	[CODIGO] [float] NULL,
	[PESO] [float] NULL,
	[F4] [nvarchar](255) NULL,
	[F5] [nvarchar](255) NULL,
	[F6] [nvarchar](255) NULL,
	[F7] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventario_2007]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventario_2007](
	[intProducto_ID] [int] NULL,
	[vchDescripcion] [varchar](100) NULL,
	[mnyPeso] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Inventario_AXEL_Enero_2016]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario_AXEL_Enero_2016](
	[LINEA] [float] NULL,
	[CODIGO] [float] NULL,
	[PRODUCTO] [nvarchar](255) NULL,
	[PESO] [float] NULL,
	[precio] [nvarchar](255) NULL,
	[total] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventario_Enero_2017]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario_Enero_2017](
	[LINEA] [float] NULL,
	[CODIGO] [float] NULL,
	[ARTICULO] [nvarchar](255) NULL,
	[CANTIDAD ] [float] NULL,
	[precio] [nvarchar](255) NULL,
	[total] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventario_Fisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario_Fisico](
	[intInventario_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NOT NULL CONSTRAINT [DF_Inventario_Fisico_dtmFecha]  DEFAULT (getdate()),
	[intUsuario_ID] [int] NOT NULL,
	[bitAplicado] [bit] NOT NULL CONSTRAINT [DF_Inventario_Fisico_bitAplicadoi]  DEFAULT (0),
	[dtmFecha_Aplicado] [datetime] NULL,
 CONSTRAINT [PK_Inventario_Fisico] PRIMARY KEY CLUSTERED 
(
	[intInventario_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventario_Fisico_Existencias]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario_Fisico_Existencias](
	[intInventario_ID] [int] NOT NULL CONSTRAINT [DF_Inventario_Fisico_Existencias_intInventario_ID]  DEFAULT (0),
	[intAlmacen_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
	[intOrdenCompra_ID] [int] NOT NULL,
	[intCanalNo] [bigint] NOT NULL,
	[intExistencia] [int] NULL,
	[mnyPeso] [money] NOT NULL,
	[intMatanza_ID] [int] NULL,
	[intIdentificador_Unico] [int] NOT NULL,
 CONSTRAINT [PK_Inventario_Fisico_Existencias] PRIMARY KEY CLUSTERED 
(
	[intInventario_ID] ASC,
	[intIdentificador_Unico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventario_Foraneo_Enero_2016]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario_Foraneo_Enero_2016](
	[LINEA] [float] NULL,
	[CODIGO] [float] NULL,
	[ARTICULO] [nvarchar](255) NULL,
	[CANTIDAD ] [float] NULL,
	[precio] [nvarchar](255) NULL,
	[total] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventario_Valco_Enero_2016]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario_Valco_Enero_2016](
	[LINEA] [float] NULL,
	[CODIGO] [float] NULL,
	[ARTICULO] [nvarchar](255) NULL,
	[CANTIDAD ] [float] NULL,
	[precio] [nvarchar](255) NULL,
	[total] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ivas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ivas](
	[intIva_ID] [int] NOT NULL,
	[mnyIVA] [money] NULL,
	[mnyRetIVA] [money] NULL,
	[mnyRetISR] [money] NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Ivas_bitActivo]  DEFAULT ((1)),
 CONSTRAINT [PK_Ivas] PRIMARY KEY CLUSTERED 
(
	[intIva_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Linea_En_Blanco]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Linea_En_Blanco](
	[vchLinea1] [varchar](10) NULL,
	[vchLinea2] [varchar](10) NULL,
	[vchLinea3] [varchar](10) NULL,
	[vchLinea4] [varchar](10) NULL,
	[vchLinea5] [varchar](10) NULL,
	[vchLinea6] [varchar](10) NULL,
	[vchLinea7] [varchar](10) NULL,
	[vchLinea8] [varchar](10) NULL,
	[vchLinea9] [varchar](10) NULL,
	[vchLinea10] [varchar](10) NULL,
	[vchLinea11] [varchar](10) NULL,
	[vchLinea12] [varchar](10) NULL,
	[vchLinea13] [varchar](10) NULL,
	[vchLinea14] [varchar](10) NULL,
	[vchLinea15] [varchar](10) NULL,
	[vchLinea16] [varchar](10) NULL,
	[vchLinea17] [varchar](10) NULL,
	[vchLinea18] [varchar](10) NULL,
	[vchLinea19] [varchar](10) NULL,
	[vchLinea20] [varchar](10) NULL,
	[vchLinea21] [varchar](10) NULL,
	[vchLinea22] [varchar](10) NULL,
	[vchLinea23] [varchar](10) NULL,
	[vchLinea24] [varchar](10) NULL,
	[vchLinea25] [varchar](10) NULL,
	[vchLinea26] [varchar](10) NULL,
	[vchLinea27] [varchar](10) NULL,
	[vchLinea28] [varchar](10) NULL,
	[vchLinea29] [varchar](10) NULL,
	[vchLinea30] [varchar](10) NULL,
	[vchLinea31] [varchar](10) NULL,
	[vchLinea32] [varchar](10) NULL,
	[vchLinea33] [varchar](10) NULL,
	[vchLinea34] [varchar](10) NULL,
	[vchLinea35] [money] NULL,
	[vchLinea36] [decimal](18, 0) NULL,
	[vchLinea37] [money] NULL,
	[vchLinea38] [money] NULL,
	[vchLinea39] [text] NULL,
	[vchLinea40] [text] NULL,
	[vchLinea41] [varchar](8000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Matanzas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matanzas](
	[intMatanza_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NULL,
	[intOrdenCompra_ID] [int] NULL CONSTRAINT [DF_Traspasos_intOrdenCompra_ID]  DEFAULT (0),
	[intProducto_ID] [int] NULL,
	[intCantidad] [int] NULL CONSTRAINT [DF_Traspasos_intCantidad]  DEFAULT (0),
	[bitProcesado] [bit] NULL CONSTRAINT [DF_Traspasos_bitProcesado]  DEFAULT (0),
	[bitVicera] [bit] NULL CONSTRAINT [DF_Matanzas_bitVicera]  DEFAULT (0),
	[bitCancelado] [bit] NOT NULL CONSTRAINT [DF_Matanzas_bitCancelado]  DEFAULT (0),
 CONSTRAINT [PK_Traspasos] PRIMARY KEY CLUSTERED 
(
	[intMatanza_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movimientos](
	[intMovimiento_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NULL CONSTRAINT [DF_Movimientos_dtmFecha]  DEFAULT (getdate()),
	[chrOperacion] [char](1) NULL,
	[intAlmacen_ID] [int] NULL,
	[intProducto_ID] [int] NULL CONSTRAINT [DF_Movimientos_intProducto_ID]  DEFAULT (0),
	[intCantidad] [int] NULL CONSTRAINT [DF_Movimientos_intCantidad]  DEFAULT (0),
	[mnyPeso] [money] NULL CONSTRAINT [DF_Movimientos_mnyPeso]  DEFAULT (0),
	[mnyPrecio] [money] NULL CONSTRAINT [DF_Movimientos_mnyPrecio]  DEFAULT (0),
	[mnyFlete] [money] NULL CONSTRAINT [DF_Movimientos_mnyFlete]  DEFAULT (0),
	[mnyImporte] [money] NULL CONSTRAINT [DF_Movimientos_mnyImporte]  DEFAULT (0),
	[intCanalNo] [bigint] NULL CONSTRAINT [DF_Movimientos_intCanalNo]  DEFAULT (0),
	[intOrdenCompra_ID] [int] NULL CONSTRAINT [DF_Movimientos_intOrdenCompra_ID]  DEFAULT (0),
	[intRemisionNo] [int] NULL CONSTRAINT [DF_Movimientos_intRemisionNo]  DEFAULT (0),
	[intCliente_ID] [int] NULL CONSTRAINT [DF_Movimientos_intCliente_ID]  DEFAULT (0),
	[intMatanza_ID] [int] NULL CONSTRAINT [DF_Movimientos_intTraspaso_ID]  DEFAULT (0),
	[intTipoVicera_ID] [int] NULL CONSTRAINT [DF_Movimientos_intTipoVicera_ID]  DEFAULT (0),
	[vchObservaciones] [varchar](100) NULL CONSTRAINT [DF_Movimientos_vchObservaciones]  DEFAULT (' '),
	[bitTiene_Devolucion] [bit] NULL CONSTRAINT [DF_Movimientos_bitTiene_Devolucion]  DEFAULT (0),
	[intRenglon_OC] [int] NULL CONSTRAINT [DF_Movimientos_intRenglon_OC]  DEFAULT (0),
	[intCantidad_Multiplicar] [int] NULL CONSTRAINT [DF_Movimientos_bitMultiplicar]  DEFAULT (0),
	[bitCancelado] [bit] NOT NULL CONSTRAINT [DF_Movimientos_bitCancelado]  DEFAULT (0),
	[vchOrden_Compra] [varchar](20) NOT NULL CONSTRAINT [DF_Movimientos_vchOrden_Compra]  DEFAULT (''),
	[intTipo_Movimiento] [int] NULL CONSTRAINT [DF_Movimientos_intTipo_Movimiento]  DEFAULT ((0)),
 CONSTRAINT [PK_Movimientos] PRIMARY KEY CLUSTERED 
(
	[intMovimiento_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notas_Credito](
	[intNota_Credito_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NULL,
	[intFactura_ID] [int] NULL CONSTRAINT [DF_Notas_Credito_intFactura_ID]  DEFAULT (0),
	[mnyImporte] [money] NULL CONSTRAINT [DF_Notas_Credito_mnyImporte]  DEFAULT (0),
	[vchObservaciones] [varchar](100) NULL,
	[intCliente_Tercero] [int] NULL CONSTRAINT [DF_Notas_Credito_intCliente_Tercero]  DEFAULT (0),
	[bitCancelada] [bit] NULL CONSTRAINT [DF_Notas_Credito_bitCancelada]  DEFAULT (0),
	[dtmFecha_Cancelacion] [datetime] NULL,
	[vchMotivo] [varchar](100) NULL,
	[bitAplicada] [bit] NULL CONSTRAINT [DF_Notas_Credito_bitAplicada]  DEFAULT (0),
 CONSTRAINT [PK_Notas_Credito] PRIMARY KEY CLUSTERED 
(
	[intNota_Credito_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Numero_Letra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Numero_Letra](
	[intNumero] [int] NULL CONSTRAINT [DF_Numero_Letra_intNumero]  DEFAULT (0),
	[vchEspanol] [varchar](50) NULL,
	[vchIngles] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orden_Compra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Compra](
	[intOrdenCompra_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NULL CONSTRAINT [DF_Orden_Compra_dtmFecha]  DEFAULT (getdate()),
	[intProveedor_ID] [int] NULL,
	[intTipoCompra] [int] NULL CONSTRAINT [DF_Orden_Compra_intTipoCompra]  DEFAULT (0),
	[mnyPeso] [money] NULL CONSTRAINT [DF_Orden_Compra_mnyPeso]  DEFAULT (0),
	[mnyPrecio] [money] NULL CONSTRAINT [DF_Orden_Compra_mnyPrecio]  DEFAULT (0),
	[bitCancelado] [bit] NOT NULL CONSTRAINT [DF_Orden_Compra_bitCancelado]  DEFAULT (0),
 CONSTRAINT [PK_Orden_Compra] PRIMARY KEY CLUSTERED 
(
	[intOrdenCompra_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pacs_Autorizados]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pacs_Autorizados](
	[intPAC_ID] [int] NOT NULL,
	[vchNombrePAC] [varchar](30) NOT NULL CONSTRAINT [DF_Pacs_Autorizados_vchNombrePAC]  DEFAULT (''),
	[bitPredeterminado] [bit] NOT NULL CONSTRAINT [DF_Pacs_Autorizados_bitPredeterminado]  DEFAULT ((0)),
 CONSTRAINT [PK_Pacs_Autorizados] PRIMARY KEY CLUSTERED 
(
	[intPAC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Parametros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Parametros](
	[vchRazonSocial] [varchar](200) NULL,
	[vchDireccion] [varchar](50) NULL,
	[vchColonia] [varchar](20) NULL,
	[vchCiudad] [varchar](20) NULL,
	[vchEstado] [varchar](20) NULL,
	[vchCodigoPostal] [varchar](5) NULL,
	[vchTelefono] [varchar](20) NULL,
	[vchFax] [varchar](20) NULL,
	[vchRFC] [varchar](20) NULL,
	[vchRepresentante_Legal] [varchar](60) NULL,
	[intTipoProducto_Compuesto] [int] NULL CONSTRAINT [DF_Parametros_intTipoProducto_Compuesto]  DEFAULT (0),
	[intTipoProducto_Agrupacion] [int] NULL CONSTRAINT [DF_Parametros_intTipoProducto_Agrupacion]  DEFAULT (0),
	[intTipoProducto_Viceras] [int] NULL CONSTRAINT [DF_Parametros_intTipoProducto_ViceRAS]  DEFAULT (0),
	[intTipoProducto_Producto] [int] NULL CONSTRAINT [DF_Parametros_intTipoProducto_Producto]  DEFAULT (0),
	[intTipoProducto_GanadoPie] [int] NULL CONSTRAINT [DF_Parametros_intTipoProducto_GanadoPie]  DEFAULT (0),
	[intUM_Cajas] [int] NULL CONSTRAINT [DF_Parametros_intUM_Cajas]  DEFAULT (0),
	[intProducto_ViceraCompleta] [int] NULL CONSTRAINT [DF_Parametros_intProducto_Vicera]  DEFAULT (0),
	[intProducto_Vicera_CM] [int] NULL CONSTRAINT [DF_Parametros_intProducto_Vicera_CM]  DEFAULT (0),
	[intProducto_Vicera_AT] [int] NULL CONSTRAINT [DF_Parametros]  DEFAULT (0),
	[intProducto_Flete] [int] NULL CONSTRAINT [DF_Parametros_intProducto_Flete]  DEFAULT (0),
	[vchPassword_Utilerias] [varchar](100) NULL,
	[vchPassword_Inv_Fisico] [varchar](100) NULL,
	[vchNoExterior] [varchar](10) NULL,
	[vchNoInterior] [varchar](10) NULL,
	[vchPais] [varchar](10) NULL,
	[vchReferencia] [varchar](50) NULL,
	[imgLogotipo] [image] NULL,
	[bitFE] [bit] NULL,
	[bitCancFolio_PAC] [bit] NULL CONSTRAINT [DF_Parametros_bitCancFolio_PAC]  DEFAULT ((0)),
	[intAlmacen_ID] [int] NULL,
	[intAlmacenMatriz_ID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[intProducto_ID] [int] NOT NULL,
	[vchDescripcion] [varchar](2000) NOT NULL,
	[intUnidad_ID] [int] NULL CONSTRAINT [DF_Articulos_intUnidad_ID]  DEFAULT (0),
	[intTipoProducto_ID] [int] NULL CONSTRAINT [DF_Articulos_intTipoProducto_ID]  DEFAULT (0),
	[mnyPrecio] [money] NULL CONSTRAINT [DF_Productos_mnyPrecio]  DEFAULT (0),
	[chrClasificacion] [char](1) NULL,
	[intNoPiezas] [int] NULL CONSTRAINT [DF_Productos_intNoPiezas]  DEFAULT (0),
	[bitIncluyeViceras] [bit] NOT NULL CONSTRAINT [DF_Productos_bitIncluyeViceras]  DEFAULT (0),
	[bitGenerar_SubProductos] [bit] NOT NULL CONSTRAINT [DF_Articulos_bitGenerarSubProductos]  DEFAULT (0),
	[bitFacturacion_Cantidad] [bit] NOT NULL CONSTRAINT [DF_Productos_bitMostrar_Cantidad]  DEFAULT (0),
	[bitFacturacion_Precio] [bit] NOT NULL CONSTRAINT [DF_Productos]  DEFAULT (0),
	[bitFacturacion_Peso] [bit] NOT NULL CONSTRAINT [DF_Productos_1]  DEFAULT (0),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Articulos_bitActivo]  DEFAULT (1),
	[mnyCostoVenta] [money] NOT NULL CONSTRAINT [DF_Productos_mnyCosto]  DEFAULT (0),
	[bitNoAplicar_InvFisico] [bit] NOT NULL CONSTRAINT [DF_Productos_bitNoAplicar_InvFisico]  DEFAULT (0),
	[vchCodigoBarras_Proveedor] [varchar](20) NOT NULL CONSTRAINT [DF_Productos_vchCodigoBarras_Proveedor]  DEFAULT (''),
	[vchClaveProdServ] [varchar](50) NOT NULL CONSTRAINT [DF_Productos_ClaveProdServ]  DEFAULT (''),
	[vchUnidad] [varchar](20) NOT NULL CONSTRAINT [DF_Productos_vchUnidad]  DEFAULT (''),
	[vchNoIdentificacion] [varchar](50) NOT NULL CONSTRAINT [DF_Productos_vchNoIdentificacion]  DEFAULT (''),
 CONSTRAINT [PK_Articulos] PRIMARY KEY CLUSTERED 
(
	[intProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos_Compuestos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_Compuestos](
	[intProductoCompuesto_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
	[intCantidad] [int] NULL CONSTRAINT [DF_Productos_Compuestos_intCantidad]  DEFAULT (0),
 CONSTRAINT [PK_Productos_Compuestos] PRIMARY KEY CLUSTERED 
(
	[intProductoCompuesto_ID] ASC,
	[intProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedores](
	[intProveedor_ID] [int] NOT NULL,
	[vchRazonSocial] [varchar](80) NULL,
	[vchNombre] [varchar](50) NULL,
	[vchApellidoPaterno] [varchar](50) NULL,
	[vchApellidoMaterno] [varchar](50) NULL,
	[vchDireccion] [varchar](60) NULL,
	[vchCiudad] [varchar](20) NULL,
	[vchEstado] [varchar](20) NULL,
	[vchCodigoPostal] [varchar](5) NULL,
	[vchTelefono] [varchar](30) NULL,
	[vchRFC] [varchar](20) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Proveedores_bitActivo]  DEFAULT (1),
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[intProveedor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Regimen_Fiscales]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Regimen_Fiscales](
	[intRegimen_ID] [int] NOT NULL CONSTRAINT [DF_Regimen_Fiscales_intRegimen_ID]  DEFAULT ((0)),
	[vchNombre] [varchar](200) NOT NULL CONSTRAINT [DF_Regimen_Fiscales_vchNombre]  DEFAULT (''),
 CONSTRAINT [PK_Regimen_Fiscales] PRIMARY KEY CLUSTERED 
(
	[intRegimen_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Relacion_Deshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relacion_Deshuese](
	[intProducto_ID] [int] NOT NULL CONSTRAINT [DF_Relacion_Deshuese_intProducto_ID]  DEFAULT (0),
	[intProducto_Deshuese] [int] NOT NULL CONSTRAINT [DF_Relacion_Deshuese_intProducto_Deshuese]  DEFAULT (0),
 CONSTRAINT [PK_Relacion_Deshuese] PRIMARY KEY CLUSTERED 
(
	[intProducto_ID] ASC,
	[intProducto_Deshuese] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Relacion_Matanza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relacion_Matanza](
	[intProducto_Pie] [int] NOT NULL CONSTRAINT [DF_Relacion_Matanza_intProducto_Pie]  DEFAULT (0),
	[intProducto_Canal] [int] NOT NULL CONSTRAINT [DF_Relacion_Matanza_intProducto_Canal]  DEFAULT (0),
	[intProducto_Vicera] [int] NOT NULL CONSTRAINT [DF_Relacion_Matanza_intProducto_Vicera]  DEFAULT (0),
 CONSTRAINT [PK_Relacion_Matanza] PRIMARY KEY CLUSTERED 
(
	[intProducto_Pie] ASC,
	[intProducto_Canal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Remisiones]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Remisiones](
	[intRemisionNo] [int] NOT NULL,
	[intCliente_ID] [int] NULL,
	[dtmFecha] [datetime] NULL,
	[mnyImporte] [money] NULL CONSTRAINT [DF_Remisiones_mnyImporte]  DEFAULT (0),
	[mnyFlete] [money] NULL CONSTRAINT [DF_Remisiones_mnyFlete]  DEFAULT (0),
	[mnySaldo] [money] NULL CONSTRAINT [DF_Remisiones_mnySaldo]  DEFAULT (0),
	[bitFacturado] [bit] NULL CONSTRAINT [DF_Remisiones_bitFacturado]  DEFAULT (0),
	[intAlmacen_ID] [int] NULL CONSTRAINT [DF_Remisiones_intAlmacen_ID]  DEFAULT (2),
	[vchOrden_Compra] [varchar](20) NOT NULL CONSTRAINT [DF_Remisiones_vchOrden_Compra]  DEFAULT (''),
 CONSTRAINT [PK_Remisiones] PRIMARY KEY CLUSTERED 
(
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Remisiones_Canceladas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Remisiones_Canceladas](
	[intConsecutivo] [int] NOT NULL,
	[intRemisionNo] [int] NOT NULL CONSTRAINT [DF_Remisiones_Canceladas_intRemisionNo]  DEFAULT (0),
	[dtmFecha] [datetime] NULL CONSTRAINT [DF_Remisiones_Canceladas_dtmFecha]  DEFAULT (getdate()),
 CONSTRAINT [PK_Remisiones_Canceladas] PRIMARY KEY CLUSTERED 
(
	[intConsecutivo] ASC,
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Repartidores]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Repartidores](
	[intRepartidor_ID] [int] NOT NULL,
	[vchNombre] [varchar](50) NULL,
	[vchApellidoPaterno] [varchar](50) NULL,
	[vchApellidoMaterno] [varchar](50) NULL,
	[bitActivo] [bit] NULL CONSTRAINT [DF_Repartidores_bitActivo]  DEFAULT (1),
 CONSTRAINT [PK_Repartidores] PRIMARY KEY CLUSTERED 
(
	[intRepartidor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Results]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Results](
	[intAlmacen_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL,
	[intOrdenCompra_ID] [int] NOT NULL,
	[intCanalNo] [int] NOT NULL,
	[eXISTENCIA] [int] NULL,
	[mnyPeso] [money] NOT NULL,
	[intmatanza_ID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sumario_Abonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sumario_Abonos](
	[Cliente] [int] NULL,
	[Fecha] [smalldatetime] NULL,
	[Producto] [int] NULL,
	[Canal] [bigint] NULL,
	[Pedimento] [char](10) NULL,
	[Cantidad] [money] NULL,
	[Precio] [money] NULL,
	[Peso] [money] NULL,
	[Importe] [money] NULL,
	[Remision] [int] NULL,
	[Consecutivo] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Movimiento]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tipo_Movimiento](
	[intTipo_Movimiento] [int] NOT NULL,
	[vchDescripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tipo_Movimiento] PRIMARY KEY CLUSTERED 
(
	[intTipo_Movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Producto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tipo_Producto](
	[intTipoProducto_ID] [int] NOT NULL,
	[vchDescripcion] [varchar](50) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Tipo_Producto_bitActivo]  DEFAULT (1),
 CONSTRAINT [PK_Tipo_Producto] PRIMARY KEY CLUSTERED 
(
	[intTipoProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Traspasos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traspasos](
	[intTraspaso_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NOT NULL,
	[intUsuario_ID] [int] NOT NULL,
	[intAlmacen_ID_FROM] [int] NOT NULL,
	[intAlmacen_ID_TO] [int] NOT NULL,
	[bitRecibido] [bit] NOT NULL CONSTRAINT [DF_Traspasos_bitRecibido]  DEFAULT ((0)),
	[dtmFecha_Recibido] [datetime] NULL,
	[intUsuario_ID_Recibido] [int] NULL,
 CONSTRAINT [PK_Traspasos_1] PRIMARY KEY CLUSTERED 
(
	[intTraspaso_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Unidad_Medida]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Unidad_Medida](
	[intUnidad_ID] [int] NOT NULL,
	[vchDescripcion] [varchar](20) NULL,
	[vchNombreCorto] [varchar](3) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Unidad_Medida_bitActivo]  DEFAULT (1),
 CONSTRAINT [PK_Unidad_Medida] PRIMARY KEY CLUSTERED 
(
	[intUnidad_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[intUsuario_ID] [int] IDENTITY(1,1) NOT NULL,
	[vchNombreCompleto] [varchar](80) NULL,
	[vchUsuario] [varchar](10) NULL,
	[vchContrasena] [varchar](100) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Usuarios_bitActivo]  DEFAULT (0),
	[bitSolo_Inventarios] [bit] NOT NULL CONSTRAINT [DF_Usuarios_bitSolo_Inventarios]  DEFAULT ((0)),
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[intUsuario_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Viceras]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Viceras](
	[intVicera_ID] [int] NOT NULL,
	[intProducto_ID] [int] NOT NULL CONSTRAINT [DF_Viceras_intProducto_ID]  DEFAULT (0),
 CONSTRAINT [PK_Viceras] PRIMARY KEY CLUSTERED 
(
	[intVicera_ID] ASC,
	[intProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Viceras_A_Surtir]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Viceras_A_Surtir](
	[intProducto_ID] [int] NOT NULL,
	[intProductoVicera_ID] [int] NOT NULL,
 CONSTRAINT [PK_Viceras_A_Surtir] PRIMARY KEY CLUSTERED 
(
	[intProducto_ID] ASC,
	[intProductoVicera_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vAbonosFacturasXDia]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAbonosFacturasXDia]
AS
SELECT dtmFecha_Abono, intCliente_ID, intFactura_ID, SUM(mnyAbono) AS mnyAbono
FROM (
	SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, CtasXCobrar.intCliente_ID, CtasXCobrar.intFactura_ID, CONVERT(DECIMAL(18,2),(mnyAbono - ISNULL(Notas_Credito.mnyImporte,0)) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) AS mnyAbono FROM Detalle_CtasXCobrar
	INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Notas_Credito ON CtasXCobrar.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitAplicada = bitAplicada_NC AND Notas_Credito.bitCancelada = 0
	WHERE Facturas.intCliente_ID <> 1000
) Abonos
GROUP BY dtmFecha_Abono, intCliente_ID, intFactura_ID





GO
/****** Object:  View [dbo].[vAbonosRemisionesXDia]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vAbonosRemisionesXDia]
AS
SELECT dtmFecha_Abono, intCliente_ID, intRemisionNo, SUM(mnyAbono) AS mnyAbono
FROM (
	SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, CtasXCobrar.intCliente_ID, CtasXCobrar.intRemisionNo, (mnyAbono - ISNULL(Detalle_Notas_Credito.mnyImporte,0)) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbono FROM Detalle_CtasXCobrar
	INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = bitAplicada_NC AND Detalle_Notas_Credito.bitCancelada = 0
	WHERE Facturas.intCliente_ID = 1000
) Abonos
GROUP BY dtmFecha_Abono, intCliente_ID, intRemisionNo




GO
/****** Object:  View [dbo].[vAbonosRemisionesXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAbonosRemisionesXFactura]
AS
SELECT dtmFecha, intCliente_ID, intRemisionNo, dtmFecha_Abono, SUM(mnyAbono) AS mnyAbono, intFactura_ID, mnyImporte
FROM (
	SELECT CtasXCobrar.dtmFecha, CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, CtasXCobrar.intCliente_ID, CtasXCobrar.intRemisionNo, (mnyAbono - ISNULL(Detalle_Notas_Credito.mnyImporte,0)) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbono, CtasXCobrar.intFactura_ID, CtasXCobrar.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte FROM Detalle_CtasXCobrar
	INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = bitAplicada_NC AND Detalle_Notas_Credito.bitCancelada = 0
) Abonos
GROUP BY dtmFecha, dtmFecha_Abono, intCliente_ID, intRemisionNo, intFactura_ID, mnyImporte



GO
/****** Object:  View [dbo].[vDeshuesesXOC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vDeshuesesXOC]
AS
SELECT DISTINCT TOP 100 PERCENT intOrdenCompra_ID, CONVERT(SMALLDATETIME, CONVERT(CHAR, dtmFecha, 103), 103) AS dtmFecha
FROM         dbo.Movimientos
WHERE     (intAlmacen_ID = 2) AND (chrOperacion = 'E') AND (intOrdenCompra_ID > 0)
ORDER BY intOrdenCompra_ID, CONVERT(SMALLDATETIME, CONVERT(CHAR, dtmFecha, 103), 103)


GO
/****** Object:  View [dbo].[vDetalle_Abonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDetalle_Abonos]
AS

SELECT intCtaXCobrar_ID, dtmFecha_Abono, mnyAbono FROM Detalle_CtasXCobrar

GO
/****** Object:  View [dbo].[vRetencionesXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vRetencionesXFactura]
AS

SELECT intFactura_ID, vchProducto, intRenglon, '001' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPretISR / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPRetISR / 100.00)) AS Importe FROM Det_Ventas
WHERE ISNULL(mnyPRetISR,0) >= 0

UNION ALL

SELECT intFactura_ID, vchProducto, intRenglon, '002' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPretIVA / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPretIVA / 100.00)) AS Importe FROM Det_Ventas
WHERE ISNULL(mnyPRetIVA,0) >= 0





GO
/****** Object:  View [dbo].[vRetencionesXNota]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vRetencionesXNota]
AS

SELECT intNota_Credito_ID, ISNULL(vchNotas,'NOTA DE CREDITO') AS VchProducto, intRenglon, '001' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPretISR / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPRetISR / 100.00)) AS Importe FROM Det_Notas_Credito
WHERE mnyPRetISR >= 0

UNION ALL

SELECT intNota_Credito_ID, ISNULL(vchNotas,'NOTA DE CREDITO') AS VchProducto, intRenglon, '002' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPretIVA / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPretIVA / 100.00)) AS Importe FROM Det_Notas_Credito
WHERE mnyPRetIVA >= 0






GO
/****** Object:  View [dbo].[vSumarizado_Abonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vSumarizado_Abonos]
AS

SELECT intCtaXCobrar_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar
GROUP BY intCtaXCobrar_ID

GO
/****** Object:  View [dbo].[vTrasladosXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vTrasladosXFactura]
AS

SELECT intFactura_ID, intRenglon, '002' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),ISNULL(mnyPIVA,0) / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), ISNULL(mnyImporte,0) * CONVERT(DECIMAL(18,6),ISNULL(mnyPIVA,0) / 100.00)) AS Importe FROM Det_Ventas
WHERE ISNULL(mnyPIVA,0) >= 0


GO
/****** Object:  View [dbo].[vTrasladosXNota]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vTrasladosXNota]
AS

SELECT intNota_Credito_ID, intRenglon, '002' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPIVA / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPIVA / 100.00)) AS Importe FROM Det_Notas_Credito
WHERE mnyPIVA >= 0



GO
/****** Object:  View [dbo].[vUltimaParcialidadXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vUltimaParcialidadXFactura]
AS
SELECT intPago_ID, intFactura_ID, MAX(intParcialidad) AS intParcialidad FROM dbo.Det_Pagos
GROUP BY intPago_ID, intFactura_ID


GO
/****** Object:  Index [By_Factura_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Factura_ID] ON [dbo].[CtasXCobrar]
(
	[intFactura_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_RemisionNo]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_RemisionNo] ON [dbo].[CtasXCobrar]
(
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Detalle_CtasXCobrar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Detalle_CtasXCobrar] ON [dbo].[Detalle_CtasXCobrar]
(
	[intCtaXCobrar_ID] ASC,
	[dtmFecha_Abono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Detalle_CtasXCobrar_1]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Detalle_CtasXCobrar_1] ON [dbo].[Detalle_CtasXCobrar]
(
	[dtmFecha_Abono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Deshueses]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Deshueses] ON [dbo].[Detalle_Deshueses]
(
	[intDeshuese_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_RemisionNo]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_RemisionNo] ON [dbo].[Detalle_Facturas]
(
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Matanza_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Matanza_ID] ON [dbo].[Existencias]
(
	[intMatanza_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_OrdenCompra_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_OrdenCompra_ID] ON [dbo].[Existencias]
(
	[intOrdenCompra_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Producto_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Producto_ID] ON [dbo].[Existencias]
(
	[intProducto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Existencias]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Existencias] ON [dbo].[Existencias]
(
	[intAlmacen_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Cliente_Fecha_Factura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Cliente_Fecha_Factura] ON [dbo].[Facturas]
(
	[intCliente_ID] ASC,
	[dtmFecha] ASC,
	[intFactura_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Fecha]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Fecha] ON [dbo].[Facturas]
(
	[dtmFecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Facturas_1]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Facturas_1] ON [dbo].[Facturas]
(
	[intCliente_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Facturas_2]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Facturas_2] ON [dbo].[Facturas]
(
	[intCliente_Tercero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_OrdenCompra_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_OrdenCompra_ID] ON [dbo].[Movimientos]
(
	[intOrdenCompra_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [BY_RemisionNo]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [BY_RemisionNo] ON [dbo].[Movimientos]
(
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tipo_Movimiento]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Tipo_Movimiento] ON [dbo].[Movimientos]
(
	[intTipo_Movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Factura_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Factura_ID] ON [dbo].[Notas_Credito]
(
	[intFactura_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Almacen_Cliente_Fecha_Remision]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [By_Almacen_Cliente_Fecha_Remision] ON [dbo].[Remisiones]
(
	[intAlmacen_ID] ASC,
	[intCliente_ID] ASC,
	[dtmFecha] ASC,
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [BY_Cliente_ID]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE NONCLUSTERED INDEX [BY_Cliente_ID] ON [dbo].[Remisiones]
(
	[intCliente_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [By_Remisiones]    Script Date: 26/06/2018 07:16:26 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [By_Remisiones] ON [dbo].[Remisiones]
(
	[intAlmacen_ID] ASC,
	[intRemisionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_dtmFecha_Registro]  DEFAULT (getdate()) FOR [dtmFecha_Registro]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchCadena_Original]  DEFAULT ('') FOR [vchCadena_Original]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchSello]  DEFAULT ('') FOR [vchSello]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_txtXMLFE]  DEFAULT ('') FOR [txtXMLFE]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchSerie_Cert_SAT]  DEFAULT ('') FOR [vchSerie_Cert_SAT]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_dtmFecha_Timbrado]  DEFAULT ('') FOR [dtmFecha_Timbrado]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchFolio_Fiscal]  DEFAULT ('') FOR [vchFolio_Fiscal_UUID]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchSello_SAT]  DEFAULT ('') FOR [vchSello_SAT]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchSello_CFD]  DEFAULT ('') FOR [vchSello_CFD]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchCadena_Original_CFDI]  DEFAULT ('') FOR [vchCadena_Original_CFDI]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_vchXML_Timbre]  DEFAULT ('') FOR [vchXML_Timbre]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_txtXML_CFDI]  DEFAULT ('') FOR [txtXML_CFDI]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_nitCancelada]  DEFAULT ((0)) FOR [bitCancelada]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Cab_Pagos_vharNotas]  DEFAULT ('') FOR [vchNotas]
GO
ALTER TABLE [dbo].[Control_Folios] ADD  CONSTRAINT [DF_Control_Folios_bitDisponible]  DEFAULT ((1)) FOR [bitDisponible]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito]  WITH CHECK ADD  CONSTRAINT [FK_Cab_Notas_Credito_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] CHECK CONSTRAINT [FK_Cab_Notas_Credito_Clientes]
GO
ALTER TABLE [dbo].[Cab_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Cab_Ventas_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Cab_Ventas] CHECK CONSTRAINT [FK_Cab_Ventas_Clientes]
GO
ALTER TABLE [dbo].[Cierre_Inventario]  WITH NOCHECK ADD  CONSTRAINT [FK_Cierre_Inventario_Usuarios] FOREIGN KEY([intUsuario_ID])
REFERENCES [dbo].[Usuarios] ([intUsuario_ID])
GO
ALTER TABLE [dbo].[Cierre_Inventario] CHECK CONSTRAINT [FK_Cierre_Inventario_Usuarios]
GO
ALTER TABLE [dbo].[Control_Folios_Remisiones]  WITH CHECK ADD  CONSTRAINT [FK_Control_Folios_Remisiones_Repartidores] FOREIGN KEY([intRepartidor_ID])
REFERENCES [dbo].[Repartidores] ([intRepartidor_ID])
GO
ALTER TABLE [dbo].[Control_Folios_Remisiones] CHECK CONSTRAINT [FK_Control_Folios_Remisiones_Repartidores]
GO
ALTER TABLE [dbo].[Correcion_Pesos]  WITH NOCHECK ADD  CONSTRAINT [FK_Correcion_Pesos_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Correcion_Pesos] CHECK CONSTRAINT [FK_Correcion_Pesos_Productos]
GO
ALTER TABLE [dbo].[CtasXCobrar]  WITH NOCHECK ADD  CONSTRAINT [FK_CtasXCobrar_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[CtasXCobrar] CHECK CONSTRAINT [FK_CtasXCobrar_Clientes]
GO
ALTER TABLE [dbo].[CtasXCobrar]  WITH NOCHECK ADD  CONSTRAINT [FK_CtasXCobrar_Remisiones] FOREIGN KEY([intRemisionNo])
REFERENCES [dbo].[Remisiones] ([intRemisionNo])
GO
ALTER TABLE [dbo].[CtasXCobrar] CHECK CONSTRAINT [FK_CtasXCobrar_Remisiones]
GO
ALTER TABLE [dbo].[CtasXPagar]  WITH NOCHECK ADD  CONSTRAINT [FK_CtasXPagar_Orden_Compra] FOREIGN KEY([intOrdenCompra_ID])
REFERENCES [dbo].[Orden_Compra] ([intOrdenCompra_ID])
GO
ALTER TABLE [dbo].[CtasXPagar] CHECK CONSTRAINT [FK_CtasXPagar_Orden_Compra]
GO
ALTER TABLE [dbo].[CtasXPagar]  WITH NOCHECK ADD  CONSTRAINT [FK_CtasXPagar_Proveedores] FOREIGN KEY([intProveedor_ID])
REFERENCES [dbo].[Proveedores] ([intProveedor_ID])
GO
ALTER TABLE [dbo].[CtasXPagar] CHECK CONSTRAINT [FK_CtasXPagar_Proveedores]
GO
ALTER TABLE [dbo].[Det_Notas_Credito]  WITH CHECK ADD  CONSTRAINT [FK_Det_Notas_Credito_Cab_Notas_Credito] FOREIGN KEY([intNota_Credito_ID])
REFERENCES [dbo].[Cab_Notas_Credito] ([intNota_Credito_ID])
GO
ALTER TABLE [dbo].[Det_Notas_Credito] CHECK CONSTRAINT [FK_Det_Notas_Credito_Cab_Notas_Credito]
GO
ALTER TABLE [dbo].[Det_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Det_Pagos_Cab_Ventas] FOREIGN KEY([intFactura_ID])
REFERENCES [dbo].[Cab_Ventas] ([intFactura_ID])
GO
ALTER TABLE [dbo].[Det_Pagos] CHECK CONSTRAINT [FK_Det_Pagos_Cab_Ventas]
GO
ALTER TABLE [dbo].[Det_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Det_Pagos_Det_Pagos] FOREIGN KEY([intPago_ID], [intFactura_ID], [intParcialidad])
REFERENCES [dbo].[Det_Pagos] ([intPago_ID], [intFactura_ID], [intParcialidad])
GO
ALTER TABLE [dbo].[Det_Pagos] CHECK CONSTRAINT [FK_Det_Pagos_Det_Pagos]
GO
ALTER TABLE [dbo].[Det_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Det_Ventas_Cab_Ventas] FOREIGN KEY([intFactura_ID])
REFERENCES [dbo].[Cab_Ventas] ([intFactura_ID])
GO
ALTER TABLE [dbo].[Det_Ventas] CHECK CONSTRAINT [FK_Det_Ventas_Cab_Ventas]
GO
ALTER TABLE [dbo].[Detalle_Cierre_Inventario]  WITH NOCHECK ADD  CONSTRAINT [FK_Detalle_Cierre_Inventario_Cierre_Inventario] FOREIGN KEY([intCierre_ID])
REFERENCES [dbo].[Cierre_Inventario] ([intCierre_ID])
GO
ALTER TABLE [dbo].[Detalle_Cierre_Inventario] CHECK CONSTRAINT [FK_Detalle_Cierre_Inventario_Cierre_Inventario]
GO
ALTER TABLE [dbo].[Detalle_CtasXCobrar]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_CtasXCobrar_CtasXCobrar] FOREIGN KEY([intCtaXCobrar_ID])
REFERENCES [dbo].[CtasXCobrar] ([intCtaXCobrar_ID])
GO
ALTER TABLE [dbo].[Detalle_CtasXCobrar] CHECK CONSTRAINT [FK_Detalle_CtasXCobrar_CtasXCobrar]
GO
ALTER TABLE [dbo].[Detalle_CtasXPagar]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_CtasXPagar_CtasXPagar] FOREIGN KEY([intCtaXPagar_ID])
REFERENCES [dbo].[CtasXPagar] ([intCtaXPagar_ID])
GO
ALTER TABLE [dbo].[Detalle_CtasXPagar] CHECK CONSTRAINT [FK_Detalle_CtasXPagar_CtasXPagar]
GO
ALTER TABLE [dbo].[Detalle_Deshueses]  WITH NOCHECK ADD  CONSTRAINT [FK_Deshueses_Orden_Compra] FOREIGN KEY([intOrdenCompra_ID])
REFERENCES [dbo].[Orden_Compra] ([intOrdenCompra_ID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Detalle_Deshueses] NOCHECK CONSTRAINT [FK_Deshueses_Orden_Compra]
GO
ALTER TABLE [dbo].[Detalle_Deshueses]  WITH NOCHECK ADD  CONSTRAINT [FK_Deshueses_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Detalle_Deshueses] CHECK CONSTRAINT [FK_Deshueses_Productos]
GO
ALTER TABLE [dbo].[Detalle_Deshueses]  WITH NOCHECK ADD  CONSTRAINT [FK_Detalle_Deshueses_Deshueses] FOREIGN KEY([intDeshuese_ID])
REFERENCES [dbo].[Deshueses] ([intDeshuese_ID])
GO
ALTER TABLE [dbo].[Detalle_Deshueses] CHECK CONSTRAINT [FK_Detalle_Deshueses_Deshueses]
GO
ALTER TABLE [dbo].[Detalle_Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Detalle_Facturas_Facturas] FOREIGN KEY([intFactura_ID])
REFERENCES [dbo].[Facturas] ([intFactura_ID])
GO
ALTER TABLE [dbo].[Detalle_Facturas] CHECK CONSTRAINT [FK_Detalle_Facturas_Facturas]
GO
ALTER TABLE [dbo].[Detalle_Inventario_Fisico]  WITH NOCHECK ADD  CONSTRAINT [FK_Detalle_Inventario_Fisico_Inventario_Fisico] FOREIGN KEY([intInventario_ID])
REFERENCES [dbo].[Inventario_Fisico] ([intInventario_ID])
GO
ALTER TABLE [dbo].[Detalle_Inventario_Fisico] CHECK CONSTRAINT [FK_Detalle_Inventario_Fisico_Inventario_Fisico]
GO
ALTER TABLE [dbo].[Detalle_Notas_Credito]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Notas_Credito_Notas_Credito] FOREIGN KEY([intNota_Credito_ID])
REFERENCES [dbo].[Notas_Credito] ([intNota_Credito_ID])
GO
ALTER TABLE [dbo].[Detalle_Notas_Credito] CHECK CONSTRAINT [FK_Detalle_Notas_Credito_Notas_Credito]
GO
ALTER TABLE [dbo].[Detalle_Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Orden_Compra_Orden_Compra] FOREIGN KEY([intOrdenCompra_ID])
REFERENCES [dbo].[Orden_Compra] ([intOrdenCompra_ID])
GO
ALTER TABLE [dbo].[Detalle_Orden_Compra] CHECK CONSTRAINT [FK_Detalle_Orden_Compra_Orden_Compra]
GO
ALTER TABLE [dbo].[Detalle_Remisiones]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Remisiones_Movimientos] FOREIGN KEY([intMovimiento_ID])
REFERENCES [dbo].[Movimientos] ([intMovimiento_ID])
GO
ALTER TABLE [dbo].[Detalle_Remisiones] CHECK CONSTRAINT [FK_Detalle_Remisiones_Movimientos]
GO
ALTER TABLE [dbo].[Detalle_Remisiones]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Remisiones_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Detalle_Remisiones] CHECK CONSTRAINT [FK_Detalle_Remisiones_Productos]
GO
ALTER TABLE [dbo].[Detalle_Remisiones]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Remisiones_Remisiones] FOREIGN KEY([intRemisionNo])
REFERENCES [dbo].[Remisiones] ([intRemisionNo])
GO
ALTER TABLE [dbo].[Detalle_Remisiones] CHECK CONSTRAINT [FK_Detalle_Remisiones_Remisiones]
GO
ALTER TABLE [dbo].[Existencias]  WITH NOCHECK ADD  CONSTRAINT [FK_Existencias_Almacenes] FOREIGN KEY([intAlmacen_ID])
REFERENCES [dbo].[Almacenes] ([intAlmacen_ID])
GO
ALTER TABLE [dbo].[Existencias] CHECK CONSTRAINT [FK_Existencias_Almacenes]
GO
ALTER TABLE [dbo].[Existencias]  WITH NOCHECK ADD  CONSTRAINT [FK_Existencias_Orden_Compra] FOREIGN KEY([intOrdenCompra_ID])
REFERENCES [dbo].[Orden_Compra] ([intOrdenCompra_ID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Existencias] NOCHECK CONSTRAINT [FK_Existencias_Orden_Compra]
GO
ALTER TABLE [dbo].[Existencias]  WITH NOCHECK ADD  CONSTRAINT [FK_Existencias_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Existencias] CHECK CONSTRAINT [FK_Existencias_Productos]
GO
ALTER TABLE [dbo].[Facturar_Terceros]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturar_Terceros_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Facturar_Terceros] CHECK CONSTRAINT [FK_Facturar_Terceros_Clientes]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Clientes]
GO
ALTER TABLE [dbo].[Inventario_Fisico]  WITH CHECK ADD  CONSTRAINT [FK_Inventario_Fisico_Usuarios] FOREIGN KEY([intUsuario_ID])
REFERENCES [dbo].[Usuarios] ([intUsuario_ID])
GO
ALTER TABLE [dbo].[Inventario_Fisico] CHECK CONSTRAINT [FK_Inventario_Fisico_Usuarios]
GO
ALTER TABLE [dbo].[Inventario_Fisico_Existencias]  WITH NOCHECK ADD  CONSTRAINT [FK_Inventario_Fisico_Existencias_Inventario_Fisico] FOREIGN KEY([intInventario_ID])
REFERENCES [dbo].[Inventario_Fisico] ([intInventario_ID])
GO
ALTER TABLE [dbo].[Inventario_Fisico_Existencias] CHECK CONSTRAINT [FK_Inventario_Fisico_Existencias_Inventario_Fisico]
GO
ALTER TABLE [dbo].[Matanzas]  WITH NOCHECK ADD  CONSTRAINT [FK_Traspasos_Orden_Compra] FOREIGN KEY([intOrdenCompra_ID])
REFERENCES [dbo].[Orden_Compra] ([intOrdenCompra_ID])
GO
ALTER TABLE [dbo].[Matanzas] CHECK CONSTRAINT [FK_Traspasos_Orden_Compra]
GO
ALTER TABLE [dbo].[Matanzas]  WITH NOCHECK ADD  CONSTRAINT [FK_Traspasos_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Matanzas] CHECK CONSTRAINT [FK_Traspasos_Productos]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Movimientos_Almacenes] FOREIGN KEY([intAlmacen_ID])
REFERENCES [dbo].[Almacenes] ([intAlmacen_ID])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_Almacenes]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Movimientos_Orden_Compra] FOREIGN KEY([intOrdenCompra_ID])
REFERENCES [dbo].[Orden_Compra] ([intOrdenCompra_ID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Movimientos] NOCHECK CONSTRAINT [FK_Movimientos_Orden_Compra]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Movimientos_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_Productos]
GO
ALTER TABLE [dbo].[Orden_Compra]  WITH NOCHECK ADD  CONSTRAINT [FK_Orden_Compra_Proveedores] FOREIGN KEY([intProveedor_ID])
REFERENCES [dbo].[Proveedores] ([intProveedor_ID])
GO
ALTER TABLE [dbo].[Orden_Compra] CHECK CONSTRAINT [FK_Orden_Compra_Proveedores]
GO
ALTER TABLE [dbo].[Productos]  WITH NOCHECK ADD  CONSTRAINT [FK_Productos_Unidad_Medida] FOREIGN KEY([intUnidad_ID])
REFERENCES [dbo].[Unidad_Medida] ([intUnidad_ID])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Unidad_Medida]
GO
ALTER TABLE [dbo].[Productos_Compuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Table1_Productos_ProductoCompuesto_ID] FOREIGN KEY([intProductoCompuesto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Productos_Compuestos] CHECK CONSTRAINT [FK_Table1_Productos_ProductoCompuesto_ID]
GO
ALTER TABLE [dbo].[Relacion_Deshuese]  WITH CHECK ADD  CONSTRAINT [FK_Relacion_Deshuese_Producto_Deshuese] FOREIGN KEY([intProducto_Deshuese])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Relacion_Deshuese] CHECK CONSTRAINT [FK_Relacion_Deshuese_Producto_Deshuese]
GO
ALTER TABLE [dbo].[Relacion_Deshuese]  WITH CHECK ADD  CONSTRAINT [FK_Relacion_Deshuese_Producto_Producto] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Relacion_Deshuese] CHECK CONSTRAINT [FK_Relacion_Deshuese_Producto_Producto]
GO
ALTER TABLE [dbo].[Relacion_Matanza]  WITH NOCHECK ADD  CONSTRAINT [FK_Relacion_Matanza_Productos_Canal] FOREIGN KEY([intProducto_Canal])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Relacion_Matanza] CHECK CONSTRAINT [FK_Relacion_Matanza_Productos_Canal]
GO
ALTER TABLE [dbo].[Relacion_Matanza]  WITH NOCHECK ADD  CONSTRAINT [FK_Relacion_Matanza_Productos_Pie] FOREIGN KEY([intProducto_Pie])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Relacion_Matanza] CHECK CONSTRAINT [FK_Relacion_Matanza_Productos_Pie]
GO
ALTER TABLE [dbo].[Remisiones]  WITH CHECK ADD  CONSTRAINT [FK_Remisiones_Almacenes_intAlmacen_ID] FOREIGN KEY([intAlmacen_ID])
REFERENCES [dbo].[Almacenes] ([intAlmacen_ID])
GO
ALTER TABLE [dbo].[Remisiones] CHECK CONSTRAINT [FK_Remisiones_Almacenes_intAlmacen_ID]
GO
ALTER TABLE [dbo].[Remisiones]  WITH NOCHECK ADD  CONSTRAINT [FK_Remisiones_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Remisiones] CHECK CONSTRAINT [FK_Remisiones_Clientes]
GO
ALTER TABLE [dbo].[Remisiones_Canceladas]  WITH CHECK ADD  CONSTRAINT [FK_Remisiones_Canceladas_Control_Folios_Remisiones] FOREIGN KEY([intConsecutivo])
REFERENCES [dbo].[Control_Folios_Remisiones] ([intConsecutivo])
GO
ALTER TABLE [dbo].[Remisiones_Canceladas] CHECK CONSTRAINT [FK_Remisiones_Canceladas_Control_Folios_Remisiones]
GO
ALTER TABLE [dbo].[Viceras_A_Surtir]  WITH CHECK ADD  CONSTRAINT [FK_Viceras_A_Surtir_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Viceras_A_Surtir] CHECK CONSTRAINT [FK_Viceras_A_Surtir_Productos]
GO
ALTER TABLE [dbo].[Viceras_A_Surtir]  WITH CHECK ADD  CONSTRAINT [FK_Viceras_A_Surtir_Productos1] FOREIGN KEY([intProductoVicera_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Viceras_A_Surtir] CHECK CONSTRAINT [FK_Viceras_A_Surtir_Productos1]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarAbonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarAbonos]
@Cliente_ID		int,
@Fecha		datetime,--varchar(30),
@Remisiones		varchar(8000),
@Importe		money,
@Nota_Credito		money,
@TipoCuenta		char(1),
@Almacen                int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Remision varchar(10), @Caracter char(1), @Contador int, @Remision_Procesada bit, @Saldo money,  @Clave int, @Saldo_Remision money, @RemisionNo int, @CtaXCobrar int, @Abono money, @Abono_Remision money, @CxC int, @Abono_Factura money, @Salir int, @Primera_Vez int, @Importe_NC_Procesado bit, @Importe_NC varchar(20), @NC money, @Factura_Prev int, @Remision_Prev int, @NC_ID int

CREATE TABLE #Remisiones (
intRemision_ID      int,
mnyImporte_NC    money)

SET @Importe = @Importe + CASE WHEN @Nota_Credito > 0 THEN @Nota_Credito ELSE 0 END
SET @Posicion = 1
SET @Contador = LEN(@Remisiones)
SET @Remision_Procesada = 0
SET @Importe_NC_Procesado = 0
SET @Remision = ' '
SET @Importe_NC = ' '
SET @Salir = 0
SET @Remision_Prev = 0
SET @Factura_Prev = 0

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Remisiones,@Posicion,1) 

	IF @Remision_Procesada = 0
	BEGIN
		IF @Caracter <> '+'
			SET @Remision = RTRIM(@Remision) + @Caracter
		ELSE
			SET @Remision_Procesada = 1
	END

	IF @Importe_NC_Procesado = 0 AND @Remision_Procesada = 1 AND @Caracter <> '+'
	BEGIN
		IF @Caracter <> ','
			SET @Importe_NC = RTRIM(@Importe_NC) + @Caracter
		ELSE
			SET @Importe_NC_Procesado = 1
	END

	IF @Remision_Procesada = 1 AND @Importe_NC_Procesado = 1
	BEGIN
		INSERT INTO #Remisiones (intRemision_ID, mnyImporte_NC) VALUES (@Remision, CONVERT(MONEY,@Importe_NC))
		SET @Remision_Procesada = 0
		SET @Importe_NC_Procesado = 0
		SET @Remision = ' '
		SET @Importe_NC = ' '
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

DECLARE Abonos_Cursor CURSOR FOR
	SELECT intRemision_ID, mnySaldo, intCtaXCobrar, mnyImporte_NC FROM (
		SELECT #Remisiones.intRemision_ID, ROUND(CASE WHEN @TipoCuenta = 'R' THEN CtasXCobrar.mnySaldo ELSE Facturas.mnySaldo END,2) AS mnySaldo, CASE WHEN @TipoCuenta = 'R' THEN intCtaXCobrar_ID ELSE 0 END AS intCtaXCobrar, mnyImporte_NC FROM #Remisiones
		LEFT OUTER JOIN CtasXCobrar ON  (#Remisiones.intRemision_ID = CtasXCobrar.intRemisionNo AND @TipoCuenta = 'R') OR  (#Remisiones.intRemision_ID = CtasXCobrar.intFactura_ID AND @TipoCuenta = 'F') AND intAlmacen_ID = @Almacen
		LEFT OUTER JOIN Facturas ON  #Remisiones.intRemision_ID = Facturas.intFactura_ID
	) Temporal GROUP BY intRemision_ID, mnySaldo, intCtaXCobrar, mnyImporte_NC
	ORDER BY  intRemision_ID

BEGIN TRANSACTION

OPEN Abonos_Cursor

FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Saldo, @CtaXCobrar, @NC

WHILE @@FETCH_STATUS = 0 OR @Salir = 0
BEGIN
	IF @TipoCuenta = 'R'
	BEGIN
		IF @Remision_Prev <> @Clave
		BEGIN
			SET @Primera_Vez = 0
			SET @Remision_Prev = @Clave
		END		

		SET @Abono = CASE WHEN @Importe > @Saldo THEN @Saldo ELSE @Importe END

		UPDATE CtasXCobrar SET mnySaldo = mnySaldo - @Abono, mnyAbonado = mnyAbonado + @Abono
		WHERE intRemisionNo = @Clave AND intAlmacen_ID = @Almacen
		SET @Status = @@ROWCOUNT

		IF @Status <> 0 AND @NC > 0 AND @Primera_Vez = 0
		BEGIN
			UPDATE Detalle_Notas_Credito SET bitAplicada = 1
			WHERE intRemisionNo = @Clave
			SET @Status = @@ROWCOUNT

			IF @Status <> 0
			BEGIN
				SET @NC_ID = (SELECT intNota_Credito_ID FROM Detalle_Notas_Credito WHERE intRemisionNo = @Clave)
	
				IF (SELECT SUM(CASE WHEN bitAplicada = 1 THEN 1 ELSE 0 END) - COUNT(*) FROM Detalle_Notas_Credito WHERE intNota_Credito_ID = @NC_ID) = 0
				BEGIN
					UPDATE Notas_Credito SET bitAplicada = 1
					WHERE intNota_Credito_ID = @NC_ID
					SET @Status = @@ROWCOUNT
				END
			END
		END

		IF @Status <> 0
		BEGIN
			UPDATE Remisiones SET  mnySaldo = mnySaldo - @Abono
			WHERE intRemisionNo = @Clave AND intAlmacen_ID = @Almacen
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			INSERT INTO Detalle_CtasXCobrar (intCtaXCobrar_ID, dtmFecha_Abono, mnyAbono, bitAplicada_NC)
			    VALUES (@CtaXCobrar, @Fecha, @Abono, CASE WHEN @NC > 0 AND @Primera_Vez = 0 THEN 1 ELSE 0 END)	
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0 AND @Almacen <> 1
		BEGIN
			UPDATE Facturas SET mnySaldo = mnySaldo - @Abono
			WHERE intFactura_ID = (SELECT intFactura_ID FROM Detalle_Facturas WHERE intRemisionNo = @Clave)
			SET @Status = @@ROWCOUNT
		END

		SET @Importe = @Importe - @Abono
		SET @Primera_Vez = 1
		
		IF @Importe = 0 SET @Salir = 1
	END
	ELSE
	BEGIN
		IF @Factura_Prev <> @Clave
		BEGIN
			SET @Primera_Vez = 0
			SET @Factura_Prev = @Clave
		END		

		SET @Abono_Factura = CASE WHEN @Importe > @Saldo THEN @Saldo ELSE @Importe END

		UPDATE Facturas SET mnySaldo = mnySaldo - @Abono_Factura
		WHERE intFactura_ID = @Clave
		SET @Status = @@ROWCOUNT

--		IF @Status <> 0 AND @Nota_Credito > 0 AND @Primera_Vez = 0
		IF @Status <> 0 AND @NC > 0 AND @Primera_Vez = 0
		BEGIN
			UPDATE Notas_Credito SET bitAplicada = 1
			WHERE intFactura_ID = @Clave
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			SET @Abono =  @Abono_Factura

			DECLARE Remisiones_Cursor CURSOR FOR
				SELECT intCtaXCobrar_ID, CtasXCobrar.intRemisionNo, Remisiones.mnySaldo FROM CtasXCobrar
				LEFT OUTER JOIN Remisiones ON  CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo AND CtasXCobrar.intAlmacen_Id = Remisiones.intAlmacen_ID
				WHERE CtasXCobrar.intFactura_ID = @Clave
				      AND CtasXCobrar.mnySaldo <> 0
				      AND CtasXCobrar.intAlmacen_ID = @Almacen
				ORDER BY Remisiones.mnySaldo DESC, CtasXCobrar.intRemisionNo

			OPEN Remisiones_Cursor
			
			FETCH NEXT FROM Remisiones_Cursor  INTO @CxC, @RemisionNo, @Saldo_Remision
			
			WHILE @@FETCH_STATUS = 0 OR @Salir = 0
			BEGIN
				SET @Abono_Remision = CASE WHEN @Abono > @Saldo_Remision THEN @Saldo_Remision ELSE @Abono END
		
				UPDATE CtasXCobrar SET mnySaldo = mnySaldo - @Abono_Remision, mnyAbonado = mnyAbonado + @Abono_Remision
				WHERE intRemisionNo = @RemisionNo AND intAlmacen_ID = @Almacen
				SET @Status = @@ROWCOUNT
		
				IF @Status <> 0
				BEGIN
					UPDATE Remisiones SET  mnySaldo = mnySaldo - @Abono_Remision
					WHERE intRemisionNo = @RemisionNo  AND intAlmacen_ID = @Almacen
					SET @Status = @@ROWCOUNT
				END
				
				IF @Status <> 0 AND @Abono_Remision > 0
				BEGIN
					INSERT INTO Detalle_CtasXCobrar (intCtaXCobrar_ID, dtmFecha_Abono, mnyAbono, bitAplicada_NC)
					    VALUES (@CXC, @Fecha, @Abono_Remision, CASE WHEN @NC > 0 AND @Primera_Vez = 0 THEN 1 ELSE 0 END)	
--					    VALUES (@CXC, @Fecha, @Abono_Remision, CASE WHEN @Nota_Credito > 0 AND @Primera_Vez = 0 THEN 1 ELSE 0 END)	
					SET @Status = @@ROWCOUNT
				END

				SET @Abono = @Abono - @Abono_Remision
				SET @Primera_Vez = 1
		
				IF @Abono <= 0 SET @Salir = 1

				FETCH NEXT FROM Remisiones_Cursor  INTO @CxC, @RemisionNo, @Saldo_Remision
			END

			CLOSE Remisiones_Cursor
			DEALLOCATE Remisiones_Cursor

		END

		SET @Importe = @Importe - @Abono_Factura

		IF @Importe = 0 SET @Salir = 1
	END

	FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Saldo, @CtaXCobrar, @NC
END

CLOSE Abonos_Cursor
DEALLOCATE Abonos_Cursor

DROP TABLE #Remisiones

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarAbonosCXP]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarAbonosCXP]
@Fecha		datetime,--varchar(30),
@Ordenes		varchar(8000),
@Importe		money,
@Observaciones	varchar(100)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Orden varchar(10), @Caracter char(1), @Contador int, @Orden_Procesada bit, @Saldo money,  @Clave int, @RemisionNo int, @CtaXPagar int, @Abono money

CREATE TABLE #Ordenes (
intOrdenCompra_ID      int)

SET @Posicion = 1
SET @Contador = LEN(@Ordenes)
SET @Orden_Procesada = 0
SET @Orden = ' '

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Ordenes,@Posicion,1) 

	IF @Orden_Procesada = 0
	BEGIN
		IF @Caracter <> ','
			SET @Orden = RTRIM(@Orden) + @Caracter
		ELSE
			SET @Orden_Procesada = 1
	END

	IF @Orden_Procesada = 1
	BEGIN
		INSERT INTO #Ordenes (intOrdenCompra_ID) VALUES (@Orden)
		SET @Orden_Procesada = 0
		SET @Orden = ' '
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

DECLARE Abonos_Cursor CURSOR FOR
	SELECT #Ordenes.intOrdenCompra_ID, CtasXPagar.mnySaldo, intCtaXPagar_ID FROM #Ordenes
	LEFT OUTER JOIN CtasXPagar ON  #Ordenes.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	ORDER BY  #Ordenes.intOrdenCompra_ID

BEGIN TRANSACTION

OPEN Abonos_Cursor

FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Saldo, @CtaXPagar

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Abono = CASE WHEN @Importe > @Saldo THEN @Saldo ELSE @Importe END

	UPDATE CtasXPagar SET mnySaldo = mnySaldo - @Abono, mnyAbonado = mnyAbonado + @Abono
	WHERE intOrdenCompra_ID = @Clave
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Detalle_CtasXPagar (intCtaXPagar_ID, dtmFecha_Abono, mnyAbono, vchObservaciones)
		    VALUES (@CtaXPagar, @Fecha, @Abono, @Observaciones)	
		SET @Status = @@ROWCOUNT
	END

	SET @Importe = @Importe - @Abono

	FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Saldo, @CtaXPagar
END

CLOSE Abonos_Cursor
DEALLOCATE Abonos_Cursor

DROP TABLE #Ordenes

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarCierreInventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarCierreInventario]
@Usuario	varchar(10)
AS

DECLARE @Status int, @Cierre_ID int, @Usuario_ID int

SET DATEFORMAT dmy

SET @Usuario_ID = (SELECT intUsuario_ID FROM Usuarios WHERE vchUsuario = @Usuario)

BEGIN TRANSACTION

INSERT INTO Cierre_Inventario (dtmFechaCierre, intUsuario_ID) VALUES (GETDATE(), @Usuario_ID)
SET @Cierre_ID = @@IDENTITY
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	INSERT INTO Detalle_Cierre_Inventario
	SELECT @Cierre_ID, * FROM Existencias
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarClaveProdServ]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarClaveProdServ]
	@Clave_ID		varchar(10),
	@Activo			int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	UPDATE c_ClaveProdServ SET Seleccionado = @Activo
	WHERE c_ClaveProdServ = @Clave_ID
	
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarCliente]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarCliente]
@Cliente_ID             int,
@RazonSocial         varchar(80) ,
@Nombre                  varchar(50) ,
@ApellidoPaterno   varchar(50) ,
@ApellidoMaterno   varchar(50) ,
@Direccion                varchar(60),
@Ciudad                     varchar(20),
@Estado                     varchar(20),
@CodigoPostal         varchar(10),
@Telefono                 varchar(30) ,
@RFC                          varchar(20) ,
@Cobrar                      int ,
@Facturar                   int ,
@Activo                       int ,
@LimiteCredito          money,
@Operacion              char(1),
@Foraneo                 int,
@Plazo		        int,
@CtaContable	       varchar(10),
@Colonia		varchar(50),
@NoInterior		varchar(10),
@NoExterior		varchar(10),
@Pais			varchar(20),
@Correo			varchar(40),
@EnviarCorreo	bit,
@OrdenCompra	bit,
@MetodoPago		varchar(30),
@Ctabancaria	varchar(20),
@Banco			varchar(20),
@Incobrable		bit,
@Uso_CFDI		varchar(10),
@FormaPago		varchar(10)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intCliente_ID) FROM Clientes WHERE intCliente_ID <> 1000),0) + 1
	SET @ID = CASE WHEN @ID = 1000 THEN @ID + 1 ELSE @ID END
	INSERT INTO Clientes (intCliente_ID, vchRazonSocial, vchNombre, vchApellidoPaterno, vchApellidoMaterno, vchDireccion, vchCiudad, vchEstado, vchCodigoPostal, vchTelefono, vchRFC, bitCobrar, bitFacturar, bitActivo, mnyLimiteCredito, bitForaneo, intPlazo, vchCuentaContable, vchColonia, vchNoInterior, vchNoExterior, vchPais, vchEmail, bitEnviarCorreo, bitOrdenCompra, vchMetodoPago, vchCuentaBancaria, vchBanco, bitIncobrable, vchUso_CFDI, vchFormaPago) VALUES (@ID, @RazonSocial, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Direccion, @Ciudad, @Estado, @CodigoPostal, @Telefono, @RFC, @Cobrar, @Facturar, @Activo, @LimiteCredito, @Foraneo, @Plazo, @CtaContable, @Colonia, @NoInterior, @NoExterior, @Pais, @Correo, @EnviarCorreo, @OrdenCompra, @MetodoPago, @CtaBancaria, @Banco, @Incobrable, @Uso_CFDI, @FormaPago)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Clientes SET  vchRazonSocial = @RazonSocial, vchNombre = @Nombre, vchApellidoPaterno = @ApellidoPaterno, vchApellidoMaterno =  @ApellidoMaterno, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchRFC = @RFC, bitCobrar = @Cobrar, bitFacturar = @Facturar, bitActivo = @Activo, mnyLimiteCredito = @LimiteCredito, bitForaneo = @Foraneo, intPlazo = @Plazo, vchCuentaContable = @CtaContable, vchColonia = @Colonia, vchNoInterior = @NoInterior, vchNoExterior = @NoExterior, vchPais = @Pais, vchEmail = @Correo, bitEnviarCorreo = @EnviarCorreo, bitOrdenCompra = @OrdenCompra, vchMetodoPago = @MetodoPago, vchCuentaBancaria = @CtaBancaria, vchBanco = @Banco, bitIncobrable = @Incobrable, vchFormaPago = @FormaPago, vchUso_CFDI = @Uso_CFDI
    WHERE intCliente_ID = @Cliente_ID
	SET @Status = @@ROWCOUNT
END
IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarClienteTercero]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ActualizarClienteTercero]
@Cliente_ID	          int,
@Cliente_Tercero      int,
@RazonSocial           varchar(80) ,
@Nombre                    varchar(50) ,
@ApellidoPaterno      varchar(50) ,
@ApellidoMaterno      varchar(50) ,
@Direccion                  varchar(60),
@Ciudad                      varchar(20),
@Estado                     varchar(20),
@CodigoPostal           varchar(10),
@Telefono                   varchar(30) ,
@RFC                          varchar(20) ,
@Activo                        int ,
@Operacion                char(1),
@Colonia		varchar(50),
@NoInterior		varchar(10),
@NoExterior		varchar(10),
@Pais			varchar(20),
@Correo			varchar(40),
@EnviarCorreo	bit,
@MetodoPago		varchar(30),
@Ctabancaria	varchar(20),
@Banco			varchar(20),
@Uso_CFDI		varchar(10),
@FormaPago		varchar(10)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intCliente_Tercero_ID) FROM Facturar_Terceros WHERE intCliente_ID = @Cliente_ID),0) + 1
	INSERT INTO Facturar_Terceros (intCliente_ID, intCliente_Tercero_ID, vchRazonSocial, vchNombre, vchApellidoPaterno, vchApellidoMaterno, vchDireccion, vchCiudad, vchEstado, vchCodigoPostal, vchTelefono, vchRFC, bitActivo, vchColonia, vchNoInterior, vchNoExterior, vchPais, vchEmail, bitEnviarCorreo, vchMetodoPago, vchCuentaBancaria, vchBanco, vchUso_CFDI, vchFormaPago) VALUES (@Cliente_ID, @ID, @RazonSocial, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Direccion, @Ciudad, @Estado, @CodigoPostal, @Telefono, @RFC, @Activo, @Colonia, @NoInterior, @NoExterior, @Pais, @Correo, @EnviarCorreo, @MetodoPago, @CtaBancaria, @Banco, @Uso_CFDI, @FormaPago)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Facturar_Terceros SET  vchRazonSocial = @RazonSocial, vchNombre = @Nombre, vchApellidoPaterno = @ApellidoPaterno, vchApellidoMaterno =  @ApellidoMaterno, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchRFC = @RFC, bitActivo = @Activo, vchColonia = @Colonia, vchNoInterior = @NoInterior, vchNoExterior = @NoExterior, vchPais = @Pais, vchEmail = @Correo, bitEnviarCorreo = @EnviarCorreo, vchMetodoPago = @MetodoPago, vchCuentaBancaria = @CtaBancaria, vchBanco = @Banco, vchFormaPago = @FormaPago, vchUso_CFDI = @Uso_CFDI
    WHERE intCliente_ID = @Cliente_ID AND intCliente_Tercero_ID = @Cliente_Tercero
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarClienteTerceroFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarClienteTerceroFactura]
@Factura		int,
@Cliente_Tercero	int
AS

SET DATEFORMAT dmy

UPDATE Facturas SET intCliente_Tercero = @Cliente_Tercero
WHERE intFactura_ID = @Factura
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarConcepto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarConcepto]
@Conceptos                varchar(8000),
@Fecha                        datetime--varchar(30)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Cuenta_Tmp varchar(15), @Concepto_Tmp varchar(30), @Debe_Tmp varchar(10), @Haber_Tmp varchar(10), @Caracter char(1), @Contador int, @Concepto_Procesado bit, @Debe_Procesado int, @Haber_Procesado int, @Cuenta_Procesada bit
DECLARE @Movimiento_ID_Cur int, @Producto_ID_Cur int, @Cantidad_Cur int, @Peso_Cur money, @NoCanal_Cur int, @OrdenCompra_ID_Cur int, @Matanza_ID_Cur int, @Importe_Cur money

CREATE TABLE #Conceptos (
vchCuentaContable   varchar(15),
vchConcepto             varchar(30),
mnyDebe                   money,
mnyHaber                  money)

SET @Posicion = 1
SET @Contador = LEN(@Conceptos)
SET @Cuenta_Procesada = 0
SET @Concepto_Procesado = 0
SET @Debe_Procesado = 0
SET @Haber_Procesado = 0
SET @Cuenta_Tmp = ''
SET @Concepto_Tmp = ' '
SET @Debe_Tmp = ' '
SET @Haber_Tmp = ' '

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Conceptos,@Posicion,1) 

	IF @Cuenta_Procesada = 0
	BEGIN
		IF @Caracter <> '*'
			SET @Cuenta_Tmp = RTRIM(@Cuenta_Tmp) + @Caracter
		ELSE
			SET @Cuenta_Procesada = 1
	END

	IF @Cuenta_Procesada = 1 AND @Concepto_Procesado = 0 AND @Caracter <> '*'
	BEGIN
		IF @Caracter <> '+'
			SET @Concepto_Tmp = RTRIM(@Concepto_Tmp) + @Caracter
		ELSE
			SET @Concepto_Procesado = 1
	END

	IF @Cuenta_Procesada = 1 AND @Concepto_Procesado = 1 AND @Debe_Procesado = 0 AND @Caracter <> '+'
	BEGIN
		IF @Caracter <> '-'
			SET @Debe_Tmp = RTRIM(@Debe_Tmp) + @Caracter
		ELSE
			SET @Debe_Procesado = 1
	END

	IF @Cuenta_Procesada = 1 AND @Concepto_Procesado = 1 AND @Debe_Procesado = 1 AND @Haber_Procesado = 0 AND @Caracter <> '-'
	BEGIN
		IF @Caracter <> ','
			SET @Haber_Tmp = RTRIM(@Haber_Tmp) + @Caracter
		ELSE
			SET @Haber_Procesado = 1
	END

	IF @Cuenta_Procesada = 1 AND @Concepto_Procesado = 1 AND @Debe_Procesado = 1 AND @Haber_Procesado = 1
	BEGIN
		INSERT INTO #Conceptos (vchCuentaContable, vchConcepto, mnyDebe, mnyHaber) VALUES (@Cuenta_Tmp, @Concepto_Tmp, CONVERT(MONEY,@Debe_Tmp), CONVERT(MONEY,@Haber_Tmp))
		SET @Cuenta_Procesada = 0
		SET @Concepto_Procesado = 0
		SET @Debe_Procesado = 0
		SET @Haber_Procesado = 0
		SET @Cuenta_Tmp = ' '
		SET @Concepto_Tmp = ' '
		SET @Debe_Tmp = ' '
		SET @Haber_Tmp = ' '
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1

END

BEGIN TRANSACTION

DELETE FROM Conceptos_Poliza WHERE dtmFecha = @Fecha

INSERT INTO Conceptos_Poliza (dtmFecha, vchCuentaContable, vchConcepto, mnyDebe, mnyHaber)
SELECT @Fecha, vchCuentaContable, vchConcepto, mnyDebe, mnyHaber FROM #Conceptos
SET @Status = @@ROWCOUNT

DROP TABLE  #Conceptos

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarControlFolios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarControlFolios]
@Consecutivo          int,
@Repartidor_ID      int,
@Folio_Inicial           int,
@Folio_Final            int,
@Operacion             char(1)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

--BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intConsecutivo) FROM Control_Folios_Remisiones),0) + 1
	INSERT INTO Control_Folios_Remisiones (intConsecutivo, intRepartidor_ID, intFolio_Inicial, intFolio_Final) VALUES (@ID, @Repartidor_ID, @Folio_Inicial, @Folio_Final)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Control_Folios_Remisiones SET intRepartidor_ID = @Repartidor_ID, intFolio_Inicial = @Folio_Inicial, intFolio_Final = @Folio_Final
                WHERE intConsecutivo = @Consecutivo
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarCorrecionPesos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarCorrecionPesos]
@Producto_ID            int,
@Movimientos            varchar(8000),
@Fecha                       datetime--varchar(30)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Peso varchar(10), @Identificador varchar(10), @Caracter char(1), @Contador int, @Peso_Procesado bit, @Identificador_Procesado bit, @Correcion_ID int
DECLARE @intIdentificador int, @mnyPeso_Anterior money, @mnyPeso money

CREATE TABLE #Movimientos (
intIdentificador            int,
mnyPeso                      money)

SET @Posicion = 1
SET @Contador = LEN(@Movimientos)
SET @Peso_Procesado = 0
SET @Identificador_Procesado = 0
SET @Peso = ' '
SET @Identificador = ' '

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Movimientos,@Posicion,1) 

	IF @Peso_Procesado = 0
	BEGIN
		IF @Caracter <> '='
			SET @Peso = RTRIM(@Peso) + @Caracter
		ELSE
			SET @Peso_Procesado = 1
	END

	IF @Identificador_Procesado = 0 AND @Peso_Procesado = 1 and @Caracter <> '='
	BEGIN
		IF @Caracter <> ','
			SET @Identificador = RTRIM(@Identificador) + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Identificador_Procesado = 1 AND @Peso_Procesado = 1
	BEGIN
		INSERT INTO #Movimientos (intIdentificador, mnyPeso) VALUES (CONVERT(INT,@Identificador), CONVERT(MONEY,@Peso))
		SET @Peso_Procesado = 0
		SET @Identificador_Procesado = 0
		SET @Peso = ' '
		SET @Identificador = ' '
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1

END

BEGIN TRANSACTION

DECLARE Movimientos_Cursor CURSOR FOR 
	SELECT intIdentificador,  mnyPeso FROM #Movimientos

OPEN Movimientos_Cursor

FETCH NEXT FROM Movimientos_Cursor  INTO @intIdentificador, @mnyPeso

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @mnyPeso_Anterior = (SELECT mnyPeso FROM Existencias WHERE intIdentificador_Unico = @intIdentificador)

	UPDATE Existencias SET mnyPeso = @mnyPeso
	        WHERE intIdentificador_Unico = @intIdentificador
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		SET @Correcion_ID = ISNULL((SELECT MAX(intCorreccion_ID) FROM Correcion_Pesos),0) + 1
		INSERT INTO Correcion_Pesos (intCorreccion_ID, intProducto_ID, dtmFecha, mnyPeso_Anterior, mnyPeso_Nuevo, intCanalNo, intOrdenCompra_ID, intMatanza_ID) 
		          SELECT @Correcion_ID, intProducto_ID, @Fecha, @mnyPeso_Anterior, @mnyPeso, intCanalNo, intOrdenCompra_ID, intMatanza_ID FROM Existencias WHERE intIdentificador_Unico = @intIdentificador
		SET @Status = @@ROWCOUNT
	END

	FETCH NEXT FROM Movimientos_Cursor INTO @intIdentificador, @mnyPeso
END

CLOSE Movimientos_Cursor
DEALLOCATE Movimientos_Cursor

DROP TABLE #Movimientos

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarCuentaContable]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarCuentaContable]
@Cuenta_ID              int,
@CuentaNo               varchar(15),
@Descripcion            varchar(30),
@Banco                  int,
@Activo                 int,
@Operacion              char(1)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intCtaContable_ID) FROM Cuentas_Contables),0) + 1
	INSERT INTO Cuentas_Contables (intCtaContable_ID, vchDescripcion, vchNoCuenta, bitBanco, bitActivo) VALUES (@ID, @Descripcion, @CuentaNo, @Banco, @Activo)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Cuentas_Contables SET vchDescripcion = @Descripcion, vchNoCuenta = @CuentaNo, bitActivo = @Activo, bitBanco = @Banco
             WHERE intCtaContable_ID = @Cuenta_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDecomiso]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarDecomiso]
	@Producto_ID		int,
	@Cantidad           int,
	@Observaciones      varchar(100),
	@Fecha              datetime,
	@Cliente_ID	        int,
	@CanalNo	        int,
	@Peso               money,
	@OrdenCompra_ID     int,
	@Matanza_ID         int,
	@Almacen_ID			int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Movimiento_ID int, @Importe money, @NoCanal_Cur int, @Peso_Cur money, @OrdenMatanza_Cur int, @OrdenCompra_Cur  int, @Existencia_Cur int

	DECLARE Existencias_Cursor CURSOR FOR
		SELECT intOrdenCompra_ID, intCanalNo, mnyPeso, intMatanza_ID, intExistencia FROM Existencias
		WHERE intProducto_ID = @Producto_ID
			   AND intAlmacen_ID = @Almacen_ID
			   AND intMatanza_ID = @Matanza_ID
			   AND intCanalNo = @CanalNo
			   AND intOrdenCompra_ID = @OrdenCompra_ID
			   AND mnyPeso = @Peso
		ORDER BY intOrdenCompra_ID, intMatanza_ID, intCanalNo

	BEGIN TRANSACTION

	OPEN Existencias_Cursor

	FETCH NEXT FROM Existencias_Cursor  INTO @OrdenCompra_Cur, @NoCanal_Cur, @Peso_Cur, @OrdenMatanza_Cur, @Existencia_Cur

	WHILE (@@FETCH_STATUS = 0 AND @Cantidad > 0 OR @Status = 0)
	BEGIN

		UPDATE Existencias SET intExistencia = intExistencia - CASE WHEN @Cantidad >= @Existencia_Cur THEN @Existencia_Cur ELSE @Cantidad END
				WHERE intAlmacen_ID = @Almacen_ID
					   AND intOrdenCompra_ID = @OrdenCompra_Cur
					   AND intMatanza_ID = @OrdenMatanza_Cur
					   AND intProducto_ID  = @Producto_ID
					   AND intCanalNo  = @NoCanal_Cur
					   AND mnyPeso  = @Peso_Cur
		SET @Status = @@ROWCOUNT
		
		IF @Status <> 0
		BEGIN
			DELETE FROM Existencias
			WHERE intAlmacen_ID = @Almacen_ID
				   AND intOrdenCompra_ID = @OrdenCompra_Cur
				   AND intMatanza_ID = @OrdenMatanza_Cur
				   AND intProducto_ID  = @Producto_ID
				   AND intCanalNo  = @NoCanal_Cur
				   AND mnyPeso  = @Peso_Cur
							 AND intExistencia = 0
		
			SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones, intTipo_Movimiento) 
			VALUES (@Movimiento_ID, @Fecha, 'D', @Almacen_ID, @Producto_ID, @Cantidad, @Peso_Cur, 0, 0, @NoCanal_Cur, @OrdenCompra_Cur, 0, @Cliente_ID, @OrdenMatanza_Cur, @Observaciones, 204)
			SET @Status = @@ROWCOUNT
		END

		SET @Cantidad = @Cantidad - @Existencia_Cur

		FETCH NEXT FROM Existencias_Cursor  INTO @OrdenCompra_Cur, @NoCanal_Cur, @Peso_Cur, @OrdenMatanza_Cur, @Existencia_Cur
	END

	CLOSE Existencias_Cursor
	DEALLOCATE Existencias_Cursor

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDeposito_Bancario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarDeposito_Bancario]
@Fecha                        datetime,--varchar(30),
@Deposito                   money
AS

SET DATEFORMAT dmy

DECLARE @Status int

BEGIN TRANSACTION

DELETE FROM Deposito_Bancario WHERE dtmFecha = @Fecha

IF (SELECT COUNT(*) FROM Deposito_Bancario WHERE dtmFecha = @Fecha) = 0 
BEGIN
	INSERT INTO Deposito_Bancario (dtmFecha, mnyDeposito) VALUES (@Fecha, @Deposito)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Deposito_Bancario SET mnyDeposito = @Deposito
	WHERE dtmFecha = @Fecha
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarDeshuese]
@Deshuese_ID           int,
@Fecha                        datetime,
@TotPeso	           money
AS

SET DATEFORMAT dmy

DECLARE @Status int

INSERT INTO Deshueses (intDeshuese_ID, dtmFecha, mnyTotal_Peso) VALUES (@Deshuese_ID, @Fecha, @TotPeso)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	UPDATE Control_Deshueses SET intContador_Deshueses = @Deshuese_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDetalleDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarDetalleDeshuese]
@Deshuese_ID           int,
@Identificador         int,
@Almacen_ID			   int = 2
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Producto_ID int, @CanalNo bigint, @Peso money, @OrdenCompra_ID int, @Matanza_ID int, @Fecha datetime, @Matanza_Deshuese int

SELECT @OrdenCompra_ID = intOrdenCompra_ID, @Matanza_ID = intMatanza_ID, @Producto_ID = intProducto_ID, @CanalNo = intCanalNo, @Peso = mnyPeso, @Fecha = GETDATE() FROM Existencias
WHERE intIdentificador_Unico = @Identificador

SET @Matanza_Deshuese = @Deshuese_ID * -1

INSERT INTO Detalle_Deshueses (intDeshuese_ID, intOrdenCompra_ID, intMatanza_ID, intProducto_ID, intCanalNo, mnyPeso)
VALUES (@Deshuese_ID, @OrdenCompra_ID,@Matanza_ID, @Producto_ID, @CanalNo, @Peso)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	EXEC Sp_ActualizarSalidaDeshuese @Producto_ID, @CanalNo, @Peso, @OrdenCompra_ID, @Matanza_Deshuese, @Identificador, @Fecha, @Almacen_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDetalleInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarDetalleInvFisico]
@InvFisico_ID		int,
@Producto_ID		int,
@Peso			money,
@Linea			int,
@Operacion		char(1)
AS

SET DATEFORMAT dmy

DECLARE @Status int

--BEGIN TRANSACTION

IF @Operacion = ''
BEGIN
	INSERT INTO Detalle_Inventario_Fisico (intInventario_ID, intLinea, intProducto_ID, mnyPeso)  VALUES (@InvFisico_ID, @Linea, @Producto_ID, @Peso)
	SET @Status = @@ROWCOUNT
END

IF @Operacion = 'U'
BEGIN
	DELETE FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID AND intLinea = @Linea AND intProducto_ID = @Producto_ID 
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Detalle_Inventario_Fisico (intInventario_ID, intLinea, intProducto_ID, mnyPeso)  VALUES (@InvFisico_ID, @Linea, @Producto_ID, @Peso)
		SET @Status = @@ROWCOUNT
	END
END

IF @Operacion = 'D'
BEGIN
	DELETE FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID AND intLinea = @Linea AND intProducto_ID = @Producto_ID 
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		UPDATE Detalle_Inventario_Fisico SET intLinea = intLinea -1 WHERE intInventario_ID = @InvFisico_ID AND intLinea > @Linea 

		IF ISNULL((SELECT COUNT(*) FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID),0) = 0
		BEGIN
			DELETE FROM Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID
			UPDATE Control_Inventarios SET intContador_Inventarios = @InvFisico_ID -1
		END
	END
END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDetalleOrdenCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarDetalleOrdenCompra]
@OrdenCompra_ID	int,
@Productos		varchar(8000),
@Fecha			datetime, --varchar(30)
@Almacen_ID		int
AS

SET DATEFORMAT dmy

DECLARE @Status int,@Posicion int, @Caracter char(1), @Contador int, @Movimiento int, @Producto varchar(10), @Cantidad varchar(10), @Renglon varchar(10), @Producto_Procesado bit, @Cantidad_Procesada bit, @Renglon_Procesado bit, @Movimiento_ID int, @Matanza_ID int, @Ganado_Pie int, @Producto_cur int, @Matanza int, @Movimiento_Cur int, @Cantidad_cur int, @GanadoPie_cur bit, @Renglon_cur int

CREATE TABLE #Productos (
intMovimiento_ID  int,
intProducto_ID      int,
intCantidad             int,
bitGanado_Pie       bit,
intRenglon              int)

SET @Posicion = 1
SET @Contador = LEN(@Productos)
SET @Producto_Procesado = 0
SET @Cantidad_Procesada = 0
SET @Renglon_Procesado = 0
SET @Producto = ' '
SET @Cantidad = ' '
SET @Renglon = ' '
SET @Movimiento = 1

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

	IF @Producto_Procesado = 0
	BEGIN
		IF @Caracter <> '='
			SET @Producto = RTRIM(@Producto) + @Caracter
		ELSE
			SET @Producto_Procesado = 1
	END
	
	IF @Cantidad_Procesada = 0 AND @Producto_Procesado = 1 AND @Caracter <> '='
	BEGIN
		IF @Caracter <> '-'
			SET @Cantidad = RTRIM(@Cantidad) + @Caracter
		ELSE
			SET @Cantidad_Procesada = 1
	END

	IF @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Caracter <> '-'
	BEGIN
		IF @Caracter <> ','
			SET @Renglon = RTRIM(@Renglon) + @Caracter
		ELSE
			SET @Renglon_Procesado = 1
	END

	IF @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Renglon_Procesado = 1
	BEGIN
		SET @Ganado_Pie = ISNULL((SELECT SUM(No_Productos) FROM (SELECT COUNT(*) AS No_Productos FROM Relacion_Matanza WHERE intProducto_Pie = @Producto UNION SELECT 1 FROM Productos WHERE intProducto_ID = @Producto AND intUnidad_ID = (SELECT intUM_Cajas FROM Parametros)) Temp),0)
		INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, bitGanado_Pie, intRenglon) 
                                                          VALUES (@Movimiento, @Producto, @Cantidad, @Ganado_Pie, @Renglon)
		SET @Producto_Procesado = 0
		SET @Cantidad_Procesada = 0
		SET @Renglon_Procesado = 0
		SET @Producto = ' '
		SET @Cantidad = ' '
		SET @Renglon = ' '
		SET @Movimiento = @Movimiento + 1
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

BEGIN TRANSACTION

DECLARE Productos_Cursor CURSOR FOR
	SELECT intMovimiento_ID, intProducto_ID, intCantidad, bitGanado_Pie, intRenglon FROM #Productos
	ORDER BY intProducto_ID

OPEN Productos_Cursor

FETCH NEXT FROM Productos_Cursor INTO @Movimiento_Cur, @Producto_cur, @Cantidad_cur, @GanadoPie_cur, @Renglon_cur

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Detalle_Orden_Compra SET intCantidad_Recibida = intCantidad_Recibida + @Cantidad_cur
	WHERE intOrdenCompra_ID = @OrdenCompra_ID 
 	       AND intProducto_ID = @Producto_cur 
	       AND intRenglon = @Renglon_cur
	SET @Status = @@ROWCOUNT
	
	IF @Status <> 0
	BEGIN
		SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)
		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, intOrdenCompra_ID, intRenglon_OC) 
			VALUES (@Movimiento_cur + @Movimiento_ID, @Fecha, 'E', @Almacen_ID, @Producto_cur, @Cantidad_cur, @OrdenCompra_ID, @Renglon_cur)
		SET @Status = @@ROWCOUNT
	END
	
	IF @Status <> 0 AND @GanadoPie_cur = 0
	BEGIN
		SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) -- + ISNULL((SELECT COUNT(*) FROM #Productos),0)
		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, intOrdenCompra_ID, intRenglon_OC) 
			VALUES (@Movimiento_cur + @Movimiento_ID , @Fecha, 'S', @Almacen_ID, @Producto_cur, @Cantidad_cur, @OrdenCompra_ID, @Renglon_cur)
		SET @Status = @@ROWCOUNT
	
		IF @Status <> 0
		BEGIN
			SET @Matanza_ID = ISNULL((SELECT MAX(intMatanza_ID) FROM Matanzas),0)
	
--			IF ISNULL((SELECT COUNT(*) FROM Matanzas WHERE intOrdenCompra_ID = @OrdenCompra_ID  AND intProducto_ID = @Producto_cur),0) = 0
--			BEGIN
				INSERT INTO Matanzas (intMatanza_ID, dtmFecha, intProducto_ID, intCantidad, intOrdenCompra_ID) 
					VALUES(@Matanza_ID + @Movimiento_cur, @Fecha, @Producto_cur, @Cantidad_cur, @OrdenCompra_ID)
--			END
--			ELSE
--			BEGIN
--				UPDATE Matanzas SET Matanzas.intCantidad = Matanzas.intCantidad + @Cantidad_cur
--			              WHERE intOrdenCompra_ID = @OrdenCompra_ID AND Matanzas.intProducto_ID = @Producto_cur
--			END
		END
	END

----  Nuevo

	IF @Status <> 0 AND @GanadoPie_cur = 1
	BEGIN
		SET @Ganado_Pie = ISNULL((SELECT COUNT(*) AS No_Productos FROM Relacion_Matanza WHERE intProducto_Pie = @Producto_cur),0)
	
		IF @Ganado_Pie <> 0
		BEGIN
			SET @Matanza = ISNULL((SELECT MAX(intMatanza_ID) FROM Matanzas),0)
			INSERT INTO Matanzas (intMatanza_ID, dtmFecha, intProducto_ID, intCantidad, intOrdenCompra_ID) 
			SELECT @Matanza + intMovimiento_ID, @Fecha, intProducto_Canal, intCantidad * 2, @OrdenCompra_ID FROM #Productos
			INNER JOIN Relacion_Matanza ON intProducto_ID = intProducto_Pie
			WHERE intProducto_ID = @Producto_cur AND intRenglon = @Renglon_cur AND intMovimiento_ID = @Movimiento_cur
			SET @Status = @@ROWCOUNT
		END
		ELSE
		BEGIN
			SET @Matanza = ISNULL((SELECT MAX(intMatanza_ID) FROM Matanzas),0)
			INSERT INTO Matanzas (intMatanza_ID, dtmFecha, intProducto_ID, intCantidad, intOrdenCompra_ID) 
				VALUES (@Matanza + @Movimiento_cur, @Fecha, @Producto_cur, @Cantidad_cur, @OrdenCompra_ID)
			SET @Status = @@ROWCOUNT
		END
	END

--	IF @Status <> 0 AND ISNULL((SELECT COUNT(*) FROM #Productos WHERE bitGanado_Pie = 1 AND intProducto_ID = @Producto_cur),0) <> 0
--	BEGIN
--		IF ISNULL((SELECT COUNT(*) FROM Existencias WHERE intAlmacen_ID = @Almacen_ID AND intOrdenCompra_ID = @OrdenCompra_ID  AND intProducto_ID = @Producto_cur),0) = 0
--		BEGIN
--			INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo) 
--	                                SELECT @Almacen_ID, intProducto_ID, intCantidad, 0, @OrdenCompra_ID, 0 FROM #Productos WHERE bitGanado_Pie = 1 AND intProducto_ID = @Producto_cur
--			SET @Status = @@ROWCOUNT
--		END
--		ELSE
--		BEGIN
--			UPDATE Existencias SET intExistencia = intExistencia + #Productos.intCantidad
--			FROM Existencias
--			INNER JOIN #Productos ON Existencias.intProducto_ID = #Productos.intProducto_ID
--		              WHERE intOrdenCompra_ID = @OrdenCompra_ID 
--			       AND intAlmacen_ID = @Almacen_ID
--			       AND bitGanado_Pie = 1
--			       AND Existencias.intProducto_ID = @Producto_cur
--			SET @Status = @@ROWCOUNT
--		END
--	END

	FETCH NEXT FROM Productos_Cursor INTO @Movimiento_Cur, @Producto_cur, @Cantidad_cur, @GanadoPie_cur, @Renglon_cur
END

CLOSE Productos_Cursor
DEALLOCATE Productos_Cursor

DROP TABLE #Productos

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDevolucion]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarDevolucion]
	@Movimientos	varchar(8000),
	@Fecha          datetime,--varchar(30),
	@Almacen	    int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Resultado int, @Movimiento_ID int, @Posicion int, @Transaccion varchar(10), @Caracter char(1), @Contador int, @Transaccion_Procesada bit, @Status_Vicera int, @Primera_Vez bit
	DECLARE @intMovimiento_ID int, @dtmFecha datetime, @intAlmacen_ID int, @intProducto_ID int, @intCantidad int, @mnyPeso money, @mnyPrecio money, @mnyImporte money, @intCanalNo bigint, @intOrdenCompra_ID int, @intRemisionNo int, @intCliente_ID int, @intMatanza_ID int, @mnyFlete money, @TipoVicera int
	DECLARE @Productos_Sel int, @Vicera_Completa int, @No_Viceras money, @EsVicera int, @Par_Non int

	CREATE TABLE #Movimientos (
	intMovimiento_ID  int)

	SET @Primera_Vez = 1
	SET @Posicion = 1
	SET @Contador = LEN(@Movimientos)
	SET @Transaccion_Procesada = 0
	SET @Transaccion = ' '

	WHILE @Contador <> 0
	BEGIN

		SET @Caracter = SUBSTRING(@Movimientos,@Posicion,1) 

		IF @Transaccion_Procesada = 0
		BEGIN
			IF @Caracter <> ','
				SET @Transaccion = RTRIM(@Transaccion) + @Caracter
			ELSE
				SET @Transaccion_Procesada = 1
		END

		IF @Transaccion_Procesada = 1
		BEGIN
			INSERT INTO #Movimientos (intMovimiento_ID) VALUES (@Transaccion)
			SET @Transaccion_Procesada = 0
			SET @Transaccion = ' '
		END

		SET @Posicion = @Posicion + 1
		SET @Contador = @Contador - 1

	END

	SET @Productos_Sel = (SELECT COUNT(*) FROM #Movimientos)
	SET @Vicera_Completa = ISNULL((SELECT 1 FROM Productos WHERE vchDescripcion LIKE '%COMPLETA%' AND intProducto_ID IN (SELECT intTipoVicera_ID FROM Movimientos WHERE intMovimiento_ID IN (SELECT intMovimiento_ID FROM #Movimientos))),0)
	SET @Par_Non = (SELECT CASE WHEN @Vicera_Completa = 1 THEN @Productos_Sel % 2 ELSE @Productos_Sel END)
	SET @No_Viceras = (SELECT CASE WHEN @Vicera_Completa = 1 THEN @Productos_Sel / 2 ELSE @Productos_Sel END)
	SET @EsVicera = ISNULL((SELECT COUNT(*) FROM Viceras_A_Surtir WHERE intProductoVicera_ID = (SELECT DISTINCT intProducto_ID FROM Movimientos WHERE intMovimiento_ID IN (SELECT intMovimiento_ID FROM #Movimientos))),0)

	IF @Vicera_Completa = 1 AND @Par_Non = 0 OR @Vicera_Completa = 0
	BEGIN
		BEGIN TRANSACTION

		IF @EsVicera = 0
			DECLARE Movimientos_Cursor CURSOR FOR 
				SELECT intMovimiento_ID, dtmFecha, intAlmacen_ID, Movimientos.intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID FROM Movimientos
				WHERE chrOperacion = 'S'
				   AND intAlmacen_ID = @Almacen
				   AND intMovimiento_ID IN (SELECT intMovimiento_ID FROM #Movimientos)
				ORDER BY intMovimiento_ID
		ELSE
				SELECT intMovimiento_ID, dtmFecha, intAlmacen_ID, Movimientos.intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID FROM Movimientos
				LEFT OUTER JOIN Viceras ON Movimientos.intProducto_ID = Viceras.intProducto_ID
				WHERE chrOperacion = 'S'
				   AND intAlmacen_ID = @Almacen
				   AND intMovimiento_ID IN (SELECT intMovimiento_ID FROM #Movimientos)
				   AND Viceras.intProducto_ID IS NULL
				ORDER BY intMovimiento_ID

		OPEN Movimientos_Cursor
		
		FETCH NEXT FROM Movimientos_Cursor  INTO @intMovimiento_ID, @dtmFecha, @intAlmacen_ID, @intProducto_ID, @intCantidad, @mnyPeso, @mnyPrecio, @mnyImporte, @intCanalNo, @intOrdenCompra_ID, @intRemisionNo, @intCliente_ID, @intMatanza_ID, @mnyFlete, @TipoVicera
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
			SET @Resultado = 0
		
		--	SET @Resultado = (SELECT COUNT(*) FROM Existencias 
		--			        WHERE intAlmacen_ID = @intAlmacen_ID 
		--				AND intOrdenCompra_ID = @intOrdenCompra_ID
		--			               AND intMatanza_ID = @intMatanza_ID
		--			               AND intProducto_ID  = @intProducto_ID
		--			               AND intCanalNo  = @intCanalNo
		--			               AND mnyPeso  = @mnyPeso)
		
			IF @Resultado = 0
			BEGIN
				INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@intAlmacen_ID, @intProducto_ID, @intCantidad, @mnyPeso, @intOrdenCompra_ID, @intCanalNo, @intMatanza_ID)
				SET @Status = @@ROWCOUNT
			END
			ELSE
			BEGIN
				UPDATE Existencias SET intExistencia = intExistencia + @intCantidad
				WHERE intAlmacen_ID = @intAlmacen_ID
				   AND intOrdenCompra_ID = @intOrdenCompra_ID
				   AND intMatanza_ID = @intMatanza_ID
				   AND intProducto_ID  = @intProducto_ID
				   AND intCanalNo  = @intCanalNo
				   AND mnyPeso  = @mnyPeso
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
				SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
				INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipo_Movimiento) 
				VALUES (@Movimiento_ID, @Fecha, 'A', @intAlmacen_ID, @intProducto_ID, @intCantidad, @mnyPeso, @mnyPrecio, @mnyImporte, @intCanalNo, @intOrdenCompra_ID, @intRemisionNo, @intCliente_ID, @intMatanza_ID, @mnyFlete, 102)
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
				UPDATE Movimientos SET bitTiene_Devolucion = 1 WHERE intMovimiento_ID = @intMovimiento_ID AND intAlmacen_ID = @intAlmacen_ID
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0 AND @TipoVicera <> 0 AND @Primera_Vez = 1
			BEGIN
				SET @Status_Vicera = 0
				EXEC Sp_ActualizarDevolucionVicera @intRemisionNo, @TipoVicera, @Fecha, @No_Viceras, @Almacen, @Status_Vicera OUTPUT
				SET @Status = @Status_Vicera
			END

			IF @Status <> 0
			BEGIN
				UPDATE CtasXCobrar SET mnyImporte = mnyImporte - (@mnyImporte + @mnyFlete), mnySaldo = mnySaldo - (@mnyImporte + @mnyFlete)
				WHERE intRemisionNo = @intRemisionNo
				   AND intCliente_ID = @intCliente_ID
				   AND intAlmacen_ID = @intAlmacen_ID
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
				DELETE FROM CtasXCobrar
				WHERE intRemisionNo = @intRemisionNo
				   AND intCliente_ID = @intCliente_ID
				   AND intAlmacen_ID = @intAlmacen_ID
				   AND mnyImporte = 0
				   AND (SELECT ISNULL(SUM(intCantidad * CASE WHEN chrOperacion = 'S' THEN 1 ELSE -1 END),0) FROM Movimientos WHERE intRemisionNo = @intRemisionNo) = 0
		
				UPDATE Remisiones SET mnyImporte = mnyImporte - (@mnyImporte + @mnyFlete), mnySaldo = mnySaldo - (@mnyImporte + @mnyFlete)
				WHERE intRemisionNo = @intRemisionNo
				   AND intCliente_ID = @intCliente_ID
				   AND intAlmacen_ID = @intAlmacen_ID
				SET @Status = @@ROWCOUNT
			END

			IF @Status <> 0
			BEGIN
				DELETE FROM Detalle_Remisiones
				WHERE intRemisionNo = @intRemisionNo
				  AND intProducto_ID = @intProducto_ID
				  AND intCantidad = @intCantidad
				  AND mnyPeso = @mnyPeso
				  AND intMovimiento_ID = @intMovimiento_ID
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
				DELETE FROM Remisiones
				WHERE intRemisionNo = @intRemisionNo
										   AND intCliente_ID = @intCliente_ID
					   AND intAlmacen_ID = @intAlmacen_ID
					   AND mnyImporte = 0
					   AND (SELECT ISNULL(SUM(intCantidad * CASE WHEN chrOperacion = 'S' THEN 1 ELSE -1 END),0) FROM Movimientos WHERE intRemisionNo = @intRemisionNo) = 0
			END
		
			SET @Primera_Vez = 0
		
			FETCH NEXT FROM Movimientos_Cursor INTO @intMovimiento_ID, @dtmFecha, @intAlmacen_ID, @intProducto_ID, @intCantidad, @mnyPeso, @mnyPrecio, @mnyImporte, @intCanalNo, @intOrdenCompra_ID, @intRemisionNo, @intCliente_ID, @intMatanza_ID, @mnyFlete, @TipoVicera
		END
		
		CLOSE Movimientos_Cursor
		DEALLOCATE Movimientos_Cursor
		
		DROP TABLE #Movimientos
	END
	ELSE
		SET @Status = 599

	IF @Status = 599
		RETURN 599
	ELSE
		IF @Status <> 0
		BEGIN
			COMMIT TRANSACTION
			RETURN 0
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			RETURN 99
		END
		
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarDevolucionVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarDevolucionVicera]
	@RemisionNo		int, 
	@TipoVicera     int,
	@Fecha          datetime,
	@No_Viceras	    money,
	@Almacen_ID		int,
	@Status_Vicera  int OUTPUT
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Resultado int, @Producto_ID int, @NoCanal bigint, @Cantidad int, @Cliente_ID int, @Movimiento_ID int, @Matanza_ID int, @OrdenCompra_ID int, @Otra_Devolucion int, @Producto_Ant int, @Contador_Piezas int, @Movimiento_ID_cur int, @No_Piezas int

	SET @Producto_Ant = 0
	SET @Contador_Piezas = 0

	DECLARE Viceras_Cursor CURSOR FOR 
		SELECT Viceras.intProducto_ID, intCanalNo, CASE WHEN intCantidad > (@No_Viceras * intNoPiezas) THEN (@No_Viceras * intNoPiezas) ELSE intCantidad END AS Cantidad, (@No_Viceras * intNoPiezas) AS No_Piezas, intCliente_ID, intOrdenCompra_ID, intMatanza_ID, intMovimiento_ID FROM Viceras
	--	SELECT Viceras.intProducto_ID,  intCanalNo, intNoPiezas, (@No_Viceras * intNoPiezas) AS intCantidad, intCliente_ID, intOrdenCompra_ID, intMatanza_ID FROM Viceras
		INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
	--	INNER JOIN Movimientos ON intAlmacen_ID = @Almacen_ID AND chrOperacion = 'S' AND Viceras.intProducto_ID = Movimientos.intProducto_ID AND intRemisionNo = @RemisionNo AND intTipoVicera_ID = @TipoVicera AND intOrdenCompra_ID = @OrdenCompra_ID AND intMatanza_ID = @Matanza_ID
		INNER JOIN Movimientos ON intAlmacen_ID = @Almacen_ID AND chrOperacion = 'S' AND Viceras.intProducto_ID = Movimientos.intProducto_ID AND intRemisionNo = @RemisionNo AND intTipoVicera_ID = @TipoVicera AND bitTiene_Devolucion = 0
		WHERE intVicera_ID = @TipoVicera

	OPEN Viceras_Cursor

	FETCH NEXT FROM Viceras_Cursor  INTO @Producto_ID, @NoCanal, @Cantidad, @No_Piezas, @Cliente_ID, @OrdenCompra_ID, @Matanza_ID, @Movimiento_ID_cur

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Contador_Piezas = @Contador_Piezas + @Cantidad

		IF @Producto_Ant <> @Producto_ID OR (@Producto_Ant = @Producto_ID AND @No_Piezas >= @Contador_Piezas)
		BEGIN
			SET @Producto_Ant = @Producto_ID
			SET @Contador_Piezas = @Cantidad

			SET @Resultado = (SELECT COUNT(*) FROM Existencias 
							WHERE intAlmacen_ID = @Almacen_ID
						AND intOrdenCompra_ID = @OrdenCompra_ID
								   AND intMatanza_ID = @Matanza_ID
								   AND intProducto_ID  = @Producto_ID
								   AND intCanalNo  = @NoCanal)
		
			IF @Resultado = 0
			BEGIN
				INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@Almacen_ID, @Producto_ID, @Cantidad, 0, @OrdenCompra_ID, @NoCanal, @Matanza_ID)
				SET @Status = @@ROWCOUNT
			END
			ELSE
			BEGIN
				UPDATE Existencias SET intExistencia = intExistencia + @Cantidad
						WHERE intAlmacen_ID = @Almacen_ID
							   AND intOrdenCompra_ID = @OrdenCompra_ID
							   AND intMatanza_ID = @Matanza_ID
							   AND intProducto_ID  = @Producto_ID
							   AND intCanalNo  = @NoCanal
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
				SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
				INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID, intTipo_Movimiento) 
									VALUES (@Movimiento_ID, @Fecha, 'A', @Almacen_ID, @Producto_ID, @Cantidad, 0, 0, 0, @NoCanal, @OrdenCompra_ID, @RemisionNo, @Cliente_ID, @Matanza_ID, 0, @Movimiento_ID_cur, 102)
				SET @Status = @@ROWCOUNT
			END

			IF @Status <> 0
			BEGIN
				DELETE FROM Detalle_Remisiones
				WHERE intRemisionNo = @RemisionNo
				  AND intProducto_ID = @Producto_ID
				  AND intCantidad = @Cantidad
				  AND intMovimiento_ID = @Movimiento_ID_cur
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
	--			SET @Otra_Devolucion = ISNULL((SELECT SUM(intCantidad) FROM Movimientos WHERE chrOperacion = 'A' AND intAlmacen_ID = @Almacen_ID AND intOrdenCompra_ID = @OrdenCompra_ID AND intMatanza_ID = @Matanza_ID AND intProducto_ID  = @Producto_ID AND intCanalNo  = @NoCanal AND intRemisionNo = @RemisionNo),0)
				SET @Otra_Devolucion = ISNULL((SELECT SUM(intCantidad) FROM Movimientos WHERE chrOperacion = 'A' AND intAlmacen_ID = @Almacen_ID AND intTipoVicera_ID = @Movimiento_ID_cur),0)
		
				UPDATE Movimientos SET bitTiene_Devolucion = CASE WHEN @Otra_Devolucion = intCantidad THEN 1 ELSE 0 END
				WHERE intAlmacen_ID = @Almacen_ID
					   AND intMovimiento_ID = @Movimiento_ID_cur
	--			       AND intOrdenCompra_ID = @OrdenCompra_ID
	--			       AND intMatanza_ID = @Matanza_ID
	--			       AND intProducto_ID  = @Producto_ID
	--			       AND intCanalNo  = @NoCanal
	--			       AND intRemisionNo = @RemisionNo
	--			       AND intTipoVicera_ID = @TipoVicera
				SET @Status = @@ROWCOUNT
			END
		END

		FETCH NEXT FROM Viceras_Cursor INTO @Producto_ID, @NoCanal, @Cantidad, @No_Piezas, @Cliente_ID, @OrdenCompra_ID, @Matanza_ID, @Movimiento_ID_cur
	END

	CLOSE Viceras_Cursor
	DEALLOCATE Viceras_Cursor

	IF @Status <> 0
		SET @Status_Vicera = 1
	ELSE
		SET @Status_Vicera = 0
		
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarEntradaDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarEntradaDeshuese]
	@NoCanal			int,
	@OrdenCompra_ID     int,
	@OrdenMatanza_ID    int,
	@Producto_ID        int,
	@Peso               money,
	@Fecha              datetime,--varchar(30)
	@Almacen_ID			int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Resultado int, @Movimiento_ID int, @Cliente_ID int, @Precio money

	SET @Precio = (SELECT mnyPrecio FROM Productos WHERE intProducto_ID = @Producto_ID)
	SET @Cliente_ID = ISNULL((SELECT MAX(intMovimiento_ID) * -1 FROM Movimientos WHERE intCliente_ID = -999 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) = CONVERT(SMALLDATETIME,CONVERT(CHAR,GETDATE(),103),103) AND chrOperacion = 'S' AND intAlmacen_ID = @Almacen_ID AND intCanalNo = @Nocanal AND intOrdenCompra_ID = @OrdenCompra_ID AND intMatanza_ID = @Ordenmatanza_ID),@OrdenMatanza_ID)

	--BEGIN TRANSACTION

	SET @Resultado = 0

	--SET @Resultado = (SELECT COUNT(*) FROM Existencias
	--		        WHERE intAlmacen_ID = @Almacen_ID
	--			AND intOrdenCompra_ID = @OrdenCompra_ID
	--		               AND intMatanza_ID = @OrdenMatanza_ID
	--		               AND intProducto_ID  = @Producto_ID
	--		               AND intCanalNo  = @NoCanal
	--		               AND mnyPeso  = @Peso)

	IF @Resultado = 0
	BEGIN
		INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@Almacen_ID, @Producto_ID, 1, @Peso, @OrdenCompra_ID, @NoCanal, @OrdenMatanza_ID)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Existencias SET intExistencia = intExistencia + 1
				WHERE intAlmacen_ID = @Almacen_ID
					   AND intOrdenCompra_ID = @OrdenCompra_ID
					   AND intMatanza_ID = @OrdenMatanza_ID
					   AND intProducto_ID  = @Producto_ID
					   AND intCanalNo  = @NoCanal
					   AND mnyPeso  = @Peso
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipo_Movimiento) 
							VALUES (@Movimiento_ID, @Fecha, 'E', @Almacen_ID, @Producto_ID, 1, @Peso, @Precio, 0, @NoCanal, @OrdenCompra_ID, 0, @Cliente_ID, @OrdenMatanza_ID, 0, 101)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
	--	COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
	--	ROLLBACK TRANSACTION
		RETURN 99
	END

END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarEntradaMatanza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarEntradaMatanza]
	@OrdenMatanza_ID	int,
	@OrdenCompra_ID     int,
	@Producto_ID        int,
	@NoCanal            bigint,
	@Peso               money,
	@TipoCompra         int,
	@Fecha              datetime ,--varchar(30)
	@Almacen_ID			int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Movimiento int, @Cantidad int, @Contador int, @Precio money

	--BEGIN TRANSACTION

	SET @Precio = (SELECT mnyPrecio FROM Productos WHERE intProducto_ID = @Producto_ID)

	UPDATE Matanzas SET bitProcesado = 1
			WHERE intMatanza_ID = @OrdenMatanza_ID 
	SET @Status = @@ROWCOUNT

	IF @TipoCompra <> 4 
	BEGIN
		IF @TipoCompra = 2 OR @TipoCompra = 0
		BEGIN
			SET @Cantidad = @Peso
			SET @Peso = 0
		END
		ELSE
			SET @Cantidad = 1

		IF @Status <> 0
		BEGIN
			SET @Movimiento = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, intOrdenCompra_ID, mnyPeso, intCanalNo, intMatanza_ID, mnyPrecio, intTipo_Movimiento) VALUES (@Movimiento, @Fecha, 'E', @Almacen_ID, @Producto_ID, @Cantidad, @OrdenCompra_ID, @Peso, @NoCanal, @OrdenMatanza_ID, @Precio, 100)
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@Almacen_ID, @Producto_ID, @Cantidad, @Peso, @OrdenCompra_ID, @NoCanal, @OrdenMatanza_ID)
			SET @Status = @@ROWCOUNT

	--		SET @Contador = @Cantidad
	--		WHILE @Contador <> 0
	--		BEGIN
	--			INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@Almacen_ID, @Producto_ID, @Cantidad, @Peso, @OrdenCompra_ID, @NoCanal, @OrdenMatanza_ID)
	--			SET @Status = @@ROWCOUNT
	--			SET @Contador = @Contador -1
	--		END
		END
		
		IF @Status <> 0 AND @TipoCompra = 3
		BEGIN
			UPDATE Control_Cajas SET intContador_Cajas = @NoCanal
			SET @Status = @@ROWCOUNT
		END
	END
	ELSE
	BEGIN
		IF @Status <> 0
		BEGIN
			SET @Movimiento = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, intOrdenCompra_ID, mnyPeso, intCanalNo, intMatanza_ID, mnyPrecio, intTipo_Movimiento) 
									 SELECT @Movimiento, @Fecha, 'E', @Almacen_ID, Viceras.intProducto_ID, intNoPiezas * @Peso, @OrdenCompra_ID, 0, @NoCanal, @OrdenMatanza_ID, @Precio, 100 FROM Viceras 
									 INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
									 WHERE intVicera_ID = @Producto_ID
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, mnyPeso, intOrdenCompra_ID, intCanalNo, intMatanza_ID) 
									 SELECT @Almacen_ID, Viceras.intProducto_ID, intNoPiezas * @Peso, 0, @OrdenCompra_ID, @NoCanal, @OrdenMatanza_ID FROM Viceras 
									 INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
									 WHERE intVicera_ID = @Producto_ID
			SET @Status = @@ROWCOUNT
		END
	END

	IF @Status <> 0
	BEGIN
	--	COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
	--	ROLLBACK TRANSACTION
		RETURN 99
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarEntradaTraspaso]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarEntradaTraspaso]
	@Traspaso_ID	int,
	@Usuario_ID		int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Movimiento int, @SQL varchar(MAX), @BaseDatos_FROM varchar(20), @BaseDatos_TO varchar(20), @Almacen_FROM int, @Almacen_TO int, @Fecha varchar(10)

	CREATE TABLE #Movs (intMovimiento_ID int)

	SELECT @BaseDatos_FROM = AF.BaseDatos, @BaseDatos_TO = AT.BaseDatos, @Almacen_FROM = T.intAlmacen_ID_FROM, @Almacen_TO = T.intAlmacen_ID_TO, @Fecha = CONVERT(varchar,dtmFecha,103) FROM Traspasos T
	INNER JOIN Almacenes AF ON T.intAlmacen_ID_FROM = AF.intAlmacen_ID
	INNER JOIN Almacenes AT ON T.intAlmacen_ID_TO = AT.intAlmacen_ID
	WHERE intTraspaso_ID = @Traspaso_ID

	BEGIN TRANSACTION

	SET @SQL = 'UPDATE ' + @BaseDatos_FROM + '.dbo.Traspasos SET bitRecibido = 1, dtmFecha_Recibido = GETDATE(), intUsuario_ID_Recibido = ' + CONVERT(varchar,@Usuario_ID) + ' WHERE intTraspaso_ID = ' + CONVERT(varchar,@Traspaso_ID)
	EXEC (@SQL)

	SET @SQL = 'UPDATE ' + @BaseDatos_TO + '.dbo.Traspasos SET bitRecibido = 1, dtmFecha_Recibido = GETDATE(), intUsuario_ID_Recibido = ' + CONVERT(varchar,@Usuario_ID) + ' WHERE intTraspaso_ID = ' + CONVERT(varchar,@Traspaso_ID)
	EXEC (@SQL)

	SET @SQL = 'DECLARE @Mov int SET @Mov = ISNULL((SELECT MAX(intMovimiento_ID) FROM ' + @BaseDatos_TO  + '.dbo.Movimientos),0) INSERT INTO #Movs VALUES (@Mov)'
	EXEC (@SQL)

	SELECT @Movimiento = intMovimiento_ID FROM #Movs

	SET @SQL = 'INSERT INTO ' + @BaseDatos_TO + '.dbo.Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intCantidad_Multiplicar, vchOrden_Compra, intTipo_Movimiento) ' +
	           'SELECT ' + CONVERT(varchar,@Movimiento) + ' + ROW_NUMBER() OVER(ORDER BY intMovimiento_ID), GETDATE(), ''E'', ' + CONVERT(varchar,@Almacen_TO) + ', intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intCantidad_Multiplicar, vchOrden_Compra, 104 FROM ' + @BaseDatos_FROM + '.dbo.Movimientos WHERE intRemisionNo = ' + CONVERT(varchar,@Traspaso_ID) + ' AND CONVERT(varchar,dtmFecha,103) = ''' + @Fecha + ''''
	EXEC (@SQL)

	SET @Status = @@ROWCOUNT 

	DROP TABLE #Movs

	IF @Status <> 0
	BEGIN
		SET @SQL = 'INSERT INTO ' + @BaseDatos_TO + '.dbo.Existencias (intAlmacen_ID, intProducto_ID, intOrdenCompra_ID, intCanalNo, intExistencia, mnyPeso, intMatanza_ID) ' +
		           'SELECT ' + CONVERT(varchar,@Almacen_TO) + ' , intProducto_ID, intOrdenCompra_ID, intCanalNo, intCantidad, mnyPeso, intMatanza_ID FROM ' + @BaseDatos_FROM + '.dbo.Movimientos WHERE intRemisionNo = ' + CONVERT(varchar,@Traspaso_ID) + ' AND CONVERT(varchar,dtmFecha,103) = ''' + @Fecha + ''''
		EXEC (@SQL)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarEntradaVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarEntradaVicera]
@OrdenMatanza_ID   int,
@OrdenCompra_ID    int,
@Producto_ID       int,
@Cantidad          int,
@Fecha             datetime,--varchar(30)
@Almacen_ID		   int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Movimiento int, @NoCanal bigint

--SET @NoCanal = CONVERT(INT,RTRIM(CONVERT(CHAR,@Producto_ID)) + RTRIM(CONVERT(CHAR,@OrdenCompra_ID)) + RTRIM(CONVERT(CHAR,@OrdenMatanza_ID)))
SET @NoCanal = CONVERT(INT,RTRIM(CONVERT(CHAR,@OrdenCompra_ID)) + RTRIM(CONVERT(CHAR,@OrdenMatanza_ID)))

--BEGIN TRANSACTION

UPDATE Matanzas SET bitVicera = 1
        WHERE intMatanza_ID = @OrdenMatanza_ID
--               AND bitProcesado = 1
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	SET @Movimiento = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
	INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@Movimiento, @Fecha, 'E', @Almacen_ID, @Producto_ID, @Cantidad, @OrdenCompra_ID, 0, @OrdenMatanza_ID)
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	INSERT INTO Existencias (intAlmacen_ID, intProducto_ID, intExistencia, intOrdenCompra_ID, intCanalNo, intMatanza_ID) VALUES (@Almacen_ID, @Producto_ID, @Cantidad, @OrdenCompra_ID, @NoCanal, @OrdenMatanza_ID)
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarErrorSistema]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarErrorSistema]
@Fecha                      varchar(30),
@NoError                   int,
@Descripcion          varchar(100),
@Forma                     varchar(40),
@Procedimiento     varchar(40)
AS

SET DATEFORMAT dmy

DECLARE @ID int

BEGIN TRANSACTION

SET @ID = ISNULL((SELECT MAX(intConsecutivo) FROM Errores),0) + 1

INSERT INTO Errores (intConsecutivo, dtmFecha, intNoError, vchDescripcion, vchForma, vchProcedimiento) VALUES (@ID, @Fecha, @NoError, @Descripcion, @Forma, @Procedimiento)

COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarFactura]
	@Cliente_ID			int,
	@Factura_ID			int,
	@Observaciones		varchar(100),
	@Fecha				datetime, --varchar(30),
	@TipoPago			int,
	@Remisiones			varchar(8000),
	@Importe			money,
	@Cliente_Tercero	int,
	@IVA_ID	int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Renglon int, @Posicion int, @Remision varchar(10), @Caracter char(1), @Contador int, @Remision_Procesada bit, @Factura_Tmp int, @IVA money, @SubTotal money, @Tot_IVA money

	SET @IVA = (SELECT mnyIVA FROM Ivas WHERE intIva_ID = @IVA_ID)

	SET @SubTotal = 0
	SET @Tot_IVA = 0

	SET @Factura_Tmp = (SELECT intContador_Facturas + 1 FROM Control_Facturas)

	IF @Factura_ID <> @Factura_Tmp
		RETURN 99
	ELSE
	BEGIN
		CREATE TABLE #DetalleFactura (
		intRenglon int IDENTITY(1,1) NOT NULL,
		intOrden int,
		mnyCantidad money,
		vchUnidad varchar(20),
		intCodigo int, 
		vchProducto varchar(2000), 
		mnyPrecio money, 
		mnyPeso money, 
		mnyImporte money,
		vchCodigo_Barras varchar(20),
		intNo_Cajas int,
		vchClaveProdServ varchar(50),
		vchNoIdentificacion varchar(20))

		CREATE TABLE #Remisiones (
		intRenglon_ID        int,
		intRemision_ID      int)
		
		SET @Posicion = 1
		SET @Contador = LEN(@Remisiones)
		SET @Remision_Procesada = 0
		SET @Remision = ' '
		SET @Renglon = 1
		
		WHILE @Contador <> 0
		BEGIN
		
			SET @Caracter = SUBSTRING(@Remisiones,@Posicion,1) 
		
			IF @Remision_Procesada = 0
			BEGIN
				IF @Caracter <> ','
					SET @Remision = RTRIM(@Remision) + @Caracter
				ELSE
					SET @Remision_Procesada = 1
			END
		
			IF @Remision_Procesada = 1
			BEGIN
				INSERT INTO #Remisiones (intRenglon_ID, intRemision_ID) VALUES (@Renglon, @Remision)
				SET @Remision_Procesada = 0
				SET @Remision = ' '
				SET @Renglon = @Renglon + 1
			END
		
			SET @Posicion = @Posicion + 1
			SET @Contador = @Contador - 1
		END

		SELECT @SubTotal = SUM(mnyImporte) FROM #Remisiones
		INNER JOIN CtasXCobrar ON #Remisiones.intRemision_ID = CtasXCobrar.intRemisionNo
		
		SET @Tot_IVA = @SubTotal * (@IVA / CONVERT(MONEY,100))
		
	--	BEGIN TRANSACTION

		UPDATE Control_Facturas SET intContador_Facturas = @Factura_ID
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN	
			INSERT INTO Facturas (intFactura_ID, dtmFecha, intCliente_ID, mnyImporte, mnySaldo, vchObservaciones, intTipoPago, intCliente_Tercero, mnyIVA, mnyPIVA) 
			VALUES (@Factura_ID, @Fecha, @Cliente_ID, @Importe, @Importe, @Observaciones, @TipoPago, @Cliente_Tercero, @Tot_IVA, @IVA)
			SET @Status = @@ROWCOUNT
			
			IF @Status <> 0	
			BEGIN
				INSERT INTO Cab_Ventas (intFactura_ID, dtmFecha_Registro, intCliente_ID, vchTipo_Pago,  mnySubTotal, mnyIVA, mnyTotal, mnyPIVA, bitCancelada) 
				SELECT @Factura_ID, GETDATE(), @Cliente_ID, CASE WHEN @TipoPago = 1 THEN 'CREDITO' ELSE 'CONTADO' END, @SubTotal, @Tot_IVA, @SubTotal + @Tot_IVA, @IVA, 0
				SET @Status = @@ROWCOUNT
			END
			
		END

		IF @Status <> 0
		BEGIN
			INSERT INTO Detalle_Facturas (intFactura_ID, intRenglon, intRemisionNo) 
			SELECT @Factura_ID, intRenglon_ID, intRemision_ID FROM #Remisiones
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			UPDATE CtasXCobrar SET intFactura_ID = @Factura_ID 
			WHERE intRemisionNo IN (SELECT intRemision_ID FROM #Remisiones)
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			UPDATE Remisiones SET bitFacturado = 1
			WHERE intRemisionNo IN (SELECT intRemision_ID FROM #Remisiones)
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0 AND @TipoPago = 2
		BEGIN
			INSERT INTO Detalle_CtasXCobrar (intCtaXCobrar_ID, dtmFecha_Abono, mnyAbono)
			SELECT intCtaXCobrar_ID, @Fecha, CtasXCobrar.mnyImporte + Cab.mnyIVA FROM CtasXCobrar 
			INNER JOIN Cab_Ventas Cab ON CtasXCobrar.intFactura_ID = Cab.intFactura_ID
			WHERE CtasXCobrar.intRemisionNo IN (SELECT intRemision_ID FROM #Remisiones)
			SET @Status = @@ROWCOUNT
		
			IF @Status <> 0
			BEGIN
				UPDATE CtasXCobrar SET mnySaldo = 0, mnyAbonado = mnyImporte
				WHERE intRemisionNo IN (SELECT intRemision_ID FROM #Remisiones)
				SET @Status = @@ROWCOUNT
			END
		
			IF @Status <> 0
			BEGIN
				UPDATE Remisiones SET mnySaldo = 0
				WHERE intRemisionNo IN (SELECT intRemision_ID FROM #Remisiones)
				SET @Status = @@ROWCOUNT
			END

			IF @Status <> 0
			BEGIN
				UPDATE Facturas SET mnySaldo = 0
				WHERE intFactura_ID = @Factura_ID
				SET @Status = @@ROWCOUNT
			END
		END

		IF @Status <> 0
		BEGIN
			INSERT INTO #DetalleFactura
			SELECT  0 AS Orden,
				SUM(CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Cantidad ELSE Agrupacion.bitFacturacion_Cantidad END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Detalle_Remisiones.intCantidad ELSE 1 END) AS Cantidad,
				U.vchNombreCorto,
				NULL AS Codigo, 
				CASE WHEN intAgrupacion_ID IS NULL  OR (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) AND (Movimientos.intTipoVicera_ID = 0 OR Productos.intNoPiezas = 0) THEN Productos.vchDEscripcion ELSE Agrupacion.vchDescripcion END AS Producto, 
	--			CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Precio ELSE Agrupacion.bitFacturacion_Precio END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.mnyPrecio ELSE NULL END AS Precio,
				Detalle_Remisiones.mnyPrecio AS Precio,
	--			SUM(CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Peso ELSE Agrupacion.bitFacturacion_Peso END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.mnyPeso * CASE WHEN intCantidad_Multiplicar = 0 THEN 1 ELSE intCantidad_Multiplicar END ELSE 0 END) AS Peso,
				SUM(Detalle_Remisiones.mnyPeso * CASE WHEN intCantidad_Multiplicar = 0 THEN CASE WHEN Productos.chrClasificacion = 'K' THEN Detalle_Remisiones.intCantidad ELSE 1 END ELSE intCantidad_Multiplicar END) AS Peso,
				SUM(ISNULL(Detalle_Remisiones.mnyImporte,0)) AS Importe,
				Productos.vchCodigoBarras_Proveedor,
				COUNT(Detalle_Remisiones.intProducto_ID),
				Productos.vchClaveProdServ,
				Detalle_Remisiones.intProducto_ID
			FROM Facturas
			INNER JOIN Detalle_Facturas ON Facturas.intFactura_ID = Detalle_Facturas.intFactura_ID
			INNER JOIN Detalle_Remisiones ON Detalle_Facturas.intRemisionNo = Detalle_Remisiones.intRemisionNo
			INNER JOIN Movimientos ON Detalle_Remisiones.intMovimiento_ID = Movimientos.intMovimiento_ID
			INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
			LEFT OUTER JOIN Agrupacion_Productos_Facturacion ON Detalle_Remisiones.intProducto_ID = Agrupacion_Productos_Facturacion.intProducto_ID
			LEFT OUTER JOIN Productos ON Detalle_Remisiones.intProducto_ID = Productos.intProducto_ID
			LEFT OUTER JOIN Productos Agrupacion ON intAgrupacion_ID = Agrupacion.intProducto_ID
			LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID AND Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID 
			LEFT OUTER JOIN Unidad_Medida U ON Productos.intUnidad_ID = U.intUnidad_ID
			WHERE Facturas.intFactura_Id = @Factura_ID
			GROUP BY CASE WHEN intAgrupacion_ID IS NULL AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Detalle_Remisiones.intProducto_ID ELSE intAgrupacion_ID END, 
						CASE WHEN intAgrupacion_ID IS NULL  OR (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) AND (Movimientos.intTipoVicera_ID = 0 OR Productos.intNoPiezas = 0) THEN Productos.vchDEscripcion ELSE Agrupacion.vchDescripcion END, 
	--					CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Precio ELSE Agrupacion.bitFacturacion_Precio END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.mnyPrecio ELSE NULL END,
						Detalle_Remisiones.mnyPrecio,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchDireccion ELSE Facturar_Terceros.vchDireccion END,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCiudad ELSE Facturar_Terceros.vchCiudad END,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchEstado ELSE Facturar_Terceros.vchEstado END,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCodigoPostal ELSE Facturar_Terceros.vchCodigoPostal END,
						CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchTelefono ELSE Facturar_Terceros.vchTelefono END,
					   Facturas.intFactura_ID,
					   Facturas.dtmFecha,
					   Facturas.vchObservaciones,
					   Productos.vchCodigoBarras_Proveedor,
					   U.vchNombreCorto,
					   Productos.vchClaveProdServ,
					   Detalle_Remisiones.intProducto_ID

			UNION

			SELECT  1 AS Orden,
				1 AS Cantidad,
				'SX',
				NULL AS Codigo, 
				CASE WHEN SUM(ISNULL(Detalle_Remisiones.mnyFlete,0)) > 0 THEN 'FLETE' ELSE '' END AS Producto, 
				SUM(ISNULL(Detalle_Remisiones.mnyFlete,0)) AS Precio,
				1 AS Peso,
				SUM(ISNULL(Detalle_Remisiones.mnyFlete,0)) AS Importe,
				'' AS Codigo_Barras,
				0 AS No_Cajas,
				'78121603',
				'123456789'
			FROM Facturas
			INNER JOIN Detalle_Facturas ON Facturas.intFactura_ID = Detalle_Facturas.intFactura_ID
			INNER JOIN Detalle_Remisiones ON Detalle_Facturas.intRemisionNo = Detalle_Remisiones.intRemisionNo
			INNER JOIN Movimientos ON Detalle_Remisiones.intMovimiento_ID = Movimientos.intMovimiento_ID
			WHERE Facturas.intFactura_Id = @Factura_ID
			ORDER BY 1,4
			
			INSERT INTO Det_Ventas (intFactura_ID, intRenglon, mnyCantidad, vchUnidad, intCodigo, vchProducto, mnyPrecio, mnyPeso, mnyImporte, vchCodigo_Barras, intNo_Cajas, vchClaveProdServ, vchNoIdentificacion)
	--		SELECT @Factura_ID, intRenglon, mnyCantidad, vchUnidad, intCodigo, vchProducto, mnyPrecio, mnyPeso, ROUND((mnyPrecio * mnyPeso) / mnyCantidad,2),  mnyImporte FROM #DetalleFactura
			SELECT @Factura_ID, intRenglon, mnyPeso, vchUnidad, intCodigo, vchProducto, mnyPrecio, mnyPeso, mnyImporte, vchCodigo_Barras, intNo_Cajas, vchClaveProdServ, vchNoIdentificacion FROM #DetalleFactura
			WHERE mnyImporte > 0	
			
			SET @Status = @@ROWCOUNT

		END
			
		DROP TABLE #Remisiones
		DROP TABLE #DetalleFactura
	END

	IF @Status <> 0
	BEGIN
	--	COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
	--	ROLLBACK TRANSACTION
		RETURN 99
	END

END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarFacturaCancelada]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarFacturaCancelada]
@Cliente_ID             int,
@Factura_ID           int,
@TipoPago              int,
@Fecha                    datetime,--varchar(30),
@Motivo                    varchar(100)
AS

SET DATEFORMAT dmy

DECLARE @Status int

--BEGIN TRANSACTION

IF ISNULL((SELECT SUM(D.mnyAbono) FROM CtasXCobrar C INNER JOIN Detalle_CtasXCobrar D ON C.intCtaXCobrar_ID = D.intCtaXCobrar_ID WHERE C.intFactura_ID = @Factura_ID),0) > 0
	RETURN -9999

UPDATE Facturas SET dtmFecha_Cancelada = @Fecha, bitCancelada = 1, vchMotivo = @Motivo
WHERE intFactura_ID = @Factura_ID
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	IF ISNULL((SELECT COUNT(*) FROM Cab_Ventas WHERE intFactura_ID = @Factura_ID),0) > 0
	BEGIN
		UPDATE Cab_Ventas SET bitCancelada = 1
		WHERE intFactura_ID = @Factura_ID
		SET @Status = @@ROWCOUNT
	END
END

IF @Status <> 0
BEGIN
	UPDATE Remisiones SET bitFacturado = 0
	WHERE intRemisionNo IN (SELECT intRemisionNo FROM Detalle_Facturas WHERE intFactura_ID = @Factura_ID)
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0 AND @TipoPago = 2
BEGIN
	DELETE FROM Detalle_CtasXCobrar
	WHERE  intCtaXCobrar_ID IN (SELECT intCtaXCobrar_ID FROM CtasXCobrar WHERE intFactura_ID = @Factura_ID)
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		UPDATE CtasXCobrar SET mnySaldo = mnyImporte, mnyAbonado = 0
		WHERE intRemisionNo IN (SELECT intRemisionNo FROM Detalle_Facturas WHERE intFactura_ID = @Factura_ID)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		UPDATE Remisiones SET mnySaldo = mnyImporte
		WHERE intRemisionNo IN (SELECT intRemisionNo FROM Detalle_Facturas WHERE intFactura_ID = @Factura_ID)
		SET @Status = @@ROWCOUNT
	END
END

IF @Status <> 0 AND @Cliente_ID <> 1000
BEGIN
	UPDATE CtasXCobrar SET intFactura_ID = 0 
	WHERE intFactura_ID = @Factura_ID
	SET @Status = @@ROWCOUNT
END


IF @Status <> 0
BEGIN
	DELETE FROM Detalle_Facturas WHERE intFactura_ID = @Factura_ID
	SET @Status = @@ROWCOUNT
END
/*
IF @Status <> 0
BEGIN
	IF ISNULL((SELECT COUNT(*) FROM Det_Ventas WHERE intFactura_ID = @Factura_ID),0) > 0
	BEGIN
		DELETE FROM Det_Ventas WHERE intFactura_ID = @Factura_ID
		SET @Status = @@ROWCOUNT
	END
END
*/

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarFolio]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarFolio]
	@Folio_ID		int,
	@TipoDoc		char(1),
	@Serie			varchar(10),
	@FI				int,
	@FF				int,
	@NoAprob		int,
	@AnoAprob		int,
	@Operacion		char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	IF ISNULL((SELECT COUNT(*) FROM Control_Folios WHERE intFolio_ID <> @Folio_ID AND chrTipo_Documento = @TipoDoc AND (@FI BETWEEN intFolioInicial AND intFolioFinal OR @FF BETWEEN intFolioInicial AND intFolioFinal)),0) > 0
	BEGIN
		RETURN -99
	END

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intFolio_ID) FROM Control_Folios),0) + 1
		INSERT INTO Control_Folios (intFolio_ID, chrTipo_Documento, vchSerie, intFolioInicial, intFolioFinal, intNumero_Aprobacion, intAno_Aprobacion, intUltimo_Folio_Usado) VALUES (@ID, @TipoDoc, @Serie, @FI, @FF, @NoAprob, @AnoAprob, 0)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Control_Folios SET chrTipo_Documento = @TipoDoc, vchSerie = @Serie, intFolioInicial = @FI, intFolioFinal = @FF, intNumero_Aprobacion = @NoAprob, intAno_Aprobacion = @AnoAprob
		WHERE intFolio_ID = @Folio_ID
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarFolios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarFolios]
@Folio		int,
@TipoFolio	char(1)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Status_Folio int

BEGIN TRANSACTION

IF @TipoFolio = 'F'
BEGIN
	SET @Status_Folio = ISNULL((SELECT intFactura_ID FROM Facturas WHERE intFactura_ID = @Folio),0)

	IF @Status_Folio <> 0
		SET @Status = 0
	ELSE
	BEGIN
		UPDATE Control_Facturas SET intContador_Facturas = @Folio -1
		SET @Status = @@ROWCOUNT
	END
END
ELSE
BEGIN
	SET @Status_Folio = ISNULL((SELECT intNota_Credito_ID FROM Notas_Credito WHERE intNota_Credito_ID = @Folio),0)

	IF @Status_Folio <> 0
		SET @Status = 0
	ELSE
	BEGIN
		UPDATE Control_Notas_Credito SET intContador_Notas = @Folio - 1
		SET @Status = @@ROWCOUNT
	END
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarInvFisico]
@InvFisico_ID		int,
@Fecha		datetime,--varchar(30),
@Usuario		varchar(10)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Usuario_ID int

--BEGIN TRANSACTION

SET @Usuario_ID = (SELECT intUsuario_ID FROM Usuarios WHERE vchUsuario = @Usuario)

INSERT INTO Inventario_Fisico (intInventario_ID, dtmFecha, intUsuario_ID, bitAplicado) VALUES (@invFisico_ID, @Fecha, @Usuario_ID, 0)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	UPDATE Control_Inventarios SET intContador_Inventarios = @InvFisico_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarIva]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarIva]
	@Iva_ID		int,
	@IVA		money,
	@RET_IVA	money,
	@RET_ISR	money,
	@Activo		int,
	@Operacion	char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intIva_ID) FROM Ivas),0) + 1
		INSERT INTO Ivas (intIva_ID, mnyIVA, mnyRetIVA, mnyRetISR, bitActivo) VALUES (@ID, @IVA, @RET_IVA, @RET_ISR, @Activo)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Ivas SET mnyIVA = @IVA, mnyRetIVA = @RET_IVA, mnyRetISR = @RET_ISR, bitActivo = @Activo
				 WHERE intIva_ID = @Iva_ID
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarMatanza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarMatanza]
	@OrdenCompra_ID   int,
	@Productos                varchar(8000),
	@Fecha                       datetime--varchar(30)
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int, @Matanza int, @Movimiento_ID int, @Posicion int, @Producto varchar(10), @Cantidad varchar(10), @Caracter char(1), @Contador int, @Producto_Procesado bit, @Cantidad_Procesada bit, @Movimiento int, @Ganado_Pie int

	CREATE TABLE #Productos (
	intMovimiento_ID  int,
	intProducto_ID       int,
	intCantidad              int)

	SET @Posicion = 1
	SET @Contador = LEN(@Productos)
	SET @Producto_Procesado = 0
	SET @Cantidad_Procesada = 0
	SET @Producto = ' '
	SET @Cantidad = ' '
	SET @Movimiento = 1

	WHILE @Contador <> 0
	BEGIN

		SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

		IF @Producto_Procesado = 0
		BEGIN
			IF @Caracter <> '='
				SET @Producto = RTRIM(@Producto) + @Caracter
			ELSE
				SET @Producto_Procesado = 1
		END
		ELSE
			IF @Cantidad_Procesada = 0 AND @Producto_Procesado = 1
			BEGIN
				IF @Caracter <> ','
					SET @Cantidad = RTRIM(@Cantidad) + @Caracter
				ELSE
					SET @Cantidad_Procesada = 1
			END

		IF @Cantidad_Procesada = 1 AND @Producto_Procesado = 1
		BEGIN
			INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad) VALUES (@Movimiento, @Producto, @Cantidad)
			SET @Producto_Procesado = 0
			SET @Cantidad_Procesada = 0
			SET @Producto = ' '
			SET @Cantidad = ' '
			SET @Movimiento = @Movimiento + 1
		END

		SET @Posicion = @Posicion + 1
		SET @Contador = @Contador - 1

	END

	BEGIN TRANSACTION

	UPDATE Existencias SET intExistencia = intExistencia - #Productos.intCantidad
	FROM Existencias
	INNER JOIN #Productos ON Existencias.intProducto_ID = #Productos.intProducto_ID
	WHERE intOrdenCompra_ID = @OrdenCompra_ID 
		   AND intAlmacen_ID = 1

	IF @Status <> 0
	BEGIN
		DELETE FROM Existencias
					WHERE intOrdenCompra_ID = @OrdenCompra_ID 
						   AND intAlmacen_ID = 1 
						   AND intExistencia = 0
						   AND intProducto_ID IN (SELECT intProducto_ID FROM #Productos)

		SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)
		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, intOrdenCompra_ID, intTipo_Movimiento) 
		SELECT intMovimiento_ID + @Movimiento_ID , @Fecha, 'S', 1, intProducto_ID, intCantidad, @OrdenCompra_ID, 205 FROM #Productos
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		SET @Ganado_Pie = ISNULL((SELECT COUNT(*) AS No_Productos FROM Relacion_Matanza WHERE intProducto_Pie IN (SELECT intProducto_ID FROM #Productos)),0)

		IF @Ganado_Pie <> 0
		BEGIN
			SET @Matanza = ISNULL((SELECT MAX(intMatanza_ID) FROM Matanzas),0)
			INSERT INTO Matanzas (intMatanza_ID, dtmFecha, intProducto_ID, intCantidad, intOrdenCompra_ID) 
			SELECT @Matanza + intMovimiento_ID, @Fecha, intProducto_Canal, intCantidad * 2, @OrdenCompra_ID FROM #Productos
			INNER JOIN Relacion_Matanza ON intProducto_ID = intProducto_Pie
			SET @Status = @@ROWCOUNT
		END
		ELSE
		BEGIN
			SET @Matanza = ISNULL((SELECT MAX(intMatanza_ID) FROM Matanzas),0)
			INSERT INTO Matanzas (intMatanza_ID, dtmFecha, intProducto_ID, intCantidad, intOrdenCompra_ID) 
			SELECT @Matanza + intMovimiento_ID, @Fecha, intProducto_ID, intCantidad, @OrdenCompra_ID FROM #Productos
			SET @Status = @@ROWCOUNT
		END
	END

	DROP TABLE #Productos

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarNota_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ActualizarNota_Credito]
@Nota_Credito_ID  int,
@Factura_ID       int,
@Observaciones    varchar(100),
@Fecha            datetime,
@Importe	      money,
@Cliente_Tercero  int,
@Remisiones	      varchar(8000),
@TipoPago		  varchar(10),
@ClaveProdServ	  varchar(50),
@NoIdentificacion varchar(50)	
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Nota_Tmp int, @Cliente_ID int, @Xml xml

CREATE TABLE #Remisiones (
intRenglon			int,
intRemisionNo		int,
mnyImporte          money,
vchClaveProdServ	varchar(50),
vchNoIdentificacion varchar(20))

SET @xml = CONVERT(XML,@Remisiones)

INSERT INTO #Remisiones (intRenglon, intRemisionNo, mnyImporte, vchClaveProdServ, vchNoIdentificacion)
SELECT Info.value('(Renglon/text())[1]','VARCHAR(100)') AS Ren,
		Info.value('(Remision_ID/text())[1]','VARCHAR(100)') AS ID,
		Info.value('(Importe/text())[1]','VARCHAR(100)') AS Importe,
		Info.value('(ClaveProdServ/text())[1]','VARCHAR(100)') AS ClaveProdServ,
		Info.value('(NoIdentificacion/text())[1]','VARCHAR(100)') AS NoIdentificacion
FROM @Xml.nodes('/Remisiones/Remision') AS TEMPTABLE(Info)

SET @Nota_Tmp = (SELECT intContador_Notas + 1 FROM Control_Notas_Credito)

IF @Nota_Credito_ID <> @Nota_Tmp
	RETURN 99
ELSE
BEGIN
--	BEGIN TRANSACTION
	
	UPDATE Control_Notas_Credito SET intContador_Notas = @Nota_Credito_ID
	SET @Status = @@ROWCOUNT
	
	IF @Status <> 0
	BEGIN
		INSERT INTO Notas_Credito (intNota_Credito_ID, dtmFecha, intFactura_ID, mnyImporte, vchObservaciones, intCliente_Tercero) VALUES (@Nota_Credito_ID, @Fecha, @Factura_ID, @Importe, @Observaciones, @Cliente_Tercero)
		SET @Status = @@ROWCOUNT
		
		IF @Status <> 0
		BEGIN

			SET @Cliente_ID = (SELECT intCliente_ID FROM Facturas WHERE intFactura_ID = @Factura_ID)

			INSERT INTO Cab_Notas_Credito (intNota_Credito_ID, dtmFecha, dtmFecha_Registro, intCliente_ID, vchTipo_Pago, mnySubTotal, mnyTotal, bitCancelada) 
			SELECT @Nota_Credito_ID, @Fecha, GETDATE(), @Cliente_ID, @TipoPago, @Importe, @Importe, 0
			SET @Status = @@ROWCOUNT

			IF @Status <> 0 AND @Remisiones = ''
			BEGIN
				INSERT INTO Det_Notas_Credito (intNota_Credito_ID, intRenglon, intFactura_ID, vchNotas, mnyImporte, vchClaveProdServ, vchNoIdentificacion, mnyPIVA, mnyPRetISR, mnyPRetIVA, mnyIVA, mnyRetISR, mnyRetIVA, vchUnidad)
				VALUES (@Nota_Credito_ID, 1, @Factura_ID, @Observaciones, @Importe, @ClaveProdServ, @NoIdentificacion,0,0,0,0,0,0,NULL)
				SET @Status = @@ROWCOUNT
			END

		END		
	END

	IF @Status <> 0 AND @Remisiones <> ''
	BEGIN

		INSERT INTO Detalle_Notas_Credito (intNota_Credito_ID, intRemisionNo, mnyImporte)
		SELECT @Nota_Credito_ID, intRemisionNo, mnyImporte FROM #Remisiones
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			INSERT INTO Det_Notas_Credito (intNota_Credito_ID, intRenglon, intFactura_ID, intRemisionNo, vchNotas, mnyImporte, vchClaveProdServ, vchNoIdentificacion, mnyPIVA, mnyPRetISR, mnyPRetIVA, mnyIVA, mnyRetISR, mnyRetIVA, vchUnidad)
			SELECT @Nota_Credito_ID, 1, 0, intRemisionNo, @Observaciones, mnyImporte, vchClaveProdServ, vchNoIdentificacion,0,0,0,0,0,0, NULL FROM #Remisiones
			SET @Status = @@ROWCOUNT
		END
	END
END

DROP TABLE #Remisiones

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarNotaCreditoCancelada]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarNotaCreditoCancelada]
@Nota_Credito_ID  int,
@Fecha                    datetime,--varchar(30),
@Motivo                    varchar(100)
AS

SET DATEFORMAT dmy

DECLARE @Status int

--BEGIN TRANSACTION

UPDATE Notas_Credito SET dtmFecha_Cancelacion = @Fecha, bitCancelada = 1, vchMotivo = @Motivo
WHERE intNota_Credito_ID = @Nota_Credito_ID
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	UPDATE Cab_Notas_Credito SET bitCancelada = 1
	WHERE intNota_Credito_ID = @Nota_Credito_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0 
	IF ISNULL((SELECT COUNT(*) FROM Detalle_Notas_Credito WHERE intNota_Credito_ID = @Nota_Credito_ID),0) > 0 
		IF (SELECT SUM(CASE WHEN bitAplicada = 1 THEN 1 ELSE 0 END) FROM Detalle_Notas_Credito WHERE intNota_Credito_ID = @Nota_Credito_ID) > 0
			SET @Status = 0
		ELSE			
		BEGIN
			UPDATE Detalle_Notas_Credito SET bitCancelada = 1
			WHERE intNota_Credito_ID = @Nota_Credito_ID
			SET @Status = @@ROWCOUNT
		END

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarOrdenCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarOrdenCompra]
@OrdenCompra_ID    int,
@Proveedor_ID           int,
@Observacioines        varchar(100),
@Fecha                        datetime,--varchar(30),
@Productos                 varchar(8000),
@Importe                      money,
@Peso                           money,
@Operacion_Gral        char(1)
AS

SET DATEFORMAT dmy

DECLARE @Status int,@Posicion int, @Caracter char(1), @Contador int, @Movimiento int, @Producto varchar(10), @Cantidad varchar(10), @Peso_Producto varchar(10), @Descuento_Producto varchar(10), @Importe_Producto varchar(10), @Producto_Procesado bit, @Cantidad_Procesada bit, @Peso_Procesado bit, @Descuento_Procesado bit, @Importe_Procesado bit, @CtaXPagar int, @Operacion char(10), @Operacion_Procesada bit

CREATE TABLE #Productos (
intMovimiento_ID  int,
intProducto_ID      int,
intCantidad             int,
mnyPeso                 money,
mnyDescuento      money,
mnyPrecio               money,
mnyImporte            money,
chrOperacion         char(1),
intRenglon              int)

SET @Posicion = 1
SET @Contador = LEN(@Productos)
SET @Producto_Procesado = 0
SET @Cantidad_Procesada = 0
SET @Peso_Procesado = 0
SET @Descuento_Procesado = 0
SET @Importe_Procesado = 0
SET @Operacion_Procesada = 0
SET @Producto = ' '
SET @Cantidad = ' '
SET @Peso_Producto = ' '
SET @Descuento_Producto = ' '
SET @Importe_Producto = ' '
SET @Operacion = ''
SET @Movimiento = 1

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

	IF @Producto_Procesado = 0
	BEGIN
		IF @Caracter <> '+'
			SET @Producto = RTRIM(@Producto) + @Caracter
		ELSE
			SET @Producto_Procesado = 1
	END
	
	IF @Cantidad_Procesada = 0 AND @Producto_Procesado = 1 AND @Caracter <> '+'
	BEGIN
		IF @Caracter <> '-'
			SET @Cantidad = RTRIM(@Cantidad) + @Caracter
		ELSE
			SET @Cantidad_Procesada = 1
	END

	IF @Peso_Procesado = 0 AND @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Caracter <> '-'
	BEGIN
		IF @Caracter <> '%'
			SET @Peso_Producto = RTRIM(@Peso_Producto) + @Caracter
		ELSE
			SET @Peso_Procesado = 1
	END

	IF @Descuento_Procesado = 0 AND @Peso_Procesado = 1 AND @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Caracter <> '%'
	BEGIN
		IF @Caracter <> '='
			SET @Descuento_Producto = RTRIM(@Descuento_Producto) + @Caracter
		ELSE
			SET @Descuento_Procesado = 1
	END

	IF @Importe_Procesado = 0 AND @Descuento_Procesado = 1 AND @Peso_Procesado = 1 AND @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Caracter <> '='
	BEGIN
		IF @Caracter <> '!'
			SET @Importe_Producto = RTRIM(@Importe_Producto) + @Caracter
		ELSE
			SET @Importe_Procesado = 1
	END

	IF @Operacion_Procesada = 0 AND @Importe_Procesado = 1 AND @Descuento_Procesado = 1 AND @Peso_Procesado = 1 AND @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Caracter <> '!'
	BEGIN
		IF @Caracter <> ','
			SET @Operacion = RTRIM(@Operacion) + @Caracter
		ELSE
			SET @Operacion_Procesada = 1
	END

	IF @Cantidad_Procesada = 1 AND @Producto_Procesado = 1 AND @Peso_Procesado = 1 AND @Importe_Procesado = 1 AND @Operacion_Procesada = 1
	BEGIN
		INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, mnyDescuento, mnyPrecio, mnyImporte, chrOperacion, intRenglon) VALUES (@Movimiento, @Producto, REPLACE(@Cantidad,',',''), CONVERT(MONEY,@Peso_Producto), CONVERT(MONEY,@Descuento_Producto), CONVERT(MONEY,@Importe_Producto), ROUND((CONVERT(MONEY,@Peso_Producto) * (1 - (CONVERT(MONEY,@Descuento_Producto) / 100))) * CONVERT(MONEY,@Importe_Producto),2), SUBSTRING(@Operacion,1,1), SUBSTRING(@Operacion,2,10))
		SET @Producto_Procesado = 0
		SET @Cantidad_Procesada = 0
		SET @Peso_Procesado = 0
		SET @Descuento_Procesado = 0		SET @Importe_Procesado = 0
		SET @Operacion_Procesada = 0
		SET @Producto = ' '
		SET @Cantidad = ' '
		SET @Peso_Producto = ' '
		SET @Descuento_Producto = ' '
		SET @Importe_Producto = ' '
		SET @Operacion = ''
		SET @Movimiento = @Movimiento + 1
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

BEGIN TRANSACTION

IF @Operacion_Gral = 'I'
BEGIN
	INSERT INTO Orden_Compra (intOrdenCompra_ID, dtmFecha, intProveedor_ID, mnyPeso, mnyPrecio) VALUES (@OrdenCompra_ID, @Fecha, @Proveedor_ID, @Peso, @Importe)
	SET @Status = @@ROWCOUNT
	
	IF @Status <> 0
	BEGIN
		INSERT INTO Detalle_Orden_Compra (intOrdenCompra_ID, intRenglon, intProducto_ID, intCantidad, mnyPeso, mnyDescuento, mnyPrecio, mnyImporte) 
	                        SELECT @OrdenCompra_ID, intRenglon, intProducto_ID, intCantidad, mnyPeso, mnyDescuento, mnyPrecio, mnyImporte FROM #Productos WHERE chrOperacion = 'I'
		SET @Status = @@ROWCOUNT
	END
	
	IF @Status <> 0
	BEGIN
		SET @CtaXPagar = ISNULL((SELECT MAX(intCtaXPagar_ID) FROM CtasXPagar),0) + 1
		INSERT INTO CtasXPagar (intCtaXPagar_ID, dtmFecha, intProveedor_ID, mnyImporte, mnySaldo, intOrdenCompra_ID) VALUES (@CtaXPagar, @Fecha, @Proveedor_ID, @Importe, @Importe, @OrdenCompra_ID)
		SET @Status = @@ROWCOUNT
	END
	
	IF @Status <> 0
	BEGIN
		UPDATE Control_Ordenes_Compra SET intContador_Ordenes = @OrdenCompra_ID
		SET @Status = @@ROWCOUNT
	END
END
ELSE
BEGIN
	UPDATE Orden_Compra SET mnyPeso = @Peso, mnyPrecio = @Importe
	WHERE intOrdenCompra_ID = @OrdenCompra_ID
	SET @Status = @@ROWCOUNT

	IF @Status <> 0 AND (SELECT COUNT(*) FROM #Productos WHERE chrOperacion = 'U')  > 0
	BEGIN
		UPDATE Detalle_Orden_Compra SET intCantidad = #Productos.intCantidad, mnyPeso = #Productos.mnyPeso, mnyDescuento = #Productos.mnyDescuento, mnyPrecio = #Productos.mnyPrecio, mnyImporte = #Productos.mnyImporte
                            FROM Detalle_Orden_Compra
                            INNER JOIN #Productos ON Detalle_Orden_Compra.intProducto_ID = #Productos.intProducto_ID AND chrOperacion = 'U' AND Detalle_Orden_Compra.intRenglon = #Productos.intRenglon
	              WHERE intOrdenCompra_ID = @OrdenCompra_ID
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0 AND (SELECT COUNT(*) FROM #Productos WHERE chrOperacion = 'D')  > 0
	BEGIN
		DELETE FROM Detalle_Orden_Compra
		WHERE intOrdenCompra_ID = @OrdenCompra_ID 
		      AND  intProducto_ID IN (SELECT intProducto_ID FROM #Productos WHERE chrOperacion = 'D')
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0 AND (SELECT COUNT(*) FROM #Productos WHERE chrOperacion = 'I')  > 0
	BEGIN
		INSERT INTO Detalle_Orden_Compra (intOrdenCompra_ID, intRenglon, intProducto_ID, intCantidad, mnyPeso, mnyDescuento, mnyPrecio, mnyImporte) 
	                        SELECT @OrdenCompra_ID, intRenglon, intProducto_ID, intCantidad, mnyPeso, mnyDescuento, mnyPrecio, mnyImporte FROM #Productos WHERE chrOperacion = 'I'
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		UPDATE CtasXPagar SET mnySaldo = @Importe - mnyAbonado, mnyImporte = @Importe
	                WHERE intOrdenCompra_ID = @OrdenCompra_ID
		SET @Status = @@ROWCOUNT
	END	
END

DROP TABLE #Productos

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarPago]
	@Cliente_ID		int,
	@Pago_ID		int,
	@MontoPagado	decimal(18,2),
	@ClaveProdServ	varchar(10),
	@Notas			varchar(200),
	@Facturas		varchar(8000)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Pago_ID <> ISNULL((SELECT intContador_Pagos + 1 FROM Control_Pagos),0) 
		GOTO ERROR

	DECLARE @Status int, @Xml xml

	SET @ClaveProdServ = '84111506'
	SET @Xml = CONVERT(XML,@Facturas)

	CREATE TABLE #Facturas (
	intRenglon			int,
	intFactura_ID		int,
	vchNoIdentificacion	varchar(50),
	vchMetodoPago		varchar(50),
	mnySaldoAnt			decimal(18,2),
	mnyImpPagado		decimal(18,2),
	mnySaldo			decimal(18,2))

------------  Obtener datos de Facturas

	INSERT INTO #Facturas (intRenglon, intFactura_ID, vchNoIdentificacion, vchMetodoPago, mnySaldoAnt, mnyImpPagado, mnySaldo)
	SELECT Info.value('(Renglon/text())[1]','VARCHAR(100)') AS Ren,
			Info.value('(Factura_ID/text())[1]','VARCHAR(100)') AS ID,
			Info.value('(UUID/text())[1]','VARCHAR(100)') AS UUID,
			Info.value('(MetodoPago/text())[1]','VARCHAR(100)') AS MetodoPago,
			Info.value('(SaldoAnterior/text())[1]','VARCHAR(100)') AS SaldoAnt,
			Info.value('(ImportePagado/text())[1]','VARCHAR(100)') AS ImpPagado,
			Info.value('(Saldo/text())[1]','VARCHAR(100)') AS Saldo
	FROM @Xml.nodes('/Facturas/Factura') AS TEMPTABLE(Info)

	UPDATE Control_Pagos SET intContador_Pagos = intContador_Pagos + 1 

	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Cab_Pagos (intPago_ID, dtmFecha_Registro, dtmFecha_Pago, vchClaveProdServ, mnyCantidad, vchDescripcion, vchUnidad, mnyPrecio, mnyImporte, mnyTotal, vchNotas)
		VALUES (@Pago_ID, GETDATE(), GETDATE(), @ClaveProdServ, 1, 'Pago', 'ACT', 0, 0, @MontoPagado, @Notas)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		INSERT INTO Det_Pagos (intPago_ID, intFactura_ID, intParcialidad, mnySaldo_Anterior, mnyMonto_Pagado, mnySaldo_Pendiente)
		SELECT @Pago_ID, F.intFactura_ID, ISNULL(P.intParcialidad + 1,1), F.mnySaldoAnt, F.mnyImpPagado, F.mnySaldo  FROM #Facturas F
		LEFT OUTER JOIN vUltimaParcialidadXFactura P ON F.intFactura_ID = P.intFactura_ID

		SET @Status = @@ROWCOUNT

	END

	IF @Status <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 99
	END

	DROP TABLE #Facturas

ERROR:

	RETURN 99

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarParametros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarParametros]
	@RazonSocial	varchar(80),
	@RFC			varchar(20),
	@Direccion		varchar(60),
	@NoInterior		varchar(10),
	@NoExterior		varchar(10),
	@CodigoPostal	varchar(10),
	@Colonia		varchar(50),
	@Ciudad			varchar(20),
	@Estado			varchar(20),
	@Pais			varchar(20),
	@Telefono		varchar(40),
	@Representante	varchar(60)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int

	BEGIN TRANSACTION

	IF ISNULL((SELECT COUNT(*) FROM Parametros),0) = 0
	BEGIN
		INSERT INTO Parametros (vchRazonSocial, vchDireccion, vchNoInterior, vchNoExterior, vchColonia, vchCiudad, vchEstado, vchPais, vchCodigoPostal, vchTelefono, vchRFC, vchRepresentante_Legal) VALUES (@RazonSocial, @Direccion, @NoInterior, @NoExterior, @Colonia, @Ciudad, @Estado, @Pais, @CodigoPostal, @Telefono, @RFC, @Representante)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Parametros SET vchNoInterior = @NoInterior, vchNoExterior = @NoExterior, vchColonia =  @Colonia, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchRFC = @RFC, vchRepresentante_Legal = @Representante, vchPais = @Pais
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarParametros_Old]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarParametros_Old]
@Representante      varchar(50) ,
@Direccion                varchar(60),
@Colonia                    varchar(20),
@Ciudad                     varchar(20),
@Estado                     varchar(20),
@CodigoPostal        varchar(10),
@Telefono                 varchar(30) ,
@Fax                           varchar(30) ,
@RFC                          varchar(20) 
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

UPDATE Parametros SET  vchRepresentante_Legal = @Representante, vchDireccion = @Direccion, vchColonia = @Colonia, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchFax = @Fax, vchRFC = @RFC
WHERE vchRazonSocial <> ''

SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarProducto]
@Producto_ID		int,
@Descripcion		varchar(2000),
@TipoProducto_ID	int,
@Unidad_ID			int,
@PrecioVta			money,
@Clasificacion		char(1),
@NoPiezas			int,
@IncViceras			int,
@SubProductos		int,
@Cantidad			int,
@Precio				int,
@Peso				int,
@Activo				int,
@Operacion			char(1),
@CostoVta			money,
@NoAplicar_IF		int,
@Codigo_Barras_Prov	varchar(20),
@ClaveProdServ		varchar(50),
@Unidad				varchar(20),
@NoIdentificacion	varchar(50)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN

	If @TipoProducto_ID <> 7
		SET @ID = ISNULL((SELECT MAX(intProducto_ID) FROM Productos WHERE intProducto_ID < 1000),0) + 1
	ELSE
		SET @ID = ISNULL((SELECT MAX(intProducto_ID) FROM Productos WHERE intProducto_ID >= 1000),1000) + 1
		
	INSERT INTO Productos (intProducto_ID, vchDescripcion, intTipoProducto_ID, intUnidad_ID, mnyPrecio, chrClasificacion, intNoPiezas, bitIncluyeViceras, bitGenerar_SubProductos, bitFacturacion_Cantidad, bitFacturacion_Precio, bitFacturacion_Peso, bitActivo, mnyCostoVenta, bitNoAplicar_InvFisico, vchCodigoBarras_Proveedor, vchClaveProdServ, vchUnidad, vchNoIdentificacion) VALUES (@ID, @Descripcion, @TipoProducto_ID, @Unidad_ID, @PrecioVta, @Clasificacion, @NoPiezas, @IncViceras, @SubProductos, @Cantidad, @Precio, @Peso, @Activo, @CostoVta, @NoAplicar_IF,@Codigo_Barras_Prov, @ClaveProdServ, @Unidad, @NoIdentificacion)
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Juarez.dbo.Productos (intProducto_ID, vchDescripcion, intTipoProducto_ID, intUnidad_ID, mnyPrecio, chrClasificacion, intNoPiezas, bitIncluyeViceras, bitGenerar_SubProductos, bitFacturacion_Cantidad, bitFacturacion_Precio, bitFacturacion_Peso, bitActivo, mnyCostoVenta, bitNoAplicar_InvFisico, vchCodigoBarras_Proveedor, vchClaveProdServ, vchUnidad, vchNoIdentificacion) VALUES (@ID, @Descripcion, @TipoProducto_ID, @Unidad_ID, @PrecioVta, @Clasificacion, @NoPiezas, @IncViceras, @SubProductos, @Cantidad, @Precio, @Peso, @Activo, @CostoVta, @NoAplicar_IF,@Codigo_Barras_Prov, @ClaveProdServ, @Unidad, @NoIdentificacion)
		SET @Status = @@ROWCOUNT
	END
	
END
ELSE
BEGIN
	UPDATE Productos SET vchDescripcion = @Descripcion, intTipoProducto_ID = @TipoProducto_ID, intUnidad_ID = @Unidad_ID, mnyPrecio = @PrecioVta, bitIncluyeViceras = @IncViceras, bitGenerar_SubProductos = @SubProductos, bitFacturacion_Cantidad = @Cantidad, bitFacturacion_Precio = @Precio, bitFacturacion_Peso = @Peso, bitActivo = @Activo, chrClasificacion = @Clasificacion, intNoPiezas = @NoPiezas, mnyCostoVenta = @CostoVta, bitNoAplicar_InvFisico = @NoAplicar_IF, vchCodigoBarras_Proveedor = @Codigo_Barras_Prov, vchClaveProdServ = @ClaveProdServ, vchUnidad = @Unidad, vchNoIdentificacion = @NoIdentificacion
    WHERE intProducto_ID = @Producto_ID
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		UPDATE Juarez.dbo.Productos SET vchDescripcion = @Descripcion, intTipoProducto_ID = @TipoProducto_ID, intUnidad_ID = @Unidad_ID, mnyPrecio = @PrecioVta, bitIncluyeViceras = @IncViceras, bitGenerar_SubProductos = @SubProductos, bitFacturacion_Cantidad = @Cantidad, bitFacturacion_Precio = @Precio, bitFacturacion_Peso = @Peso, bitActivo = @Activo, chrClasificacion = @Clasificacion, intNoPiezas = @NoPiezas, mnyCostoVenta = @CostoVta, bitNoAplicar_InvFisico = @NoAplicar_IF, vchCodigoBarras_Proveedor = @Codigo_Barras_Prov, vchClaveProdServ = @ClaveProdServ, vchUnidad = @Unidad, vchNoIdentificacion = @NoIdentificacion
		WHERE intProducto_ID = @Producto_ID
		SET @Status = @@ROWCOUNT
	END

END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarProductoAgrupado]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarProductoAgrupado]
@Agrupacion_ID   int,
@Producto_ID        int
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

INSERT INTO Agrupacion_Productos_Facturacion (intAgrupacion_ID, intProducto_ID) VALUES (@Agrupacion_ID, @Producto_ID)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarProductoCompuesto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarProductoCompuesto]
@Compuesto_ID   int,
@Producto_ID        int
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

INSERT INTO Productos_Compuestos (intProductoCompuesto_ID, intProducto_ID, intCantidad) VALUES (@Compuesto_ID, @Producto_ID, 1)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarProductoDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarProductoDeshuese]
@Deshuese_ID      int,
@Producto_ID        int
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

INSERT INTO Relacion_Deshuese (intProducto_ID, intProducto_Deshuese) VALUES (@Deshuese_ID, @Producto_ID)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarProveedor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarProveedor]
@Proveedor_ID       int,
@RazonSocial         varchar(80) ,
@Nombre                  varchar(50) ,
@ApellidoPaterno  varchar(50) ,
@ApellidoMaterno  varchar(50) ,
@Direccion                varchar(60),
@Ciudad                     varchar(20),
@Estado                     varchar(20),
@CodigoPostal        varchar(10),
@Telefono                 varchar(30) ,
@RFC                          varchar(20) ,
@Activo                       int ,
@Operacion              char(1)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intProveedor_ID) FROM Proveedores),0) + 1
	INSERT INTO Proveedores (intProveedor_ID, vchRazonSocial, vchNombre, vchApellidoPaterno, vchApellidoMaterno, vchDireccion, vchCiudad, vchEstado, vchCodigoPostal, vchTelefono, vchRFC, bitActivo) VALUES (@ID, @RazonSocial, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Direccion, @Ciudad, @Estado, @CodigoPostal, @Telefono, @RFC, @Activo)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Proveedores SET  vchRazonSocial = @RazonSocial, vchNombre = @Nombre, vchApellidoPaterno = @ApellidoPaterno, vchApellidoMaterno =  @ApellidoMaterno, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchRFC = @RFC, bitActivo = @Activo
                WHERE intProveedor_ID = @Proveedor_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRegimenFiscal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarRegimenFiscal]
	@Regimen_ID		int,
	@Nombre			varchar(200)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int

	BEGIN TRANSACTION

	DELETE FROM Regimen_Fiscales

	IF ISNULL((SELECT MAX(intRegimen_ID) FROM Regimen_Fiscales),0) = 0
	BEGIN
		INSERT INTO Regimen_Fiscales (intRegimen_ID, vchNombre) VALUES (@Regimen_ID, @Nombre)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Regimen_Fiscales SET vchNombre = @Nombre
		WHERE intRegimen_ID = @Regimen_ID
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRelacionProductos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarRelacionProductos]
@Pie_ID          int,
@Canal_ID     int
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

INSERT INTO Relacion_Matanza (intProducto_Pie, intProducto_Canal) VALUES (@Pie_ID, @Canal_ID)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRemisionCancelada]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarRemisionCancelada]
@Consecutivo_ID   int,
@RemisionNo          int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Nota_Tmp int

--BEGIN TRANSACTION

INSERT INTO Remisiones_Canceladas (intConsecutivo, intRemisionNo) VALUES (@Consecutivo_ID, @RemisionNo)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
--	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarRepartidor]
@Repartidor_ID       int,
@Nombre                  varchar(50) ,
@ApellidoPaterno  varchar(50) ,
@ApellidoMaterno  varchar(50) ,
@Activo                       int ,
@Operacion              char(1)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intRepartidor_ID) FROM Repartidores),0) + 1
	INSERT INTO Repartidores (intRepartidor_ID,  vchNombre, vchApellidoPaterno, vchApellidoMaterno, bitActivo) VALUES (@ID, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Activo)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Repartidores SET  vchNombre = @Nombre, vchApellidoPaterno = @ApellidoPaterno, vchApellidoMaterno =  @ApellidoMaterno, bitActivo = @Activo
                WHERE intRepartidor_ID = @Repartidor_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarSalidaDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarSalidaDeshuese]
	@Producto_ID		int,
	@NoCanal            bigint,
	@Peso	            money,
	@OrdenCompra_ID     int,
	@Matanza_ID         int,
	@Identificador      int,
	@Fecha              datetime,--varchar(30)
	@Almacen_ID			int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Movimiento_ID int

	--BEGIN TRANSACTION

	UPDATE Existencias SET intExistencia = intExistencia - CASE WHEN @Peso <> 0 THEN 1 ELSE intExistencia END
			WHERE intIdentificador_Unico = @Identificador
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		DELETE FROM Existencias
		WHERE intIdentificador_Unico = @Identificador
						   AND intExistencia = 0

		SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0) + 1
		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipo_Movimiento) 
							VALUES (@Movimiento_ID, @Fecha, 'S', @Almacen_ID, @Producto_ID, 1, @Peso, 0, 0, @NoCanal, @OrdenCompra_ID, 0, -999, @Matanza_ID, 0, 201)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
	---	COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
	--	ROLLBACK TRANSACTION
		RETURN 99
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarSalidaInventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarSalidaInventario]
	@OrdenMatanza_ID    int,
	@OrdenCompra_ID		int,
	@Producto_ID        int,
	@NoCanal            int,
	@TipoVicera         int,
	@Cliente_ID         int,
	@RemisionNo         int,
	@Cantidad           int,
	@Precio             money,
	@Peso               money,
	@Flete              money,
	@EsVicera           bit,
	@Clasificacion      char(1),
	@Fecha              datetime, --varchar(30),
	@Productos          varchar(8000),
	@SinPeso	        int,
	@Productos_Sel      int,
	@Orden_Compra		varchar(20),
	@Almacen_ID			int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Movimiento_ID int, @CxC int, @Posicion int, @Cantidad_Tmp varchar(10), @Matanza_Tmp varchar(10), @Peso_Tmp varchar(10), @Canal_Tmp varchar(10), @Orden_Tmp varchar(10), @Caracter char(1), @Contador int, @Cantidad_Procesada bit, @Movimiento int, @Importe money, @Status_Vicera int, @Peso_Procesado int, @Canal_Procesado int, @Orden_Procesada int, @Matanza_Procesada int, @Primera_Vez bit, @Cantidad_Definitiva int, @Identificador_Procesado int, @Identificador_Tmp varchar(10), @Multiplicar int, @Movs_Viceras int, @Vicera_Completa bit, @No_Viceras int
	DECLARE @Movimiento_ID_Cur int, @Producto_ID_Cur int, @Cantidad_Cur int, @Peso_Cur money, @NoCanal_Cur bigint, @OrdenCompra_ID_Cur int, @Matanza_ID_Cur int, @Importe_Cur money, @Identificador_Cur int, @Cant_Multiplicar_Cur int

	CREATE TABLE #Productos (
	intMovimiento_ID      	int,
	intProducto_ID          	int,
	intCantidad                 	int,
	mnyPeso                     	money,
	intNoCanal                  	bigint,
	intOrdenCompra_ID  	int,
	intMatanza_ID           	int,
	intIdentificador           	int,
	mnyImporte                     money,
	intCantidad_Multiplicar  int)

	SET @Primera_Vez = 1
	SET @Posicion = 1
	SET @Contador = LEN(@Productos)
	SET @Cantidad_Procesada = 0
	SET @Peso_Procesado = 0
	SET @Canal_Procesado = 0
	SET @Orden_Procesada = 0
	SET @Matanza_Procesada = 0
	SET @Identificador_Procesado = 0
	SET @Cantidad_Tmp = ' '
	SET @Peso_Tmp = ' '
	SET @Canal_Tmp = ' '
	SET @Orden_Tmp = ' '
	SET @Matanza_Tmp = ' '
	SET @Identificador_Tmp = ' '
	SET @Movimiento = 1

	WHILE @Contador <> 0
	BEGIN

		SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

		IF @Cantidad_Procesada = 0
		BEGIN
			IF @Caracter <> '*'
				SET @Cantidad_Tmp = RTRIM(@Cantidad_Tmp) + @Caracter
			ELSE
				SET @Cantidad_Procesada = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 0 AND @Caracter <> '*'
		BEGIN
			IF @Caracter <> '-'
				SET @Peso_Tmp = RTRIM(@Peso_Tmp) + @Caracter
			ELSE
				SET @Peso_Procesado = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 0 AND @Caracter <> '-'
		BEGIN
			IF @Caracter <> '+'
				SET @Canal_Tmp = RTRIM(@Canal_Tmp) + @Caracter
			ELSE
				SET @Canal_Procesado = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 0 AND @Caracter <> '+'
		BEGIN
			IF @Caracter <> '#'
				SET @Orden_Tmp = RTRIM(@Orden_Tmp) + @Caracter
			ELSE
				SET @Orden_Procesada = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Matanza_Procesada = 0 AND @Caracter <> '#'
		BEGIN
			IF @Caracter <> '%'
				SET @Matanza_Tmp = RTRIM(@Matanza_Tmp) + @Caracter
			ELSE
				SET @Matanza_Procesada = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Matanza_Procesada = 1 AND @Identificador_Procesado = 0 AND @Caracter <> '%'
		BEGIN
			IF @Caracter <> ','
				SET @Identificador_Tmp = RTRIM(@Identificador_Tmp) + @Caracter
			ELSE
				SET @Identificador_Procesado = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Identificador_Procesado = 1 AND @Matanza_Procesada = 1
		BEGIN
			SET @Multiplicar = ISNULL((SELECT COUNT(*) FROM Relacion_Matanza WHERE intProducto_Canal = @Producto_ID),0)
	--		SET @Cantidad_Definitiva = CASE WHEN @Cantidad <> @Cantidad_Tmp AND @Productos_Sel = 1 THEN @Cantidad ELSE @Cantidad_Tmp END
			SET @Importe = ROUND(CASE WHEN  @EsVicera = 1 AND @Clasificacion = 'K' 
								THEN CASE WHEN @Cantidad > 1 THEN @Cantidad ELSE 1 END * @Precio * CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END 
							   WHEN  @EsVicera = 1 AND @Clasificacion = 'P'  
								THEN  CASE WHEN @Cantidad = @Cantidad_Tmp THEN CONVERT(MONEY,@Cantidad_Tmp) ELSE @Cantidad END * @Precio 
							   ELSE 
								CASE WHEN @Multiplicar = 0 AND @Cantidad_Tmp >= @Cantidad  THEN @Cantidad ELSE 1 END * @Precio * (CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END)
																				END,2)

			INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyImporte, intIdentificador, intCantidad_Multiplicar) 
					 VALUES (@Movimiento, @Producto_ID, CASE WHEN @Cantidad = @Cantidad_Tmp OR  (@Multiplicar = 0 AND @Cantidad_Tmp <= @Cantidad)  OR @Multiplicar <> 0 THEN CONVERT(MONEY,@Cantidad_Tmp) ELSE @Cantidad END, CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END, @Canal_Tmp, @Orden_Tmp, @Matanza_Tmp, @Importe, @Identificador_Tmp, CASE WHEN @EsVicera = 1 THEN 0 ELSE CASE WHEN @Multiplicar = 0 AND @Cantidad_Tmp >= @Cantidad  THEN @Cantidad ELSE 1 END END)

			SET @Cantidad_Procesada = 0
			SET @Peso_Procesado = 0

			SET @Canal_Procesado = 0
			SET @Orden_Procesada = 0
			SET @Matanza_Procesada = 0
			SET @Identificador_Procesado = 0
			SET @Cantidad_Tmp = ' '
			SET @Peso_Tmp = ' '
			SET @Canal_Tmp = ' '
			SET @Orden_Tmp = ' '
			SET @Matanza_Tmp = ' '
			SET @Identificador_Tmp = ' '
			SET @Movimiento = @Movimiento + 1
		END

		SET @Posicion = @Posicion + 1
		SET @Contador = @Contador - 1

	END

	IF (SELECT COUNT(*) FROM #Productos) = 0
	BEGIN
		SET @Importe = ROUND(CASE WHEN  @EsVicera = 1 AND @Clasificacion = 'K' THEN @Precio * @Peso WHEN  @EsVicera = 1 AND @Clasificacion = 'P'  THEN CONVERT(MONEY,@Cantidad) * @Precio ELSE @Precio * @Peso END,2)

		INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyImporte, intIdentificador, intCantidad_Multiplicar) VALUES (1, @Producto_ID, @Cantidad, @Peso, @NoCanal, @OrdenCompra_ID, @OrdenMatanza_ID, @Importe, @Identificador_Tmp, CASE WHEN  @EsVicera = 1 THEN 0 ELSE 1 END)
	END

	SET @Vicera_Completa = ISNULL((SELECT 1 FROM Productos WHERE intProducto_ID = @TipoVicera AND vchDescripcion LIKE '%COMPLETA%'),0)
	SET @No_Viceras = (SELECT CASE WHEN @Vicera_Completa = 1 THEN @Productos_Sel / 2 ELSE @Productos_Sel END)
	SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)
	SET @CxC = ISNULL((SELECT MAX(intCtaXCobrar_ID) FROM CtasXCobrar),0) 
	SET @Movs_Viceras = @Movimiento_ID + (SELECT COUNT(*) FROM #Productos) + 1

	DECLARE Productos_Cursor CURSOR FOR
		SELECT intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyImporte, intIdentificador, intCantidad_Multiplicar FROM #Productos

	BEGIN TRANSACTION

	OPEN Productos_Cursor

	FETCH NEXT FROM Productos_Cursor INTO @Movimiento_ID_Cur, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @Matanza_ID_Cur, @Importe_Cur, @Identificador_Cur, @Cant_Multiplicar_Cur

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Flete = ISNULL((SELECT CASE WHEN @Primera_Vez = 1 THEN @Flete ELSE 0 END),0)

		UPDATE Existencias SET intExistencia = intExistencia - @Cantidad_Cur
				WHERE intIdentificador_Unico = @Identificador_Cur
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			DELETE FROM Existencias
			WHERE intIdentificador_Unico = @Identificador_Cur
							 AND intExistencia = 0
		
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID, intCantidad_Multiplicar, vchOrden_Compra, intTipo_Movimiento)
								VALUES (@Movimiento_ID + @Movimiento_ID_Cur, @Fecha, 'S', @Almacen_ID, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @Precio, @Importe_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @RemisionNo, @Cliente_ID, @Matanza_ID_Cur, @Flete, @TipoVicera, @Cant_Multiplicar_Cur, @Orden_Compra, 200)
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			IF (SELECT COUNT(*) FROM Remisiones WHERE intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID) = 0
			BEGIN
				INSERT INTO Remisiones (intRemisionNo, intCliente_ID, dtmFecha, mnyImporte, mnyFlete, mnySaldo, intAlmacen_ID, vchOrden_Compra) 
									VALUES (@RemisionNo, @Cliente_ID, @Fecha, @Importe_Cur + @Flete, @Flete, @Importe_Cur + @Flete, @Almacen_ID, @Orden_Compra)
				SET @Status = @@ROWCOUNT
			END
			ELSE
			BEGIN
				UPDATE Remisiones SET mnyImporte = mnyImporte + @Importe_Cur + @Flete, mnySaldo = ISNULL(mnySaldo,0) +  @Importe_Cur + @Flete
				WHERE intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID AND intAlmacen_ID = @Almacen_ID
				SET @Status = @@ROWCOUNT
			END
		END

		IF @Status <> 0
		BEGIN
			INSERT INTO Detalle_Remisiones (intRemisionNo, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyFlete, mnyImporte, intMovimiento_ID) 
			VALUES (@RemisionNo, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @Precio, @Flete, @Importe_Cur, @Movimiento_ID + @Movimiento_ID_Cur)
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			IF (SELECT COUNT(*) FROM CtasXCobrar WHERE intAlmacen_ID = @Almacen_ID AND intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID) = 0
			BEGIN
				INSERT INTO CtasXCobrar (intCtaXCobrar_ID, intAlmacen_ID, dtmFecha, intCliente_ID, intRemisionNo, mnyImporte, mnySaldo, vchOrden_Compra) 
									VALUES (@CxC + @Movimiento_ID_Cur, @Almacen_ID, @Fecha, @Cliente_ID, @RemisionNo, @Importe_Cur + @Flete, @Importe_Cur + @Flete, @Orden_Compra)
				SET @Status = @@ROWCOUNT
			END
			ELSE
			BEGIN
				UPDATE CtasXCobrar SET mnyImporte = mnyImporte + @Importe_Cur + @Flete, mnySaldo = ISNULL(mnySaldo,0) +  @Importe_Cur  + @Flete
				WHERE intAlmacen_ID = @Almacen_ID AND intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID
				SET @Status = @@ROWCOUNT
			END
		END

		IF @Status <> 0 AND @TipoVicera <> 0 AND @Primera_Vez = 1
		BEGIN
			SET @Status_Vicera = 0
			EXEC Sp_ActualizarSalidaViceras @Matanza_ID_cur, @OrdenCompra_ID_cur, @TipoVicera, @Cliente_ID, @RemisionNo, @No_Viceras, @Fecha, @Movs_Viceras, @Almacen_ID, @Status_Vicera OUTPUT
			SET @Status = @Status_Vicera
		END

		SET @Primera_Vez = 0

		FETCH NEXT FROM Productos_Cursor INTO @Movimiento_ID_Cur, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @Matanza_ID_Cur, @Importe_Cur, @Identificador_Cur, @Cant_Multiplicar_Cur
	END

	CLOSE Productos_Cursor
	DEALLOCATE Productos_Cursor

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarSalidaInventarioScrap]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarSalidaInventarioScrap]
	@Producto_ID    int,
	@Fecha          datetime,
	@Productos      varchar(8000),
	@Motivo			varchar(100),
	@Almacen_ID		int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Movimiento_ID int, @CxC int, @Posicion int, @Cantidad_Tmp varchar(10), @Matanza_Tmp varchar(10), @Peso_Tmp varchar(10), @Canal_Tmp varchar(10), @Orden_Tmp varchar(10), @Caracter char(1), @Contador int, @Cantidad_Procesada bit, @Movimiento int, @Status_Vicera int, @Peso_Procesado int, @Canal_Procesado int, @Orden_Procesada int, @Matanza_Procesada int, @Cantidad_Definitiva int, @Identificador_Procesado int, @Identificador_Tmp varchar(10), @Precio money
	DECLARE @Movimiento_ID_Cur int, @Producto_ID_Cur int, @Cantidad_Cur int, @Peso_Cur money, @NoCanal_Cur bigint, @OrdenCompra_ID_Cur int, @Matanza_ID_Cur int, @Importe_Cur money, @Identificador_Cur int, @Cant_Multiplicar_Cur int

	CREATE TABLE #Productos (
	intMovimiento_ID      	 int,
	intProducto_ID           int,
	intCantidad              int,
	mnyPeso                  money,
	intNoCanal               bigint,
	intOrdenCompra_ID		 int,
	intMatanza_ID            int,
	intIdentificador         int,
	intCantidad_Multiplicar  int)

	SET @Posicion = 1
	SET @Contador = LEN(@Productos)
	SET @Cantidad_Procesada = 0
	SET @Peso_Procesado = 0
	SET @Canal_Procesado = 0
	SET @Orden_Procesada = 0
	SET @Matanza_Procesada = 0
	SET @Identificador_Procesado = 0
	SET @Cantidad_Tmp = ' '
	SET @Peso_Tmp = ' '
	SET @Canal_Tmp = ' '
	SET @Orden_Tmp = ' '
	SET @Matanza_Tmp = ' '
	SET @Identificador_Tmp = ' '
	SET @Movimiento = 1

	WHILE @Contador <> 0
	BEGIN

		SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

		IF @Cantidad_Procesada = 0
		BEGIN
			IF @Caracter <> '*'
				SET @Cantidad_Tmp = RTRIM(@Cantidad_Tmp) + @Caracter
			ELSE
				SET @Cantidad_Procesada = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 0 AND @Caracter <> '*'
		BEGIN
			IF @Caracter <> '-'
				SET @Peso_Tmp = RTRIM(@Peso_Tmp) + @Caracter
			ELSE
				SET @Peso_Procesado = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 0 AND @Caracter <> '-'
		BEGIN
			IF @Caracter <> '+'
				SET @Canal_Tmp = RTRIM(@Canal_Tmp) + @Caracter
			ELSE
				SET @Canal_Procesado = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 0 AND @Caracter <> '+'
		BEGIN
			IF @Caracter <> '#'
				SET @Orden_Tmp = RTRIM(@Orden_Tmp) + @Caracter
			ELSE
				SET @Orden_Procesada = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Matanza_Procesada = 0 AND @Caracter <> '#'
		BEGIN
			IF @Caracter <> '%'
				SET @Matanza_Tmp = RTRIM(@Matanza_Tmp) + @Caracter
			ELSE
				SET @Matanza_Procesada = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Matanza_Procesada = 1 AND @Identificador_Procesado = 0 AND @Caracter <> '%'
		BEGIN
			IF @Caracter <> ','
				SET @Identificador_Tmp = RTRIM(@Identificador_Tmp) + @Caracter
			ELSE
				SET @Identificador_Procesado = 1
		END

		IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Identificador_Procesado = 1 AND @Matanza_Procesada = 1
		BEGIN
			INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, intIdentificador, intCantidad_Multiplicar) 
			VALUES (@Movimiento, @Producto_ID, @Cantidad_Tmp, CONVERT(MONEY, @Peso_Tmp), @Canal_Tmp, @Orden_Tmp, @Matanza_Tmp, @Identificador_Tmp, 0)

			SET @Cantidad_Procesada = 0
			SET @Peso_Procesado = 0
			SET @Canal_Procesado = 0
			SET @Orden_Procesada = 0
			SET @Matanza_Procesada = 0
			SET @Identificador_Procesado = 0
			SET @Cantidad_Tmp = ' '
			SET @Peso_Tmp = ' '
			SET @Canal_Tmp = ' '
			SET @Orden_Tmp = ' '
			SET @Matanza_Tmp = ' '
			SET @Identificador_Tmp = ' '
			SET @Movimiento = @Movimiento + 1
		END

		SET @Posicion = @Posicion + 1
		SET @Contador = @Contador - 1
	END

	SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)

	DECLARE Productos_Cursor CURSOR FOR
		SELECT intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, 0 AS mnyImporte, intIdentificador, intCantidad_Multiplicar FROM #Productos

	BEGIN TRANSACTION

	OPEN Productos_Cursor

	FETCH NEXT FROM Productos_Cursor INTO @Movimiento_ID_Cur, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @Matanza_ID_Cur, @Importe_Cur, @Identificador_Cur, @Cant_Multiplicar_Cur

	WHILE @@FETCH_STATUS = 0
	BEGIN

		UPDATE Existencias SET intExistencia = intExistencia - @Cantidad_Cur
		WHERE intIdentificador_Unico = @Identificador_Cur
		SET @Status = @@ROWCOUNT
		
		IF @Status <> 0
		BEGIN
			DELETE FROM Existencias
			WHERE intIdentificador_Unico = @Identificador_Cur
			  AND intAlmacen_ID = @Almacen_ID
			  AND intExistencia = 0

			SET @Precio = (SELECT mnyPrecio FROM Productos WHERE intProducto_ID = @Producto_ID_Cur)
		
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID, intCantidad_Multiplicar, vchObservaciones, intTipo_Movimiento) 
			VALUES (@Movimiento_ID + @Movimiento_ID_Cur, @Fecha, 'S', @Almacen_ID, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @Precio, @Importe_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, 0, 0, @Matanza_ID_Cur, 0, 0, @Cant_Multiplicar_Cur, @Motivo, 202)
			SET @Status = @@ROWCOUNT
		END

		FETCH NEXT FROM Productos_Cursor INTO @Movimiento_ID_Cur, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @Matanza_ID_Cur, @Importe_Cur, @Identificador_Cur, @Cant_Multiplicar_Cur
	END

	CLOSE Productos_Cursor
	DEALLOCATE Productos_Cursor

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarSalidaTraspaso]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarSalidaTraspaso]
	@Movimientos		varchar(8000),
	@Fecha				datetime,
	@Usuario_ID			int,
	@Almacen_ID_FROM	int,
	@Almacen_ID_TO		int
AS
BEGIN

	SET DATEFORMAT dmy

	DECLARE @Status int, @Posicion int, @Peso varchar(10), @Identificador varchar(10), @Caracter char(1), @Contador int, @Peso_Procesado bit, @Identificador_Procesado bit
	DECLARE @intContador int, @intIdentificador int, @Movimiento_ID int, @intTraspaso_ID int

	CREATE TABLE #Movimientos (
	intIdentificador	int,
	mnyPeso				money)

	SET @Posicion = 1
	SET @Contador = LEN(@Movimientos)
	SET @Peso_Procesado = 0
	SET @Identificador_Procesado = 0
	SET @Peso = ' '
	SET @Identificador = ' '
	SET @intContador = 1

	WHILE @Contador <> 0
	BEGIN

		SET @Caracter = SUBSTRING(@Movimientos,@Posicion,1) 

		IF @Peso_Procesado = 0
		BEGIN
			IF @Caracter <> '='
				SET @Peso = RTRIM(@Peso) + @Caracter
			ELSE
				SET @Peso_Procesado = 1
		END

		IF @Identificador_Procesado = 0 AND @Peso_Procesado = 1 and @Caracter <> '='
		BEGIN
			IF @Caracter <> ','
				SET @Identificador = RTRIM(@Identificador) + @Caracter
			ELSE
				SET @Identificador_Procesado = 1
		END

		IF @Identificador_Procesado = 1 AND @Peso_Procesado = 1
		BEGIN
			INSERT INTO #Movimientos (intIdentificador, mnyPeso) VALUES (CONVERT(INT,@Identificador), CONVERT(MONEY,@Peso))
			SET @Peso_Procesado = 0
			SET @Identificador_Procesado = 0
			SET @Peso = ' '
			SET @Identificador = ' '
		END

		SET @Posicion = @Posicion + 1
		SET @Contador = @Contador - 1

	END

	BEGIN TRANSACTION

	SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)
	SET @intTraspaso_ID = ISNULL((SELECT MAX(intTraspaso_ID) FROM Valco_FE.dbo.Traspasos),0) + 1

	INSERT INTO Valco_FE.dbo.Traspasos (intTraspaso_ID, dtmFecha, intUsuario_ID, intAlmacen_ID_FROM, intAlmacen_ID_TO, bitRecibido)
	VALUES (@intTraspaso_ID, @Fecha, @Usuario_ID, @Almacen_ID_FROM, @Almacen_ID_TO, 0)

	INSERT INTO Juarez.dbo.Traspasos (intTraspaso_ID, dtmFecha, intUsuario_ID, intAlmacen_ID_FROM, intAlmacen_ID_TO, bitRecibido)
	VALUES (@intTraspaso_ID, @Fecha, @Usuario_ID, @Almacen_ID_FROM, @Almacen_ID_TO, 0)

	DECLARE Movimientos_Cursor CURSOR FOR 
		SELECT intIdentificador FROM #Movimientos

	OPEN Movimientos_Cursor

	FETCH NEXT FROM Movimientos_Cursor INTO @intIdentificador

	WHILE @@FETCH_STATUS = 0
	BEGIN

		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intCantidad_Multiplicar, vchOrden_Compra, intTipo_Movimiento)
		SELECT @Movimiento_ID + @intContador, @Fecha, 'S', 2, intProducto_ID, intExistencia, mnyPeso, 0, 0, intCanalNo, intOrdenCompra_ID, @intTraspaso_ID, 0, intMatanza_ID, 0, 0, '', 206 FROM Existencias
		WHERE intIdentificador_Unico = @intIdentificador

		DELETE FROM Existencias
		WHERE intIdentificador_Unico = @intIdentificador
		
		SET @Status = @@ROWCOUNT

		SET @intContador = @intContador + 1

		FETCH NEXT FROM Movimientos_Cursor INTO @intIdentificador
	END

	CLOSE Movimientos_Cursor
	DEALLOCATE Movimientos_Cursor

	DROP TABLE #Movimientos

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarSalidaViceras]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarSalidaViceras]
	@OrdenMatanza_ID    int,
	@OrdenCompra_ID		int,
	@TipoVicera         int,
	@Cliente_ID         int,
	@RemisionNo         int,
	@Cantidad           int,
	@Fecha              datetime,
	@Movimiento_ID      int,
	@Almacen_ID			int,
	@Status_Vicera      int OUTPUT
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @Producto_ID int, @NoPiezas int, @Identificador int, @Contador int, @Cant_Rebajar int, @Renglon int

	SET @Renglon = 0

	DECLARE Viceras_Cursor CURSOR FOR
		SELECT Viceras.intProducto_ID, intNoPiezas FROM Viceras
		INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
		WHERE intVicera_ID = @TipoVicera

	OPEN Viceras_Cursor

	FETCH NEXT FROM Viceras_Cursor INTO @Producto_ID, @NoPiezas

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Contador = (@Cantidad * @NoPiezas)

		WHILE @Contador <> 0
		BEGIN
			SET @Identificador = (SELECT TOP 1 intIdentificador_Unico FROM Existencias WHERE intAlmacen_ID = @Almacen_ID AND intProducto_ID  = @Producto_ID ORDER BY intOrdenCompra_ID)
			SET @Cant_Rebajar = (SELECT CASE WHEN intExistencia >  @Contador THEN  @Contador ELSE intExistencia END FROM Existencias WHERE intAlmacen_ID = @Almacen_ID AND intProducto_ID  = @Producto_ID AND intIdentificador_Unico = @Identificador)

			UPDATE Existencias SET intExistencia = intExistencia - @Cant_Rebajar
			WHERE intAlmacen_ID = @Almacen_ID
				  AND intIdentificador_Unico = @Identificador
				  AND intProducto_ID  = @Producto_ID
			SET @Status = @@ROWCOUNT

			IF @Status <> 0
			BEGIN
				INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID, intTipo_Movimiento) 
				SELECT @Movimiento_ID + @Renglon, @Fecha, 'S', @Almacen_ID, intProducto_ID, @Cant_Rebajar, 0, 0, 0, intCanalNo, intOrdenCompra_ID, @RemisionNo, @Cliente_ID, intMatanza_ID, 0, @TipoVicera, 200 FROM Existencias
				WHERE intAlmacen_ID = @Almacen_ID
					   AND intIdentificador_Unico = @Identificador
					   AND intProducto_ID  = @Producto_ID
				SET @Status = @@ROWCOUNT

				DELETE FROM Existencias
				WHERE intAlmacen_ID = @Almacen_ID
					   AND intIdentificador_Unico = @Identificador
					   AND intProducto_ID  = @Producto_ID
								 AND intExistencia = 0
			END

			IF @Status <> 0
			BEGIN
				INSERT INTO Detalle_Remisiones (intRemisionNo, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyFlete, mnyImporte, intMovimiento_ID) 
				SELECT @RemisionNo, intProducto_ID, @Cant_Rebajar, 0, 0, 0, 0, @Movimiento_ID + @Renglon FROM Existencias
				WHERE intAlmacen_ID = @Almacen_ID
					   AND intIdentificador_Unico = @Identificador
					   AND intProducto_ID  = @Producto_ID
				SET @Status = @@ROWCOUNT
			END

			SET @Contador = @Contador - @Cant_Rebajar
			SET @Renglon = @Renglon + 1
		END

		FETCH NEXT FROM Viceras_Cursor INTO @Producto_ID, @NoPiezas
	END

	CLOSE Viceras_Cursor
	DEALLOCATE Viceras_Cursor

	IF @Status <> 0
		SET @Status_Vicera = 1
	ELSE
		SET @Status_Vicera = 0

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarStatusDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarStatusDeshuese]
@Deshuese_ID	int
AS

SET DATEFORMAT dmy

UPDATE Deshueses SET bitProcesado = 1, dtmFecha_Procesado = GETDATE()
WHERE intDeshuese_ID = @Deshuese_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarTraspaso]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ActualizarTraspaso]
@Cliente_ID                int,
@RemisionNo              int,
@Fecha                        datetime,--varchar(30),
@Productos                 varchar(8000),
@TipoPago	           int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Movimiento_ID int, @CxC int, @Posicion int, @Cantidad_Tmp varchar(10), @Precio_Tmp varchar(10), @Peso_Tmp varchar(10), @Canal_Tmp varchar(10), @Orden_Tmp varchar(10), @Caracter char(1), @Contador int, @Cantidad_Procesada bit, @Movimiento int, @Importe money, @Status_Vicera int, @Peso_Procesado int, @Canal_Procesado int, @Orden_Procesada int, @Precio_Procesado int, @Primera_Vez bit, @Producto_ID int, @Producto_Procesado int, @Producto_Tmp varchar(10), @EsVicera bit, @Clasificacion  char(1), @Matanza_Procesada int, @Matanza_Tmp varchar(10), @Flete money, @Contador_Movimientos int, @Identificador_Procesado int, @Identificador_Tmp varchar(10), @Multiplicar int, @Cantidad  int, @Peso money
DECLARE @Movimiento_ID_Cur int, @Producto_ID_Cur int, @Cantidad_Cur int, @Peso_Cur money, @NoCanal_Cur int, @OrdenCompra_ID_Cur int, @Matanza_ID_Cur int, @Importe_Cur money, @Precio_Cur money, @SinPeso_Cur int, @Identificador_Cur int, @Cant_Multiplicar_Cur int

SET @Flete = 0
SET @Contador_Movimientos = 1

CREATE TABLE #Productos (
intMovimiento_ID           int,
intProducto_ID               int,
intCantidad                      int,
mnyPeso                          money,
intNoCanal                       int,
intOrdenCompra_ID      int,
intMatanza_ID                int,
mnyPrecio                        money,
mnyImporte                     money,
intIdentificador                int,
intSinPeso                       int,
intCantidad_Multiplicar  int)

SET @Primera_Vez = 0
SET @Posicion = 1
SET @Contador = LEN(RTRIM(@Productos))
SET @Producto_Procesado = 0
SET @Cantidad_Procesada = 0
SET @Peso_Procesado = 0
SET @Canal_Procesado = 0
SET @Orden_Procesada = 0
SET @Matanza_Procesada = 0
SET @Identificador_Procesado = 0
SET @Precio_Procesado = 0
SET @Producto_Tmp = ' '
SET @Cantidad_Tmp = ' '
SET @Peso_Tmp = ' '
SET @Canal_Tmp = ' '
SET @Orden_Tmp = ' '
SET @Precio_Tmp = ' '
SET @Matanza_Tmp = ' '
SET @Identificador_Tmp = ' '
SET @Movimiento = 1

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

	IF @Producto_Procesado = 0
	BEGIN
		IF @Caracter <> '+'
			SET @Producto_Tmp = RTRIM(@Producto_Tmp) + @Caracter
		ELSE
			SET @Producto_Procesado = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 0 AND  @Caracter <> '+'
	BEGIN
		IF @Caracter <> '-'
			SET @Canal_Tmp = RTRIM(@Canal_Tmp) + @Caracter
		ELSE
			SET @Canal_Procesado = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 0 AND @Caracter <> '-'
	BEGIN
		IF @Caracter <> '*'
			SET @Peso_Tmp = RTRIM(@Peso_Tmp) + @Caracter
		ELSE
			SET @Peso_Procesado = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 1 AND @Orden_Procesada = 0 AND @Caracter <> '*'
	BEGIN
		IF @Caracter <> '#'
			SET @Orden_Tmp = RTRIM(@Orden_Tmp) + @Caracter
		ELSE
			SET @Orden_Procesada = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 1 AND @Orden_Procesada = 1 AND @Cantidad_Procesada = 0 AND @Caracter <> '#'
	BEGIN
		IF @Caracter <> '='
			SET @Cantidad_Tmp = RTRIM(@Cantidad_Tmp) + @Caracter
		ELSE
			SET @Cantidad_Procesada = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 1 AND @Orden_Procesada = 1 AND @Cantidad_Procesada = 1 AND @Precio_Procesado = 0 AND @Caracter <> '='
	BEGIN
		IF @Caracter <> '/'
			SET @Precio_Tmp = RTRIM(@Precio_Tmp) + @Caracter
		ELSE
			SET @Precio_Procesado = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 1 AND @Orden_Procesada = 1 AND @Cantidad_Procesada = 1 AND @Precio_Procesado = 1 AND @Matanza_Procesada = 0 AND @Caracter <> '/'
	BEGIN
		IF @Caracter <> '%'
			SET @Matanza_Tmp = RTRIM(@Matanza_Tmp) + @Caracter
		ELSE
			SET @Matanza_Procesada = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 1 AND @Orden_Procesada = 1 AND @Cantidad_Procesada = 1 AND @Precio_Procesado = 1 AND @Matanza_Procesada = 1 AND @Identificador_Procesado = 0 AND @Caracter <> '%'
	BEGIN
		IF @Caracter <> ','
			SET @Identificador_Tmp = RTRIM(@Identificador_Tmp) + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Producto_Procesado = 1 AND @Canal_Procesado = 1 AND @Peso_Procesado = 1 AND @Orden_Procesada = 1 AND @Cantidad_Procesada = 1 AND @Precio_Procesado = 1 AND @Matanza_Procesada = 1 AND @Identificador_Procesado = 1
	BEGIN
		SELECT @Clasificacion = chrClasificacion, @EsVicera = CASE WHEN intNoPiezas > 0 THEN 1 ELSE 0 END FROM Productos WHERE intProducto_Id = @Producto_Tmp
		
		SET @Cantidad = CONVERT(INT, @Cantidad_Tmp)
		SET @Peso = CONVERT(MONEY, @Peso_Tmp)

		SET @Multiplicar = ISNULL((SELECT COUNT(*) FROM Relacion_Matanza WHERE intProducto_Canal = @Producto_Tmp),0)
		SET @Importe = ROUND(CASE WHEN  @EsVicera = 1 AND @Clasificacion = 'K' 
							THEN CASE WHEN @Cantidad > 1 THEN @Cantidad ELSE 1 END * CONVERT(MONEY,@Precio_Tmp) * CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END 
						   WHEN  @EsVicera = 1 AND @Clasificacion = 'P'  
							THEN  CASE WHEN @Cantidad = @Cantidad_Tmp THEN CONVERT(MONEY,@Cantidad_Tmp) ELSE @Cantidad END * CONVERT(MONEY,@Precio_Tmp)
						   ELSE 
							CASE WHEN @Multiplicar = 0 AND @Cantidad_Tmp >= @Cantidad  THEN @Cantidad ELSE 1 END * CONVERT(MONEY,@Precio_Tmp) * (CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END)
                                                                            END,2)

		INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyPrecio, mnyImporte, intSinPeso, intIdentificador, intCantidad_Multiplicar) 
		         VALUES (@Movimiento, @Producto_Tmp, CASE WHEN @Cantidad = @Cantidad_Tmp OR  (@Multiplicar = 0 AND @Cantidad_Tmp <= @Cantidad)  OR @Multiplicar <> 0 THEN CONVERT(MONEY,@Cantidad_Tmp) ELSE @Cantidad END, CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END, @Canal_Tmp, @Orden_Tmp, @Matanza_Tmp, CONVERT(MONEY,@Precio_Tmp), @Importe, CASE WHEN CONVERT(INT,@Cantidad_Tmp) = 0 THEN 0 ELSE 1 END, @Identificador_Tmp, CASE WHEN @EsVicera = 1 THEN 0 ELSE CASE WHEN @Multiplicar = 0 AND @Cantidad_Tmp >= @Cantidad  THEN @Cantidad ELSE 1 END END)

		SET @Cantidad_Procesada = 0
		SET @Peso_Procesado = 0
		SET @Canal_Procesado = 0
		SET @Precio_Procesado = 0
		SET @Orden_Procesada = 0
		SET @Producto_Procesado = 0
		SET @Matanza_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Cantidad_Tmp = ' '
		SET @Peso_Tmp = ' '
		SET @Canal_Tmp = ' '
		SET @Orden_Tmp = ' '
		SET @Producto_Tmp = ' '
		SET @Matanza_Tmp = ' '
		SET @Precio_Tmp = ' '
		SET @Identificador_Tmp = ' '
		SET @Movimiento = @Movimiento + 1
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)
SET @CxC = ISNULL((SELECT MAX(intCtaXCobrar_ID) FROM CtasXCobrar),0) 

DECLARE Productos_Cursor CURSOR FOR
	SELECT intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyPrecio, mnyImporte, intSinPeso, intIdentificador, intCantidad_Multiplicar FROM #Productos

BEGIN TRANSACTION

OPEN Productos_Cursor

FETCH NEXT FROM Productos_Cursor INTO @Movimiento_ID_Cur, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @Matanza_ID_Cur, @Precio_Cur, @Importe_Cur, @SinPeso_Cur, @Identificador_Cur, @Cant_Multiplicar_Cur

WHILE @@FETCH_STATUS = 0
BEGIN

	IF @SinPeso_Cur = 0
	BEGIN
		UPDATE Existencias SET intExistencia = intExistencia - @Cantidad_Cur
		        WHERE intIdentificador_Unico = @Identificador_Cur
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID) 
		                        VALUES (@Movimiento_ID + @Contador_Movimientos, @Fecha, 'E', 1, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, 0, 0, @NoCanal_Cur, @OrdenCompra_ID_Cur, 0, 0, @Matanza_ID_Cur, 0, 0)
			SET @Status = @@ROWCOUNT
			SET @Contador_Movimientos = @Contador_Movimientos + 1
		END	
	END
	ELSE
	BEGIN
		UPDATE Existencias SET intExistencia = intExistencia - @Cantidad_Cur
		        WHERE intIdentificador_Unico = @Identificador_Cur
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID, intCantidad_Multiplicar) 
		                        VALUES (@Movimiento_ID + @Contador_Movimientos, @Fecha, 'E', 1, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, 0, 0, @NoCanal_Cur, @OrdenCompra_ID_Cur, 0, 0, @Matanza_ID_Cur, 0, 0, @Cant_Multiplicar_Cur)
			SET @Status = @@ROWCOUNT
			SET @Contador_Movimientos = @Contador_Movimientos + 1
		END		
	END
	
	IF @Status <> 0
	BEGIN
		DELETE FROM Existencias
		WHERE intIdentificador_Unico = @Identificador_Cur
	                     AND intExistencia = 0
	
		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, mnyImporte, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, mnyFlete, intTipoVicera_ID) 
	                        VALUES (@Movimiento_ID + @Contador_Movimientos, @Fecha, 'S', 1, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @Precio_Cur, @Importe_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @RemisionNo, @Cliente_ID, @Matanza_ID_Cur, @Flete, 0)
		SET @Status = @@ROWCOUNT
		SET @Contador_Movimientos = @Contador_Movimientos + 1
	END

	IF @Status <> 0
	BEGIN
		IF (SELECT COUNT(*) FROM Remisiones WHERE intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID) = 0
		BEGIN
			INSERT INTO Remisiones (intRemisionNo, intCliente_ID, dtmFecha, mnyImporte, mnyFlete, mnySaldo, intAlmacen_ID) 
		                        VALUES (@RemisionNo, @Cliente_ID, @Fecha, @Importe_Cur + @Flete, @Flete, CASE WHEN @TipoPago = 1 THEN @Importe_Cur + @Flete ELSE 0 END, 1)
			SET @Status = @@ROWCOUNT
		END
		ELSE
		BEGIN
			UPDATE Remisiones SET mnyImporte = mnyImporte + @Importe_Cur, mnySaldo = mnySaldo +  CASE WHEN @TipoPago = 1 THEN @Importe_Cur + @Flete ELSE 0 END
			WHERE intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID AND intAlmacen_ID = 1
			SET @Status = @@ROWCOUNT
		END
	END

	IF @Status <> 0
	BEGIN
		IF (SELECT COUNT(*) FROM CtasXCobrar WHERE intAlmacen_ID = 1 AND intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID) = 0
		BEGIN
			INSERT INTO CtasXCobrar (intCtaXCobrar_ID, intAlmacen_ID, dtmFecha, intCliente_ID, intRemisionNo, mnyImporte, mnySaldo) 
		                        VALUES (@CxC + @Movimiento_ID_Cur, 1, @Fecha, @Cliente_ID, @RemisionNo, @Importe_Cur + @Flete, CASE WHEN @TipoPago = 1 THEN @Importe_Cur + @Flete ELSE 0 END)
			SET @Status = @@ROWCOUNT

			IF @Status <> 0 AND @TipoPago = 2
			BEGIN
				INSERT INTO Detalle_CtasXCobrar (intCtaXCobrar_ID, dtmFecha_Abono, mnyAbono) 
			                        VALUES (@CxC + @Movimiento_ID_Cur, @Fecha, @Importe_Cur + @Flete)
				SET @Status = @@ROWCOUNT
			END
		END
		ELSE
		BEGIN
			UPDATE CtasXCobrar SET mnyImporte = mnyImporte + @Importe_Cur, mnySaldo = mnySaldo +  CASE WHEN @TipoPago = 1 THEN @Importe_Cur + @Flete ELSE 0 END
			WHERE intAlmacen_ID = 1 AND intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID
			SET @Status = @@ROWCOUNT

			IF @Status <> 0 AND @TipoPago = 2
			BEGIN
				UPDATE Detalle_CtasXCobrar SET mnyAbono = mnyAbono + @Importe_Cur + @Flete
				FROM CtasXCobrar
				INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
				WHERE intAlmacen_ID = 1 AND intRemisionNo = @RemisionNo AND intCliente_ID = @Cliente_ID AND dtmFecha_Abono = @Fecha
				SET @Status = @@ROWCOUNT
			END
		END
	END

	FETCH NEXT FROM Productos_Cursor INTO @Movimiento_ID_Cur, @Producto_ID_Cur, @Cantidad_Cur, @Peso_Cur, @NoCanal_Cur, @OrdenCompra_ID_Cur, @Matanza_ID_Cur, @Precio_Cur, @Importe_Cur, @SinPeso_Cur, @Identificador_Cur, @Cant_Multiplicar_Cur
END

CLOSE Productos_Cursor
DEALLOCATE Productos_Cursor

IF @Status <> 0
BEGIN
	UPDATE Control_Remisiones SET intContador_Remisiones = intContador_Remisiones + 1
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarUnidadMedida]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarUnidadMedida]
@Unidad_ID              int,
@Descripcion            varchar(20),
@NombreCorto          varchar(3),
@Activo                     int,
@Operacion              char(1)
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

IF @Operacion = 'I'
BEGIN
	SET @ID = ISNULL((SELECT MAX(intUnidad_ID) FROM Unidad_Medida),0) + 1
	INSERT INTO Unidad_Medida (intUnidad_ID, vchDescripcion, vchNombreCorto, bitActivo) VALUES (@ID, @Descripcion, @NombreCorto, @Activo)
	SET @Status = @@ROWCOUNT
END
ELSE
BEGIN
	UPDATE Unidad_Medida SET vchDescripcion = @Descripcion, vchNombreCorto = @NombreCorto, bitActivo = @Activo
             WHERE intUnidad_ID = @Unidad_ID
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarVicera]
@Vicera_ID           int,
@Producto_ID      int
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

INSERT INTO Viceras (intVicera_ID, intProducto_ID) VALUES (@Vicera_ID, @Producto_ID)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarVicerasASurtir]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarVicerasASurtir]
@Vicera_ID           int,
@Producto_ID      int
AS

SET DATEFORMAT dmy

DECLARE @ID int, @Status int

BEGIN TRANSACTION

INSERT INTO Viceras_A_Surtir (intProducto_ID, intProductoVicera_ID) VALUES (@Vicera_ID, @Producto_ID)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_AplicarInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_AplicarInvFisico]
	@InvFisico_ID	int,
	@Almacen_ID		int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @Status int, @OC int, @Movimiento_ID int

	SET @OC = RTRIM(CONVERT(CHAR,YEAR(GETDATE()))) + RTRIM(CASE WHEN LEN(RTRIM(CONVERT(CHAR, @InvFisico_ID))) = 1 THEN '0' ELSE '' END + RTRIM(CONVERT(CHAR, @InvFisico_ID)))
	SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)

	BEGIN TRANSACTION

	CREATE TABLE #MovimientosSalida (
	intMovimiento_ID 	int NOT NULL IDENTITY (1, 1),
	dtmFecha 		datetime,
	chrOperacion 		char(1),
	intAlmacen_ID		int,
	intProducto_ID		int,
	intCantidad		int,
	mnyPeso		money,
	mnyPrecio		money,
	intCanalNo		int,
	intOrdenCompra_ID	int,
	intRemisionNo		int,
	intCliente_ID		int,
	intMatanza_ID		int,
	vchObservaciones 	varchar(100)
	) ON [PRIMARY]

	CREATE TABLE #MovimientosEntrada (
	intMovimiento_ID 	int NOT NULL IDENTITY (1, 1),
	dtmFecha 		datetime,
	chrOperacion 		char(1),
	intAlmacen_ID		int,
	intProducto_ID		int,
	intCantidad		int,
	mnyPeso		money,
	mnyPrecio		money,
	intCanalNo		int,
	intOrdenCompra_ID	int,
	intRemisionNo		int,
	intCliente_ID		int,
	intMatanza_ID		int,
	vchObservaciones 	varchar(100)
	) ON [PRIMARY]

	UPDATE Inventario_Fisico SET bitAplicado = 1, dtmFecha_Aplicado = GETDATE() WHERE intInventario_ID = @InvFisico_ID
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Inventario_Fisico_Existencias
		SELECT @InvFisico_ID, Existencias.* FROM Existencias
		INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
		WHERE Productos.bitNoAplicar_InvFisico = 0
	--	WHERE intProducto_ID IN (SELECT DISTINCT intProducto_ID FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID)

		INSERT INTO #MovimientosSalida (dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones)
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,GETDATE(),103),103), 'S', @Almacen_ID, Existencias.intProducto_ID, 1, mnyPeso, mnyCostoVenta, intCanalNo, intOrdenCompra_ID, @InvFisico_ID, 0, intMatanza_ID, 'SALIDA POR INV FISICO' FROM Existencias
		INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
		WHERE Productos.bitNoAplicar_InvFisico = 0
	--	WHERE Existencias.intProducto_ID IN (SELECT DISTINCT intProducto_ID FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID)

		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones, intTipo_Movimiento)
		SELECT @Movimiento_ID + intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones, CASE WHEN chrOperacion = 'E' THEN 103 ELSE 203 END FROM #MovimientosSalida

		DELETE FROM Existencias
		WHERE intProducto_ID IN (SELECT intProducto_ID FROM Productos WHERE bitNoAplicar_InvFisico = 0)
	--	WHERE intProducto_ID IN (SELECT DISTINCT intProducto_ID FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID)
	END

	IF @Status <> 0
	BEGIN
		INSERT INTO Existencias
		SELECT 2, intProducto_ID, @OC, 0, 1, mnyPeso, 0  FROM Detalle_Inventario_Fisico
		WHERE intInventario_ID = @InvFisico_ID
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		UPDATE Existencias SET intCanalNo = intIdentificador_Unico
		WHERE intOrdenCompra_ID = @OC
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		INSERT INTO #MovimientosEntrada (dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones)
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,GETDATE(),103),103), 'E', @Almacen_ID, Existencias.intProducto_ID, 1, mnyPeso, mnyCostoVenta, intCanalNo, intOrdenCompra_ID, @InvFisico_ID, 0, intMatanza_ID, 'ENTRADA POR INV FISICO' FROM Existencias
		INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
		WHERE intOrdenCompra_ID = @OC
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)

		INSERT INTO Movimientos (intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones, intTipo_Movimiento)
		SELECT @Movimiento_ID + intMovimiento_ID, dtmFecha, chrOperacion, intAlmacen_ID, intProducto_ID, intCantidad, mnyPeso, mnyPrecio, intCanalNo, intOrdenCompra_ID, intRemisionNo, intCliente_ID, intMatanza_ID, vchObservaciones, CASE WHEN chrOperacion = 'E' THEN 103 ELSE 203 END FROM #MovimientosEntrada
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END

	DROP TABLE #MovimientosSalida
	DROP TABLE #MovimientosEntrada

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CalcularRendimiento]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CalcularRendimiento]
@OrdenCompra	int,
@Almacen_ID		int,
@Rendimiento	money OUTPUT,
@PesoNeto	money OUTPUT,
@PesoTotal	money OUTPUT
AS

SET DATEFORMAT dmy

DECLARE @Peso_Ventas money, @Peso_Deshuese money, @Peso_Compra money

SELECT @Peso_Compra = mnyPeso FROM Orden_Compra 
WHERE intOrdenCompra_ID = @OrdenCompra AND bitCancelado = 0

SELECT @Peso_Ventas = SUM(mnyPeso) FROM Movimientos
WHERE intOrdenCompra_ID = @OrdenCompra
  AND chrOperacion = 'S'
  AND intRemisionNo > 0
  AND intProducto_ID IN (SELECT intProducto_Canal FROM Relacion_Matanza)
  AND bitCancelado = 0

SELECT @Peso_Deshuese = SUM(mnyPeso) FROM Movimientos
WHERE Movimientos.intAlmacen_ID = @Almacen_ID
  AND intOrdenCompra_ID = @OrdenCompra
  AND (intCliente_ID <= 0 AND intCliente_ID <> -999)
  AND bitCancelado = 0

IF ABS((ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0))) > 0
	SET @Rendimiento = (ISNULL(@Peso_Deshuese,0) / ABS((ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0)))) * 100
ELSE
	SET @Rendimiento = 0

SET @PesoNeto = ISNULL(@Peso_Deshuese,0)
SET @PesoTotal = ABS(ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0))

RETURN @Rendimiento
RETURN @PesoNeto
RETURN @PesoTotal
GO
/****** Object:  StoredProcedure [dbo].[Sp_CancelarAbonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_CancelarAbonos]
@Cliente_ID		int,
@Remisiones		varchar(8000),
@TipoCuenta		char(1),
@Almacen		int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Identificador varchar(10), @Remision varchar(10), @Caracter char(1), @Contador int, @Remision_Procesada bit, @Identificador_Procesado  bit, @Clave int, @RemisionNo int, @CtaXCobrar int, @Abono money, @Abono_Remision money, @CxC int, @Id_Identificador int, @Aplicada_NC bit, @NC_ID int

CREATE TABLE #Remisiones (
intRemision_ID       int,
intIdentificador        int,
dtmFecha                smalldatetime)

SET @Posicion = 1
SET @Contador = LEN(@Remisiones)
SET @Remision_Procesada = 0
SET @Identificador_Procesado = 0
SET @Remision = ''
SET @Identificador = ''

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Remisiones,@Posicion,1) 

	IF @Remision_Procesada = 0
	BEGIN
		IF @Caracter <> '='
			SET @Remision = RTRIM(@Remision) + @Caracter
		ELSE
			SET @Remision_Procesada = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 0 and @Caracter <> '='
	BEGIN
		IF @Caracter <> ','
			SET @Identificador = @Identificador + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 1
	BEGIN
		IF @TipoCuenta = 'R'
			INSERT INTO #Remisiones (intRemision_ID, intIdentificador) VALUES (@Remision, @Identificador)
		ELSE
			INSERT INTO #Remisiones (intRemision_ID, dtmFecha) VALUES (@Remision, @Identificador)
		SET @Remision_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Remision = ''
		SET @Identificador = ''
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

DECLARE Abonos_Cursor CURSOR FOR
	SELECT intRemision_ID, Identificador, mnyAbono, intCtaXCobrar, bitAplicada_NC FROM (
		SELECT #Remisiones.intRemision_ID, Detalle_CtasXCobrar.Identificador,  CASE WHEN @TipoCuenta = 'R' THEN Detalle_CtasXCobrar.mnyAbono ELSE Abonos.mnyAbonado END AS mnyAbono, CASE WHEN @TipoCuenta = 'R' THEN CtasXCobrar.intCtaXCobrar_ID ELSE 0 END AS intCtaXCobrar, bitAplicada_NC FROM #Remisiones
		INNER JOIN CtasXCobrar ON  (#Remisiones.intRemision_ID = CtasXCobrar.intRemisionNo AND @TipoCuenta = 'R') OR  (#Remisiones.intRemision_ID = CtasXCobrar.intFactura_ID AND @TipoCuenta = 'F') AND CtasXCobrar.intAlmacen_ID = @Almacen
		LEFT OUTER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID AND ((Detalle_CtasXCobrar.Identificador = #Remisiones.intIdentificador AND @TipoCuenta = 'R') OR (Detalle_CtasXCobrar.dtmFecha_Abono BETWEEN #Remisiones.dtmFecha AND #Remisiones.dtmFecha + '23:59' AND @TipoCuenta = 'F'))
		LEFT OUTER JOIN  (SELECT intFactura_ID, SUM(Detalle_CtasXCobrar.mnyAbono) AS mnyAbonado, CASE WHEN @TipoCuenta = 'R' THEN Detalle_CtasXCobrar.Identificador ELSE Detalle_CtasXCobrar.dtmFecha_Abono END AS Identificador, Detalle_CtasXCobrar.Identificador AS Indice FROM CtasXCobrar
				          INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
				          GROUP BY intFactura_ID, CASE WHEN @TipoCuenta = 'R' THEN Detalle_CtasXCobrar.Identificador ELSE Detalle_CtasXCobrar.dtmFecha_Abono END, Detalle_CtasXCobrar.Identificador
				         ) Abonos ON  #Remisiones.intRemision_ID = Abonos.intFactura_ID AND (Abonos.Identificador = #Remisiones.intIdentificador AND @TipoCuenta = 'R' OR Abonos.Indice = Detalle_CtasXCobrar.Identificador AND @TipoCuenta = 'F')
	) Temporal 
               WHERE NOT bitAplicada_NC IS NULL AND NOT mnyAbono IS NULL
	GROUP BY intRemision_ID, Identificador, intCtaXCobrar, bitAplicada_NC, mnyAbono
	ORDER BY  intRemision_ID

BEGIN TRANSACTION

OPEN Abonos_Cursor

FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @Abono, @CtaXCobrar, @Aplicada_NC

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @TipoCuenta = 'R'
	BEGIN
		UPDATE CtasXCobrar SET mnySaldo = mnySaldo + @Abono, mnyAbonado = mnyAbonado - @Abono
		WHERE intRemisionNo = @Clave AND intAlmacen_ID = @Almacen
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			UPDATE Remisiones SET  mnySaldo = mnySaldo + @Abono
			WHERE intRemisionNo = @Clave AND intAlmacen_ID = @Almacen
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			DELETE FROM Detalle_CtasXCobrar WHERE intCtaXCobrar_ID = @CtaXCobrar AND Identificador = @Id_Identificador
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			UPDATE Facturas SET mnySaldo = mnySaldo + @Abono
			WHERE intFactura_ID = (SELECT intFactura_ID FROM Detalle_Facturas WHERE intRemisionNo = @Clave)
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0 AND ISNULL((SELECT COUNT(*) FROM Detalle_Notas_Credito WHERE intRemisionNo = @Clave),0) > 0 AND @Aplicada_NC = 1
		BEGIN
			UPDATE Detalle_Notas_Credito SET bitAplicada = 0
			WHERE intRemisionNo = @Clave
			SET @Status = @@ROWCOUNT

			SET @NC_ID = (SELECT intNota_Credito_ID FROM Detalle_Notas_Credito WHERE intRemisionNo = @Clave)

			IF @Status <> 0 AND (SELECT SUM(CASE WHEN bitAplicada = 1 THEN 1 ELSE 0 END) - COUNT(*) FROM Notas_Credito WHERE intNota_Credito_ID = @NC_ID) > 0
			BEGIN
				UPDATE Notas_Credito SET bitAplicada = 0
				WHERE intNota_Credito_ID = @NC_ID
				SET @Status = @@ROWCOUNT
			END
		END
	END
	ELSE
	BEGIN
		IF @Aplicada_NC = 0 
			SET @Status = 1
		ELSE
		BEGIN
			UPDATE Notas_Credito SET bitAplicada = 0
			WHERE intFactura_ID = @Clave
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			UPDATE Facturas SET mnySaldo = mnySaldo + @Abono
			WHERE intFactura_ID = @Clave
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN

			DECLARE Remisiones_Cursor CURSOR FOR
				SELECT CtasXCobrar.intCtaXCobrar_ID, CtasXCobrar.intRemisionNo, ISNULL(Detalle_CtasXCobrar.mnyAbono,0) FROM CtasXCobrar
				INNER JOIN  Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID AND Detalle_CtasXCobrar.Identificador = @Id_Identificador
				INNER JOIN Remisiones ON  CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo 
				WHERE CtasXCobrar.intFactura_ID = @Clave
--				      AND CtasXCobrar.mnySaldo <> 0
				      AND CtasXCobrar.intAlmacen_ID = @Almacen
				ORDER BY  CtasXCobrar.intRemisionNo

			OPEN Remisiones_Cursor
			
			FETCH NEXT FROM Remisiones_Cursor  INTO @CxC, @RemisionNo, @Abono_Remision
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @Status <> 0
				BEGIN
					UPDATE CtasXCobrar SET mnySaldo = mnySaldo + @Abono_Remision, mnyAbonado = mnyAbonado - @Abono_Remision
					WHERE intRemisionNo = @RemisionNo AND intAlmacen_ID = @Almacen
					SET @Status = @@ROWCOUNT
				END

				IF @Status <> 0 AND @Abono_Remision > 0
				BEGIN
					DELETE FROM Detalle_CtasXCobrar  WHERE intCtaXCobrar_ID = @CXC AND Identificador = @Id_Identificador
					SET @Status = @@ROWCOUNT
				END

				IF @Status <> 0
				BEGIN
					UPDATE Remisiones SET  mnySaldo = mnySaldo + @Abono_Remision
					WHERE intRemisionNo = @RemisionNo AND intAlmacen_ID = @Almacen
					SET @Status = @@ROWCOUNT
				END
				
				FETCH NEXT FROM Remisiones_Cursor  INTO @CxC, @RemisionNo, @Abono_Remision
			END

			CLOSE Remisiones_Cursor
			DEALLOCATE Remisiones_Cursor
		END
	END

	FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @Abono, @CtaXCobrar, @Aplicada_NC
END

CLOSE Abonos_Cursor
DEALLOCATE Abonos_Cursor

DROP TABLE #Remisiones

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_CancelarAbonosCXP]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_CancelarAbonosCXP]
@Ordenes		varchar(8000)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Identificador varchar(10), @Orden varchar(10), @Caracter char(1), @Contador int, @Orden_Procesada bit, @Identificador_Procesado bit, @Clave int, @CtaXPagar int, @Abono money, @Id_Identificador int

CREATE TABLE #Ordenes (
intOrdenCompra_ID       int,
intIdentificador                int)

SET @Posicion = 1
SET @Contador = LEN(@Ordenes)
SET @Orden_Procesada = 0
SET @Identificador_Procesado = 0
SET @Orden = ' '
SET @Identificador = ' '

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Ordenes,@Posicion,1) 

	IF @Orden_Procesada = 0
	BEGIN
		IF @Caracter <> '='
			SET @Orden = RTRIM(@Orden) + @Caracter
		ELSE
			SET @Orden_Procesada = 1
	END

	IF @Orden_Procesada = 1 AND @Identificador_Procesado = 0 and @Caracter <> '='
	BEGIN
		IF @Caracter <> ','
			SET @Identificador = @Identificador + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Orden_Procesada = 1 AND @Identificador_Procesado = 1
	BEGIN
		INSERT INTO #Ordenes (intOrdenCompra_ID, intIdentificador) VALUES (@Orden, @Identificador)
		SET @Orden_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Orden = ' '
		SET @Identificador = ' '
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

DECLARE Abonos_Cursor CURSOR FOR
	SELECT #Ordenes.intOrdenCompra_ID, #Ordenes.intIdentificador,  Detalle_CtasXPagar.mnyAbono, CtasXPagar.intCtaXPagar_ID FROM #Ordenes
	LEFT OUTER JOIN CtasXPagar ON  #Ordenes.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	LEFT OUTER JOIN Detalle_CtasXPagar ON CtasXPagar.intCtaXPagar_ID = Detalle_CtasXPagar.intCtaXPagar_ID AND Detalle_CtasXPagar.Identificador = #Ordenes.intIdentificador
	LEFT OUTER JOIN  (SELECT intOrdenCompra_ID, SUM(Detalle_CtasXPagar.mnyAbono) AS mnyAbonado, Detalle_CtasXPagar.Identificador FROM CtasXPagar
	                                     INNER JOIN Detalle_CtasXPagar ON CtasXPagar.intCtaXPagar_ID = Detalle_CtasXPagar.intCtaXPagar_ID
		                       GROUP BY intOrdenCompra_ID, Detalle_CtasXPagar.Identificador
	                                   )  Abonos ON  #Ordenes.intOrdenCompra_ID = Abonos.intOrdenCompra_ID AND Abonos.Identificador = #Ordenes.intIdentificador
	ORDER BY  #Ordenes.intOrdenCompra_ID

BEGIN TRANSACTION

OPEN Abonos_Cursor

FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @Abono, @CtaXPagar

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE CtasXPagar SET mnySaldo = mnySaldo + @Abono, mnyAbonado = mnyAbonado - @Abono
	WHERE intOrdenCompra_ID = @Clave
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		DELETE FROM Detalle_CtasXPagar WHERE intCtaXPagar_ID = @CtaXPagar AND Identificador = @Id_Identificador
		SET @Status = @@ROWCOUNT
	END

	FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @Abono, @CtaXPagar
END

CLOSE Abonos_Cursor
DEALLOCATE Abonos_Cursor

DROP TABLE #Ordenes

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_CancelarOrdenCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_CancelarOrdenCompra]
@OrdenCompra_ID	int,
@OrdenAbierta		int,
@MatanzaAbierta	int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Ganado_Pie int, @Producto int, @TipoProducto int

BEGIN TRANSACTION

--SET @OrdenCompra_ID = 591
--SET @OrdenAbierta = 0
--SET @MatanzaAbierta = 1

SET @TipoProducto = ISNULL((SELECT COUNT(*) FROM Matanzas
                                                   LEFT OUTER JOIN Relacion_Matanza ON Matanzas.intProducto_ID = Relacion_Matanza.intProducto_Canal
                                                   LEFT OUTER JOIN Detalle_Orden_Compra ON Matanzas.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID AND Relacion_Matanza.intProducto_Pie = Detalle_Orden_Compra.intProducto_ID
                                                  WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID 
                                                        AND bitProcesado = 0
                                                       AND NOT Detalle_Orden_Compra.intOrdenCompra_ID IS NULL),0)

-- Tiene Sub-Producto (Ganado en Pie -> 1/2 Canal)
IF @TipoProducto = 0
BEGIN
	IF @MatanzaAbierta <> 0
	BEGIN
		UPDATE Movimientos SET bitCancelado = 1
		WHERE intOrdenCompra_ID = @OrdenCompra_ID
		      AND intProducto_ID IN (SELECT intProducto_ID FROM Matanzas WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID AND bitProcesado = 0)
		SET @Status = @@ROWCOUNT
	
		IF @Status <> 0
		BEGIN
			UPDATE Detalle_Orden_Compra SET intCantidad = 0, intCantidad_Recibida = 0 
			WHERE intOrdenCompra_ID = @OrdenCompra_ID 
		                   AND intProducto_ID IN (SELECT intProducto_ID FROM Matanzas WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID AND bitProcesado = 0)
			SET @Status = @@ROWCOUNT
		END
	END
	ELSE
	BEGIN
		UPDATE Detalle_Orden_Compra SET intCantidad = 0, intCantidad_Recibida = 0 
		WHERE intOrdenCompra_ID = @OrdenCompra_ID 
		SET @Status = @@ROWCOUNT
	END
END
ELSE
BEGIN
	UPDATE Movimientos SET bitCancelado = 1
	WHERE intOrdenCompra_ID = @OrdenCompra_ID
                   AND intProducto_ID IN (SELECT Detalle_Orden_Compra.intProducto_ID FROM Matanzas
	                                            LEFT OUTER JOIN Relacion_Matanza ON Matanzas.intProducto_ID = Relacion_Matanza.intProducto_Canal
	                                            LEFT OUTER JOIN Detalle_Orden_Compra ON Matanzas.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID AND Relacion_Matanza.intProducto_Pie = Detalle_Orden_Compra.intProducto_ID
	                                            WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID AND bitProcesado = 0 AND NOT Detalle_Orden_Compra.intOrdenCompra_ID IS NULL)
	SET @Status = @@ROWCOUNT

	IF @Status <> 0 
	BEGIN
		UPDATE Detalle_Orden_Compra SET intCantidad = 0, intCantidad_Recibida = 0 
		WHERE intOrdenCompra_ID = @OrdenCompra_ID 
                                 AND intProducto_ID IN (SELECT Detalle_Orden_Compra.intProducto_ID FROM Matanzas
	                                                           LEFT OUTER JOIN Relacion_Matanza ON Matanzas.intProducto_ID = Relacion_Matanza.intProducto_Canal
	                                                           LEFT OUTER JOIN Detalle_Orden_Compra ON Matanzas.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID AND Relacion_Matanza.intProducto_Pie = Detalle_Orden_Compra.intProducto_ID
  	                                                           WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID AND bitProcesado = 0 AND NOT Detalle_Orden_Compra.intOrdenCompra_ID IS NULL)
		SET @Status = @@ROWCOUNT
	END
END

IF @Status <> 0 AND @MatanzaAbierta <> 0
BEGIN
	UPDATE Matanzas SET bitCancelado = 1 WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID AND bitProcesado = 0
	SET @Status = @@ROWCOUNT
END

IF @Status <> 0
BEGIN
--	IF (SELECT SUM(intCantidad) FROM Detalle_Orden_Compra WHERE intOrdenCompra_ID = @OrdenCompra_ID) = 0
--	BEGIN
		UPDATE CtasXPagar SET bitCancelado = 1 WHERE intOrdenCompra_ID = @OrdenCompra_ID
		SET @Status = @@ROWCOUNT

		UPDATE Orden_Compra SET bitCancelado = 1 WHERE intOrdenCompra_ID = @OrdenCompra_ID
		SET @Status = @@ROWCOUNT
--	END
END

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_CorregirAbonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_CorregirAbonos]
@Cliente_ID		int,
@Remisiones		varchar(8000),
@TipoCuenta		char(1),
@Almacen	              int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Identificador varchar(10), @Monto varchar(50), @Remision varchar(10), @Caracter char(1), @Contador int, @Remision_Procesada bit, @Identificador_Procesado bit, @Monto_Procesado bit, @Clave int, @RemisionNo int, @CtaXCobrar int, @Abono money, @Nuevo_Abono money, @Abono_Remision money, @CxC int, @Id_Identificador int, @Abono_Tmp money, @Importe money, @Primera_Vez int, @Id_Identificador_Detalle int

CREATE TABLE #Remisiones (
intRemision_ID       int,
mnyAbono	      money,
intIdentificador       int,
dtmFecha               smalldatetime)

SET @Primera_Vez = 0
SET @Posicion = 1
SET @Contador = LEN(@Remisiones)
SET @Remision_Procesada = 0
SET @Identificador_Procesado = 0
SET @Monto_Procesado = 0
SET @Remision = ''
SET @Identificador = ''
SET @Monto = ''

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Remisiones,@Posicion,1) 

	IF @Remision_Procesada = 0
	BEGIN
		IF @Caracter <> '='
			SET @Remision = RTRIM(@Remision) + @Caracter
		ELSE
			SET @Remision_Procesada = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 0 AND @Caracter <> '='
	BEGIN
		IF @Caracter <> '#'
			SET @Identificador = @Identificador + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 1 AND @Monto_Procesado = 0 AND @Caracter <> '#'
	BEGIN
		IF @Caracter <> ','
			SET @Monto = @Monto + @Caracter
		ELSE
			SET @Monto_Procesado = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 1 AND @Monto_Procesado = 1
	BEGIN
		IF @TipoCuenta = 'R'
			INSERT INTO #Remisiones (intRemision_ID, mnyAbono, intIdentificador) VALUES (@Remision, CONVERT(MONEY,@Monto), @Identificador)
		ELSE
			INSERT INTO #Remisiones (intRemision_ID, mnyAbono, dtmFecha) VALUES (@Remision, CONVERT(MONEY,@Monto), @Identificador)

		SET @Remision_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Monto_Procesado = 0
		SET @Remision = ''
		SET @Identificador = ''
		SET @Monto = ''
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

DECLARE Abonos_Cursor CURSOR FOR
	SELECT intRemision_ID, Identificador, intCtaXCobrar, mnyAbono, Nuevo_Abono FROM (
		SELECT #Remisiones.intRemision_ID, ISNULL(Detalle_CtasXCobrar.Identificador,0) AS Identificador,  ISNULL(CASE WHEN @TipoCuenta = 'R' THEN Detalle_CtasXCobrar.mnyAbono ELSE Abonos.mnyAbonado END,0) AS mnyAbono, CASE WHEN @TipoCuenta = 'R' THEN CtasXCobrar.intCtaXCobrar_ID ELSE 0 END AS intCtaXCobrar, #Remisiones.mnyAbono AS Nuevo_Abono FROM #Remisiones
		LEFT OUTER JOIN CtasXCobrar ON  (#Remisiones.intRemision_ID = CtasXCobrar.intRemisionNo AND @TipoCuenta = 'R') OR  (#Remisiones.intRemision_ID = CtasXCobrar.intFactura_ID AND @TipoCuenta = 'F') AND CtasXCobrar.intAlmacen_ID = @Almacen
--		LEFT OUTER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID AND ((Detalle_CtasXCobrar.Identificador = #Remisiones.intIdentificador AND @TipoCuenta = 'R') OR (Detalle_CtasXCobrar.dtmFecha_Abono BETWEEN #Remisiones.dtmFecha AND #Remisiones.dtmFecha + '23:59' AND @TipoCuenta = 'F'))
		LEFT OUTER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID AND Detalle_CtasXCobrar.Identificador = #Remisiones.intIdentificador AND @TipoCuenta = 'R'
		LEFT OUTER JOIN  (SELECT intFactura_ID, SUM(Detalle_CtasXCobrar.mnyAbono) AS mnyAbonado, CASE WHEN @TipoCuenta = 'R' THEN Detalle_CtasXCobrar.Identificador ELSE Detalle_CtasXCobrar.dtmFecha_Abono END AS Identificador, Detalle_CtasXCobrar.Identificador AS Indice FROM CtasXCobrar
		                                     INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
				         WHERE intAlmacen_ID = @Almacen
			                       GROUP BY intFactura_ID, CASE WHEN @TipoCuenta = 'R' THEN Detalle_CtasXCobrar.Identificador ELSE Detalle_CtasXCobrar.dtmFecha_Abono END, Detalle_CtasXCobrar.Identificador
		                                   )  Abonos ON  #Remisiones.intRemision_ID = Abonos.intFactura_ID AND (Abonos.Indice = #Remisiones.intIdentificador AND @TipoCuenta = 'R' OR Abonos.Indice = Detalle_CtasXCobrar.Identificador AND @TipoCuenta = 'F')
		) Temporal 
	GROUP BY intRemision_ID, Identificador, intCtaXCobrar, mnyAbono, Nuevo_Abono
	ORDER BY  intRemision_ID

BEGIN TRANSACTION

OPEN Abonos_Cursor

FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @CtaXCobrar, @Abono, @Nuevo_Abono

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @TipoCuenta = 'R'
	BEGIN
		UPDATE CtasXCobrar SET mnySaldo = mnySaldo - (@Nuevo_Abono - @Abono), mnyAbonado = mnyAbonado + (@Nuevo_Abono - @Abono)
		WHERE intRemisionNo = @Clave AND intAlmacen_ID = @Almacen
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			UPDATE Remisiones SET  mnySaldo = mnySaldo - (@Nuevo_Abono - @Abono)
			WHERE intRemisionNo = @Clave AND intAlmacen_ID = @Almacen
			SET @Status = @@ROWCOUNT
		END
		
		IF @Status <> 0
		BEGIN
			UPDATE Detalle_CtasXCobrar SET mnyAbono = mnyAbono + (@Nuevo_Abono - @Abono)
			WHERE intCtaXCobrar_ID = @CtaXCobrar 
			      AND Identificador = @Id_Identificador
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			DELETE FROM Detalle_CtasXCobrar
			WHERE intCtaXCobrar_ID = @CtaXCobrar 
			      AND Identificador = @Id_Identificador
			      AND mnyAbono = 0
		END

		IF @Status <> 0
		BEGIN
			UPDATE Facturas SET mnySaldo = mnySaldo - (@Nuevo_Abono - @Abono)
			WHERE intFactura_ID = (SELECT intFactura_ID FROM Detalle_Facturas WHERE intRemisionNo = @Clave)
			SET @Status = @@ROWCOUNT
		END
	END
	ELSE
	BEGIN
		IF @Primera_Vez = 0
		BEGIN
			UPDATE Facturas SET mnySaldo = mnyImporte - @Nuevo_Abono
			WHERE intFactura_ID = @Clave
			SET @Importe = @Nuevo_Abono
			SET @Primera_Vez = 1
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			DECLARE Remisiones_Cursor CURSOR FOR
				SELECT CtasXCobrar.intCtaXCobrar_ID, CtasXCobrar.intRemisionNo, CtasXCobrar.mnyImporte, Detalle_CtasXCobrar.Identificador FROM CtasXCobrar
				LEFT OUTER JOIN  Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID -- AND Detalle_CtasXCobrar.Identificador = @Id_Identificador
				LEFT OUTER JOIN Remisiones ON  CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo AND CtasXCobrar.intAlmacen_ID = Remisiones.intAlmacen_ID
				WHERE CtasXCobrar.intFactura_ID = @Clave
                                                              AND CtasXCobrar.intAlmacen_ID = @Almacen
				      AND Detalle_CtasXCobrar.mnyAbono <> 0
				ORDER BY  CtasXCobrar.intRemisionNo DESC

			OPEN Remisiones_Cursor
			
			FETCH NEXT FROM Remisiones_Cursor  INTO @CxC, @RemisionNo, @Abono_Remision, @Id_Identificador_Detalle
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @Abono_Tmp = CASE WHEN @Importe > @Abono_Remision THEN @Abono_Remision ELSE @Importe END

				UPDATE CtasXCobrar SET mnySaldo = mnyImporte - @Abono_Tmp, mnyAbonado = @Abono_Tmp
				WHERE intRemisionNo = @RemisionNo AND intAlmacen_ID = @Almacen
				SET @Status = @@ROWCOUNT
		
				IF @Status <> 0
				BEGIN
					UPDATE Remisiones SET  mnySaldo = mnyImporte - @Abono_Tmp
					WHERE intRemisionNo = @RemisionNo AND intAlmacen_ID = @Almacen
					SET @Status = @@ROWCOUNT
				END

				IF @Status <> 0
				BEGIN
					UPDATE Detalle_CtasXCobrar  SET mnyAbono = mnyAbono - (mnyAbono - @Abono_Tmp)
					WHERE intCtaXCobrar_ID = @CXC AND Identificador = @Id_Identificador_Detalle
					SET @Status = @@ROWCOUNT
				END

				IF @Status <> 0
				BEGIN
					DELETE FROM Detalle_CtasXCobrar
					WHERE intCtaXCobrar_ID = @CXC 
					      AND Identificador = @Id_Identificador_Detalle
					      AND mnyAbono = 0
				END

				SET @Importe = @Importe - @Abono_Tmp

				FETCH NEXT FROM Remisiones_Cursor  INTO @CxC, @RemisionNo, @Abono_Remision, @Id_Identificador_Detalle
			END

			CLOSE Remisiones_Cursor
			DEALLOCATE Remisiones_Cursor

		END
	END

	FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @CtaXCobrar, @Abono, @Nuevo_Abono
END

CLOSE Abonos_Cursor
DEALLOCATE Abonos_Cursor

DROP TABLE #Remisiones

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_CorregirAbonosCXP]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_CorregirAbonosCXP]
@Ordenes		varchar(8000)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Identificador varchar(10), @Monto varchar(50), @Orden varchar(10), @Caracter char(1), @Contador int, @Orden_Procesada bit, @Identificador_Procesado bit, @Monto_Procesado bit, @Clave int, @CtaXPagar int, @Abono money, @Nuevo_Abono money, @Id_Identificador int

CREATE TABLE #Ordenes (
intOrdenCompra_ID     int,
mnyAbono	            money,
intIdentificador              int)

SET @Posicion = 1
SET @Contador = LEN(@Ordenes)
SET @Orden_Procesada = 0
SET @Identificador_Procesado = 0
SET @Monto_Procesado = 0
SET @Orden = ' '
SET @Identificador = ' '
SET @Monto = ' '

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Ordenes,@Posicion,1) 

	IF @Orden_Procesada = 0
	BEGIN
		IF @Caracter <> '='
			SET @Orden = RTRIM(@Orden) + @Caracter
		ELSE
			SET @Orden_Procesada = 1
	END

	IF @Orden_Procesada = 1 AND @Identificador_Procesado = 0 AND @Caracter <> '='
	BEGIN
		IF @Caracter <> '#'
			SET @Identificador = @Identificador + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Orden_Procesada = 1 AND @Identificador_Procesado = 1 AND @Monto_Procesado = 0 AND @Caracter <> '#'
	BEGIN
		IF @Caracter <> ','
			SET @Monto = @Monto + @Caracter
		ELSE
			SET @Monto_Procesado = 1
	END

	IF @Orden_Procesada = 1 AND @Identificador_Procesado = 1 AND @Monto_Procesado = 1
	BEGIN
		INSERT INTO #Ordenes (intOrdenCompra_ID, mnyAbono, intIdentificador) VALUES (@Orden, CONVERT(MONEY,@Monto), @Identificador)
		SET @Orden_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Monto_Procesado = 0
		SET @Orden = ' '
		SET @Identificador = ' '
		SET @Monto = ''
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

DECLARE Abonos_Cursor CURSOR FOR
	SELECT #Ordenes.intOrdenCompra_ID, #Ordenes.intIdentificador,  Detalle_CtasXPagar.mnyAbono, CtasXPagar.intCtaXPagar_ID, #Ordenes.mnyAbono AS Nuevo_Abono FROM #Ordenes
	LEFT OUTER JOIN CtasXPagar ON  #Ordenes.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	LEFT OUTER JOIN Detalle_CtasXPagar ON CtasXPagar.intCtaXPagar_ID = Detalle_CtasXPagar.intCtaXPagar_ID AND Detalle_CtasXPagar.Identificador = #Ordenes.intIdentificador
	LEFT OUTER JOIN  (SELECT intOrdenCompra_ID, SUM(Detalle_CtasXPagar.mnyAbono) AS mnyAbonado, Detalle_CtasXPagar.Identificador FROM CtasXPagar
	                                     INNER JOIN Detalle_CtasXPagar ON CtasXPagar.intCtaXPagar_ID = Detalle_CtasXPagar.intCtaXPagar_ID
		                       GROUP BY intOrdenCompra_ID, Detalle_CtasXPagar.Identificador
	                                   )  Abonos ON  #Ordenes.intOrdenCompra_ID = Abonos.intOrdenCompra_ID AND Abonos.Identificador = #Ordenes.intIdentificador
	ORDER BY  #Ordenes.intOrdenCompra_ID

BEGIN TRANSACTION

OPEN Abonos_Cursor

FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @Abono, @CtaXPagar, @Nuevo_Abono

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE CtasXPagar SET mnySaldo = mnySaldo - (@Nuevo_Abono - @Abono), mnyAbonado = mnyAbonado + (@Nuevo_Abono - @Abono)
	WHERE intOrdenCompra_ID = @Clave
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		UPDATE Detalle_CtasXPagar SET mnyAbono = mnyAbono + (@Nuevo_Abono - @Abono)
		WHERE intCtaXPagar_ID = @CtaXPagar 
		      AND Identificador = @Id_Identificador
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		DELETE FROM Detalle_CtasXPagar
		WHERE intCtaXPagar_ID = @CtaXPagar 
		      AND Identificador = @Id_Identificador
		      AND mnyAbono = 0
	END

	FETCH NEXT FROM Abonos_Cursor  INTO @Clave, @Id_Identificador, @Abono, @CtaXPagar, @Nuevo_Abono
END

CLOSE Abonos_Cursor
DEALLOCATE Abonos_Cursor

DROP TABLE #Ordenes

IF @Status <> 0
BEGIN
	COMMIT TRANSACTION
	RETURN 0
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	RETURN 99
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXML]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CrearArchivoXML]
	@Folio_ID	Int,
	@Sello		Varchar(8000),
	@Empresa	varchar(100)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie	varchar(20), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @XML_Conceptos XML, @LugarExpedicion varchar(100)

	SET @Serie = 'DCV'
	SET	@LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	CREATE TABLE #Comprobante
	(
		[Version] varchar(10),
		Serie varchar(20),
		Folio int,
		Fecha varchar(25),
		Sello varchar(500),
		NoCertificado varchar(40),
		Certificado varchar(4000),
		CondicionesDePago Varchar(50),
		SubTotal Varchar(20),
		TipoCambio Varchar(7),
		Moneda Varchar(20),
		Total Varchar(20),
		FormaPago Varchar(50),
		Descuento Varchar(30),
		TipoDeComprobante varchar(30),
		xsi varchar(300),
		xmlns varchar(300),
		xmlnsxsi varchar(300),
		MetodoPago Varchar(100),
		LugarExpedicion Varchar(100)
	)

	CREATE TABLE #Traslados
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Retenciones
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Emisor
	(
		Rfc varchar(30),
		Nombre varchar(300),
		RegimenFiscal	varchar(200)
	)

	CREATE TABLE #ImpuestosRetenidos
	(
		impuesto varchar(100),
		importe varchar(20),
		TasaOCuota	varchar(20),
		TipoFactor	varchar(10)
	)

	CREATE TABLE #Impuestos
	(
		totalImpuestosRetenidos Varchar(20),
		totalImpuestosTrasladados Varchar(20)
	)

	CREATE TABLE #ImpuestosTrasladados
	(
		impuesto varchar(100),
		importe varchar(20),
		TasaOCuota	varchar(20),
		TipoFactor	varchar(10)
	)

	CREATE TABLE #Receptor
	(
		Rfc varchar(30),
		Nombre varchar(300),
		UsoCFDI	varchar(20)
	)

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, FormaPago,descuento,tipoDeComprobante,xsi,xmlns,xmlnsxsi,MetodoPago,LugarExpedicion)
	SELECT @Serie, 
		DFE.vchVersion, 
		@Folio_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
		'Pago en una sola exhibicion',
		Rtrim(Ltrim(Convert(Char,Round(CV.mnySUBTOTAL,2)))),
		1.00,
        'MXN',
		Rtrim(Ltrim(Convert(Char,Round(cv.mnytotal,2)))),
		C.vchFormaPago,
		Rtrim(Ltrim(Convert(Char,Round(0.00,2)))),
		'I',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		C.vchMetodoPago,
		@LugarExpedicion As LugarExpedicion
	FROM Cab_Ventas CV
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID, Datos_FacturaElectronica DFE 
	WHERE CV.intFactura_ID = @Folio_ID

	INSERT INTO #Emisor(rfc,nombre,RegimenFiscal)
	SELECT vchRFC,@Empresa, (SELECT intRegimen_ID FROM REGIMEN_FISCALES) FROM Parametros

	INSERT INTO #Receptor(rfc,nombre,UsoCFDI)
	Select Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL, CC.vchUso_CFDI FROM CAB_VENTAS CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID, REGIMEN_FISCALES RF
	Where CV.intFactura_ID = @Folio_ID 

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Convert(DECIMAL(18,2),ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0))))),
			   Rtrim(Ltrim(Convert(Char,Convert(DECIMAL(18,2),isnull(mnyIVA,0)))))
		From CAB_VENTAS
		Where intFactura_ID = @Folio_ID
		--Select Rtrim(Ltrim(Convert(Char,Convert(DECIMAL(18,2),Case When ISNULL(mnyRetIVA,0) = 0 AND ISNULL(mnyRetISR,0) = 0 Then 0 Else ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0) End)))),
		--	   Rtrim(Ltrim(Convert(Char,Convert(DECIMAL(18,2),Case When ISNULL(mnyIVA,0) = 0 Then 0 Else isnull(mnyIVA,0) End ))))
		--From CAB_VENTAS
		--Where intFactura_ID = @Folio_ID
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe,TipoFactor,TasaOCuota)
		Select '002',	
			   Rtrim(Ltrim(Convert(Char,Round(ISNULL(mnyRetIVA,0),2)))),
			   'Tasa',
			   Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),ISNULL(mnyPRetIVA,0) / 100.00))))
		From CAB_VENTAS CV 
		Where intFactura_ID = @Folio_ID
		  and mnyRetIVA >= 0
		Union
		Select '001', 
			   Rtrim(Ltrim(Convert(Char,Round(ISNULL(mnyRetISR,0),2)))), 
			   'Tasa',
			   Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),ISNULL(mnyPRetISR,0) / 100.00))))
		From CAB_VENTAS CV 
		Where intFactura_ID = @Folio_ID
		  and mnyRetISR >= 0
		--Select Case When mnyRetIVA = 0 Then Null Else '002' End,	
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetIVA = 0 Then Null Else Round(mnyRetIVA,2) End))),
		--	   Case When mnyRetIVA = 0 Then Null Else 'Tasa' End,
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetIVA = 0 Then Null Else convert(decimal(18,6),mnyPRetIVA / 100.00) End)))
		--From CAB_VENTAS CV 
		--Where intFactura_ID = @Folio_ID
		--  and mnyRetIVA > 0
		--Union
		--Select Case When mnyRetISR = 0 Then Null Else '001' End, 
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetISR = 0 Then Null Else Round(mnyRetISR,2) End))), 
		--	   Case When mnyRetISR = 0 Then Null Else 'Tasa' End,
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetISR = 0 Then Null Else convert(decimal(18,6),mnyPRetISR / 100.00) End)))
		--From CAB_VENTAS CV 
		--Where intFactura_ID = @Folio_ID
		--  and mnyRetISR > 0
		
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,TipoFactor,tasaoCuota)
		Select  '002', 
				Rtrim(Ltrim(Convert(Char,convert(decimal(16,2),ISNULL(mnyIVA,0))))),
				'Tasa',
			    Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),ISNULL(mnyPIVA,0) / 100.00))))
		From CAB_VENTAS CV
		Where intFactura_ID = @Folio_ID
		 and mnyIVA >= 0
		--Select  Case When mnyIVA = 0 AND mnyRetIVA = 0 Then '002' Else '002' End, 
		--		Rtrim(Ltrim(Convert(Char,convert(decimal(16,2),Case When mnyIVA = 0 AND mnyRetIVA = 0 Then 0.00 Else mnyIVA End)))),
		--		'Tasa',
		--	    case when mnyIVA = 0 then 0.000000 else Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPIVA / 100.00)))) end
		--From CAB_VENTAS CV
		--Where intFactura_ID = @Folio_ID
		-- and mnyIVA >= 0

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	set @XML_Conceptos = (SELECT
	(
		SELECT ISNULL(DV.vchClaveProdServ,'01010101') AS ClaveProdServ, 
		       ISNULL(U.vchDescripcion,DV.vchUnidad) AS Unidad, 
			   DV.vchUnidad AS ClaveUnidad, 
			   CONVERT(DECIMAL(18,2),DV.mnyCantidad) AS Cantidad, 
			   ISNULL(DV.vchNoIdentificacion,DV.intRenglon) AS NoIdentificacion, 
			   DV.vchProducto AS Descripcion, 
			   CONVERT(DECIMAL(18,2),DV.mnyPrecio) AS ValorUnitario, 
			   CONVERT(DECIMAL(18,2),DV.mnyImporte) AS Importe,
			( 
				SELECT (SELECT T.Impuesto, T.Base, T.TipoFactor, T.TasaOCuota, T.Importe
						FROM vTrasladosXFactura T
						WHERE DV.intFactura_ID = T.intFactura_ID AND DV.intRenglon = T.intRenglon
						FOR XML RAW('Traslado'),TYPE
						)
				FOR XML RAW('Traslados'),TYPE

			),
			( 
				SELECT (SELECT R.Impuesto, R.Base, R.TipoFactor, R.TasaOCuota, R.Importe
						FROM vRetencionesXFactura R
						WHERE DV.intFactura_ID = R.intFactura_ID AND DV.intRenglon = R.intRenglon
						FOR XML RAW('Retencion'),TYPE
						)
				FOR XML RAW('Retenciones'),TYPE

			)
		FROM Det_Ventas DV
		LEFT OUTER JOIN Unidad_Medida U ON DV.vchUnidad = U.vchNombreCorto
		WHERE intFactura_ID = @Folio_ID
		FOR XML RAW('Concepto'), TYPE
	) FOR XML PATH(''), ROOT('Conceptos'))

	IF CHARINDEX('<Traslados/><Retenciones/>',CONVERT(VARCHAR(MAX),@XML_Conceptos)) > 0
		SET @XML_Conceptos = CONVERT(XML,REPLACE(REPLACE(CONVERT(VARCHAR(MAX),@XML_Conceptos),'<Traslados>','<Impuestos><Traslados>'),'<Traslados/><Retenciones/>','</Impuestos>'))
	ELSE
		IF CHARINDEX('<Retenciones/>',CONVERT(VARCHAR(MAX),@XML_Conceptos)) = 0
			SET @XML_Conceptos = CONVERT(XML,REPLACE(REPLACE(CONVERT(VARCHAR(MAX),@XML_Conceptos),'<Traslados>','<Impuestos><Traslados>'),'</Retenciones>','</Retenciones></Impuestos>'))
		ELSE
			SET @XML_Conceptos = CONVERT(XML,REPLACE(REPLACE(CONVERT(VARCHAR(MAX),@XML_Conceptos),'<Traslados>','<Impuestos><Traslados>'),'<Retenciones/>','</Impuestos>'))

	Set @XMLORIGINAL =
	(
	SELECT [Version],
	       LugarExpedicion, 
		   Serie, 
		   Folio, 
		   Fecha, 
		   SubTotal,
		   Descuento,
		   Moneda,
		   TipoCambio,
		   Total,
		   MetodoPago,
		   TipoDeComprobante,
		   FormaPago,
		   NoCertificado,
		   Certificado,
		   Sello,
		   xsi "xsi:schemaLocation",
		   xmlnsxsi "xmlns:xsi",		
		(SELECT Rfc,Nombre, RegimenFiscal FROM #Emisor "Emisor" FOR XML AUTO, TYPE),
		(SELECT Rfc,Nombre, UsoCFDI FROM #Receptor "Receptor" FOR XML AUTO, TYPE),
		@XML_Conceptos,
	(SELECT TotalImpuestosRetenidos, TotalImpuestosTrasladados,
		  (Select DISTINCT Borrame,Id_Borrado As Borrame2, Retencion.Impuesto, Retencion.importe As Importe
			From #Retenciones "Retenciones", #ImpuestosRetenidos "Retencion"
			FOR XML AUTO, TYPE),
		  (Select Borrame,Id_Borrado As Borrame2,Traslado.Impuesto, TipoFactor, Traslado.TasaOCuota, Traslado.importe Importe
			From #Traslados "Traslados", #ImpuestosTrasladados "Traslado"
			FOR XML AUTO, TYPE)
	FROM #Impuestos "Impuestos"
	FOR XML AUTO, TYPE)
	FROM #Comprobante Comprobante
	FOR XML AUTO, TYPE
	)

	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Retencion','cfdi:Retencion'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

	SET @XMLCHAR1 = REPLACE(REPLACE(@XMLCHAR1,'<Traslados>','<Impuestos><Traslados>'),'</Retenciones>','</Retenciones></Impuestos>')

	SELECT CONVERT(XML,@XMLCHAR1), '' AS Addenda

	DROP TABLE #Comprobante
	DROP TABLE #Emisor
	DROP TABLE #Receptor
	DROP TABLE #ImpuestosRetenidos
	DROP TABLE #ImpuestosTrasladados
	DROP TABLE #Impuestos
	DROP TABLE #Traslados
	DROP TABLE #Retenciones

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXML_Alsuper]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CrearArchivoXML_Alsuper]
	@Factura_ID Int,
	@Sello		Varchar(8000),
	@RazonSocial varchar(100)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @RetIVA money, @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @XMLADDENDA XML, @ADDENDA Varchar(Max), @ADDENDA_Conceptos Varchar(Max), @Remisiones varchar(1000), @OrdenCompra varchar(20), @Remision_cur int, @CostoPagar money, @LugarExpedicion varchar(100)

	SET @CostoPagar = (SELECT SUM((mnyPeso * mnyPrecio) / intNo_Cajas) FROM Det_Ventas WHERE intFactura_ID = @Factura_ID) 

	SET @OrdenCompra = (SELECT DISTINCT RIGHT('000000' + vchOrden_Compra,6) FROM CtasXCobrar WHERE intFactura_ID = @Factura_ID)

	SET @Remisiones = ''

	DECLARE Remisiones_CURSOR CURSOR FOR
		SELECT intRemisionNo FROM CtasXCobrar
		WHERE intFactura_ID = @Factura_ID

	OPEN Remisiones_CURSOR

	FETCH NEXT FROM Remisiones_CURSOR INTO @Remision_cur

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @Remisiones = @Remisiones + RTRIM(LTRIM(CONVERT(varchar,@Remision_cur))) + ','

		FETCH NEXT FROM Remisiones_CURSOR INTO @Remision_cur
	END
	
	CLOSE Remisiones_CURSOR
	DEALLOCATE Remisiones_CURSOR

	SET @Remisiones = SUBSTRING(@Remisiones,1,LEN(@Remisiones)-1)
	SET @RetIVA = 0
	SET	@LugarExpedicion = (SELECT vchCiudad + ',' + vchEstado FROM Parametros)

	CREATE TABLE #Comprobante
	(
		Serie varchar(20),
		[version] varchar(10),
		folio int,
		fecha varchar(25),
		sello varchar(500),
		noCertificado varchar(40),
		certificado varchar(4000),
		condicionesDePago Varchar(20),
		subTotal Varchar(20),
		TipoCambio Varchar(7),
		Moneda Varchar(20),
		total Varchar(20),
		formaDePago Varchar(50),
		descuento Varchar(30),
		tipoDeComprobante varchar(30),
		xsi varchar(300),
		xmlns varchar(300),
		xmlnsxsi varchar(300),
		xmlnsalsuper varchar(300),
		metodoDePago Varchar(100),
		LugarExpedicion Varchar(100),
		NumCtaPago Varchar(20)
	)

	CREATE TABLE #Concepto
	(
		no_renglon Int,
		cantidad varchar(20),
		unidad varchar(20),
		noIdentificacion varchar(30),
		descripcion varchar(1000),
		valorUnitario Varchar(20),
		importe Varchar(20)
	)

	CREATE TABLE #Conceptos
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #RegimenFiscal
	(
		Regimen Varchar(100) Not Null Default ''
	)

	CREATE TABLE #Traslados
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Retenciones
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Emisor
	(
		rfc varchar(30),
		nombre varchar(300)
	)

	CREATE TABLE #Domicilio
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(100),
		pais varchar(100),
		codigoPostal varchar(50)
	)

	CREATE TABLE #DomicilioSuc
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(50),
		pais varchar(50),
		codigoPostal varchar(50)
	)

	CREATE TABLE #ImpuestosRetenidos
	(
		impuesto varchar(100),
		importe varchar(20)
	)

	CREATE TABLE #Impuestos
	(
		totalImpuestosRetenidos Varchar(20),
		totalImpuestosTrasladados Varchar(20)
	)

	CREATE TABLE #ImpuestosTrasladados
	(
		impuesto varchar(100),
		tasa varchar(20),
		importe varchar(20)
	)

	CREATE TABLE #Receptor
	(
		rfc varchar(30),
		nombre varchar(300)
	)

	CREATE TABLE #DomicilioReceptor
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(100),
		pais varchar(100),
		codigoPostal varchar(50),
	)

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, formaDePago,descuento,tipoDeComprobante,xsi,xmlns,xmlnsxsi,xmlnsAlsuper,metodoDePago,LugarExpedicion,NumCtaPago)
	SELECT 'DCV', 
		DFE.vchVersion, 
       		@Factura_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
--		CV.vchTipo_Pago,
		'CONTADO',
		Rtrim(Ltrim(Convert(Char,Round(CV.mnySUBTOTAL,2)))),
		1.00,
        'MXN',
		Rtrim(Ltrim(Convert(Char,Round(cv.mnytotal,2)))),
		'Pago en una sola exhibicion',
		Rtrim(Ltrim(Convert(Char,Round(0.00,2)))),
		'ingreso',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		'http://proveedores.alsuper.com/CFD',
		ISNULL(C.vchMetodoPago,'No identificado'),
		@LugarExpedicion As LugarExpedicion,
		CASE WHEN LEN(ISNULL(C.vchCuentaBancaria,'')) < 4 THEN '0000' ELSE C.vchCuentaBancaria END AS NumCtaPago
	FROM Cab_Ventas CV
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID, Datos_FacturaElectronica DFE
	WHERE CV.intFactura_ID = @Factura_ID

	INSERT INTO #Emisor(rfc,nombre)
	SELECT vchRFC,@RazonSocial FROM Parametros

	INSERT INTO #Domicilio(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	SELECT rtrim(vchDireccion),vchNoExterior,vchNoInterior,vchCOLONIA,vchCiudad,vchCiudad,
		vchEstado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais)),vchCODIGOPOSTAL, vchReferencia
	FROM Parametros

	INSERT INTO #Receptor(rfc,nombre)
	Select Case When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) End, 
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN CC.vchRAZONSOCIAL = '' OR CC.vchRAZONSOCIAL IS NULL THEN RTRIM(CC.vchNombre) +  ' ' + RTRIM(CC.vchApellidoPaterno) + ' ' + RTRIM(CC.vchApellidoMaterno) ELSE CC.vchRAZONSOCIAL END ELSE CASE WHEN FT.vchRAZONSOCIAL = '' OR FT.vchRAZONSOCIAL IS NULL THEN RTRIM(FT.vchNombre) +  ' ' + RTRIM(FT.vchApellidoPaterno) + ' ' + RTRIM(FT.vchApellidoMaterno) ELSE FT.vchRAZONSOCIAL END END 
    FROM CAB_VENTAS CV
	INNER JOIN Facturas ON CV.intFactura_ID = Facturas.intFactura_ID
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON Facturas.intCliente_Tercero = FT.intCliente_Tercero_ID AND CV.intCliente_ID = FT.intCliente_ID
	Where CV.intFactura_ID = @Factura_ID

	INSERT INTO #DomicilioReceptor (calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	Select CASE WHEN Facturas.intCliente_Tercero = 0 THEN cc.vchDireccion ELSE FT.vchDireccion END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchNoExterior ELSE FT.vchNoExterior END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchNoInterior ELSE FT.vchNoInterior END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCOLONIA ELSE FT.vchCOLONIA END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCIUDAD ELSE FT.vchCIUDAD END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCiudad ELSE FT.vchCiudad END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchEstado ELSE FT.vchEstado END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais)) ELSE SUBSTRING(FT.vchPais,CHARINDEX('-',FT.vchPais,1 )+1,LEN(FT.vchPais)) END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCODIGOPOSTAL ELSE FT.vchCODIGOPOSTAL END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchReferencia ELSE FT.vchReferencia END
	From CAB_VENTAS CV
	INNER JOIN Facturas ON CV.intFactura_ID = Facturas.intFactura_ID
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON Facturas.intCliente_Tercero = FT.intCliente_Tercero_ID AND CV.intCliente_ID = FT.intCliente_ID
	Where CV.intFactura_ID = @Factura_ID

	INSERT INTO #DomicilioSuc(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
		Select vchDireccion,vchNoExTerior ,vchNoInterior ,vchCOLONIA ,vchCiudad,vchCiudad,
			vchestado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais))
			,vchCODIGOPOSTAL,vchREFERENCIA
		From Parametros SUC

	INSERT INTO #RegimenFiscal
	SELECT vchNombre FROM REGIMEN_FISCALES

	Update #DomicilioSuc SET calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End
		
	Update #Domicilio SET calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End

	Update #DomicilioReceptor SET calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End

	INSERT INTO #Concepto(cantidad,unidad,noIdentificacion,descripcion, valorUnitario ,importe,no_renglon)
	Select Ltrim(Rtrim(Convert(Char,Round(VDV.mnycantidad,2)))),
		dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(vchUnidad),'')))),
		'',
		dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CASE WHEN CB.vchDescripcion <> '' THEN CB.vchDescripcion ELSE vchProducto END),'')))),
		Ltrim(Rtrim(Convert(Char,Round(VDV.mnyPrecio,2))))
		,LTRIM(Rtrim(Convert(Char,mnyImporte))),intRenglon
	From Det_Ventas VDV
	LEFT OUTER JOIN CodigoBarras_Proveedor CB ON VDV.vchCodigo_Barras = CB.vchCodigoBarras_Proveedor
	WHERE VDV.intFactura_ID = @Factura_ID
	Order By intRenglon

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When @RetIVA = 0 Then Null Else @RetIVA End,2))))
			,Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		From CAB_VENTAS
		Where intFactura_ID = @Factura_ID
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe)
		Select Case When @RetIVA = 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When @RetIVA = 0 Then Null Else @RetIVA End,2))))
		From CAB_VENTAS CV 
		Where intFactura_ID = @Factura_ID
		 and @RetIVA > 0
			
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select Case When mnyIVA = 0 OR @RetIVA > 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 OR @RetIVA > 0 Then Null Else mnyIVA End,2))))
			, case when @RetIVA > 0 then null else Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) end
		From CAB_VENTAS CV
		Where intFactura_ID = @Factura_ID
		 and mnyIVA > 0

	INSERT INTO #Conceptos(Borrame)
	Select '1'

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	SET @XMLORIGINAL =
	(
	SELECT version,serie,folio,fecha,sello,tipoDeComprobante,
		formaDePago,condicionesDePago,noCertificado,certificado,
		subTotal,descuento,Moneda,TipoCambio,total,metodoDePago,LugarExpedicion,NumCtaPago,xsi "xsi:schemaLocation",xmlnsxsi "xmlns:xsi",xmlnsAlsuper,
		  (SELECT rfc,nombre,
		  (SELECT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,
				pais,codigoPostal
		   FROM #Domicilio "DomicilioFiscal"
		   FOR XML AUTO, TYPE),
		  (SELECT DISTINCT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #DomicilioSuc  "ExpedidoEn"
		   FOR XML AUTO, TYPE),(Select Regimen From #RegimenFiscal RegimenFiscal For XML AUTO, TYPE)
	FROM #Emisor "Emisor"
	FOR XML AUTO, TYPE),
		  (SELECT DISTINCT rfc,nombre,calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #Receptor Receptor,#DomicilioReceptor  "Domicilio"
		   FOR XML AUTO, TYPE),
	(Select Isnull(Conceptos.Borrame,'') Borrame , Id_Borrado As Borrame2, Concepto.cantidad, Concepto.unidad, 
		 Concepto.descripcion, Concepto.valorUnitario, Concepto.importe
	From #Conceptos Conceptos, #Concepto Concepto
	Order By Concepto.no_renglon 
	For XML AUTO,TYPE),
	(SELECT totalImpuestosRetenidos, totalImpuestosTrasladados,
		  (Select Borrame,Id_Borrado As Borrame2,Retencion.impuesto, Retencion.importe As importe
			From #Retenciones "Retenciones", #ImpuestosRetenidos "Retencion"
			FOR XML AUTO, TYPE),
		  (Select Borrame,Id_Borrado As Borrame2,Traslado.impuesto, Traslado.tasa tasa,Traslado.importe importe
			From #Traslados "Traslados", #ImpuestosTrasladados "Traslado"
			FOR XML AUTO, TYPE)
	FROM #Impuestos "Impuestos"
	FOR XML AUTO, TYPE)
	FROM #Comprobante Comprobante
	FOR XML AUTO, TYPE
	)

	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://proveedores.alsuper.com/CFD http://proveedores.alsuper.com/addenda/1.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'ExpedidoEn','cfdi:ExpedidoEn'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'RegimenFiscal','cfdi:RegimenFiscal'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Domicilio','<cfdi:Domicilio'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xmlnsalsuper','xmlns:alsuper'))

	SET @ADDENDA = '<cfdi:Addenda>'
	SET @ADDENDA = @ADDENDA + '<alsuper:Alsuper version="1.0" remision="' + @Remisiones + '" ordenDeCompra="' + @OrdenCompra + '" sucursal="10092000" tipoMoneda="Pesos" tipoBulto="cajas" email="recepcion@cfd.alsuper.com" >'
	SET @ADDENDA = @ADDENDA + '<alsuper:Conceptos>'

	SET @xmlADDENDA = (SELECT intRenglon AS noPartida, alsuperConcepto.vchCodigo_Barras AS codigoDeBarras, 1 AS factorEmpaque, intNo_Cajas AS empaqueIngreso, @CostoPagar AS costoPagar, 0 AS valorIva, 0 AS valorIeps FROM Det_Ventas alsuperConcepto
	                   WHERE intFactura_ID = @Factura_ID
	                   ORDER BY intRenglon 
	                   For XML AUTO,TYPE)

	SET @ADDENDA_Conceptos = CONVERT(varchar(MAX),@xmlADDENDA)
	
	SET @ADDENDA_Conceptos = (Replace(@ADDENDA_Conceptos,'alsuperConcepto','alsuper:Concepto'))
	
	SET @ADDENDA = @ADDENDA + @ADDENDA_Conceptos
	SET @ADDENDA = @ADDENDA + '</alsuper:Conceptos>'
	SET @ADDENDA = @ADDENDA + '</alsuper:Alsuper>'
	SET @ADDENDA = @ADDENDA + '</cfdi:Addenda>'

	SELECT CONVERT(XML,@XMLCHAR1) AS XML_Data, @ADDENDA AS Addenda

	DROP TABLE #Comprobante
	DROP TABLE #Emisor
	DROP TABLE #Domicilio
	DROP TABLE #DomicilioSuc
	DROP TABLE #Receptor
	DROP TABLE #DomicilioReceptor
	DROP TABLE #Concepto
	DROP TABLE #Conceptos
	DROP TABLE #ImpuestosRetenidos
	DROP TABLE #ImpuestosTrasladados
	DROP TABLE #Impuestos
	DROP TABLE #Traslados
	DROP TABLE #Retenciones
	DROP TABLE #RegimenFiscal

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXML_v32]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CrearArchivoXML_v32]
	@Factura_ID Int,
	@Sello		Varchar(8000),
	@RazonSocial varchar(100)
AS

BEGIN
	SET NOCOUNT ON;

	IF (SELECT vchAddenda FROM Clientes WHERE intCliente_ID IN (SELECT intCliente_ID FROM Facturas WHERE intFactura_ID = @Factura_ID)) = 'Alsuper'
	BEGIN
		EXEC Sp_CrearArchivoXML_Alsuper @Factura_ID, @Sello, @RazonSocial
		RETURN
	END

	DECLARE @RetIVA money, @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @LugarExpedicion varchar(100)

	SET @RetIVA = 0
	SET	@LugarExpedicion = (SELECT vchCiudad + ',' + vchEstado FROM Parametros)

	CREATE TABLE #Comprobante
	(
		Serie varchar(20),
		[version] varchar(10),
		folio int,
		fecha varchar(25),
		sello varchar(500),
		noCertificado varchar(40),
		certificado varchar(4000),
		condicionesDePago Varchar(20),
		subTotal Varchar(20),
		TipoCambio Varchar(7),
		Moneda Varchar(20),
		total Varchar(20),
		formaDePago Varchar(50),
		descuento Varchar(30),
		tipoDeComprobante varchar(30),
		xsi varchar(300),
		xmlns varchar(300),
		xmlnsxsi varchar(300),
		metodoDePago Varchar(100),
		LugarExpedicion Varchar(100),
		NumCtaPago Varchar(20)
	)

	CREATE TABLE #Concepto
	(
		no_renglon Int,
		cantidad varchar(20),
		unidad varchar(20),
		noIdentificacion varchar(30),
		descripcion varchar(1000),
		valorUnitario Varchar(20),
		importe Varchar(20)
	)

	CREATE TABLE #Conceptos
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #RegimenFiscal
	(
		Regimen Varchar(200) Not Null Default ''
	)

	CREATE TABLE #Traslados
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Retenciones
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Emisor
	(
		rfc varchar(30),
		nombre varchar(300)
	)

	CREATE TABLE #Domicilio
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(100),
		pais varchar(100),
		codigoPostal varchar(50)
	)

	CREATE TABLE #DomicilioSuc
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(50),
		pais varchar(50),
		codigoPostal varchar(50)
	)

	CREATE TABLE #ImpuestosRetenidos
	(
		impuesto varchar(100),
		importe varchar(20)
	)

	CREATE TABLE #Impuestos
	(
		totalImpuestosRetenidos Varchar(20),
		totalImpuestosTrasladados Varchar(20)
	)

	CREATE TABLE #ImpuestosTrasladados
	(
		impuesto varchar(100),
		tasa varchar(20),
		importe varchar(20)
	)

	CREATE TABLE #Receptor
	(
		rfc varchar(30),
		nombre varchar(300)
	)

	CREATE TABLE #DomicilioReceptor
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(100),
		pais varchar(100),
		codigoPostal varchar(50),
	)

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, formaDePago,descuento,tipoDeComprobante, xsi,xmlns,xmlnsxsi,metodoDePago,LugarExpedicion,NumCtaPago)
	SELECT 'DCV', 
		DFE.vchVersion, 
       		@Factura_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
--		CV.vchTipo_Pago,
		'CONTADO',
		Rtrim(Ltrim(Convert(Char,Round(CV.mnySUBTOTAL,2)))),
		1.00,
        'MXN',
		Rtrim(Ltrim(Convert(Char,Round(cv.mnytotal,2)))),
		'Pago en una sola exhibicion',
		Rtrim(Ltrim(Convert(Char,Round(0.00,2)))),
		'ingreso',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		ISNULL(C.vchMetodoPago,'No identificado'),
		@LugarExpedicion As LugarExpedicion,
		CASE WHEN LEN(ISNULL(C.vchCuentaBancaria,'')) < 4 THEN '0000' ELSE C.vchCuentaBancaria END AS NumCtaPago
	FROM Cab_Ventas CV
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID, Datos_FacturaElectronica DFE
	WHERE CV.intFactura_ID = @Factura_ID

	INSERT INTO #Emisor(rfc,nombre)
	SELECT vchRFC,@RazonSocial FROM Parametros

	INSERT INTO #Domicilio(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	SELECT rtrim(vchDireccion),vchNoExterior,vchNoInterior,vchCOLONIA,vchCiudad,vchCiudad,
		vchEstado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais)),vchCODIGOPOSTAL, vchReferencia
	FROM Parametros

	INSERT INTO #Receptor(rfc,nombre)
	Select Case When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) End, 
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN CC.vchRAZONSOCIAL = '' OR CC.vchRAZONSOCIAL IS NULL THEN RTRIM(CC.vchNombre) +  ' ' + RTRIM(CC.vchApellidoPaterno) + ' ' + RTRIM(CC.vchApellidoMaterno) ELSE CC.vchRAZONSOCIAL END ELSE CASE WHEN FT.vchRAZONSOCIAL = '' OR FT.vchRAZONSOCIAL IS NULL THEN RTRIM(FT.vchNombre) +  ' ' + RTRIM(FT.vchApellidoPaterno) + ' ' + RTRIM(FT.vchApellidoMaterno) ELSE FT.vchRAZONSOCIAL END END 
    FROM CAB_VENTAS CV
	INNER JOIN Facturas ON CV.intFactura_ID = Facturas.intFactura_ID
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON Facturas.intCliente_Tercero = FT.intCliente_Tercero_ID AND CV.intCliente_ID = FT.intCliente_ID
	Where CV.intFactura_ID = @Factura_ID

	INSERT INTO #DomicilioReceptor (calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	Select CASE WHEN Facturas.intCliente_Tercero = 0 THEN cc.vchDireccion ELSE FT.vchDireccion END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchNoExterior ELSE FT.vchNoExterior END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchNoInterior ELSE FT.vchNoInterior END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCOLONIA ELSE FT.vchCOLONIA END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCIUDAD ELSE FT.vchCIUDAD END,
	       CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCiudad ELSE FT.vchCiudad END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchEstado ELSE FT.vchEstado END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais)) ELSE SUBSTRING(FT.vchPais,CHARINDEX('-',FT.vchPais,1 )+1,LEN(FT.vchPais)) END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCODIGOPOSTAL ELSE FT.vchCODIGOPOSTAL END,
		   CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchReferencia ELSE FT.vchReferencia END
	From CAB_VENTAS CV
	INNER JOIN Facturas ON CV.intFactura_ID = Facturas.intFactura_ID
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON Facturas.intCliente_Tercero = FT.intCliente_Tercero_ID AND CV.intCliente_ID = FT.intCliente_ID
	Where CV.intFactura_ID = @Factura_ID

	INSERT INTO #RegimenFiscal
	SELECT vchNombre FROM REGIMEN_FISCALES

	INSERT INTO #DomicilioSuc(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
		Select vchDireccion,vchNoExTerior ,vchNoInterior ,vchCOLONIA ,vchCiudad,vchCiudad,
			vchestado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais))
			,vchCODIGOPOSTAL,vchREFERENCIA
		From Parametros SUC
		
	Update #DomicilioSuc SET calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End
		
	Update #Domicilio SET calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End

	Update #DomicilioReceptor SET calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End

	INSERT INTO #Concepto(cantidad,unidad,noIdentificacion,descripcion, valorUnitario ,importe,no_renglon)
	Select Ltrim(Rtrim(Convert(Char,Round(VDV.mnycantidad,2)))),
		dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(vchUnidad),'')))),
--		Ltrim(Rtrim(Isnull(Convert(Char,isnull(VDV.intRenglon,0)),''))),
		'',
		dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CASE WHEN CB.vchDescripcion <> '' THEN CB.vchDescripcion ELSE vchProducto END),'')))),
		Ltrim(Rtrim(Convert(Char,Round(VDV.mnyPrecio,2))))
		,LTRIM(Rtrim(Convert(Char,mnyImporte))),intRenglon
	From Det_Ventas VDV
	LEFT OUTER JOIN CodigoBarras_Proveedor CB ON VDV.vchCodigo_Barras = CB.vchCodigoBarras_Proveedor
	WHERE VDV.intFactura_ID = @Factura_ID
	Order By intRenglon

/*

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When @RetIVA = 0 Then Null Else @RetIVA End,2))))
--		Select Rtrim(Ltrim(Convert(Char,Round(@RetIVA,2))))
			,Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
--			,Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2))))
		From CAB_VENTAS
		Where intFactura_ID = @Factura_ID

*/

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When @RetIVA = 0 Then Null Else @RetIVA End,2))))
			,Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2))))
		From CAB_VENTAS
		Where intFactura_ID = @Factura_ID
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe)
		Select Case When @RetIVA = 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When @RetIVA = 0 Then Null Else @RetIVA End,2))))
		From CAB_VENTAS CV 
		Where intFactura_ID = @Factura_ID
		 and @RetIVA > 0

/*

	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select Case When mnyIVA = 0 OR @RetIVA > 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 OR @RetIVA > 0 Then Null Else mnyIVA End,2))))
			, case when @RetIVA > 0 then null else Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) end
		From CAB_VENTAS CV
		Where intFactura_ID = @Factura_ID
		 and mnyIVA > 0

*/
			
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select 'IVA', 
			Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2))))
			, Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2))))
		From CAB_VENTAS CV
		Where intFactura_ID = @Factura_ID

	 
--		Select 'IVA', 
--			Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))),
--			Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) 
--		From CAB_VENTAS CV
--		Where intFactura_ID = @Factura_ID

	INSERT INTO #Conceptos(Borrame)
	Select '1'

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	SET @XMLORIGINAL =
	(
	SELECT version,serie,folio,fecha,sello,tipoDeComprobante,
		formaDePago,condicionesDePago,noCertificado,certificado,
		subTotal,descuento,Moneda,TipoCambio,total,metodoDePago,LugarExpedicion,NumCtaPago,xsi "xsi:schemaLocation",xmlnsxsi "xmlns:xsi",
		  (SELECT rfc,nombre,
		  (SELECT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,
				pais,codigoPostal
		   FROM #Domicilio "DomicilioFiscal"
		   FOR XML AUTO, TYPE),
		  (SELECT DISTINCT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #DomicilioSuc  "ExpedidoEn"
		   FOR XML AUTO, TYPE),(Select Regimen From #RegimenFiscal RegimenFiscal For XML AUTO, TYPE)
	FROM #Emisor "Emisor"
	FOR XML AUTO, TYPE),
		  (SELECT DISTINCT rfc,nombre,calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #Receptor Receptor,#DomicilioReceptor  "Domicilio"
		   FOR XML AUTO, TYPE),
	(Select Isnull(Conceptos.Borrame,'') Borrame , Id_Borrado As Borrame2, Concepto.cantidad, Concepto.unidad, 
		 Concepto.descripcion, Concepto.valorUnitario, Concepto.importe
	From #Conceptos Conceptos, #Concepto Concepto
	Order By Concepto.no_renglon 
	For XML AUTO,TYPE),
	(SELECT totalImpuestosRetenidos, totalImpuestosTrasladados,
		  (Select Borrame,Id_Borrado As Borrame2,Retencion.impuesto, Retencion.importe As importe
			From #Retenciones "Retenciones", #ImpuestosRetenidos "Retencion"
			FOR XML AUTO, TYPE),
		  (Select Borrame,Id_Borrado As Borrame2,Traslado.impuesto, Traslado.tasa tasa,Traslado.importe importe
			From #Traslados "Traslados", #ImpuestosTrasladados "Traslado"
			FOR XML AUTO, TYPE)
	FROM #Impuestos "Impuestos"
	FOR XML AUTO, TYPE)
	FROM #Comprobante Comprobante
	FOR XML AUTO, TYPE
	)

	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

--	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'DomicilioFiscal','cfdi:DomicilioFiscal'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'ExpedidoEn','cfdi:ExpedidoEn'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Domicilio','<cfdi:Domicilio'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'RegimenFiscal','cfdi:RegimenFiscal'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

--	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'Impuestos ','cfdi:Impuestos '))
		
	print @XMLCHAR1

	SELECT CONVERT(XML,@XMLCHAR1), '' AS Addenda

	DROP TABLE #Comprobante
	DROP TABLE #Emisor
	DROP TABLE #Domicilio
	DROP TABLE #DomicilioSuc
	DROP TABLE #Receptor
	DROP TABLE #DomicilioReceptor
	DROP TABLE #Concepto
	DROP TABLE #Conceptos
	DROP TABLE #ImpuestosRetenidos
	DROP TABLE #ImpuestosTrasladados
	DROP TABLE #Impuestos
	DROP TABLE #Traslados
	DROP TABLE #Retenciones
	DROP TABLE #RegimenFiscal

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXMLNC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CrearArchivoXMLNC]
	@Folio_ID	Int,
	@Sello		Varchar(8000),
	@Empresa	VARCHAR(100)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie	varchar(20), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @XML_Conceptos XML, @XML_Relacionados XML, @LugarExpedicion varchar(100)

	SET @Serie = 'NC'
	SET	@LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	CREATE TABLE #Comprobante
	(
		[Version] varchar(10),
		Serie varchar(20),
		Folio int,
		Fecha varchar(25),
		Sello varchar(500),
		NoCertificado varchar(40),
		Certificado varchar(4000),
		CondicionesDePago Varchar(50),
		SubTotal Varchar(20),
		TipoCambio Varchar(7),
		Moneda Varchar(20),
		Total Varchar(20),
		FormaPago Varchar(50),
		Descuento Varchar(30),
		TipoDeComprobante varchar(30),
		xsi varchar(300),
		xmlns varchar(300),
		xmlnsxsi varchar(300),
		MetodoPago Varchar(100),
		LugarExpedicion Varchar(100)
	)

	CREATE TABLE #Traslados
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Retenciones
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #Emisor
	(
		Rfc varchar(30),
		Nombre varchar(300),
		RegimenFiscal	varchar(200)
	)

	CREATE TABLE #ImpuestosRetenidos
	(
		impuesto varchar(100),
		importe varchar(20),
		TasaOCuota	varchar(20),
		TipoFactor	varchar(10)
	)

	CREATE TABLE #Impuestos
	(
		totalImpuestosRetenidos Varchar(20),
		totalImpuestosTrasladados Varchar(20)
	)

	CREATE TABLE #ImpuestosTrasladados
	(
		impuesto varchar(100),
		importe varchar(20),
		TasaOCuota	varchar(20),
		TipoFactor	varchar(10)
	)

	CREATE TABLE #Receptor
	(
		Rfc varchar(30),
		Nombre varchar(300),
		UsoCFDI	varchar(20)
	)

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, FormaPago,descuento,tipoDeComprobante,xsi,xmlns,xmlnsxsi,MetodoPago,LugarExpedicion)
	SELECT @Serie, 
		DFE.vchVersion, 
		@Folio_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
		'Pago en una sola exhibicion',
		Rtrim(Ltrim(Convert(Char,Round(CV.mnySUBTOTAL,2)))),
		1.00,
        'MXN',
		Rtrim(Ltrim(Convert(Char,Round(cv.mnytotal,2)))),
		C.vchFormaPago,
		Rtrim(Ltrim(Convert(Char,Round(0.00,2)))),
		'E',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		'PUE' AS vchMetodoPago,
		@LugarExpedicion As LugarExpedicion
	FROM Cab_Notas_Credito CV
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID, Datos_FacturaElectronica DFE 
	WHERE CV.intNota_Credito_ID = @Folio_ID

	INSERT INTO #Emisor(rfc,nombre,RegimenFiscal)
	SELECT vchRFC,@Empresa, (SELECT intRegimen_ID FROM REGIMEN_FISCALES) FROM Parametros

	INSERT INTO #Receptor(rfc,nombre,UsoCFDI)
	Select Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL, CC.vchUso_CFDI FROM Cab_Notas_Credito CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID, REGIMEN_FISCALES RF
	Where CV.intNota_Credito_ID = @Folio_ID 

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(CONVERT(DECIMAL(18,2),ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0)),2)))),
			   Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2))))
		From Cab_Notas_Credito
		Where intNota_Credito_ID = @Folio_ID
		--Select Rtrim(Ltrim(Convert(Char,Round(Case When ISNULL(mnyRetIVA,0) = 0 AND ISNULL(mnyRetISR,0) = 0 Then CONVERT(DECIMAL(18,2),0) Else CONVERT(DECIMAL(18,2),ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0)) End,2)))),
		--	   Case When ISNULL(mnyIVA,0) = 0 Then 0.00 Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		--From Cab_Notas_Credito
		--Where intNota_Credito_ID = @Folio_ID
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe,TipoFactor,TasaOCuota)
		Select '002',	
			   Rtrim(Ltrim(Convert(Char,Round(mnyRetIVA,2)))),
			   'Tasa',
			   Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPRetIVA / 100.00))))
		From Cab_Notas_Credito CV 
		Where intNota_Credito_ID = @Folio_ID
		  and ISNULL(mnyRetIVA,0) >= 0
		Union
		Select '001', 
			   Rtrim(Ltrim(Convert(Char,Round(mnyRetISR,2)))), 
			   'Tasa',
			   Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPRetISR / 100.00))))
		From Cab_Notas_Credito CV 
		Where intNota_Credito_ID = @Folio_ID
		  and ISNULL(mnyRetISR,0) >= 0
		--Select Case When ISNULL(mnyRetIVA,0) = 0 Then '002' Else '002' End,	
		--	   Rtrim(Ltrim(Convert(Char,Case When ISNULL(mnyRetIVA,0) = 0 Then 0.00 Else Round(mnyRetIVA,2) End))),
		--	   'Tasa',
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetIVA = 0 Then 0.000000 Else convert(decimal(18,6),mnyPRetIVA / 100.00) End)))
		--From Cab_Notas_Credito CV 
		--Where intNota_Credito_ID = @Folio_ID
		--  and ISNULL(mnyRetIVA,0) > 0
		--Union
		--Select Case When ISNULL(mnyRetISR,0) = 0 Then '001' Else '001' End, 
		--	   Rtrim(Ltrim(Convert(Char,Case When ISNULL(mnyRetISR,0) = 0 Then 0.00 Else Round(mnyRetISR,2) End))), 
		--	   'Tasa',
		--	   Rtrim(Ltrim(Convert(Char,Case When ISNULL(mnyRetISR,0) = 0.000000 Then 0.00 Else convert(decimal(18,6),mnyPRetISR / 100.00) End)))
		--From Cab_Notas_Credito CV 
		--Where intNota_Credito_ID = @Folio_ID
		--  and ISNULL(mnyRetISR,0) > 0
		
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,TipoFactor,tasaoCuota)
		Select  '002', 
				Rtrim(Ltrim(Convert(Char,Round(CONVERT(DECIMAL(18,2),mnyIVA),2)))),
				'Tasa',
			    Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPIVA / 100.00))))
		From Cab_Notas_Credito CV
		Where intNota_Credito_ID = @Folio_ID
		 and ISNULL(mnyIVA,0) >= 0
		--Select  Case When ISNULL(mnyIVA,0) = 0 AND ISNULL(mnyRetIVA,0) = 0.00 Then '002' Else '002' End, 
		--		Rtrim(Ltrim(Convert(Char,Round(Case When ISNULL(mnyIVA,0) = 0 AND ISNULL(mnyRetIVA,0) = 0 Then CONVERT(DECIMAL(18,2),0) Else CONVERT(DECIMAL(18,2),mnyIVA) End,2)))),
		--		'Tasa',
		--	    case when ISNULL(mnyIVA,0) = 0 then 0.000000 else Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPIVA / 100.00)))) end
		--From Cab_Notas_Credito CV
		--Where intNota_Credito_ID = @Folio_ID
		-- and ISNULL(mnyIVA,0) >= 0

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	SET  @XML_Relacionados = (SELECT
	(
		SELECT CV.vchFolio_Fiscal AS UUID FROM Det_Notas_Credito NC
		INNER JOIN Cab_Ventas CV ON NC.intFactura_ID = CV.intFactura_ID
		WHERE intNota_Credito_ID = @Folio_ID
		FOR XML RAW('CfdiRelacionado'), TYPE
	) FOR XML PATH(''), ROOT('CfdiRelacionados'))

	SET @XML_Relacionados = CONVERT(XML,REPLACE(CONVERT(VARCHAR(MAX),@XML_Relacionados),'<CfdiRelacionados>','<CfdiRelacionados TipoRelacion="01">'))
	
	set @XML_Conceptos = (SELECT
	(
		SELECT ISNULL(DV.vchClaveProdServ,'84111506') AS ClaveProdServ, 
		       ISNULL(U.vchDescripcion,'ACTIVIDAD') AS Unidad, 
			   ISNULL(DV.vchUnidad,'ACT') AS ClaveUnidad, 
			   CONVERT(DECIMAL(18,2),ISNULL(DV.mnyCantidad,1.00)) AS Cantidad, 
			   ISNULL(DV.vchNoIdentificacion,DV.intFactura_ID) AS NoIdentificacion, 
			   ISNULL(CASE WHEN DV.vchNotas = '' THEN 'NOTA DE CREDITO' ELSE DV.vchNotas END,'NOTA DE CREDITO') AS Descripcion, 
			   CONVERT(DECIMAL(18,2),DV.mnyImporte) AS ValorUnitario, 
			   CONVERT(DECIMAL(18,2),DV.mnyImporte) AS Importe,
			( 
				SELECT (SELECT T.Impuesto, T.Base, T.TipoFactor, T.TasaOCuota, T.Importe
						FROM vTrasladosXNota T
						WHERE DV.intNota_Credito_ID = T.intNota_Credito_ID AND DV.intRenglon = T.intRenglon
						FOR XML RAW('Traslado'),TYPE
						)
				FOR XML RAW('Traslados'),TYPE

			),
			( 
				SELECT (SELECT R.Impuesto, R.Base, R.TipoFactor, R.TasaOCuota, R.Importe
						FROM vRetencionesXNota R
						WHERE DV.intNota_Credito_ID = R.intNota_Credito_ID AND DV.intRenglon = R.intRenglon
						FOR XML RAW('Retencion'),TYPE
						)
				FOR XML RAW('Retenciones'),TYPE

			)
		FROM Det_Notas_Credito DV
		LEFT OUTER JOIN Unidad_Medida U ON DV.vchUnidad = U.vchNombreCorto
		WHERE intNota_Credito_ID = @Folio_ID
		FOR XML RAW('Concepto'), TYPE
	) FOR XML PATH(''), ROOT('Conceptos'))

	PRINT CONVERT(VARCHAR(max),@XML_Conceptos)

	IF CHARINDEX('<Retenciones/>',CONVERT(VARCHAR(MAX),@XML_Conceptos)) = 0
		SET @XML_Conceptos = CONVERT(XML,REPLACE(REPLACE(CONVERT(VARCHAR(MAX),@XML_Conceptos),'<Traslados>','<Impuestos><Traslados>'),'</Retenciones>','</Retenciones></Impuestos>'))
	ELSE
		SET @XML_Conceptos = CONVERT(XML,REPLACE(REPLACE(CONVERT(VARCHAR(MAX),@XML_Conceptos),'<Traslados>','<Impuestos><Traslados>'),'<Retenciones/>','</Impuestos>'))

	Set @XMLORIGINAL =
	(
	SELECT [Version],
	       LugarExpedicion, 
		   Serie, 
		   Folio, 
		   Fecha, 
		   SubTotal,
		   Descuento,
		   Moneda,
		   TipoCambio,
		   Total,
		   MetodoPago,
		   TipoDeComprobante,
		   FormaPago,
		   NoCertificado,
		   Certificado,
		   Sello,
		   xsi "xsi:schemaLocation",
		   xmlnsxsi "xmlns:xsi",
		@XML_Relacionados,		
		(SELECT Rfc,Nombre, RegimenFiscal FROM #Emisor "Emisor" FOR XML AUTO, TYPE),
		(SELECT Rfc,Nombre, UsoCFDI FROM #Receptor "Receptor" FOR XML AUTO, TYPE),
		@XML_Conceptos,
	(SELECT TotalImpuestosRetenidos, TotalImpuestosTrasladados,
		  (Select DISTINCT Borrame,Id_Borrado As Borrame2, Retencion.Impuesto, Retencion.importe As Importe
			From #Retenciones "Retenciones", #ImpuestosRetenidos "Retencion"
			FOR XML AUTO, TYPE),
		  (Select Borrame,Id_Borrado As Borrame2,Traslado.Impuesto, TipoFactor, Traslado.TasaOCuota, Traslado.importe Importe
			From #Traslados "Traslados", #ImpuestosTrasladados "Traslado"
			FOR XML AUTO, TYPE)
	FROM #Impuestos "Impuestos"
	FOR XML AUTO, TYPE)
	FROM #Comprobante Comprobante
	FOR XML AUTO, TYPE
	)
	PRINT CONVERT(VARCHAR(max),@XMLORIGINAL)
	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Retencion','cfdi:Retencion'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'<CfdiRelacionado','<cfdi:CfdiRelacionado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</CfdiRelacionados>','</cfdi:CfdiRelacionados>'))
	
	SET @XMLCHAR1 = REPLACE(REPLACE(@XMLCHAR1,'<Traslados>','<Impuestos><Traslados>'),'</Retenciones>','</Retenciones></Impuestos>')
	
	SELECT CONVERT(XML,@XMLCHAR1)

	DROP TABLE #Comprobante
	DROP TABLE #Emisor
	DROP TABLE #Receptor
	DROP TABLE #ImpuestosRetenidos
	DROP TABLE #ImpuestosTrasladados
	DROP TABLE #Impuestos
	DROP TABLE #Traslados
	DROP TABLE #Retenciones

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXMLNC_v32]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Sp_CrearArchivoXMLNC_v32]
(
	@Nota_Credito_ID	Int,
	@Sello			Varchar(8000),
	@Empresa		varchar(100)
)
AS	

BEGIN

	SET NOCOUNT ON

	DECLARE @Impuesto_Retenido money, @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @LugarExpedicion varchar(100)
	
	SET @Impuesto_Retenido = 0
	SET	@LugarExpedicion = (SELECT vchCiudad + ',' + vchEstado FROM Parametros)

	Create Table #Comprobante
	(
		serie varchar(20),
		[version] varchar(10),
		folio int,
		fecha varchar(25),
		sello varchar(500),
		noCertificado varchar(40),
		certificado varchar(4000),
		condicionesDePago Varchar(20),
		subTotal Varchar(20),
		TipoCambio Varchar(7),
		Moneda Varchar(20),
		total Varchar(20),
		formaDePago Varchar(50),
		descuento Varchar(30),
		tipoDeComprobante varchar(30),
		xsi varchar(300),
		xmlns varchar(300),
		xmlnsxsi varchar(300),
		metodoDePago Varchar(100),
		LugarExpedicion Varchar(100),
		NumCtaPago Varchar(20)
	)

	Create Table #Concepto
	(
		No_Renglon	int,
		cantidad varchar(20),
		unidad varchar(20),
		noIdentificacion varchar(30),
		descripcion varchar(200),
		valorUnitario Varchar(20),
		importe Varchar(20)
	)

	Create Table #Conceptos
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	CREATE TABLE #RegimenFiscal
	(
		Regimen Varchar(200) Not Null Default ''
	)

	Create Table #Traslados
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	Create Table #Retenciones
	(
		Borrame Varchar(20),
		Id_Borrado Int Not Null Default 0
	)

	Create Table #Emisor
	(
		rfc varchar(30),
		nombre varchar(300)
	)

	Create Table #Domicilio
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(100),
		pais varchar(100),
		codigoPostal varchar(50)
	)

	Create Table #DomicilioSuc
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(50),
		pais varchar(50),
		codigoPostal varchar(50)
	)

	Create Table #ImpuestosRetenidos
	(
		impuesto varchar(100),
		importe varchar(20)
	)

	Create Table #Impuestos
	(
		totalImpuestosRetenidos Varchar(20),
		totalImpuestosTrasladados Varchar(20)
	)

	Create Table #ImpuestosTrasladados
	(
		impuesto varchar(100),
		tasa varchar(20),
		importe varchar(20)
	)

	Create Table #Receptor
	(
		rfc varchar(30),
		nombre varchar(300)
	)

	Create Table #DomicilioReceptor
	(
		calle varchar(100),
		noExterior varchar(10),
		noInterior varchar(10),
		colonia varchar(100),
		localidad varchar(100),
		referencia varchar(200),
		municipio varchar(100),
		estado varchar(100),
		pais varchar(100),
		codigoPostal varchar(50),
	)

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio, Moneda, total, formaDePago,descuento,tipoDeComprobante, xsi,xmlns,xmlnsxsi,metodoDePago,LugarExpedicion,NumCtaPago)
	SELECT 'NC', 
		DFE.vchVersion, 
		@Nota_Credito_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(NC.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(NC.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(NC.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,NC.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
--		NC.vchTipo_Pago,
		'CONTADO',
		Rtrim(Ltrim(Convert(Char,Round(NC.mnySUBTOTAL,2)))),
		1.00,
                'MXN',
		Rtrim(Ltrim(Convert(Char,Round(NC.mnytotal,2)))),
		'Pago en una sola exhibicion',
		NULL,
		'egreso',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		ISNULL(C.vchMetodoPago,'No identificado'),
		@LugarExpedicion As LugarExpedicion,
		CASE WHEN LEN(ISNULL(C.vchCuentaBancaria,'')) < 4 THEN '0000' ELSE C.vchCuentaBancaria END AS NumCtaPago
	FROM Cab_Notas_Credito NC
	INNER JOIN Clientes C ON NC.intCliente_ID = C.intCliente_ID, Datos_FacturaElectronica DFE
	WHERE NC.intNota_Credito_ID = @Nota_Credito_ID

	INSERT INTO #Emisor(rfc,nombre)
	SELECT vchRFC,@Empresa FROM Parametros

	INSERT INTO #Domicilio(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	SELECT rtrim(vchDireccion),vchNoExterior,vchNoInterior,vchCOLONIA,vchCiudad,vchCiudad,
		vchEstado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais)),vchCODIGOPOSTAL, vchReferencia
	FROM Parametros

	INSERT INTO #Receptor(rfc,nombre)
	Select Case When Ltrim(Rtrim(Isnull(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchRFC END) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) End, 
	       CASE WHEN DN.intCliente_Tercero = 0 THEN CASE WHEN CC.vchRAZONSOCIAL = '' OR CC.vchRAZONSOCIAL IS NULL THEN RTRIM(CC.vchNombre) +  ' ' + RTRIM(CC.vchApellidoPaterno) + ' ' + RTRIM(CC.vchApellidoMaterno) ELSE CC.vchRAZONSOCIAL END ELSE CASE WHEN FT.vchRAZONSOCIAL = '' OR FT.vchRAZONSOCIAL IS NULL THEN RTRIM(FT.vchNombre) +  ' ' + RTRIM(FT.vchApellidoPaterno) + ' ' + RTRIM(FT.vchApellidoMaterno) ELSE FT.vchRAZONSOCIAL END END 
	FROM Cab_Notas_Credito NC
	INNER JOIN Notas_Credito DN ON NC.intNota_Credito_ID = DN.intNOta_Credito_ID
	INNER JOIN Facturas ON DN.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Clientes CC ON Facturas.intCliente_ID = CC.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON DN.intCliente_Tercero = FT.intCliente_Tercero_ID AND NC.intCliente_ID = FT.intCliente_ID, Parametros DG, Parametros Suc, Datos_FacturaElectronica DFE
	Where NC.intNota_Credito_ID = @Nota_Credito_ID

	INSERT INTO #DomicilioReceptor (calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	Select CASE WHEN DN.intCliente_Tercero = 0 THEN cc.vchDireccion ELSE FT.vchDireccion END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchNoExterior ELSE FT.vchNoExterior END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchNoInterior ELSE FT.vchNoInterior END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCOLONIA ELSE FT.vchColonia END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCiudad ELSE FT.vchCiudad END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCiudad ELSE FT.vchCiudad END,
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchEstado ELSE FT.vchEstado END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais)) ELSE SUBSTRING(FT.vchPais,CHARINDEX('-',FT.vchPais,1 )+1,LEN(FT.vchPais)) END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCodigoPostal ELSE FT.vchCodigoPostal END, 
		   CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchReferencia ELSE FT.vchReferencia END
	From Cab_Notas_Credito NC
	INNER JOIN Notas_Credito DN ON NC.intNota_Credito_ID = DN.intNOta_Credito_ID
	INNER JOIN Facturas ON DN.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Clientes CC ON Facturas.intCliente_ID = CC.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON DN.intCliente_Tercero = FT.intCliente_Tercero_ID AND NC.intCliente_ID = FT.intCliente_ID, Parametros DG, Parametros Suc, Datos_FacturaElectronica DFE
	Where NC.intNota_Credito_ID = @Nota_Credito_ID

	INSERT INTO #RegimenFiscal
	SELECT vchNombre FROM REGIMEN_FISCALES

	INSERT INTO #DomicilioSuc(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
		Select vchDireccion, vchNoExterior,vchNoInterior,vchColonia,vchCiudad,vchCiudad,
			vchestado,vchPais ,vchCodigoPostal,vchREFERENCIA
		From Parametros SUC

	Update #DomicilioSuc Set calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End
		
	Update #Domicilio Set calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End

	Update #DomicilioReceptor Set calle=case When calle = '' Then Null Else Ltrim(Rtrim(calle)) End,
		noExterior=case When noExterior = '' Then Null Else Ltrim(Rtrim(noExterior)) End,
		NoInterior=case When NoInterior = '' Then Null Else Ltrim(Rtrim(NoInterior)) End,
		colonia=case When colonia = '' Then Null Else Ltrim(Rtrim(colonia)) End,
		localidad=case When localidad = '' Then Null Else Ltrim(Rtrim(localidad)) End,
		municipio=case When municipio = '' Then Null Else Ltrim(Rtrim(municipio)) End,
		estado=case When estado = '' Then Null Else Ltrim(Rtrim(estado)) End,
		pais=case When pais = '' Then Null Else Ltrim(Rtrim(pais)) End,
		codigoPostal=case When codigoPostal = '' Then Null Else Ltrim(Rtrim(codigoPostal)) End,
		referencia=case When referencia = '' Then Null Else Ltrim(Rtrim(referencia)) End

	INSERT INTO #Concepto(cantidad,unidad,noIdentificacion,descripcion,valorUnitario,importe)
	Select  Ltrim(Rtrim(Convert(Char,Round(1.00,2)))),
		'NA',
			Ltrim(Rtrim(CONVERT(Char,'001'))),
			dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(Case When vchNotas = '' Then 'NOTA DE CREDITO' Else vchNotas End,'')))),
			Ltrim(Rtrim(Convert(Char,Round(VDV.mnyImporte,2)))),
			Ltrim(Rtrim(Convert(Char,Round(VDV.mnyimporte,2))))
	From Det_Notas_Credito VDV
	Inner Join Cab_Notas_Credito NC ON NC.intNota_Credito_ID = VDV.intNota_Credito_ID
	WHERE VDV.intNota_Credito_ID = @Nota_Credito_ID
	Order By intRenglon

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When @Impuesto_Retenido = 0 Then Null Else @Impuesto_Retenido End,2)))),
			   Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		From Cab_Notas_Credito
		Where intNota_Credito_ID = @Nota_Credito_ID
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe)
		Select Case When @Impuesto_Retenido = 0 Then Null Else 'IVA' End, 
			   Rtrim(Ltrim(Convert(Char,Round(Case When @Impuesto_Retenido = 0 Then Null Else @Impuesto_Retenido End,2))))
		From Cab_Notas_Credito NC
		Where intNota_Credito_ID = @Nota_Credito_ID
		  AND @Impuesto_Retenido > 0
			
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select Case When mnyIVA = 0 Then Null Else 'IVA' End, 
			   Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 Then Null Else mnyIVA End,2)))),
			   case when mnyIVA = 0 then null else Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) end
		From Cab_Notas_Credito NC
		Where intNota_Credito_ID = @Nota_Credito_ID
		 and mnyIVA > 0

	INSERT INTO #Conceptos(Borrame)
	Select '1'

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	SET @XMLORIGINAL =
	(SELECT version,
		serie,
		folio,
		fecha,
		sello,
		tipoDeComprobante,
		formaDePago,
		condicionesDePago,
		noCertificado,
		certificado,
		subTotal,
		descuento,
		Moneda,
		TipoCambio,
		total,
		metodoDePago,
		LugarExpedicion,
		NumCtaPago,
		xsi "xsi:schemaLocation",xmlnsxsi "xmlns:xsi",
		(SELECT rfc,nombre,
		  (SELECT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal FROM #Domicilio "DomicilioFiscal"
		   FOR XML AUTO, TYPE),
		  (SELECT DISTINCT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal FROM #DomicilioSuc  "ExpedidoEn"
		   FOR XML AUTO, TYPE),(Select Regimen From #RegimenFiscal RegimenFiscal For XML AUTO, TYPE)
	FROM #Emisor "Emisor"
	FOR XML AUTO, TYPE),
		  (SELECT DISTINCT rfc,nombre,calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #Receptor Receptor,#DomicilioReceptor  "Domicilio"
		   FOR XML AUTO, TYPE),
	(Select Isnull(Conceptos.Borrame,'') Borrame , Id_Borrado As Borrame2, Concepto.*
	From #Conceptos Conceptos, #Concepto Concepto
	Order By Concepto.no_renglon
	For XML AUTO,TYPE),
	(SELECT totalImpuestosRetenidos, totalImpuestosTrasladados,
		  (Select Borrame,Id_Borrado As Borrame2,Retenido.impuesto, Retenido.importe As importe
			From #Retenciones "Retenciones", #ImpuestosRetenidos "Retenido"
			FOR XML AUTO, TYPE),
		  (Select Borrame,Id_Borrado As Borrame2,Traslado.impuesto, Traslado.tasa tasa,Traslado.importe importe
			From #Traslados "Traslados", #ImpuestosTrasladados "Traslado"
			FOR XML AUTO, TYPE)
	FROM #Impuestos "Impuestos"
	FOR XML AUTO, TYPE)
	FROM #Comprobante Comprobante
	FOR XML AUTO, TYPE
	)

	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

--	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'DomicilioFiscal','cfdi:DomicilioFiscal'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'ExpedidoEn','cfdi:ExpedidoEn'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Domicilio','<cfdi:Domicilio'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'RegimenFiscal','cfdi:RegimenFiscal'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Impuestos','cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

--	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'Impuestos ','cfdi:Impuestos '))

	SELECT CONVERT(XML,@XMLCHAR1)

	Drop Table #Comprobante
	Drop Table #Emisor
	Drop Table #Domicilio
	Drop Table #DomicilioSuc
	Drop Table #Receptor
	Drop Table #DomicilioReceptor
	Drop Table #Concepto
	Drop Table #Conceptos
	Drop Table #ImpuestosRetenidos
	Drop Table #ImpuestosTrasladados
	Drop Table #Impuestos
	Drop Table #Traslados
	Drop Table #Retenciones
	DROP TABLE #RegimenFiscal

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[Sp_CrearCadenaOriginal]
(
	@Folio_ID		Int,
	@Empresa		varchar(100)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @Serie varchar(20), @RegimenFiscales Varchar(MAX), @LugarExpedicion varchar(100)

	SET @LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	SET @Serie = 'DCV'

	SET @RegimenFiscales = (SELECT intRegimen_ID FROM Regimen_Fiscales)
	
	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull(DFE.[vchVersion],''))) 
		+ '|' + @Serie
		+ '|' + RTRIM(CONVERT(VARCHAR,CV.intFactura_ID))
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108)))
		+ '|' + CC.vchFormaPago
		+ '|' + DFE.vchNo_Serie_Certificado
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,CV.mnySubTotal),'')))
		+ '|' + Ltrim(Rtrim(0.00))
		+ '|' + 'MXN'
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,CV.mnyTotal),'')))
		+ '|' + 'I'
		+ '|' + CC.vchMetodoPago
		+ '|' + @LugarExpedicion
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(@Empresa) ,'')))
		+ '|' + Isnull(@RegimenFiscales,'')
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),'')))
		+ '|' + CC.vchUso_CFDI As Campo,
		0 as Renglon2
	FROM Cab_Ventas CV
	Left Join Clientes CC On CC.intCliente_ID = CV.intCliente_ID, Datos_FacturaElectronica DFE, Parametros DG 
	WHERE CV.intFactura_ID = @Folio_ID
		
	UNION

	SELECT 2 As Renglon,
	         '|' + ISNULL(VDV.vchClaveProdServ,'01010101')
		   + '|' + CASE WHEN VDV.vchNoIdentificacion <> '' THEN VDV.vchNoIdentificacion ELSE Rtrim(Ltrim(Ltrim(Rtrim(CONVERT(Char,VDV.intRenglon))))) END
	       + '|' + Ltrim(Rtrim(Isnull(Convert(Char,VDV.mnycantidad),'')))
		   + '|' + VDV.vchUnidad
		   + '|' + ISNULL(UNI.[vchDescripcion],VDV.vchUnidad)
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(VDV.vchProducto),''))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(VDV.mnyPrecio,2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))

		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))
		   + '|' + '002'
		   + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0)))))
		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0))))

		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0))))
	       + '|' + '001'
	       + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetISR / 100.00,0)))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyRetISR)))

		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else LTRIM(Rtrim(Convert(Char,mnyImporte))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else '002' End 					
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'Tasa' End 					
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0))))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End

		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0)))) End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else '001' End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else 'Tasa' End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetISR / 100.00,0))))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else LTRIM(Rtrim(Convert(Char,mnyRetISR))) End

		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0))))
	       + '|' + '002'
	       + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetIVA / 100.00,0)))))
	       + '|' + LTRIM(Rtrim(Convert(Char,mnyRetIVA)))

		   + '|' + '', 
		   intRenglon AS Renglon2
	FROM Det_Ventas VDV
	LEFT OUTER JOIN Unidad_Medida UNI ON UNI.vchNombreCorto = VDV.vchUnidad
	WHERE VDV.intFactura_ID = @Folio_ID

	UNION

	SELECT 3 As Renglon, 

	          '|' +  '001'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0))))

	        + '|' +  '002'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0))))

			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0))))

	  --        '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else '001' End
			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) End

	  --      + '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else '002' End
			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) End

			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '0.00' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0)))) End

			+ '|' +  '002'
			+ '|' +  'Tasa'
			+ '|' +  Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0)))))
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0))))

			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))),

		   3 As Renglon2
	FROM Cab_Ventas
	WHERE intFactura_ID = @Folio_ID 
	
	ORDER BY Renglon, Renglon2

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginal_v32]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Sp_CrearCadenaOriginal_v32]
(
	@Factura_ID		Int,
	@RazonSocial	varchar(100)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @RetIVA money, @RegimenFiscales Varchar(MAX), @Tabla AS TablaUnSplit, @LugarExpedicion varchar(100)

	SET	@LugarExpedicion = (SELECT vchCiudad + ',' + vchEstado FROM Parametros)
	  
	INSERT INTO @Tabla
	SELECT vchNombre FROM Regimen_Fiscales
		  	
	SET @RegimenFiscales = (SELECT dbo.UnSplit(@Tabla,'|'))
	SET @RetIVA = 0

	print @RegimenFiscales

	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull([vchVersion],''))) 
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108)))
		+ '|' + 'ingreso' 
		+ '|' + 'Pago en una sola exhibicion' 
--		+ '|' + CV.vchTipo_Pago
		+ '|' + 'CONTADO'
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,mnySubTotal),'')))
		+ '|' + Ltrim(Rtrim(0.00))
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + 'MXN'
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,mnyTotal),'')))
		+ '|' + Isnull(cc.vchMetodoPago,'No Identificado') --MétododePago
		+ '|' + @LugarExpedicion  --LugarExpedicion
		+ '|' + Case When Len(Isnull(cc.vchCuentaBancaria,'')) < 4 Then 'No Identificado' Else cc.vchCuentaBancaria End
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(@RazonSocial) ,'')))
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchDireccion),''))) 
		+ '|' + LTRIM(RTRIM(Isnull(dbo.Fmt_espacios(DG.vchNoExterior),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchNoInterior),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchColonia),'')))
		+ '|' + LTRIM(Rtrim(ISNULL(dbo.Fmt_espacios(DG.vchCiudad),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchReferencia),''))) 
		+ '|' + LTRIM(Rtrim(ISNULL(dbo.Fmt_espacios(DG.vchCiudad),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchEstado),'')))
		+ '|' + LTRIM(Rtrim(ISNULL(SUBSTRING(dbo.Fmt_espacios(DG.vchPais),CHARINDEX('-',dbo.Fmt_espacios(DG.vchPais),1 )+1,LEN(DG.vchPais)),'')))
		+ '|' + LTRIM(RTRIM(Isnull(dbo.Fmt_espacios(DG.vchCodigoPostal),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchDireccion),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNoExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(SUBSTRING(dbo.Fmt_espacios(Suc.vchPais),CHARINDEX('-',dbo.Fmt_espacios(Suc.vchPais),1 )+1,LEN(Suc.vchPais)),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCodigoPostal),''))) 
		+ '|' + Isnull(@RegimenFiscales,'') --RegimenFiscal
		+ '|' + Case When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' AND UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END,''))) = '' And UPPER(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchRFC ELSE FT.vchRFC END),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN CC.vchRAZONSOCIAL = '' OR CC.vchRAZONSOCIAL IS NULL THEN RTRIM(CC.vchNombre) +  ' ' + RTRIM(CC.vchApellidoPaterno) + ' ' + RTRIM(CC.vchApellidoMaterno) ELSE CC.vchRAZONSOCIAL END ELSE CASE WHEN FT.vchRAZONSOCIAL = '' OR FT.vchRAZONSOCIAL IS NULL THEN RTRIM(FT.vchNombre) +  ' ' + RTRIM(FT.vchApellidoPaterno) + ' ' + RTRIM(FT.vchApellidoMaterno) ELSE FT.vchRAZONSOCIAL END END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN cc.vchDireccion ELSE FT.vchDireccion END),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchNoExterior ELSE FT.vchNoExterior END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchNoInterior ELSE FT.vchNoInterior END),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCOLONIA ELSE FT.vchCOLONIA END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCIUDAD ELSE FT.vchCIUDAD END),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchReferencia ELSE FT.vchReferencia END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCIUDAD ELSE FT.vchCIUDAD END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchEstado ELSE FT.vchEstado END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais)) ELSE SUBSTRING(FT.vchPais,CHARINDEX('-',FT.vchPais,1 )+1,LEN(FT.vchPais)) END,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CASE WHEN Facturas.intCliente_Tercero = 0 THEN CC.vchCODIGOPOSTAL ELSE FT.vchCODIGOPOSTAL END,''))) As Campo, 
              0 as Renglon2
	FROM Cab_Ventas CV
	INNER JOIN Facturas ON CV.intFactura_ID = Facturas.intFactura_ID
	Left Join Clientes CC On CC.intCliente_ID = CV.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON Facturas.intCliente_Tercero = FT.intCliente_Tercero_ID AND CV.intCliente_ID = FT.intCliente_ID, Datos_FacturaElectronica DFE, Parametros DG, Parametros Suc
	WHERE CV.intFactura_ID = @Factura_ID
		
	UNION

	SELECT 2 As Renglon, 
	         '|' + Ltrim(Rtrim(Isnull(Convert(Char,isnull(VDV.mnyPeso,0)),'')))
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(vchUnidad),''))))
		   + '|' + ''    --Ltrim(Rtrim(Isnull(Convert(Char,isnull(VDV.intRenglon,0)),'')))
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CASE WHEN CB.vchDescripcion <> '' THEN CB.vchDescripcion ELSE vchProducto END),''))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(isnull(VDV.mnyPrecio,0),2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))
		   + '|' + ''
		   + '|' + ''
		   + '|' + '', 
              intRenglon AS Renglon2
	FROM Det_Ventas VDV
	LEFT OUTER JOIN CodigoBarras_Proveedor CB ON VDV.vchCodigo_Barras = CB.vchCodigoBarras_Proveedor
	WHERE VDV.intFactura_ID = @Factura_ID

	UNION

	SELECT 3 As Renglon, 
	          '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) = '0.00' Then '' Else 'IVA' End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) End
			+ '|' +  'IVA'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyPIVA,0))))
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0))))
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))), 
		   3 As Renglon2
	FROM Cab_Ventas
	WHERE intFactura_ID = @Factura_ID

	ORDER BY Renglon, Renglon2

END

/*

	SELECT 3 As Renglon, 
	          '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) = '0.00' Then '' Else 'IVA' End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(@RetIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'IVA' End 					
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyPIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End, 
		   3 As Renglon2

*/
GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalComplemento]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginalComplemento]
(
	@Folio_ID Int,
	@TipoDocumento char(1)
)

As

Set NoCount On

IF @TipoDocumento = 'F'
	Select 1 As Renglon, 
		  '|' + Ltrim(Rtrim(Isnull('1.0',''))) 
        + '|' + Ltrim(Rtrim(Isnull(CV.vchFolio_Fiscal,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CV.dtmFecha_Timbrado,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CV.vchSello_CFD,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CV.vchSerie_Cert_SAT,''))) As Campo
	FROM Cab_Ventas CV
	WHERE CV.intFactura_ID = @Folio_ID
	GROUP BY vchFolio_Fiscal, CV.dtmFecha_Timbrado, CV.vchSello_CFD, CV.vchSerie_Cert_SAT
ELSE
	Select 1 As Renglon, 
		  '|' + Ltrim(Rtrim(Isnull('1.0',''))) 
        + '|' + Ltrim(Rtrim(Isnull(CN.vchFolio_Fiscal,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CN.dtmFecha_Timbrado,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CN.vchSello_CFD,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CN.vchSerie_Cert_SAT,''))) As Campo
	FROM Cab_Notas_Credito CN
	WHERE CN.intNota_Credito_ID = @Folio_ID
	GROUP BY vchFolio_Fiscal, CN.dtmFecha_Timbrado, CN.vchSello_CFD, CN.vchSerie_Cert_SAT

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalComplementoPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginalComplementoPago]
(
	@Pago_ID		Int
)

As

	Set NoCount On

	Select 1 As Renglon, 
		  '|' + Ltrim(Rtrim(Isnull('1.1',''))) 
        + '|' + Ltrim(Rtrim(Isnull(vchFolio_Fiscal_UUID,'')))
		+ '|' + Ltrim(Rtrim(Isnull(dtmFecha_Timbrado,'')))
        + '|' + Ltrim(Rtrim(Isnull(vchRfcProvCertifSAT,'')))
		+ '|' + Ltrim(Rtrim(Isnull(vchSello_CFD,'')))
		+ '|' + Ltrim(Rtrim(Isnull([vchSerie_Cert_SAT],'')))
		+ '|' + Ltrim(Rtrim(Isnull(vchSello_SAT,''))) As Campo
	FROM Cab_Pagos
	WHERE intPago_ID = @Pago_ID
	GROUP BY vchFolio_Fiscal_UUID, dtmFecha_Timbrado, vchSello_CFD, vchSello_SAT, vchRfcProvCertifSAT, [vchSerie_Cert_SAT]

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalNC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[Sp_CrearCadenaOriginalNC]
(
	@Folio_ID		Int,
	@Empresa		varchar(100)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @Serie varchar(20), @RegimenFiscales Varchar(MAX), @LugarExpedicion varchar(100)

	SET @LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	SET @Serie = 'NC'

	SET @RegimenFiscales = (SELECT intRegimen_ID FROM Regimen_Fiscales)
	
	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull(DFE.[vchVersion],''))) 
		+ '|' + @Serie
		+ '|' + RTRIM(CONVERT(VARCHAR,CV.intNota_Credito_ID))
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108)))
		+ '|' + CC.vchFormaPago
		+ '|' + DFE.vchNo_Serie_Certificado
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,CV.mnySubTotal),'')))
		+ '|' + Ltrim(Rtrim(0.00))
		+ '|' + 'MXN'
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,CV.mnyTotal),'')))
		+ '|' + 'E'
		+ '|' + 'PUE'
		+ '|' + @LugarExpedicion

		+ '|' + '01'
		+ '|' + V.vchFolio_Fiscal

--		+ '|' + 'Pago en una sola exhibicion'
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(@Empresa) ,'')))
		+ '|' + Isnull(@RegimenFiscales,'')
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),'')))
		+ '|' + CC.vchUso_CFDI As Campo,
		0 as Renglon2
	FROM Cab_Notas_Credito CV
	INNER JOIN Det_Notas_Credito NC ON CV.intNota_Credito_ID = NC.intNota_Credito_ID
	INNER JOIN Cab_Ventas V ON Nc.intFactura_ID = V.intFactura_ID
	Left Join Clientes CC On CC.intCliente_ID = CV.intCliente_ID, Datos_FacturaElectronica DFE, Parametros DG 
	WHERE CV.intNota_Credito_ID = @Folio_ID
		
	UNION

	SELECT 2 As Renglon,
	         '|' + ISNULL(VDV.vchClaveProdServ,'84111506')
		   + '|' + CASE WHEN VDV.vchNoIdentificacion <> '' THEN VDV.vchNoIdentificacion ELSE Rtrim(Ltrim(Ltrim(Rtrim(CONVERT(Char,VDV.intFactura_ID))))) END
	       + '|' + Ltrim(Rtrim(Isnull(Convert(Char,VDV.mnycantidad),'1.00')))
		   + '|' + ISNULL(VDV.vchUnidad,'ACT')
		   + '|' + ISNULL(UNI.[vchDescripcion],'ACTIVIDAD')
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CASE WHEN VDV.vchNotas = '' THEN 'NOTA DE CREDITO' ELSE VDV.vchNotas END),'NOTA DE CRADITO'))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(ISNULL(VDV.mnyImporte,0),2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,ISNULL(mnyImporte,0))))

		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))
		   + '|' + '002'
		   + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0)))))
		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0))))

		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0))))
	       + '|' + '001'
	       + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetISR / 100.00,0)))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyRetISR)))

		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else LTRIM(Rtrim(Convert(Char,mnyImporte))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else '002' End 					
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'Tasa' End 					
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0))))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End

		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0)))) End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else '001' End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else 'Tasa' End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetISR / 100.00,0))))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else LTRIM(Rtrim(Convert(Char,mnyRetISR))) End

		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0))))
	       + '|' + '002'
	       + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetIVA / 100.00,0)))))
	       + '|' + LTRIM(Rtrim(Convert(Char,mnyRetIVA)))

		   + '|' + '', 
		   intRenglon AS Renglon2
	FROM Det_Notas_Credito VDV
	LEFT OUTER JOIN Unidad_Medida UNI ON UNI.vchNombreCorto = VDV.vchUnidad
	WHERE VDV.intNota_Credito_ID = @Folio_ID

	UNION

	SELECT 3 As Renglon, 

	          '|' +  '001'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0))))

	        + '|' +  '002'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0))))

			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0))))

	  --        '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else '001' End
			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) End

	  --      + '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else '002' End
			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) End

			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '0.00' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0)))) End

			+ '|' +  '002'
			+ '|' +  'Tasa'
			+ '|' +  Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0)))))
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0))))

			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))),

		   3 As Renglon2
	FROM Cab_Notas_Credito
	WHERE intNota_Credito_ID = @Folio_ID 
	
	ORDER BY Renglon, Renglon2

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalNC_v32]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Sp_CrearCadenaOriginalNC_v32]
(
	@Nota_Credito_ID	Int,
	@Empresa		varchar(100)
)

AS

BEGIN

	SET NOCOUNT ON

	DECLARE @IVA_Retenido money, @RegimenFiscales Varchar(MAX), @Tabla AS TablaUnSplit, @LugarExpedicion varchar(100)

	SET	@LugarExpedicion = (SELECT vchCiudad + ',' + vchEstado FROM Parametros)
	  
	INSERT INTO @Tabla
	SELECT vchNombre FROM Regimen_Fiscales
		  	
	SET @RegimenFiscales = (SELECT dbo.UnSplit(@Tabla,'|'))
	SET @IVA_Retenido = 0

	SELECT 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull([vchVersion],''))) 
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(NC.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(NC.dtmFecha_Registro)))),2) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(NC.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,NC.dtmFecha_Registro,108)))
		+ '|' + 'egreso' 
		+ '|' + 'Pago en una sola exhibicion' 
--		+ '|' + NC.vchTipo_Pago
		+ '|' + 'CONTADO'
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,ROUND(mnySubTotal,2)),'')))
		+ '|' + ''
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + 'MXN'
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,(ROUND(mnyTotal,2))),'')))
		+ '|' + Isnull(cc.vchMetodoPago,'No Identificado') --MétododePago
		+ '|' + @LugarExpedicion  --LugarExpedicion
		+ '|' + Case When Len(Isnull(cc.vchCuentaBancaria,'')) < 4 Then 'No Identificado' Else cc.vchCuentaBancaria End
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(@Empresa) ,'')))
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchDireccion),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchNoInterior),''))) 
		+ '|' + LTRIM(RTRIM(Isnull(dbo.Fmt_espacios(DG.vchNoExterior),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchColonia),'')))
		+ '|' + LTRIM(Rtrim(ISNULL(dbo.Fmt_espacios(DG.vchCiudad),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchReferencia),''))) 
		+ '|' + LTRIM(Rtrim(ISNULL(dbo.Fmt_espacios(DG.vchCiudad),''))) 
		+ '|' + LTRIM(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchEstado),'')))
		+ '|' + LTRIM(Rtrim(ISNULL(SUBSTRING(dbo.Fmt_espacios(DG.vchPais),CHARINDEX('-',dbo.Fmt_espacios(DG.vchPais),1 )+1,LEN(DG.vchPais)),'')))
		+ '|' + LTRIM(RTRIM(Isnull(dbo.Fmt_espacios(DG.vchCodigoPostal),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchDireccion),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNOExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchPais),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCodigoPostal),''))) 
		+ '|' + Isnull(@RegimenFiscales,'') --RegimenFiscal
		+ '|' + CASE WHEN DN.intCliente_Tercero = 0 THEN Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End ELSE Case When Ltrim(Rtrim(Isnull(FT.vchRFC,''))) = '' And UPPER(FT.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(FT.vchRFC,''))) = '' And UPPER(FT.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(FT.vchRFC,''))) End END
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CASE WHEN CC.vchRAZONSOCIAL = '' OR CC.vchRAZONSOCIAL IS NULL THEN RTRIM(CC.vchNombre) +  ' ' + RTRIM(CC.vchApellidoPaterno) + ' ' + RTRIM(CC.vchApellidoMaterno) ELSE CC.vchRAZONSOCIAL END ELSE CASE WHEN FT.vchRAZONSOCIAL = '' OR FT.vchRAZONSOCIAL IS NULL THEN RTRIM(FT.vchNombre) +  ' ' + RTRIM(FT.vchApellidoPaterno) + ' ' + RTRIM(FT.vchApellidoMaterno) ELSE FT.vchRAZONSOCIAL END END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchDireccion ELSE FT.vchDireccion END),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchNoExterior ELSE FT.vchNoExterior END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchNoInterior ELSE FT.vchNoInterior END),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchColonia ELSE FT.vchColonia END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCiudad ELSE FT.vchCiudad END),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchReferencia ELSE FT.vchReferencia END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCiudad ELSE FT.vchCiudad END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchEstado ELSE FT.vchEstado END),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchPais ELSE FT.vchPais END,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CASE WHEN DN.intCliente_Tercero = 0 THEN CC.vchCodigoPostal ELSE FT.vchCodigoPostal END,''))) As Campo, 0 AS REN2
	FROM Cab_Notas_Credito NC
	INNER JOIN Notas_Credito DN ON NC.intNota_Credito_ID = DN.intNOta_Credito_ID
	INNER JOIN Facturas ON DN.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Clientes CC ON Facturas.intCliente_ID = CC.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros FT ON DN.intCliente_Tercero = FT.intCliente_Tercero_ID AND NC.intCliente_ID = FT.intCliente_ID, Parametros DG, Parametros Suc, Datos_FacturaElectronica DFE
	WHERE NC.intNota_Credito_ID = @Nota_Credito_ID

	UNION

	Select 2 As Renglon, 
			 '|' +  Ltrim(Rtrim(Isnull(Convert(Char,1.00),'')))
		   + '|' + Rtrim(Ltrim(Isnull('NA',''))) 
		   + '|' + Rtrim(Ltrim('001'))
		   + '|' + RTRIM(Ltrim(Isnull(Case When vchNotas = '' Then 'NOTA DE CREDITO' Else vchNotas End,''))) 
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(mnyImporte,2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,Round(mnyImporte,2))))
		   + '|' + ''
		   + '|' + ''
		   + '|' + '',intRenglon AS REN2
	From Det_Notas_Credito DMC
	Where DMC.intNota_Credito_ID = @Nota_Credito_ID

	UNION

	Select 3 As Renglon, 
	          '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(@IVA_Retenido,0)))) = '0.00' Then '' Else 'IVA' End
			+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(@IVA_Retenido,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(Round(@IVA_Retenido,2),0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(@IVA_Retenido,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(Round(@IVA_Retenido,2),0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'IVA' End 					
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyPIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End,
			0 AS Ren2
	FROM Cab_Notas_Credito
	WHERE intNota_Credito_ID = @Nota_Credito_ID

	Order By Renglon, Ren2

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalPagos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[Sp_CrearCadenaOriginalPagos]
(
	@Pago_ID		Int,
	@Empresa		varchar(200)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @Serie varchar(20), @Serie_Factura varchar(20), @PAC_ID int, @RegimenFiscales Varchar(MAX), @LugarExpedicion varchar(100), @Folio_Pago int

	SET @LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	SET @Serie = 'P'
	SET @Folio_Pago = (select intContador_Pagos FROM Control_Pagos)
	SET @Serie_Factura = 'DCV'

	SET @RegimenFiscales = (SELECT intRegimen_ID FROM Regimen_Fiscales)

	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull(DFE.[vchVersion],''))) 
		+ '|' + ISNULL(@Serie,'P')
		+ '|' + RTRIM(CONVERT(VARCHAR,ISNULL(@Folio_Pago,0)))
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(P.dtmFecha_Pago)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(P.dtmFecha_Pago)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(P.dtmFecha_Pago)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,P.dtmFecha_Pago,108)))
		+ '|' + DFE.vchNo_Serie_Certificado
		+ '|' + '0'
		+ '|' + 'XXX'
		+ '|' + '0'
		+ '|' + 'P'
		+ '|' + @LugarExpedicion
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(@Empresa) ,'')))
		+ '|' + Isnull(@RegimenFiscales,'')
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),'')))
		+ '|' + CC.vchUso_CFDI As Campo,
		0 as Renglon2
	FROM Cab_Pagos P
	INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID) DP ON P.intPago_ID = DP.intPago_ID
	Left Join Clientes CC On DP.intCliente_ID = CC.intCliente_ID, Datos_FacturaElectronica DFE, Parametros DG
	WHERE P.intPago_ID = @Pago_ID
		
	UNION

	SELECT 2 As Renglon,
	         '|' + P.vchClaveProdServ
	       + '|' + Ltrim(Rtrim(Isnull(Convert(Char,CONVERT(DECIMAL(18,0),P.mnycantidad)),'')))
		   + '|' + P.vchUnidad
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(P.vchDescripcion),''))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,CONVERT(DECIMAL(18,0),P.mnyPrecio))))
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,0),P.mnyImporte))))

		   + '|' + '1.0'
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Year(P.dtmFecha_Pago)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(P.dtmFecha_Pago)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(P.dtmFecha_Pago)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,P.dtmFecha_Pago,108)))
		   + '|' + CC.vchFormaPago
		   + '|' + 'MXN'
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),P.mnyTotal))))
		   + '|', 
		   
		   0 AS Renglon2
	FROM Cab_Pagos P
	INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID) DP ON P.intPago_ID = DP.intPago_ID
	Left Join Clientes CC On DP.intCliente_ID = CC.intCliente_ID
	WHERE P.intPago_ID = @Pago_ID

	UNION

	SELECT 3 As Renglon,
		   + CV.vchFolio_Fiscal
		   + '|' + @Serie_Factura
		   + '|' + LTRIM(Rtrim(Convert(Char,DP.intFactura_ID)))
		   + '|' + 'MXN'
		   + '|' + CC.vchMetodoPago
		   + '|' + LTRIM(Rtrim(CONVERT(Char,DP.intParcialidad)))
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),DP.mnySaldo_Anterior))))
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),DP.mnyMonto_Pagado)))) 
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),DP.mnySaldo_Pendiente))))
		   + '|', 
		   DP.intParcialidad AS Renglon2
	FROM Det_Pagos DP
	INNER JOIN Cab_Pagos P ON DP.intPago_ID = P.intPago_ID
	INNER JOIN Cab_Ventas CV ON DP.intFactura_ID = CV.intFactura_ID
	Left Join Clientes CC On CV.intCliente_ID = CC.intCliente_ID
	WHERE DP.intPago_ID = @Pago_ID

	ORDER BY Renglon, Renglon2

END




GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearComplementoPagoXML]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_CrearComplementoPagoXML]
	@Pago_ID	Int,
	@Sello		Varchar(8000),
	@Empresa	varchar(200)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie varchar(20), @Parcialidad smallint, @Forma_Pago varchar(10), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @XML_Conceptos XML, @XML_Complemento XML, @PAC_ID int, @LugarExpedicion varchar(100)

	SET @Serie = 'DCV'
	SET	@LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)
	SET @Forma_Pago = (SELECT DISTINCT c.vchFormaPago FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID)
	
	CREATE TABLE #Comprobante
	(
		[Version] varchar(10),
		Serie varchar(20),
		Folio int,
		Fecha varchar(25),
		Sello varchar(500),
		NoCertificado varchar(40),
		Certificado varchar(4000),
		SubTotal Varchar(20),
		Moneda Varchar(20),
		Total Varchar(20),
		TipoDeComprobante varchar(30),
		xsi varchar(300),
		xmlns varchar(300),
		xmlnsxsi varchar(300),
		xmlnspago varchar(300),
		LugarExpedicion Varchar(100)
	)

	CREATE TABLE #Emisor
	(
		Rfc varchar(30),
		Nombre varchar(300),
		RegimenFiscal	varchar(200)
	)

	CREATE TABLE #Receptor
	(
		Rfc varchar(30),
		Nombre varchar(300),
		UsoCFDI	varchar(20)
	)

	CREATE TABLE #Dcto
	(
		IdDocumento			varchar(50), 
		Serie				varchar(10), 
		Folio				int, 
		MetodoDePagoDR		varchar(10), 
		MonedaDR			varchar(10), 
		ImpSaldoAnt			DECIMAL(18,2), 
		ImpSaldoInsoluto	DECIMAL(18,2), 
		ImpPagado			DECIMAL(18,2),
		NumParcialidad		SMALLINT
	)

	INSERT INTO #Dcto
	SELECT CV.vchFolio_Fiscal AS IdDocumento, @Serie AS Serie, CV.intFactura_ID AS Folio, C.vchMetodoPago AS MetodoDePagoDR, 'MXN' AS MonedaDR, DP.mnySaldo_Anterior AS ImpSaldoAnt, DP.mnySaldo_Pendiente AS ImpSaldoInsoluto, DP.mnyMonto_Pagado, P.intParcialidad AS ImpPagado 
	FROM vUltimaParcialidadXFactura P
	INNER JOIN Det_Pagos DP ON P.intFactura_ID = DP.intFactura_ID AND P.intParcialidad = DP.intParcialidad 
	INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID
	WHERE P.intPago_ID = @Pago_ID 


	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,subTotal,Moneda,total,tipoDeComprobante,xsi,xmlns,xmlnsxsi,xmlnsPago,LugarExpedicion)
	SELECT 'P', 
		DFE.vchVersion, 
		@Pago_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(P.dtmFecha_Pago)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(P.dtmFecha_Pago)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(P.dtmFecha_Pago)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,P.dtmFecha_Pago,108))),
		@Sello,
		Left(DFE.vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(DFE.vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(DFE.vchCertificadoPublico)) End As certificado,
		0,
        'XXX',
		0,
		'P',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		'http://www.sat.gob.mx/Pagos',
		@LugarExpedicion As LugarExpedicion
	FROM Cab_Pagos P, Datos_FacturaElectronica DFE
	WHERE P.intPago_ID = @Pago_ID

	INSERT INTO #Emisor(rfc,nombre,RegimenFiscal)
	SELECT vchRFC,@Empresa, (SELECT intRegimen_ID FROM REGIMEN_FISCALES) FROM Parametros

	INSERT INTO #Receptor(rfc,nombre,UsoCFDI)
	Select DISTINCT Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL, CC.vchUso_CFDI FROM Det_Pagos P
	INNER JOIN CAB_VENTAS CV ON P.intFactura_ID = CV.intFactura_ID
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID, REGIMEN_FISCALES RF
	Where P.intpago_ID = @Pago_ID

	set @XML_Conceptos = (SELECT
	(
		SELECT P.vchClaveProdServ AS ClaveProdServ, 
			   CONVERT(DECIMAL(18,0),P.mnyCantidad) AS Cantidad, 
		       P.vchUnidad AS ClaveUnidad, 
			   P.vchDescripcion AS Descripcion, 
			   CONVERT(DECIMAL(18,0),P.mnyPrecio) AS ValorUnitario, 
			   CONVERT(DECIMAL(18,0),P.mnyImporte) AS Importe
		FROM Cab_Pagos P
		WHERE P.intPago_ID = @Pago_ID
		FOR XML RAW('Concepto'), TYPE
	) FOR XML PATH(''), ROOT('Conceptos'))

	SET @XML_Complemento = (SELECT
	(
		SELECT Ltrim(Rtrim(CONVERT(Char,Year(P.dtmFecha_Pago)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(P.dtmFecha_Pago)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(P.dtmFecha_Pago)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,P.dtmFecha_Pago,108))) AS FechaPago, 
			   'MXN' AS MonedaP, 
		       @Forma_Pago AS FormaDePagoP, 
			   CONVERT(DECIMAL(18,2),P.mnyTotal) AS Monto,
			   (
			    SELECT IdDocumento, Serie, Folio, MetodoDePagoDR, MonedaDR, ImpSaldoAnt, ImpSaldoInsoluto, ImpPagado, NumParcialidad FROM #Dcto AS DoctoRelacionado FOR XML AUTO, TYPE
			   ) 
		FROM Cab_Pagos P
		WHERE P.intPago_ID = @Pago_ID
		FOR XML RAW('Pago'), TYPE
	) FOR XML PATH(''), ROOT('Pagos'))

	Set @XMLORIGINAL =
	(
	SELECT [Version],
	       LugarExpedicion, 
		   Serie, 
		   Folio, 
		   Fecha, 
		   SubTotal,
		   Moneda,
		   Total,
		   TipoDeComprobante,
		   NoCertificado,
		   Certificado,
		   Sello,
		   xsi "xsi:schemaLocation",
		   xmlnsxsi "xmlns:xsi",		
		   xmlnsPago "xmlns:pago10",
		   xmlns "xmlns:cfdi",
		(SELECT Rfc,Nombre, RegimenFiscal FROM #Emisor "Emisor" FOR XML AUTO, TYPE),
		(SELECT Rfc,Nombre, UsoCFDI FROM #Receptor "Receptor" FOR XML AUTO, TYPE),
		@XML_Conceptos, 
		@XML_Complemento
	FROM #Comprobante Comprobante
	FOR XML AUTO, TYPE
	)

	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'<Pago','<pago10:Pago'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Pago','</pago10:Pago'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'<DoctoRelacionado','<pago10:DoctoRelacionado'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<pago10:Pagos>','<cfdi:Complemento><pago10:Pagos Version="1.0">'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</pago10:Pagos>','</pago10:Pagos></cfdi:Complemento>'))

	SELECT CONVERT(XML,@XMLCHAR1)

	DROP TABLE #Comprobante
	DROP TABLE #Emisor
	DROP TABLE #Receptor

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarClaveProdServ]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarClaveProdServ]
	@Clave_ID  varchar(600)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	UPDATE c_ClaveProdServ SET Seleccionado = 0 WHERE c_ClaveProdServ = SUBSTRING(@Clave_ID,1,CHARINDEX('-',@Clave_ID) -1)

	SET @Status = @@ROWCOUNT
	SET @Error = @@ERROR

	IF @Error = 547
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 547
	END
	ELSE
		IF @Status = 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN 99
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 0
		END
		
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarCliente]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarCliente]
@Cliente_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Clientes WHERE intCliente_ID = @Cliente_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarClienteTercero]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarClienteTercero]
@Cliente_ID            int,
@Cliente_Tercero   int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int, @Existe_Facturas int, @Existe_Notas int

BEGIN TRANSACTION

SET @Existe_Facturas = ISNULL((SELECT COUNT(*) FROM Facturas WHERE intCliente_Tercero = @Cliente_Tercero),0)
SET @Existe_Notas = ISNULL((SELECT COUNT(*) FROM Notas_Credito WHERE intCliente_Tercero = @Cliente_Tercero),0)

IF (@Existe_Facturas + @Existe_Notas) = 0
BEGIN
	DELETE FROM Facturar_Terceros WHERE intCliente_ID = @Cliente_ID AND intCliente_Tercero_ID = @Cliente_Tercero
	SET @Status = @@ROWCOUNT
	SET @Error = @@ERROR
END
ELSE
	SET @Error = 547

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarControlFolios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarControlFolios]
@Consecutivo  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int, @Encontro_Folios bit, @Folio_Ini int, @Folio_Fin int

BEGIN TRANSACTION

SELECT @Folio_Ini = intFolio_Inicial, @Folio_Fin = intFolio_Final FROM Control_Folios_Remisiones WHERE intConsecutivo = @Consecutivo
SET @Encontro_Folios = ISNULL((SELECT COUNT(*) FROM Remisiones WHERE intRemisionNo BETWEEN @Folio_Ini AND @Folio_Fin),0)

IF @Encontro_Folios = 0
BEGIN
	DELETE FROM Control_Folios_Remisiones WHERE intConsecutivo = @Consecutivo
	SET @Status = @@ROWCOUNT
	SET @Error = @@ERROR

	IF @Status <> 0
	BEGIN
		DELETE FROM Remisiones_Canceladas WHERE intConsecutivo = @Consecutivo
--		SET @Status = @@ROWCOUNT
	END
END
ELSE
	SET @Error = 547

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarCuentaContable]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_EliminarCuentaContable]
@Cuenta_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Cuentas_Contables WHERE intCtaContable_ID = @Cuenta_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END


GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarFolio]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_EliminarFolio]
	@Folio_ID		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	DELETE FROM Control_Folios WHERE intFolio_ID = @Folio_ID
	SET @Status = @@ROWCOUNT
	SET @Error = @@ERROR

	IF @Error = 547
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 547
	END
	ELSE
		IF @Status = 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN 99
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 0
		END
		
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarInvFisico]
@InvFisico_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

DELETE FROM Detalle_Inventario_Fisico WHERE intInventario_ID = @InvFisico_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
	RETURN 547
ELSE
	IF @Status = 0
		RETURN 99
	ELSE
		RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarIva]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_EliminarIva]
	@Iva_ID  int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	DELETE FROM Ivas WHERE intIva_ID = @Iva_ID
	SET @Status = @@ROWCOUNT
	SET @Error = @@ERROR

	IF @Error = 547
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 547
	END
	ELSE
		IF @Status = 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN 99
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 0
		END
		
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarOrdenCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarOrdenCompra]
@OrdenCompra_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int

IF (SELECT mnyAbonado FROM CtasXPagar WHERE intOrdenCompra_ID = @OrdenCompra_ID) > 0
	RETURN 999
ELSE
BEGIN
	BEGIN TRANSACTION
	
	UPDATE Orden_Compra SET bitCancelado = 1 WHERE intOrdenCompra_ID = @OrdenCompra_ID
	SET @Status = @@ROWCOUNT
	
	IF @Status <> 0 
	BEGIN
		UPDATE CtasXPagar SET bitCancelado = 1 WHERE intOrdenCompra_ID = @OrdenCompra_ID
		SET @Status = @@ROWCOUNT
	END
	
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarProducto]
@Producto_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Productos WHERE intProducto_ID = @Producto_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarProductoAgrupado]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarProductoAgrupado]
@Producto_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Agrupacion_Productos_Facturacion WHERE intAgrupacion_ID = @Producto_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarProductoCompuesto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarProductoCompuesto]
@Producto_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Productos_Compuestos WHERE intProductoCompuesto_ID = @Producto_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarProductoDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarProductoDeshuese]
@Producto_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Relacion_Deshuese WHERE intProducto_ID = @Producto_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarProveedor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarProveedor]
@Proveedor_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Proveedores WHERE intProveedor_ID = @Proveedor_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRegimenFiscal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_EliminarRegimenFiscal]
	@Regimen_ID		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	DELETE FROM Regimen_Fiscales WHERE intRegimen_ID = @Regimen_ID
	SET @Status = @@ROWCOUNT
	SET @Error = @@ERROR

	IF @Error = 547
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 547
	END
	ELSE
		IF @Status = 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN 99
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 0
		END
		
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRelacionProductos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarRelacionProductos]
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Relacion_Matanza
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRemisionCancelada]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarRemisionCancelada]
@Consecutivo_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

--BEGIN TRANSACTION

DELETE FROM Remisiones_Canceladas WHERE intConsecutivo = @Consecutivo_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
--	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
--		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
--		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarRepartidor]
@Repartidor_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Repartidores WHERE intRepartidor_ID = @Repartidor_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarUnidadMedida]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarUnidadMedida]
@Unidad_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Unidad_Medida WHERE intUnidad_ID = @Unidad_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarVicera]
@Producto_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Viceras WHERE intVicera_ID = @Producto_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarVicerasASurtir]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_EliminarVicerasASurtir]
@Producto_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM Viceras_A_Surtir WHERE intProducto_ID = @Producto_ID
SET @Status = @@ROWCOUNT
SET @Error = @@ERROR

IF @Error = 547
BEGIN
	ROLLBACK TRANSACTION
	RETURN 547
END
ELSE
	IF @Status = 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 99
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 0
	END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerAbonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerAbonos]
@Cliente_ID 	int,
@Cuenta	char(1),
@Almacen         int
AS

SET NOCOUNT ON;

SET DATEFORMAT dmy

IF @Cliente_ID <> 0 
BEGIN

	IF @Cuenta = 'R'
		IF @Almacen <> 1
			SELECT CASE WHEN bitAplicada > 0 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103), CtasXCobrar.intRemisionNo, CtasXCobrar.mnyImporte, Detalle_CtasXCobrar.mnyAbono   - CASE WHEN bitAplicada_NC > 0 THEN Detalle_Notas_Credito.mnyImporte ELSE 0 END, CASE WHEN bitAplicada_NC > 0 THEN Detalle_Notas_Credito.mnyImporte ELSE NULL END, CtasXCobrar.mnySaldo, 0, Detalle_CtasXCobrar.Identificador FROM Detalle_CtasXCobrar
			INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
			LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
			LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitCancelada = 0
			WHERE CtasXCobrar.intCliente_ID = @Cliente_ID AND intTipoPago = 1 AND YEAR(Detalle_CtasXCobrar.dtmFecha_Abono)  >=2007 AND Facturas.intCliente_ID = 1000
			ORDER BY Detalle_CtasXCobrar.dtmFecha_Abono DESC
		ELSE
			SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103), CtasXCobrar.intRemisionNo, CtasXCobrar.mnyImporte, Detalle_CtasXCobrar.mnyAbono, NULL,  CtasXCobrar.mnySaldo, 0, Detalle_CtasXCobrar.Identificador FROM Detalle_CtasXCobrar
			INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
			WHERE CtasXCobrar.intCliente_ID = @Cliente_ID  AND YEAR(Detalle_CtasXCobrar.dtmFecha_Abono)  >=2007
			ORDER BY Detalle_CtasXCobrar.dtmFecha_Abono DESC
	ELSE
	BEGIN
		CREATE TABLE #Abonos (
		intFactura_ID int,
		mnyTotal money,
		dtmFecha_Abono datetime
		)

		INSERT INTO #Abonos
		SELECT CtasXCobrar.intFactura_ID, SUM(Detalle_CtasXCobrar.mnyAbono) AS mnyTotal, dtmFecha_Abono FROM CtasXCobrar
	    INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
		WHERE intAlmacen_ID = @Almacen  AND YEAR(dtmFecha_Abono)  >=2007
		GROUP BY CtasXCobrar.intFactura_ID, Detalle_CtasXCobrar.dtmFecha_Abono

		SELECT CASE WHEN bitAplicada > 0 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,#Abonos.dtmFecha_Abono,103),103), Facturas.intFactura_ID, Facturas.mnyImporte + + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, (#Abonos.mnyTotal + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - CASE WHEN bitAplicada > 0 THEN Notas_Credito.mnyImporte ELSE 0 END, CASE WHEN bitAplicada > 0 THEN Notas_Credito.mnyImporte ELSE NULL END, Facturas.mnySaldo, 0, Facturas.intFactura_ID FROM Facturas
		INNER JOIN #Abonos ON Facturas.intFactura_ID = #Abonos.intFactura_ID
        LEFT OUTER JOIN Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0
		WHERE intCliente_ID = @Cliente_ID AND intTipoPago = 1 AND Facturas.intCliente_ID <> 1000
		ORDER BY #Abonos.dtmFecha_Abono DESC
		
		DROP TABLE #Abonos
	END
END
ELSE
BEGIN

	CREATE TABLE #Abonado (
	dtmFecha_Abono datetime,
	Total_Abonado money
	)

	IF @Cuenta = 'R'
		IF @Almacen <> 1
		BEGIN

			INSERT INTO #Abonado
			SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, SUM(mnyAbono) AS Total_Abonado FROM Detalle_CtasXCobrar 
	        INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
			LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
			WHERE Facturas.intCliente_ID = 1000
			GROUP BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)

			SELECT CASE WHEN bitAplicada > 0 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103), mnyAbono, CtasXCobrar.intRemisionNo, CtasXCobrar.mnyImporte, CtasxCobrar.mnySaldo, ISNULL(Total_Abonado,0), ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_CtasXCobrar
			INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
			LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
			INNER JOIN Clientes ON CtasxCobrar.intCliente_ID = Clientes.intCliente_ID
			LEFT OUTER JOIN  Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitCancelada = 0
			LEFT OUTER JOIN #Abonado ON CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) = #Abonado.dtmFecha_Abono
			WHERE Facturas.intCliente_ID = 1000  AND YEAR(Detalle_CtasXCobrar.dtmFecha_Abono)  >=2007
	--		ORDER BY Detalle_CtasXCobrar.dtmFecha_Abono DESC
			ORDER BY 2 DESC, 9, 4
		END
		ELSE
		BEGIN
		
			INSERT INTO #Abonado
			SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, SUM(mnyAbono) AS Total_Abonado FROM Detalle_CtasXCobrar 
	        INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
			GROUP BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)

			SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103), mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbono, intRemisionNo, CtasXCobrar.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, CtasxCobrar.mnySaldo, ISNULL(Total_Abonado,0), ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_CtasXCobrar
			INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
	        INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
			INNER JOIN Clientes ON CtasxCobrar.intCliente_ID = Clientes.intCliente_ID
			LEFT OUTER JOIN #Abonado ON CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) = #Abonado.dtmFecha_Abono
			WHERE YEAR(Detalle_CtasXCobrar.dtmFecha_Abono)  >=2007
			ORDER BY 2 DESC, 9, 4
		END
	ELSE
	BEGIN
		
		INSERT INTO #Abonado 	
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, SUM(mnyAbono) AS Total_Abonado FROM Detalle_CtasXCobrar 
                INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		WHERE Facturas.intCliente_ID <> 1000
                GROUP BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)
	
		SELECT CASE WHEN Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103), (mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - CASE WHEN Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN Notas_Credito.mnyImporte ELSE 0 END AS Abono, Notas_Credito.mnyImporte AS [Nota Credito], Facturas.intFactura_ID, Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, Facturas.mnySaldo, ISNULL(Total_Abonado,0) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0), CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN #Abonado ON CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) = #Abonado.dtmFecha_Abono
		LEFT OUTER JOIN  Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0
		WHERE NOT CtasXCobrar.intFactura_ID IS NULL 
          AND Facturas.intCliente_ID <> 1000
		  AND YEAR(Detalle_CtasXCobrar.dtmFecha_Abono)  >=2007
		GROUP BY Notas_Credito.intNota_Credito_ID, Detalle_CtasXCobrar.bitAplicada_NC, Detalle_CtasXCobrar.dtmFecha_Abono, mnyAbono, Facturas.mnyImporte, Notas_Credito.mnyImporte, Facturas.intFactura_ID, Facturas.mnyImporte, Facturas.mnySaldo, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre, Total_Abonado, Facturas.mnyIVA
--		ORDER BY Detalle_CtasXCobrar.dtmFecha_Abono DESC, 9, Facturas.intFactura_ID
		ORDER BY 2 DESC, 9, 5
		
	END

	DROP TABLE #Abonado

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerAbonosCXP]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerAbonosCXP]
@Proveedor_ID   int
AS

SET DATEFORMAT dmy

IF @Proveedor_ID <> 0
	SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXPagar.dtmFecha_Abono,103),103), CtasXPagar.intOrdenCompra_ID, CtasXPagar.mnyImporte, Detalle_CtasXPagar.mnyAbono , CtasXPagar.mnySaldo, 0, Detalle_CtasXPagar.Identificador FROM Detalle_CtasXPagar
	INNER JOIN CtasXPagar ON Detalle_CtasXPagar.intCtaXPagar_ID = CtasXPagar.intCtaXPagar_ID
	WHERE CtasXPagar.intProveedor_ID = @Proveedor_ID
	ORDER BY Detalle_CtasXPagar.dtmFecha_Abono
ELSE
	SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103), intOrdenCompra_ID, mnyImporte, mnyAbono, CtasXPagar.mnySaldo, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_CtasXPagar
	INNER JOIN CtasXPagar ON CtasXPagar.intCtaXPagar_ID = Detalle_CtasXPagar.intCtaXPagar_ID
	INNER JOIN Proveedores ON CtasXPagar.intProveedor_ID = Proveedores.intProveedor_ID
	ORDER BY 7, intOrdenCompra_ID, dtmFecha_Abono
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerAbonosCXPParametros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerAbonosCXPParametros]
@Fecha_Inicial    smalldatetime, --varchar(30),
@Fecha_Final     smalldatetime, --varchar(30),
@OrdenCompra  int,
@Proveedor_ID   int
AS

SET DATEFORMAT dmy

SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103), intOrdenCompra_ID, mnyImporte, mnyAbono, CtasXPagar.mnySaldo, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_CtasXPagar
INNER JOIN CtasXPagar ON Detalle_CtasXPagar.intCtaXPagar_ID = CtasXPagar.intCtaXPagar_ID
INNER JOIN Proveedores ON CtasXPagar.intProveedor_ID = Proveedores.intProveedor_ID
WHERE (CtasXPagar.intProveedor_ID = @Proveedor_ID AND @Proveedor_ID <> 0 OR @Proveedor_ID = 0)
      AND (intOrdenCompra_ID = @OrdenCompra AND @OrdenCompra <> 0 OR @OrdenCompra = 0)
      AND (CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) BETWEEN @Fecha_Inicial AND @Fecha_Final AND @Fecha_Inicial <> '' OR NOT dtmFecha IS NULL AND @Fecha_Inicial = '')
ORDER BY 7, intOrdenCompra_ID, dtmFecha_Abono
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCertificado]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ObtenerCertificado]
AS

BEGIN
	SET NOCOUNT ON;

    SELECT vchCertificadoPEM FROM Datos_FacturaElectronica
  
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCierresInventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerCierresInventario]
AS

SELECT ' ', intCierre_ID, dtmFechaCierre, Usuarios.vchNombreCompleto FROM Cierre_Inventario
INNER JOIN Usuarios ON Cierre_Inventario.intUsuario_ID = Usuarios.intUsuario_ID
ORDER BY intCierre_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerComboClientes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerComboClientes]
AS

SET DATEFORMAT dmy

SELECT intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre FROM Clientes
WHERE bitActivo = 1
ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasVencidas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasVencidas]
@TipoConsulta		char(1)
AS

SET DATEFORMAT dmy

IF @TipoConsulta = 'R'
	SELECT '', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, intPlazo, CtasXCobrar.dtmFecha, intRemisionNo, CtasXCobrar.mnyImporte, CASE WHEN mnyAbonado = 0 THEN NULL ELSE mnyAbonado END, CtasXCobrar.mnySaldo FROM CtasXCobrar
	LEFT OUTER JOIN Facturas ON CtasxCobrar.intFactura_ID = Facturas.intFactura_ID
	INNER JOIN Clientes ON CtasxCobrar.intCliente_ID = Clientes.intCliente_ID
	WHERE CtasXCobrar.mnySaldo > 0
	      AND DATEDIFF(day, CtasXCobrar.dtmFecha, GETDATE()) > intPlazo
	      AND (Facturas.intCliente_ID = 1000 OR Facturas.intCliente_ID IS NULL)
	ORDER BY 2, 4
ELSE
	SELECT '', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, intPlazo, dtmFecha, intFactura_ID, mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, CASE WHEN mnyImporte - mnySaldo = 0 THEN NULL ELSE (mnyImporte - mnySaldo) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) END, mnySaldo FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	WHERE mnySaldo > 0
	      AND DATEDIFF(day, dtmFecha, GETDATE()) > intPlazo
	      AND Facturas.intCliente_ID <> 1000
	ORDER BY 2, 4

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXCobrar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXCobrar]
@Cliente_ID 	int,
@Cuenta	char(1),
@Almacen         int
AS

SET DATEFORMAT dmy

IF @Cuenta = 'R'
	SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,Remisiones.dtmFecha,103),103), Remisiones.intRemisionNo, Remisiones.mnySaldo, 0, '' FROM Remisiones
	INNER JOIN CtasXCobrar ON Remisiones.intRemisionNo = CtasXCobrar.intRemisionNo
	LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	WHERE Remisiones.intCliente_ID = @Cliente_ID
	      AND (Facturas.intCliente_ID = 1000 AND @Almacen <> 1 OR Facturas.intCliente_ID IS NULL AND @Almacen = 1)
	      AND bitFacturado = CASE WHEN @Almacen = 1 THEN 0 ELSE 1 END
	      AND Remisiones.mnySaldo <> 0
	      AND Remisiones.intAlmacen_Id = @Almacen
	ORDER  BY Remisiones.intRemisionNo
ELSE
	SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103), intFactura_ID, mnySaldo, 0, '' FROM Facturas
	WHERE intCliente_ID = @Cliente_ID
	      AND bitCancelada = 0
	      AND mnySaldo <> 0
	ORDER BY intFactura_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXCobrarXCliente]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXCobrarXCliente]
@Cliente_ID 	int,
@Cuenta	char(1),
@Almacen         int,
@Todas	int
AS

SET DATEFORMAT dmy

IF @Cuenta = 'R'
	SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,Remisiones.dtmFecha,103),103), Remisiones.intRemisionNo, CtasXCobrar.mnyImporte - ISNULL(Detalle_Notas_Credito.mnyImporte,0), ISNULL(CtasXCobrar.mnyAbonado,0), ISNULL(CtasXCobrar.mnySaldo,0) - ISNULL(Detalle_Notas_Credito.mnyImporte,0) FROM Remisiones
	INNER JOIN CtasXCobrar ON Remisiones.intRemisionNo = CtasXCobrar.intRemisionNo
	INNER JOIN Detalle_Facturas ON Remisiones.intRemisionNo = Detalle_Facturas.intRemisionNo
	INNER JOIN Facturas ON Detalle_Facturas.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
	WHERE Remisiones.intCliente_ID = @Cliente_ID
--	      AND bitFacturado = CASE WHEN @Almacen = 1 THEN 0 ELSE 1 END
	      AND (Remisiones.mnySaldo <> 0 AND @Todas = 0 OR @Todas = 1)
	      AND Remisiones.intAlmacen_Id = @Almacen
	      AND Facturas.intCliente_ID = 1000
	      AND Facturas.bitCancelada = 0
	ORDER BY Remisiones.dtmFecha
ELSE
	SELECT CASE WHEN Notas_Credito.bitAplicada = 0 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103), Facturas.intFactura_ID, Facturas.mnyImporte - ISNULL(Notas_Credito.mnyImporte,0), ISNULL(mnyAbonado,0), ISNULL(mnySaldo,0) - ISNULL(Notas_Credito.mnyImporte,0) FROM Facturas
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbonado) AS mnyAbonado FROM CtasXCobrar WHERE intAlmacen_ID = @Almacen GROUP BY intFactura_ID) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte, bitAplicada FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID, bitAplicada) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
	WHERE Facturas.intCliente_ID = @Cliente_ID
	      AND Facturas.bitCancelada = 0
	      AND (mnySaldo <> 0 AND @Todas = 0 OR @Todas = 1)
	ORDER BY Facturas.dtmFecha

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXCobrarXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXCobrarXFactura]
@Factura	int
AS

SET DATEFORMAT dmy

SELECT ' ', vAbonosRemisionesXFactura.intRemisionNo, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, dtmFecha, vAbonosRemisionesXFactura.mnyImporte, dtmFecha_Abono, mnyAbono, vAbonosRemisionesXFactura.mnyImporte - mnyTotalAbono FROM vAbonosRemisionesXFactura
INNER JOIN Clientes ON vAbonosRemisionesXFactura.intCliente_ID = Clientes.intCliente_ID
INNER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyTotalAbono FROM vAbonosRemisionesXFactura
	           WHERE intFactura_ID = @Factura
	           GROUP BY intFactura_ID) TotalCliente ON vAbonosRemisionesXFactura.intFactura_ID = TotalCliente.intFactura_ID
WHERE vAbonosRemisionesXFactura.intFactura_ID = @Factura
ORDER BY 2,3, 4

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXCobrarXFecha]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXCobrarXFecha]
@Fecha 	smalldatetime,
@TipoCuenta	char(1)
AS

SET DATEFORMAT dmy

IF @TipoCuenta = 'R'
	SELECT ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, intRemisionNo, mnyAbono, mnyTotalAbono FROM vAbonosRemisionesXDia
	INNER JOIN Clientes ON vAbonosRemisionesXDia.intCliente_ID = Clientes.intCliente_ID
	INNER JOIN (SELECT intCliente_ID, SUM(mnyAbono) AS mnyTotalAbono FROM vAbonosRemisionesXDia
		           WHERE dtmFecha_Abono BETWEEN @Fecha AND @Fecha + '23:59'
		           GROUP BY intCliente_ID) TotalCliente ON vAbonosRemisionesXDia.intCliente_ID = TotalCliente.intCliente_ID
	WHERE dtmFecha_Abono BETWEEN @Fecha AND @Fecha + '23:59'
	ORDER BY 2,3
ELSE
	SELECT ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, intFactura_ID, mnyAbono, mnyTotalAbono FROM vAbonosFacturasXDia
	INNER JOIN Clientes ON vAbonosFacturasXDia.intCliente_ID = Clientes.intCliente_ID
	INNER JOIN (SELECT intCliente_ID, SUM(mnyAbono) AS mnyTotalAbono FROM vAbonosFacturasXDia
		           WHERE dtmFecha_Abono BETWEEN @Fecha AND @Fecha + '23:59'
		           GROUP BY intCliente_ID) TotalCliente ON vAbonosFacturasXDia.intCliente_ID = TotalCliente.intCliente_ID
	WHERE dtmFecha_Abono BETWEEN @Fecha AND @Fecha + '23:59'
	ORDER BY 2,3
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXPagar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXPagar]
@Proveedor_ID 	int
AS

SET DATEFORMAT dmy

SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXPagar.dtmFecha,103),103), CtasXPagar.intOrdenCompra_ID, mnySaldo FROM CtasXPagar
INNER JOIN Orden_Compra OC On CtasXPagar.intOrdenCompra_ID = OC.intOrdenCompra_ID
WHERE CtasXPagar.intProveedor_ID = @Proveedor_ID
      AND mnySaldo <> 0
      AND OC.bitCancelado = 0
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXPagarXFecha]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXPagarXFecha]
@Fecha 	smalldatetime
AS

SET DATEFORMAT mdy

SELECT ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, intOrdenCompra_ID, mnyAbono FROM Detalle_CtasXPagar
INNER JOIN CtasXPagar ON Detalle_CtasXPagar.intCtaXPagar_ID = CtasXPagar.intCtaXPagar_ID
INNER JOIN Proveedores ON CtasXPagar.intProveedor_ID = Proveedores.intProveedor_ID
WHERE dtmFecha_Abono BETWEEN @Fecha AND @Fecha + '23:59' AND bitCancelado = 0

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCuentasXPagarXProveedor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerCuentasXPagarXProveedor]
@Proveedor_ID 	int,
@Todas		int
AS

SET DATEFORMAT dmy

SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXPagar.dtmFecha,103),103), CtasXPagar.intOrdenCompra_ID, mnyImporte, mnyAbonado, mnySaldo FROM CtasXPagar
INNER JOIN Orden_Compra OC ON CtasXPagar.intOrdenCompra_ID = OC.intOrdenCompra_ID
WHERE CtasXPagar.intProveedor_ID = @Proveedor_ID
      AND (mnySaldo <> 0 AND @Todas = 0 OR @Todas = 1)
      AND OC.bitCancelado = 0
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCveProdServ]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerCveProdServ]
	@Clave_ID	varchar(10),
	@Todos		int,
	@Estatus	int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT ROW_NUMBER() OVER(ORDER BY c_ClaveProdServ ASC) AS intClave_ID, c_ClaveProdServ + ' - ' + Descripcion AS vchDescripcion FROM c_ClaveProdServ
		WHERE ISNULL(Seleccionado,0) = 1 AND (c_ClaveProdServ = @Clave_ID AND @Clave_ID <> 0 OR @Clave_ID = 0)
	ELSE
		SELECT ' ', ROW_NUMBER() OVER(ORDER BY c_ClaveProdServ ASC) AS intClave_ID, c_ClaveProdServ + ' - ' + Descripcion AS vchDescripcion FROM c_ClaveProdServ
		WHERE ISNULL(Seleccionado,0) = @Estatus AND (c_ClaveProdServ = @Clave_ID AND @Clave_ID <> 0 OR @Clave_ID = 0)
	
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosCfgCorreo]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosCfgCorreo]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM Configuracion_Correo
	
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosCliente]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosCliente]
@Cliente_ID       int,
@Todos              int,
@Estatus             int
AS

SET DATEFORMAT dmy

IF @Todos = 1
	SELECT * FROM Clientes
	WHERE bitActivo = @Estatus AND (intCliente_ID = @Cliente_ID AND @Cliente_ID <> 0 OR @Cliente_ID = 0) 
ELSE
	SELECT ' ', intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, vchRFC, bitEnviarCorreo, vchEmail, bitOrdenCompra FROM Clientes
	WHERE bitActivo = @Estatus AND (intCliente_ID = @Cliente_ID AND @Cliente_ID <> 0 OR @Cliente_ID = 0)
	ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosClienteTercero]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosClienteTercero]
@Cliente_ID               int,
@Cliente_Tercero     int,
@Todos                      int,
@Estatus                   int
AS

SET DATEFORMAT dmy

IF @Todos = 1
	SELECT * FROM Facturar_Terceros
	WHERE bitActivo = @Estatus 
	      AND intCliente_ID = @Cliente_ID
	      AND (intCliente_Tercero_ID = @Cliente_Tercero AND @Cliente_Tercero <> 0 OR @Cliente_Tercero = 0) 
ELSE
	SELECT ' ', intCliente_Tercero_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, vchRFC, bitEnviarCorreo, vchEmail FROM Facturar_Terceros
	WHERE bitActivo = @Estatus 
                   AND intCliente_ID = @Cliente_ID
                   AND (intCliente_Tercero_ID = @Cliente_Tercero AND @Cliente_Tercero <> 0 OR @Cliente_Tercero = 0)
	ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
	
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosClienteXRemision]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosClienteXRemision]
@RemisionNo	int,
@Almacen	int
AS

SET DATEFORMAT dmy

IF (SELECT COUNT(*) FROM Remisiones WHERE Remisiones.intRemisionNo = @RemisionNo AND intAlmacen_ID = @Almacen) = 0
	SELECT  'C' AS Cancelada, '' AS Nombre FROM Remisiones_Canceladas WHERE  intRemisionNo = @RemisionNo
ELSE
	SELECT CASE WHEN intConsecutivo IS NULL THEN '' ELSE 'C' END AS Cancelada, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre FROM Remisiones
	INNER JOIN Clientes ON Remisiones.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Remisiones_Canceladas ON Remisiones.intRemisionNo = Remisiones_Canceladas.intRemisionNo
	WHERE Remisiones.intRemisionNo = @RemisionNo
	       AND intAlmacen_ID = @Almacen
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosConcepto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosConcepto]
@Fecha	smalldatetime
AS

SET DATEFORMAT dmy

SELECT CASE WHEN bitBanco = 1 THEN '*' ELSE '' END, vchCuentaContable, vchConcepto, mnyDebe, mnyHaber FROM Conceptos_Poliza
INNER JOIN Cuentas_Contables ON vchCuentaContable = vchNoCuenta
WHERE dtmFecha = @Fecha


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosControlFolios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosControlFolios]
@Consecutivo    int
AS

SET DATEFORMAT dmy

IF @Consecutivo <> 0
	SELECT * FROM  Control_Folios_Remisiones
	WHERE intConsecutivo = @Consecutivo
ELSE
	SELECT ' ', intFolio_Inicial, intFolio_Final, RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) AS vchNombre, intConsecutivo FROM  Control_Folios_Remisiones
	INNER JOIN Repartidores ON Control_Folios_Remisiones.intRepartidor_ID = Repartidores.intRepartidor_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosCuentaContable]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosCuentaContable]
@Cuenta_ID   int,
@Todos       int,
@Estatus     int
AS

SET DATEFORMAT dmy

IF @Todos = 1
	SELECT * FROM Cuentas_Contables
	WHERE bitActivo = @Estatus AND (intCtaContable_ID = @Cuenta_ID AND @Cuenta_ID <> 0 OR @Cuenta_ID = 0)

IF @Todos = -1
	SELECT ' ', vchNoCuenta, Rtrim(vchDescripcion) AS vchDescripcion FROM Cuentas_Contables
	WHERE bitActivo = @Estatus
ELSE
	SELECT ' ', intCtaContable_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Cuentas_Contables
	WHERE bitActivo = @Estatus AND (intCtaContable_ID = @Cuenta_ID AND @Cuenta_ID <> 0 OR @Cuenta_ID = 0)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDeshuese]
@Producto_ID  int
AS

SET DATEFORMAT dmy

SELECT '', Productos.vchDescripcion, '', Productos_Compuestos.intProducto_ID FROM Productos_Compuestos
INNER JOIN Productos ON Productos_Compuestos.intProducto_ID = Productos.intProducto_ID
WHERE intProductoCompuesto_ID = @Producto_ID
--ORDER BY Productos.vchDescripcion
ORDER BY Productos.intProducto_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleFactura]
@Factura_ID       int
AS

SET DATEFORMAT dmy

SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,Remisiones.dtmFecha,103),103), Detalle_Facturas.intRemisionNo, Remisiones.mnyImporte, Facturas.intCliente_ID, 
	CASE WHEN Facturas.intCliente_Tercero = 0  THEN 
		CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END 
	ELSE 
		CASE WHEN RTRIM(T.vchRazonSocial) <> '' THEN RTRIM(T.vchRazonSocial) ELSE RTRIM(T.vchApellidoPaterno) + ' ' + RTRIM(T.vchApellidoMaterno) + ' ' + RTRIM(T.vchNombre) END 
	END AS Nombre, intTipoPago, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, vchObservaciones, CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE T.vchRFC END AS vchRFC, Cab_Ventas.vchFolio_Fiscal FROM Detalle_Facturas
INNER JOIN Facturas ON Detalle_Facturas.intFactura_ID = Facturas.intFactura_ID
INNER JOIN Remisiones ON Detalle_Facturas.intRemisionNo = Remisiones.intRemisionNo
INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN Facturar_Terceros T ON Facturas.intCliente_ID = T.intCliente_ID AND Facturas.intCliente_Tercero = T.intCliente_Tercero_ID
LEFT OUTER JOIN Cab_Ventas ON Detalle_Facturas.intFactura_ID = Cab_Ventas.intFactura_ID
WHERE Detalle_Facturas.intFactura_ID = @Factura_ID
      AND Facturas.bitCancelada = 0
      AND Cab_Ventas.vchXML_Timbre <> ''
--    AND (Facturas.mnyImporte = Facturas.mnySaldo OR Facturas.intTipoPago = 2)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleFacturaNC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleFacturaNC]
@Factura_ID       int
AS

SET DATEFORMAT dmy

SELECT ' ', Detalle_Facturas.intRemisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,Remisiones.dtmFecha,103),103), CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Remisiones.mnyImporte, '' AS ImporteNC FROM Detalle_Facturas
INNER JOIN Facturas ON Detalle_Facturas.intFactura_ID = Facturas.intFactura_ID
INNER JOIN Remisiones ON Detalle_Facturas.intRemisionNo = Remisiones.intRemisionNo
INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
WHERE Detalle_Facturas.intFactura_ID = @Factura_ID
      AND bitCancelada = 0

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleInvFisico]
@InvFisico_ID		int
AS

SET DATEFORMAT dmy

SELECT intLinea, Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, mnyPeso, 'U' FROM Detalle_Inventario_Fisico
INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
WHERE Detalle_Inventario_Fisico.intInventario_ID = @InvFisico_ID
ORDER BY intLinea

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleMatanza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleMatanza]
@OrdenCompra_ID	int,
@Producto_ID	int,
@Almacen_ID		int
AS

SET DATEFORMAT dmy

IF ISNULL((SELECT COUNT(*) FROM Relacion_Matanza WHERE intProducto_Pie = @Producto_ID),0) > 0
BEGIN
	SELECT '', Productos.vchDescripcion, MGP.dtmFecha AS dtmFecha, MGP.intCantidad / 2 AS Cantidad, Movs.mnyPeso 
	--, DOC.intOrdenCompra_ID AS OC, MGP.intMatanza_ID AS Matanza, DOC.intProducto_ID AS GP, DOC.intCantidad AS Cant_OC, MGP.intProducto_ID AS Canal, Movs.mnyPeso 
	FROM Detalle_Orden_Compra DOC
	INNER JOIN Productos ON DOC.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Relacion_Matanza RM ON DOC.intProducto_ID = RM.intProducto_Pie
	INNER JOIN Matanzas MGP ON MGP.bitCancelado = 0 AND MGP.bitProcesado = 1 AND DOC.intOrdenCompra_ID = MGP.intOrdenCompra_ID AND RM.intProducto_Canal = MGP.intProducto_ID
	LEFT OUTER JOIN (SELECT intOrdenCompra_ID, intMatanza_ID, intProducto_ID, SUM(mnyPeso) AS mnyPeso FROM Movimientos Movs WHERE chrOperacion = 'E' AND intAlmacen_ID = @Almacen_ID GROUP BY intOrdenCompra_ID, intMatanza_ID, intProducto_ID) Movs ON DOC.intOrdenCompra_ID = Movs.intOrdenCompra_ID AND mGP.intMatanza_ID = Movs.intMatanza_ID AND RM.intProducto_Canal = Movs.intProducto_ID
	WHERE DOC.intOrdenCompra_ID = @OrdenCompra_ID AND DOC.intProducto_ID = @Producto_ID
	ORDER BY  DOC.intOrdenCompra_ID, MGP.intMatanza_ID
END
ELSE
BEGIN
	SELECT '', Productos.vchDescripcion, MGP.dtmFecha AS dtmFecha, MGP.intCantidad AS Cantidad, ISNULL(Movs.mnyPeso,0)
	FROM Detalle_Orden_Compra DOC
	INNER JOIN Productos ON DOC.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Matanzas MGP ON MGP.bitCancelado = 0 AND MGP.bitProcesado = 1 AND DOC.intOrdenCompra_ID = MGP.intOrdenCompra_ID AND DOC.intProducto_ID = MGP.intProducto_ID
	LEFT OUTER JOIN (SELECT intOrdenCompra_ID, intMatanza_ID, SUM(mnyPeso) AS mnyPeso FROM Movimientos Movs WHERE intAlmacen_ID = @Almacen_ID AND CASE WHEN intProducto_ID = 2 THEN 'S' ELSE 'E' END = chrOperacion GROUP BY intOrdenCompra_ID, intMatanza_ID) Movs ON DOC.intOrdenCompra_ID = Movs.intOrdenCompra_ID AND mGP.intMatanza_ID = Movs.intMatanza_ID
	WHERE DOC.intOrdenCompra_ID = @OrdenCompra_ID AND DOC.intProducto_ID = @Producto_ID
	GROUP BY Productos.vchDescripcion, MGP.dtmFecha, MGP.intCantidad, ISNULL(Movs.mnyPeso,0)
END

--SELECT ' ', Productos.vchDescripcion, Matanzas.dtmFecha, Matanzas.intCantidad / CASE WHEN ISNULL(Ganado_Pie.intProducto_Pie,0) <> 0 THEN 2 ELSE 1 END AS Cantidad FROM Matanzas
--INNER JOIN (SELECT intOrdenCompra_ID, intProducto_ID FROM Detalle_Orden_Compra GROUP BY intOrdenCompra_ID, intProducto_ID) Detalle_Orden_Compra ON Matanzas.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID AND Detalle_Orden_Compra.intProducto_ID = @Producto_ID
--INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
--LEFT OUTER JOIN (SELECT intProducto_Pie,  intProducto_Canal FROM Relacion_Matanza) Ganado_Pie ON Detalle_Orden_Compra.intProducto_ID = Ganado_Pie.intProducto_Pie
--WHERE Matanzas.intOrdenCompra_ID = @OrdenCompra_ID
--      AND (Matanzas.intProducto_ID = @Producto_ID AND Ganado_Pie.intProducto_Pie IS NULL OR Detalle_Orden_Compra.intProducto_ID = @Producto_ID AND NOT Ganado_Pie.intProducto_Pie IS NULL)
--ORDER BY Matanzas.intOrdenCompra_ID, Matanzas.intMatanza_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleNotas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleNotas_Credito]
@Nota_Credito		int
AS

SET DATEFORMAT dmy

SELECT ' ', Detalle_Notas_Credito.intRemisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) AS dtmFecha, CtasXCobrar.mnyImporte, Detalle_Notas_Credito.mnyImporte, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_Notas_Credito
INNER JOIN CtasXCobrar ON Detalle_Notas_Credito.intRemisionNo = CtasXCobrar.intRemisionNo
INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
WHERE Detalle_Notas_Credito.intNota_Credito_ID = @Nota_Credito
ORDER BY Detalle_Notas_Credito.intRemisionNo


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleOrdenCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleOrdenCompra]
@OrdenCompra_ID     int,
@TipoConsulta             int,
@TipoProceso              char(1)
AS

SET DATEFORMAT dmy

IF @TipoProceso = 'O'
	IF @TipoConsulta = 0
		SELECT ' ', vchDescripcion, intCantidad, intCantidad - intCantidad_Recibida, ' ',  Detalle_Orden_Compra.intProducto_ID, intRenglon FROM Detalle_Orden_Compra
		INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
		WHERE intOrdenCompra_ID = @OrdenCompra_ID
                                 AND intCantidad > 0
	ELSE
		IF @TipoConsulta = 1
--			SELECT ' ', Detalle_Orden_Compra.intProducto_ID, vchDescripcion, Detalle_Orden_Compra.intCantidad - intCantidad_Recibida, Detalle_Orden_Compra.intCantidad, Detalle_Orden_Compra.mnyPeso, mnyDescuento, Detalle_Orden_Compra.mnyPrecio, Detalle_Orden_Compra.mnyImporte, 'U', SUM(ISNULL(Movimientos.intCantidad,0)), intRenglon FROM Detalle_Orden_Compra
			SELECT ' ', Detalle_Orden_Compra.intProducto_ID, vchDescripcion, Detalle_Orden_Compra.intCantidad - intCantidad_Recibida, Detalle_Orden_Compra.intCantidad, Detalle_Orden_Compra.mnyPeso, mnyDescuento, Detalle_Orden_Compra.mnyPrecio, Detalle_Orden_Compra.mnyImporte, 'U', Detalle_Orden_Compra.intCantidad_Recibida, intRenglon FROM Detalle_Orden_Compra
			INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
--			LEFT OUTER JOIN Movimientos ON chrOperacion = 'E' AND Movimientos.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID AND Movimientos.intProducto_ID = Detalle_Orden_Compra.intProducto_ID AND intAlmacen_ID = 1 AND intRenglon = intRenglon_OC
			WHERE Detalle_Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND intCantidad > 0
--			GROUP BY Detalle_Orden_Compra.intProducto_ID, vchDescripcion, Detalle_Orden_Compra.intCantidad, intCantidad_Recibida, Detalle_Orden_Compra.mnyPeso, mnyDescuento, Detalle_Orden_Compra.mnyPrecio, Detalle_Orden_Compra.mnyImporte, intRenglon
		ELSE
			SELECT ' ', Detalle_Orden_Compra.intProducto_ID, vchDescripcion, Detalle_Orden_Compra.intCantidad, Detalle_Orden_Compra.mnyPeso, mnyDescuento, Detalle_Orden_Compra.mnyPrecio, Detalle_Orden_Compra.mnyImporte FROM Detalle_Orden_Compra
			INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
			WHERE Detalle_Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND intCantidad > 0
ELSE
--	SELECT ' ', vchDescripcion, CASE WHEN intExistencia IS NULL THEN Matanzas.intCantidad ELSE intExistencia END AS intExistencia, ' ', Detalle_Orden_Compra.intProducto_ID FROM Detalle_Orden_Compra
	SELECT ' ', vchDescripcion, intExistencia, ' ', Detalle_Orden_Compra.intProducto_ID FROM Detalle_Orden_Compra
	INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
	LEFT OUTER JOIN Existencias ON intAlmacen_ID = 1 AND Detalle_Orden_Compra.intProducto_ID = Existencias.intProducto_ID AND Detalle_Orden_Compra.intOrdenCompra_ID = Existencias.intOrdenCompra_ID
--	LEFT OUTER JOIN Matanzas ON Detalle_Orden_Compra.intProducto_ID = Matanzas.intProducto_ID AND Detalle_Orden_Compra.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
	WHERE Detalle_Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID
                     AND intCantidad > 0
	       AND NOT intExistencia IS NULL

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleTraspasos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleTraspasos]
	@Traspaso_ID	int,
	@Almacen_ID		int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @SQL varchar(MAX), @BaseDatos varchar(20), @Almacen_FROM int, @Fecha varchar(10)

	SET @Almacen_FROM = (SELECT DISTINCT intAlmacen_ID_FROM FROM Traspasos WHERE intAlmacen_ID_TO = @Almacen_ID)
	SET @Fecha = (SELECT CONVERT(varchar,dtmFecha,103) FROM Traspasos WHERE intTraspaso_ID = @Traspaso_ID)
	SET @BaseDatos = (SELECT BaseDatos FROM Almacenes WHERE intAlmacen_ID = @Almacen_FROM)

	SET @SQL = 'SELECT '''', P.vchDescripcion, M.intCanalNo, M.mnyPeso FROM ' + @BaseDatos + '.dbo.Movimientos M ' +
	           'INNER JOIN ' + @BaseDatos + '.dbo.Productos P On M.intProducto_ID = P.intProducto_ID ' +
	           'WHERE CONVERT(varchar,dtmFecha,103) = ''' + @Fecha + ''' AND intRemisionNo = ' + CONVERT(varchar,@Traspaso_ID) + ' ' +
	           'ORDER BY P.vchDescripcion'

	EXEC (@SQL)

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosEmpresa]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosEmpresa]
AS

SET DATEFORMAT dmy

SELECT *  FROM Parametros
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosEntradaMatanza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosEntradaMatanza]
@Matanza_ID     int
AS

SET DATEFORMAT dmy

SELECT ' ', intCanalNo, mnyPeso, dtmFecha FROM Movimientos
WHERE intMatanza_ID = @Matanza_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosEntradaVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosEntradaVicera]
@Matanza_ID    int,
@Operacion        char(1),
@Vicera_ID        int
AS

SET DATEFORMAT dmy

DECLARE @ViceraCompleta int

SET @ViceraCompleta = (SELECT  Parametros.intProducto_ViceraCompleta FROM Parametros)

IF @Operacion = 'C'
	SELECT ' ', Productos.vchDescripcion, Productos.intNoPiezas, Movimientos.intCantidad FROM Movimientos
	INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
	WHERE intMatanza_ID = @Matanza_ID 
	       AND Movimientos.intProducto_ID IN (SELECT intProducto_ID FROM Viceras WHERE INTVicera_ID = @ViceraCompleta)
ELSE
	IF @Operacion = 'P'
		SELECT ' ', Productos.vchDescripcion, Productos.intNoPiezas, Productos.intNoPiezas * Matanzas.intCantidad,  Viceras.intProducto_ID  FROM Matanzas
		INNER JOIN Viceras ON @ViceraCompleta = Viceras.intVicera_ID
		INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
		WHERE intMatanza_ID = @Matanza_ID
	ELSE
		SELECT Productos.intNoPiezas, Viceras.intProducto_ID  FROM Matanzas
		INNER JOIN Viceras ON @Vicera_ID = Viceras.intVicera_ID
		INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
		WHERE intMatanza_ID = @Matanza_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosEstadoCuenta]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosEstadoCuenta]
@Cliente	int,
@Fecha_Ini	datetime,
@Fecha_Fin	datetime,
@TipoConsulta	char(1)
AS

SET DATEFORMAT dmy
SET NOCOUNT ON

--SET @Cliente = 666
--SET @Fecha_Ini = '01/07/2008'
--SET @Fecha_Fin = '31/07/2008'
--SET @TipoConsulta = 'R'

CREATE TABLE #Movimientos (
dtmFecha     smalldatetime,
intRemision  varchar(10),
mnySaldo_Ant money,
mnyCargos    money,
mnyAbonos    money,
mnySaldo     money)

DECLARE @Saldo_Anterior money, @Saldo_Nuevo money, @dtmFecha smalldatetime, @intRemision varchar(10), @Cargo money, @Abono money, @Saldo_Diario money

IF @TipoConsulta = 'R'
BEGIN
	SET @Saldo_Anterior = ISNULL((SELECT SUM(ISNULL(CtasXCobrar.mnyImporte,0) - (ISNULL(Abonos.mnyAbonado,0) +  ISNULL(Detalle_Notas_Credito.mnyImporte,0))) AS mnySaldo FROM CtasXCobrar
				      LEFT OUTER JOIN (SELECT intCtaXCobrar_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < @Fecha_Ini GROUP BY intCtaXCobrar_ID) Abonos ON CtasXCobrar.intCtaXCobrar_ID = Abonos.intCtaXCobrar_ID
				      LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
				      LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
				      WHERE CtasXCobrar.intCliente_ID = @Cliente
				        AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) < @Fecha_Ini
                                                             AND Facturas.intCliente_ID = 1000),0)
	
	SET @Saldo_Nuevo = ISNULL((SELECT SUM(ISNULL(CtasXCobrar.mnyImporte,0) - (ISNULL(Abonos.mnyAbonado,0) +  ISNULL(Detalle_Notas_Credito.mnyImporte,0))) AS mnySaldo FROM CtasXCobrar
				      LEFT OUTER JOIN (SELECT intCtaXCobrar_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < DATEADD(day,1,@Fecha_Fin) GROUP BY intCtaXCobrar_ID) Abonos ON CtasXCobrar.intCtaXCobrar_ID = Abonos.intCtaXCobrar_ID
				      LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
				      LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
				      WHERE CtasXCobrar.intCliente_ID = @Cliente
				        AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) < DATEADD(day,1,@Fecha_Fin)
                                                             AND Facturas.intCliente_ID = 1000),0)
	
	SET @Saldo_Diario = @Saldo_Anterior
	
	INSERT INTO #Movimientos (mnySaldo_Ant) VALUES (@Saldo_Anterior)
	
	DECLARE Movimientos_Cursor CURSOR FOR
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) AS dtmFecha, LTRIM(RTRIM(CONVERT(CHAR,CtasXCobrar.intRemisionNo))) AS intRemisionNo, CtasXCobrar.mnyImporte - ISNULL(Detalle_Notas_Credito.mnyImporte,0), 0 AS Abonado FROM CtasXCobrar
		LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		WHERE CtasXCobrar.intCliente_ID = @Cliente
                                 AND Facturas.intCliente_ID = 1000
		       AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		
		UNION
		
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103), LTRIM(RTRIM(CONVERT(CHAR,intRemisionNo))) AS intRemisionNo, 0, ISNULL(SUM(mnyAbono),0) AS mnyAbonado FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin 
		       AND CtasXCobrar.intCliente_ID = @Cliente
                                 AND Facturas.intCliente_ID = 1000
		GROUP BY intRemisionNo, dtmFecha_Abono
        HAVING ISNULL(SUM(mnyAbono),0) > 0
		
		ORDER BY dtmFecha, intRemisionNo
END
ELSE
BEGIN
	SET @Saldo_Anterior = ISNULL((SELECT SUM((Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - (ISNULL(mnyAbonado,0) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) + ISNULL(Notas_Credito.mnyImporte,0)) FROM Facturas
				                  LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar 
				                                   LEFT OUTER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
				                                   WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < @Fecha_Ini
				                                   GROUP BY intFactura_ID) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
					              LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
				                  WHERE Facturas.intCliente_ID = @Cliente
				                    AND Facturas.bitCancelada = 0
				                    AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) < @Fecha_Ini),0)
	
	SET @Saldo_Nuevo = ISNULL((SELECT SUM((Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - (ISNULL(mnyAbonado,0) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) + ISNULL(Notas_Credito.mnyImporte,0)) FROM Facturas
				               LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar 
				                                LEFT OUTER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
				                                WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < DATEADD(day,1,@Fecha_Fin)
				                                GROUP BY intFactura_ID) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
					           LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
				               WHERE Facturas.intCliente_ID = @Cliente
				                 AND Facturas.bitCancelada = 0
				                 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) < DATEADD(day,1,@Fecha_Fin)),0)
	
	SET @Saldo_Diario = @Saldo_Anterior
	
	INSERT INTO #Movimientos (mnySaldo_Ant) VALUES (@Saldo_Anterior)
	
	DECLARE Movimientos_Cursor CURSOR FOR
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.intFactura_ID, (Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - ISNULL(Notas_Credito.mnyImporte,0), 0 AS Abonado FROM Facturas
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
		WHERE Facturas.intCliente_ID = @Cliente
	      AND Facturas.bitCancelada = 0
		  AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		
		UNION
		
		SELECT CASE WHEN dtmFecha_Abono IS NULL THEN Facturas.dtmFecha ELSE dtmFecha_Abono END, Facturas.intFactura_ID, 0, ISNULL(SUM(mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)),0) - ISNULL(NC.mnyImporte,0) AS mnyAbonado FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID 
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitCancelada = 0 GROUP BY intFactura_ID) NC ON CtasXCobrar.intFactura_ID = NC.intFactura_ID
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		  AND Facturas.intCliente_ID = @Cliente
		  AND Facturas.bitCancelada = 0
		GROUP BY Facturas.intFactura_ID, CASE WHEN dtmFecha_Abono IS NULL THEN Facturas.dtmFecha ELSE dtmFecha_Abono END, NC.mnyImporte
		HAVING ISNULL(SUM(mnyAbono),0) > 0
	
		ORDER BY dtmFecha, Facturas.intFactura_ID
END

OPEN Movimientos_Cursor

FETCH NEXT FROM Movimientos_Cursor INTO @dtmFecha, @intRemision, @Cargo, @Abono

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Saldo_Diario = @Saldo_Diario + @Cargo - @Abono

	INSERT INTO #Movimientos (dtmFecha, intRemision, mnyCargos, mnyAbonos, mnySaldo) VALUES (@dtmFecha, @intRemision, @Cargo, @Abono, @Saldo_Diario)

	FETCH NEXT FROM Movimientos_Cursor INTO @dtmFecha, @intRemision, @Cargo, @Abono
END

INSERT INTO #Movimientos (mnySaldo_Ant) VALUES (@Saldo_Nuevo)

CLOSE Movimientos_Cursor
DEALLOCATE Movimientos_Cursor

SELECT '', dtmFecha, intRemision, CASE WHEN mnySaldo_Ant = 0 THEN NULL ELSE mnySaldo_Ant END, CASE WHEN mnyCargos = 0 THEN NULL ELSE mnyCargos END, CASE WHEN mnyAbonos = 0 THEN NULL ELSE mnyAbonos END, CASE WHEN mnySaldo = 0 THEN NULL ELSE mnySaldo END FROM #Movimientos

DROP TABLE #Movimientos

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFactura]
@TipoConsulta	int,
@Cliente_ID		int,
@Almacen_ID		int
AS

SET DATEFORMAT dmy

DECLARE @Fecha_ini datetime, @Fecha_Fin datetime, @Dia int

SET @Dia = (SELECT DAY(DATEADD(d, -DAY(DATEADD(m,1,GETDATE())),DATEADD(m,1,GETDATE()))))

SET @Fecha_Ini = CONVERT(DATETIME,'01/' + RTRIM(CONVERT(CHAR,MONTH(DATEADD(mm,-1,GETDATE())))) + '/' + RTRIM(CONVERT(CHAR,YEAR(GETDATE()))))
SET @Fecha_Fin = CONVERT(DATETIME,RTRIM(CONVERT(CHAR,@Dia)) + '/' + RTRIM(CONVERT(CHAR,MONTH(GETDATE()))) + '/' + RTRIM(CONVERT(CHAR,YEAR(GETDATE()))))

IF @Cliente_ID = 0
	IF @TipoConsulta = 0
		SELECT ' ', intFactura_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS dtmFecha, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Facturas
		INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0
		      AND Facturas.dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin
--		      AND  mnyImporte = mnySaldo
		ORDER BY Facturas.dtmFecha DESC
	ELSE
		SELECT CASE WHEN bitCancelada = 1 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.intFactura_ID, Facturas.mnyImporte, CtasXCobrar.mnyAbonado, Facturas.mnySaldo, CASE WHEN intTipoPago = 1 THEN 'CREDITO' ELSE 'CONTADO' END, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Facturas
		INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbonado) AS mnyAbonado FROM CtasXCobrar WHERE intAlmacen_ID = @Almacen_ID GROUP BY intFactura_ID) CtasXCobrar ON Facturas.intFactura_ID = CtasXCobrar.intFactura_ID
		WHERE YEAR(Facturas.dtmFecha) >= YEAR(GETDATE()) 
		ORDER BY Facturas.dtmFecha
ELSE
	IF @TipoConsulta = 0
		SELECT ' ',  Facturas.intFactura_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS dtmFecha, mnyImporte, mnyTotal, mnySaldo FROM Facturas
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(Detalle_CtasXCobrar.mnyAbono) AS mnyTotal FROM CtasXCobrar
	                                                   INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
				         WHERE intAlmacen_ID = @Almacen_ID
			                       GROUP BY intFactura_ID
	                                                  )  Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
		WHERE bitCancelada = 0
		      AND intCliente_ID = @Cliente_ID
		      AND  mnySaldo <> 0
		ORDER BY Facturas.intFactura_ID
	ELSE
		SELECT ' ',  Facturas.intFactura_ID, Facturas.dtmFecha, Facturas.mnyImporte, mnyTotal, mnySaldo, Facturas.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, 0 AS Tiene_NC FROM Facturas --ISNULL(Notas_Credito.intFactura_ID,0) AS Tiene_NC FROM Facturas
		INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(Detalle_CtasXCobrar.mnyAbono) AS mnyTotal, dtmFecha_Abono FROM CtasXCobrar
	                                                   INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
				         WHERE intAlmacen_ID = @Almacen_ID 
			                       GROUP BY intFactura_ID, Detalle_CtasXCobrar.dtmFecha_Abono, dtmFecha_Abono 
	                                                  )  Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
		WHERE Facturas.bitCancelada = 0
		      AND Facturas.intFactura_ID = @Cliente_ID
		      AND  mnySaldo <> 0

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFacturaConParametros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFacturaConParametros]
	@Fecha_Ini	datetime,--char(30),
	@Fecha_Fin	datetime,--char(30),
	@Factura_ID	int,
	@Cliente_ID	int,
	@Almacen_ID	int
AS
BEGIN
	SET DATEFORMAT dmy

	SELECT CASE WHEN bitCancelada = 1 THEN '*' ELSE ' ' END, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.intFactura_ID, Facturas.mnyImporte, CtasXCobrar.mnyAbonado, Facturas.mnySaldo, CASE WHEN intTipoPago = 1 THEN 'CREDITO' ELSE 'CONTADO' END, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, vchRFC + '-' + RTRIM(LTRIM(CONVERT(CHAR,Facturas.intFactura_ID))) + '.PDF' FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbonado) AS mnyAbonado FROM CtasXCobrar WHERE intAlmacen_ID = @Almacen_ID GROUP BY intFactura_ID) CtasXCobrar ON Facturas.intFactura_ID = CtasXCobrar.intFactura_ID
	WHERE (Facturas.dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59' AND @Fecha_Ini <> '' OR @Fecha_Ini = '')
		  AND (Facturas.intCliente_ID = @Cliente_ID AND @Cliente_ID <> 0 OR @Cliente_ID = 0)
		  AND (Facturas.intFactura_ID = @Factura_ID AND @Factura_ID <> 0 OR @Factura_ID = 0)
	ORDER BY Facturas.dtmFecha

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFacturaElectronica]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFacturaElectronica]
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT * FROM Datos_FacturaElectronica

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFacturaNotaOrden]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFacturaNotaOrden]
@Tipo       char(1)
AS

SET DATEFORMAT dmy

IF @Tipo = 'F'
	SELECT 0 AS Folio_ID, intContador_Facturas + 1 AS Siguiente_Factura FROM Control_Facturas
		
IF @Tipo = 'N'
	SELECT 0 AS Folio_ID, intContador_Notas + 1 AS Siguiente_Nota FROM Control_Notas_Credito

IF @Tipo = 'O'
	SELECT  intContador_Ordenes + 1 AS Siguiente_Orden FROM Control_Ordenes_Compra

IF @Tipo = 'R'
	SELECT  intContador_Remisiones + 1 AS Siguiente_Remision FROM Control_Remisiones

IF @Tipo = 'D'
	SELECT  intContador_Deshueses + 1 AS Siguiente_Deshuese FROM Control_Deshueses

IF @Tipo = 'P'
	SELECT  intContador_Pagos + 1 AS Siguiente_Pago FROM Control_Pagos

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFolios]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFolios]
	@Folio_ID		int,
	@Todos			int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT * FROM Control_Folios
		WHERE bitDisponible = 1 AND (intFolio_ID = @Folio_ID AND @Folio_ID <> 0 OR @Folio_ID = 0)
	ELSE
		SELECT chrTipo_Documento, vchSerie, intFolioInicial, intFolioFinal, intNumero_Aprobacion, intAno_Aprobacion, intUltimo_Folio_Usado, intFolio_ID * CASE WHEN bitDisponible = 1 THEN 1 ELSE -1 END AS ID FROM Control_Folios
		WHERE (intFolio_ID = @Folio_ID AND @Folio_ID <> 0 OR @Folio_ID = 0)

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosInformacionFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosInformacionFactura]
@Factura_ID       int
AS

SET DATEFORMAT dmy

SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre FROM Facturas
INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
WHERE Facturas.intFactura_ID = @Factura_ID
      AND bitCancelada = 0


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosInvFisico]
@Inventario_ID	int,
@Inv_Aplicado	smallint,
@TipoConsulta	smallint
AS

SET DATEFORMAT dmy

IF @TipoConsulta = 0
	IF @Inv_Aplicado = 2
		SELECT CASE WHEN bitAplicado = 1 THEN '*' ELSE '' END, intInventario_ID, dtmFecha, Usuarios.vchUsuario FROM Inventario_Fisico
		INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
	ELSE
		SELECT '', intInventario_ID, dtmFecha, Usuarios.vchUsuario FROM Inventario_Fisico
		INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
		WHERE bitAplicado = @Inv_Aplicado

IF @TipoConsulta = 1
	IF @Inv_Aplicado = 2
		SELECT Inventario_Fisico.*, Usuarios.vchUsuario FROM Inventario_Fisico
		INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
		WHERE intInventario_ID = @Inventario_ID
	ELSE
		SELECT Inventario_Fisico.*, Usuarios.vchUsuario FROM Inventario_Fisico
		INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
		WHERE intInventario_ID = @Inventario_ID
		      AND bitAplicado = @Inv_Aplicado

IF @TipoConsulta = 2
	SELECT '', intInventario_ID, dtmFecha, Usuarios.vchUsuario, dtmFecha_Aplicado FROM Inventario_Fisico
	INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
	WHERE bitAplicado = @Inv_Aplicado

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosInvFisicoExistencias]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosInvFisicoExistencias]
@InvFisico_ID		int
AS

SET DATEFORMAT dmy

SELECT ' ', Inventario_Fisico_Existencias.intProducto_ID, Productos.vchDescripcion, intCanalNo, mnyPeso, intOrdenCompra_ID FROM Inventario_Fisico_Existencias
INNER JOIN Productos ON Inventario_Fisico_Existencias.intProducto_ID = Productos.intProducto_ID
WHERE Inventario_Fisico_Existencias.intInventario_ID = @InvFisico_ID
ORDER BY 2

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosIva]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosIva]
	@Iva_ID		int,
	@Todos		int,
	@Estatus	int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT * FROM Ivas
		WHERE bitActivo = @Estatus AND (intIva_ID = @Iva_ID AND @Iva_ID <> 0 OR @Iva_ID = 0)
	ELSE
		SELECT ' ', intIva_ID, Rtrim(CONVERT(CHAR,mnyIVA)) AS mnyIVA FROM Ivas
		WHERE bitActivo = @Estatus AND (intIva_ID = @Iva_ID AND @Iva_ID <> 0 OR @Iva_ID = 0)

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosMatanza]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosMatanza]
@Matanza_ID     int,
@Todos                int,
@Estatus             int
AS

SET DATEFORMAT dmy

IF @Todos = 1
	SELECT Matanzas.*, Productos.vchDescripcion, CASE WHEN NOT Ganado_Pie.intProducto_Pie IS NULL AND Matanzas.intProducto_ID <> Detalle_OC.intProducto_ID THEN 1 WHEN NOT Medio_Canal.intProducto_Canal IS NULL AND Matanzas.intProducto_ID = Detalle_OC.intProducto_ID THEN 2 WHEN NOT Cajas.intProducto_ID IS NULL THEN 3 WHEN NOT Viceras.intProducto_ID IS NULL THEN 4 ELSE 0 END AS  intTipoCompra,ISNULL( (SELECT MAX(intContador_Cajas) FROM Control_Cajas),0) + 1 AS intCaja_Siguiente, mnyPeso FROM Matanzas
 	INNER JOIN Productos ON Matanzas.intProducto_ID = Productos.intProducto_ID
	LEFT OUTER JOIN Relacion_Matanza Ganado_Pie ON Matanzas.intProducto_ID = Ganado_Pie.intProducto_Canal
	LEFT OUTER JOIN Relacion_Matanza Medio_Canal ON Matanzas.intProducto_ID = Medio_Canal.intProducto_Canal
	LEFT OUTER JOIN Productos Cajas ON Matanzas.intProducto_ID = Cajas.intProducto_ID AND Cajas.intUnidad_ID = (SELECT intUM_Cajas FROM Parametros)
	LEFT OUTER JOIN Productos Viceras ON Matanzas.intProducto_ID = Cajas.intProducto_ID AND Viceras.intProducto_ID = (SELECT  Parametros.intProducto_ViceraCompleta FROM Parametros)
	LEFT OUTER JOIN (SELECT Detalle_Orden_Compra.intOrdenCompra_ID, intTipoProducto_ID, Detalle_Orden_Compra.intProducto_ID, mnyPeso FROM Detalle_Orden_Compra
                 		         INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID) Detalle_OC 
                                             ON Matanzas.intOrdenCompra_ID = Detalle_OC.intOrdenCompra_ID
		       AND  CASE WHEN NOT Ganado_Pie.intProducto_Pie IS NULL AND Detalle_OC.intTipoProducto_ID = (SELECT intTipoProducto_GanadoPie FROM Parametros) THEN Ganado_Pie.intProducto_Pie WHEN NOT Medio_Canal.intProducto_Canal IS NULL THEN Medio_Canal.intProducto_Canal WHEN NOT Cajas.intProducto_ID IS NULL 	THEN Cajas.intProducto_ID WHEN NOT Viceras.intProducto_ID IS NULL THEN Viceras.intProducto_ID ELSE Matanzas.intProducto_ID END = Detalle_OC.intProducto_ID
	WHERE bitProcesado = @Estatus
	      AND  mnyPeso <> 0
                    AND (intMatanza_ID = @Matanza_ID AND @Matanza_ID <> 0 OR @Matanza_ID = 0)
	      AND Matanzas.bitCancelado = 0
	GROUP BY intMatanza_ID, dtmFecha, Matanzas.intOrdenCompra_ID, intCantidad, bitProcesado, bitVicera, Productos.vchDescripcion, Ganado_Pie.intProducto_Pie, Matanzas.intProducto_ID, Detalle_OC.intProducto_ID, Medio_Canal.intProducto_Canal, Matanzas.intProducto_ID, Detalle_OC.intProducto_ID, Cajas.intProducto_ID,  mnyPeso , Viceras.intProducto_ID, Matanzas.bitCancelado
ELSE
--	SELECT ' ' , CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS Fecha, Productos.vchDescripcion,  Matanzas.intOrdenCompra_ID, Matanzas.intCantidad / CASE WHEN Relacion_Matanza.intProducto_ID IS NULL THEN 1 ELSE 2 END, intMatanza_ID FROM Matanzas
	SELECT ' ' , CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS Fecha, Productos.vchDescripcion,  Matanzas.intOrdenCompra_ID, Matanzas.intCantidad, intMatanza_ID FROM Matanzas
	INNER JOIN Productos ON Matanzas.intProducto_ID = Productos.intProducto_ID
--	LEFT OUTER JOIN (SELECT intOrdenCompra_ID, intProducto_ID, intProducto_Canal FROM Detalle_Orden_Compra LEFT OUTER JOIN Relacion_Matanza ON Detalle_Orden_Compra.intProducto_ID = Relacion_Matanza.intProducto_Pie WHERE NOT intProducto_Canal IS NULL) Relacion_Matanza ON Matanzas.intOrdenCompra_ID = Relacion_Matanza.intOrdenCompra_ID AND Matanzas.intProducto_ID = Relacion_Matanza.intProducto_Canal
	WHERE bitProcesado =  @Estatus
                       AND (intMatanza_ID = @Matanza_ID AND @Matanza_ID <> 0 OR @Matanza_ID = 0)
	          AND bitCancelado = 0

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosMatanzaVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosMatanzaVicera]
@Matanza_ID     int,
@Todos               int,
@Estatus              int
AS

SET DATEFORMAT dmy

DECLARE @ViceraCompleta int

SET @ViceraCompleta = (SELECT  Parametros.intProducto_ViceraCompleta FROM Parametros)

IF @Todos = 1
	SELECT Matanzas.*, Productos.vchDescripcion FROM Matanzas
 	INNER JOIN Productos ON @ViceraCompleta  = Productos.intProducto_ID
	WHERE bitProcesado = 1
                       AND bitCancelado = 0
                       AND bitIncluyeViceras = 1
	         AND bitVicera = @Estatus
                       AND (intMatanza_ID = @Matanza_ID AND @Matanza_ID <> 0 OR @Matanza_ID = 0)
ELSE
	SELECT ' ' , CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS Fecha, Productos.vchDescripcion,  intOrdenCompra_ID, intCantidad, intMatanza_ID FROM Matanzas
	INNER JOIN Productos ON @ViceraCompleta = Productos.intProducto_ID
	WHERE bitProcesado = 1
                       AND bitCancelado = 0
                       AND bitIncluyeViceras = 1
	         AND bitVicera = @Estatus
                       AND (intMatanza_ID = @Matanza_ID AND @Matanza_ID <> 0 OR @Matanza_ID = 0)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosMovimiento]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosMovimiento]
@Cliente_ID         int,
@Producto_ID     int,
@Almacen            int
AS

SET DATEFORMAT dmy

--SELECT CASE WHEN Remisiones.mnyImporte = Remisiones.mnySaldo THEN ' 'ELSE '*' END, Movimientos.dtmFecha, intCantidad, CASE WHEN mnyPeso = 0 THEN NULL ELSE mnyPeso END, intCanalNo, Movimientos.intRemisionNo, 0, intMovimiento_ID, CASE WHEN Remisiones.mnyImporte = Remisiones.mnySaldo THEN 1 ELSE 0 END FROM Movimientos
SELECT CASE WHEN Remisiones.mnyImporte = Remisiones.mnySaldo THEN ' 'ELSE '*' END, Movimientos.dtmFecha, Movimientos.intCantidad - ISNULL(Devoluciones.intcantidad,0), CASE WHEN mnyPeso = 0 THEN NULL ELSE mnyPeso END, mnyPrecio, Movimientos.intCanalNo, Movimientos.intRemisionNo, 0, intMovimiento_ID, Remisiones.bitFacturado FROM Movimientos
INNER JOIN Remisiones ON Movimientos.intCliente_ID = Remisiones.intCliente_ID AND Movimientos.intRemisionNo = Remisiones.intRemisionNo AND Movimientos.intAlmacen_ID = Remisiones.intAlmacen_ID
LEFT OUTER JOIN (SELECT intTipoVicera_ID, SUM(intCantidad) AS intCantidad FROM Movimientos WHERE chrOperacion = 'A' AND intAlmacen_ID = 2 GROUP BY intTipoVicera_ID) Devoluciones ON Movimientos.intMovimiento_ID = Devoluciones.intTipoVicera_ID
WHERE Movimientos.intCliente_ID = @Cliente_ID
       AND bitTiene_Devolucion = 0
       AND Movimientos.intAlmacen_ID = @Almacen
--    AND Movimientos.mnyImporte > 0
       AND chrOperacion = 'S'
       AND (Movimientos.intProducto_ID = @Producto_ID AND @Producto_ID <> 0 OR @Producto_ID = 0)
ORDER BY Movimientos.dtmFecha DESC, Movimientos.intRemisionNo DESC


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosNoCuentaContable]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosNoCuentaContable]
@Cuenta_ID   varchar(15),
@Estatus     int
AS

SET DATEFORMAT dmy

SELECT * FROM Cuentas_Contables
WHERE bitActivo = @Estatus AND (vchNoCuenta = @Cuenta_ID AND @Cuenta_ID <> '' OR @Cuenta_ID = '')


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosNotas_Credito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosNotas_Credito]
	@TipoConsulta	int,
	@Nota_Credito	int
AS
BEGIN
	SET DATEFORMAT dmy

	IF @TipoConsulta = 0
		SELECT CASE WHEN Notas_Credito.bitCancelada = 1 THEN '*' ELSE ' ' END, Notas_Credito.dtmFecha, Notas_Credito.intNota_Credito_ID, Notas_Credito.mnyImporte, Notas_Credito.bitAplicada, Notas_Credito.intFactura_ID, 
			   CASE WHEN Notas_Credito.intCliente_Tercero = 0 THEN
						 CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END
					ELSE
						 CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END 
					END,
			   Notas_Credito.vchObservaciones,
			   CASE WHEN Notas_Credito.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END + '-' + RTRIM(LTRIM(CONVERT(CHAR,Notas_Credito.intNota_Credito_ID))) + '.PDF'
		 FROM Notas_Credito
	--	INNER JOIN Det_Notas_Credito Det ON Notas_Credito.intNota_Credito_ID = Det.intNota_Credito_ID
		INNER JOIN Facturas ON Notas_Credito.intFactura_ID = Facturas.intFactura_ID
		INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN Facturar_Terceros ON Notas_Credito.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID AND Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID

	IF @TipoConsulta = 1
		SELECT ' ', Notas_Credito.intNota_Credito_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Notas_Credito.dtmFecha,103),103) AS dtmFecha, Notas_Credito.intFactura_ID, 
			   CASE WHEN Notas_Credito.intCliente_Tercero = 0 THEN
						 CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END
					ELSE
						 CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END 
					END
		FROM Notas_Credito
	--	INNER JOIN Det_Notas_Credito Det ON Notas_Credito.intNota_Credito_ID = Det.intNota_Credito_ID
		INNER JOIN Facturas ON Notas_Credito.intFactura_ID = Facturas.intFactura_ID
		INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN Facturar_Terceros ON Notas_Credito.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID AND Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID
		WHERE bitAplicada >=0
  		  AND Notas_Credito.bitCancelada = 0

	IF @TipoConsulta = 2
		SELECT CASE WHEN Notas_Credito.bitCancelada = 1 THEN '*' ELSE ' ' END AS Status, Notas_Credito.dtmFecha, Notas_Credito.intNota_Credito_ID, Notas_Credito.mnyImporte, Notas_Credito.intFactura_ID, 
			   CASE WHEN Notas_Credito.intCliente_Tercero = 0 THEN
						 CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END
					ELSE
						 CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END 
					END AS vchCliente, 
			   Notas_Credito.vchObservaciones, Facturas.dtmFecha AS dtmFecha_Factura, Facturas.mnyImporte AS mnyImporte_Factura, CASE WHEN Notas_Credito.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END AS vchRFC,
			   Cab_Notas_Credito.vchFolio_Fiscal
		FROM Notas_Credito
		INNER JOIN Cab_Notas_Credito ON Notas_Credito.intNota_Credito_ID = Cab_Notas_Credito.intNota_Credito_ID
	--	INNER JOIN Det_Notas_Credito Det ON Notas_Credito.intNota_Credito_ID = Det.intNota_Credito_ID
		INNER JOIN Facturas ON Notas_Credito.intFactura_ID = Facturas.intFactura_ID
		INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN Facturar_Terceros ON Notas_Credito.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID AND Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID
		WHERE bitAplicada >=0
			  AND Notas_Credito.intNota_Credito_ID = @Nota_Credito
  			  AND Notas_Credito.bitCancelada = 0

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosOrdenCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosOrdenCompra]
@OrdenCompra_ID     int,
@Todos                         int,
@TipoProceso              char(1),
@Status	            char(1)
AS

SET DATEFORMAT dmy

IF @TipoProceso = 'O'
	IF @Todos = 1 OR @Todos = -1
		SELECT Orden_Compra.*, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchProveedor FROM Orden_Compra
		INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
		LEFT OUTER JOIN (SELECT intOrdenCompra_ID, SUM(intCantidad - intCantidad_Recibida) AS bitOrdenAbierta FROM Detalle_Orden_Compra
				         GROUP BY intOrdenCompra_ID
	                                                  ) Detalle ON Orden_Compra.intOrdenCompra_ID = Detalle.intOrdenCompra_ID
		WHERE bitCancelado = 0
		       AND (bitOrdenAbierta > 0 AND @Todos = 1 AND @Status = 'O' OR @Todos = -1 OR @Status = 'T')
	                     AND (Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND @OrdenCompra_ID <> 0 OR @OrdenCompra_ID = 0) 
	ELSE
		IF @Todos = -2
			SELECT Orden_Compra.*, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchProveedor, bitOrdenAbierta, ISNULL(bitMatanzaAbierta,0) AS bitMatanzaAbierta  FROM Orden_Compra
			INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
			LEFT OUTER JOIN (SELECT intOrdenCompra_ID, SUM(intCantidad - intCantidad_Recibida) AS bitOrdenAbierta FROM Detalle_Orden_Compra
					       GROUP BY intOrdenCompra_ID
			                	     ) Detalle ON Orden_Compra.intOrdenCompra_ID = Detalle.intOrdenCompra_ID
			LEFT OUTER JOIN (SELECT intOrdenCompra_ID, COUNT(bitProcesado) AS bitMatanzaAbierta FROM Matanzas
					      WHERE bitProcesado = 0
                                                                               AND bitCancelado = 0
					      GROUP BY intOrdenCompra_ID
			                	    ) Matanzas ON Orden_Compra.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
			WHERE bitCancelado = 0
			      AND (bitOrdenAbierta > 0 OR ISNULL(bitMatanzaAbierta,0) > 0)
			     AND (Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND @OrdenCompra_ID <> 0 OR @OrdenCompra_ID = 0) 
		ELSE
			SELECT ' ', Orden_Compra.intOrdenCompra_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) AS Fecha, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchProveedor FROM Orden_Compra
		              INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
			LEFT OUTER JOIN (SELECT intOrdenCompra_ID, SUM(intCantidad - intCantidad_Recibida) AS bitOrdenAbierta FROM Detalle_Orden_Compra
					         GROUP BY intOrdenCompra_ID
		                                                  ) Detalle ON Orden_Compra.intOrdenCompra_ID = Detalle.intOrdenCompra_ID
			WHERE bitCancelado =0
			       AND (bitOrdenAbierta > 0 AND @Status = 'O' OR @Status = 'T')
		                     AND (Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND @OrdenCompra_ID <> 0 OR @OrdenCompra_ID = 0)
ELSE
	IF @Todos = 1
		SELECT Orden_Compra.*, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchProveedor FROM Orden_Compra
		INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
		LEFT OUTER JOIN (SELECT Detalle_Orden_Compra.intOrdenCompra_ID, intExistencia FROM Detalle_Orden_Compra
				         INNER JOIN Existencias ON intAlmacen_ID = 1 AND Detalle_Orden_Compra.intProducto_ID = Existencias.intProducto_ID  AND Detalle_Orden_Compra.intOrdenCompra_ID = Existencias.intOrdenCompra_ID
	                                                  ) Detalle ON Orden_Compra.intOrdenCompra_ID = Detalle.intOrdenCompra_ID
		WHERE bitCancelado = 0
		       AND intExistencia  > 0
	                     AND (Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND @OrdenCompra_ID <> 0 OR @OrdenCompra_ID = 0) 
	ELSE
		SELECT ' ', Orden_Compra.intOrdenCompra_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) AS Fecha, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchProveedor FROM Orden_Compra
	              INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
		LEFT OUTER JOIN (SELECT Detalle_Orden_Compra.intOrdenCompra_ID, intExistencia FROM Detalle_Orden_Compra
				         INNER JOIN Existencias ON intAlmacen_ID = 1 AND Detalle_Orden_Compra.intProducto_ID = Existencias.intProducto_ID AND Detalle_Orden_Compra.intOrdenCompra_ID = Existencias.intOrdenCompra_ID
	                                                  ) Detalle ON Orden_Compra.intOrdenCompra_ID = Detalle.intOrdenCompra_ID
		WHERE bitCancelado =0
		       AND intExistencia > 0
	                     AND (Orden_Compra.intOrdenCompra_ID = @OrdenCompra_ID AND @OrdenCompra_ID <> 0 OR @OrdenCompra_ID = 0)
		GROUP BY Orden_Compra.intOrdenCompra_ID,  Orden_Compra.dtmFecha, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosOrdenesCompra]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosOrdenesCompra]
@Detallada	int,
@Almacen_ID	int
AS

SET DATEFORMAT dmy

IF @Detallada = 0
	SELECT CASE WHEN Orden_Compra.bitCancelado = 1 THEN '*' ELSE '' END, Orden_Compra.dtmFecha, Orden_Compra.intOrdenCompra_ID, CtasXPagar.mnyImporte, CASE WHEN CtasXPagar.mnyAbonado = 0 THEN NULL ELSE CtasXPagar.mnyAbonado END, CtasXPagar.mnySaldo, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Orden_Compra
	INNER JOIN CtasXPagar ON Orden_Compra.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID

IF @Detallada = 1
	SELECT ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchNombre, Orden_Compra.intOrdenCompra_ID, dtmFecha, vchDescripcion, intCantidad, intCantidad_Recibida, intCantidad - intCantidad_Recibida AS intSaldo, Detalle_Orden_Compra.intProducto_ID FROM Orden_Compra
	INNER JOIN Detalle_Orden_Compra ON Orden_Compra.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID
	INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	ORDER BY 2, 3, 4

IF @Detallada = 2
BEGIN
	SET NOCOUNT ON

	DECLARE @OC int, @Rendimiento money, @PesoNeto money, @PesoTotal money

	CREATE TABLE #Rendimientos (
	OrdenCompra	int,
	Rendimiento	money,
	PesoNeto	money,
	PesoTotal	money)

	DECLARE Rendimientos_Cursor CURSOR FOR
		SELECT intOrdenCompra_ID FROM Orden_Compra WHERE bitCancelado = 0

	OPEN Rendimientos_Cursor
	
	FETCH NEXT FROM Rendimientos_Cursor  INTO @OC
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC Sp_CalcularRendimiento @OC, @Almacen_ID, @Rendimiento OUTPUT, @PesoNeto OUTPUT, @PesoTotal OUTPUT
	
		INSERT INTO #Rendimientos (OrdenCompra, Rendimiento, PesoNeto, PesoTotal) VALUES (@OC, @Rendimiento, @PesoNeto, @PesoTotal)

		FETCH NEXT FROM Rendimientos_Cursor INTO @OC
	END
	
	CLOSE Rendimientos_Cursor
	DEALLOCATE Rendimientos_Cursor
	
	SELECT '', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchNombre, Orden_Compra.intOrdenCompra_ID, dtmFecha, TotalPeso, PesoNeto, PesoTotal, Rendimiento  FROM Orden_Compra
	INNER JOIN #Rendimientos ON Orden_Compra.intOrdenCompra_ID = #Rendimientos.OrdenCompra
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	LEFT OUTER JOIN (SELECT intOrdenCompra_ID, SUM(mnyPeso * (1 - (mnyDescuento / 100))) AS TotalPeso FROM Detalle_Orden_Compra GROUP BY intOrdenCompra_ID) Detalle_Orden_Compra ON Orden_Compra.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID
	ORDER BY 1, 2

	DROP TABLE #Rendimientos
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosOrdenesXProveedor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosOrdenesXProveedor]
@Proveedor	int
AS

SET DATEFORMAT dmy

SELECT ' ', dtmFecha, Orden_Compra.intOrdenCompra_ID, vchDescripcion, intCantidad, intCantidad_Recibida, intCantidad - intCantidad_Recibida AS intSaldo FROM Orden_Compra
INNER JOIN Detalle_Orden_Compra ON Orden_Compra.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID
INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
WHERE intProveedor_ID = @Proveedor AND bitCancelado = 0
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosPAC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosPAC]
AS

BEGIN
	SET NOCOUNT ON;

	SELECT * FROM DATOS_CFDI
	WHERE intPAC_ID IN (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosPagosDetalle]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ObtenerDatosPagosDetalle]
	@Pago_ID		int,
	@Opcion			int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Opcion = 1
		SELECT '', Clientes.vchRazonSocial, P.intPago_ID, P.dtmFecha_Pago, P.mnyTotal, P.bitCancelada AS Estatus, vchRFC + '-' + RTRIM(LTRIM(CONVERT(CHAR,P.intPago_ID))) + '.PDF' FROM Cab_Pagos P
		INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID) DP ON P.intPago_ID = DP.intPago_ID
		INNER JOIN Clientes ON DP.intCliente_ID = Clientes.intCliente_ID
		ORDER BY P.intPago_ID

	IF @Opcion = 2
		SELECT '', Clientes.vchRazonSocial, P.intPago_ID, P.dtmFecha_Pago, mnyTotal FROM Cab_Pagos P
		INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID) DP ON P.intPago_ID = DP.intPago_ID
		INNER JOIN Clientes ON DP.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0
		ORDER BY P.intPago_ID

	IF @Opcion = 3
		SELECT P.*, Clientes.* FROM Cab_Pagos P
		INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID) DP ON P.intPago_ID = DP.intPago_ID
		INNER JOIN Clientes ON DP.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND P.intPago_ID = @Pago_ID

	IF @Opcion = 4
		SELECT Cab_Ventas.*, Clientes.*, ISNULL(P.mnySaldo_Pendiente,Cab_Ventas.mnyTotal) AS mnySaldoAnterior FROM Cab_Ventas
		INNER JOIN Clientes ON Cab_Ventas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN (SELECT intFactura_ID, MAX(intParcialidad) AS intParcialidad FROM vUltimaParcialidadXFactura GROUP BY intFactura_ID) UP ON Cab_Ventas.intFactura_ID = UP.intFactura_ID
		LEFT OUTER JOIN Det_Pagos P ON Cab_Ventas.intFactura_ID = P.intFactura_ID AND UP.intParcialidad = P.intParcialidad
		WHERE Cab_Ventas.bitCancelada = 0 AND Cab_Ventas.intFactura_ID = @Pago_ID

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosParametros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosParametros]
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT * FROM Parametros, Datos_FacturaElectronica

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProducto]
@Producto_ID   int,
@Todos              int,
@Estatus             int
AS

SET DATEFORMAT dmy

IF @Todos = -1
	SELECT Productos.* FROM Relacion_Deshuese
	INNER JOIN Productos ON Relacion_Deshuese.intProducto_Deshuese = Productos.intProducto_ID
	WHERE bitActivo = @Estatus 
                      AND  Relacion_Deshuese.intProducto_Deshuese = @Producto_ID
ELSE
	IF @Todos = 1
		SELECT Productos.*, Unidad_medida.vchNombreCorto, Unidad_Medida.vchDescripcion AS vchUnidad_Descripcion FROM Productos
		INNER JOIN Unidad_medida ON Productos.intUnidad_ID = Unidad_medida.intUnidad_ID
		WHERE Productos.bitActivo = @Estatus 
	                      AND  intProducto_ID = @Producto_ID
	ELSE
		SELECT ' ', intProducto_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Productos
		WHERE bitActivo = @Estatus AND (intProducto_ID = @Producto_ID AND @Producto_ID <> 0 OR @Producto_ID = 0)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProductoAgrupado]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProductoAgrupado]
@Producto_ID  int,
@Detallado       int
AS

SET DATEFORMAT dmy

IF @Detallado = 1
	SELECT Agrupacion_Productos_Facturacion.intProducto_ID, Productos.vchDescripcion FROM Agrupacion_Productos_Facturacion
                INNER JOIN Productos ON Agrupacion_Productos_Facturacion.intProducto_ID = Productos.intProducto_ID
	WHERE intAgrupacion_ID = @Producto_ID 
ELSE
	SELECT ' ', intProducto_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Productos
	WHERE bitActivo = 1 AND  intTipoProducto_ID = (SELECT intTipoProducto_Agrupacion FROM Parametros)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProductoCompuesto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProductoCompuesto]
@Producto_ID  int,
@Detallado       int
AS

SET DATEFORMAT dmy

IF @Detallado = 1
	SELECT Productos_Compuestos.intProducto_ID, Productos.vchDescripcion FROM Productos_Compuestos
              INNER JOIN Productos ON Productos_Compuestos.intProducto_ID = Productos.intProducto_ID
	WHERE intProductoCompuesto_ID = @Producto_ID 
ELSE
	SELECT ' ', intProducto_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Productos
	WHERE bitActivo = 1 AND  intTipoProducto_ID = (SELECT intTipoProducto_Compuesto FROM Parametros)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProductoDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProductoDeshuese]
@Producto_ID  int,
@Detallado       int
AS

SET DATEFORMAT dmy

IF @Detallado = 1
	SELECT Relacion_Deshuese.intProducto_Deshuese, Productos.vchDescripcion FROM Relacion_Deshuese
              INNER JOIN Productos ON Relacion_Deshuese.intProducto_Deshuese = Productos.intProducto_ID
	WHERE Relacion_Deshuese.intProducto_ID = @Producto_ID 
ELSE
	SELECT ' ', intProducto_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Productos
	WHERE bitActivo = 1 AND  bitGenerar_SubProductos = 1
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProductosSinAsignar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProductosSinAsignar]
@Producto_ID   int,
@Tipo                  char(1)
AS

SET DATEFORMAT dmy

IF @Tipo = 'D'
	SELECT Productos.intProducto_ID, Productos.vchDescripcion FROM Productos
	LEFT OUTER JOIN Relacion_Deshuese ON Productos.intProducto_ID = Relacion_Deshuese.intProducto_Deshuese AND Relacion_Deshuese.intProducto_ID = @Producto_ID
	WHERE Productos.intTipoProducto_ID =  (SELECT intTipoProducto_Compuesto FROM Parametros)
	       AND bitActivo = 1
	       AND Relacion_Deshuese.intProducto_Deshuese IS NULL

IF @Tipo = 'C'
	SELECT Productos.intProducto_ID, Productos.vchDescripcion FROM Productos
	LEFT OUTER JOIN Productos_Compuestos ON Productos.intProducto_ID = Productos_Compuestos.intProducto_ID AND Productos_Compuestos.intProductoCompuesto_ID = @Producto_ID
	WHERE Productos.intTipoProducto_ID =  (SELECT intTipoProducto_Producto FROM Parametros)
	       AND bitActivo = 1
	       AND Productos_Compuestos.intProducto_ID IS NULL

IF @Tipo = 'A'
	SELECT Productos.intProducto_ID, Productos.vchDescripcion FROM Productos
	LEFT OUTER JOIN Agrupacion_Productos_Facturacion ON Productos.intProducto_ID = Agrupacion_Productos_Facturacion.intProducto_ID AND Agrupacion_Productos_Facturacion.intAgrupacion_ID = @Producto_ID
	WHERE Productos.intTipoProducto_ID =  (SELECT intTipoProducto_Producto FROM Parametros)
	       AND bitActivo = 1
	       AND Agrupacion_Productos_Facturacion.intProducto_ID IS NULL

IF @Tipo = 'V'
	SELECT Productos.intProducto_ID, Productos.vchDescripcion FROM Productos
	LEFT OUTER JOIN Viceras ON Productos.intProducto_ID = Viceras.intProducto_ID AND Viceras.intVicera_ID = @Producto_ID
	WHERE Productos.intTipoProducto_ID =  (SELECT intTipoProducto_Producto FROM Parametros)
	       AND bitActivo = 1
	       AND Viceras.intProducto_ID IS NULL

IF @Tipo = 'P'
	SELECT Productos.intProducto_ID, Productos.vchDescripcion FROM Productos
	WHERE Productos.intTipoProducto_ID =  (SELECT intTipoProducto_Producto FROM Parametros)
	       AND bitActivo = 1
 	ORDER BY Productos.vchDescripcion

IF @Tipo = 'S'
	SELECT Viceras.intVicera_ID, Productos.vchDescripcion FROM (SELECT DISTINCT intVicera_ID FROM Viceras) Viceras
	INNER JOIN Productos ON Viceras.intVicera_ID = Productos.intProducto_ID
	LEFT OUTER JOIN Viceras_A_Surtir ON Viceras.intVicera_ID = Viceras_A_Surtir.intProductoVicera_ID AND Viceras_A_Surtir.intProducto_ID = @Producto_ID
	WHERE Viceras_A_Surtir.intProductoVicera_ID IS NULL
	      AND bitActivo = 1

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProveedor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProveedor]
@Proveedor_ID       int,
@Todos                     int,
@Estatus                  int
AS

SET DATEFORMAT dmy

IF @Todos = -1
	SELECT  intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchNombre FROM Proveedores
	WHERE bitActivo =  @Estatus
	ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
ELSE
	IF @Todos = 1
		SELECT * FROM Proveedores
		WHERE bitActivo = @Estatus AND (intProveedor_ID = @Proveedor_ID AND @Proveedor_ID <> 0 OR @Proveedor_ID = 0) 
	ELSE
		SELECT ' ', intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchNombre FROM Proveedores
		WHERE bitActivo = @Estatus AND (intProveedor_ID = @Proveedor_ID AND @Proveedor_ID <> 0 OR @Proveedor_ID = 0)
		ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRegimenes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRegimenes]
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT Regimen_Fiscal, [Descripción] FROM c_RegimenFiscal

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRegimenFiscal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRegimenFiscal]
	@Regimen_ID		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Regimen_ID <> 0
		SELECT * FROM Regimen_Fiscales
		WHERE intRegimen_ID = @Regimen_ID
	ELSE
		SELECT '', vchNombre, intRegimen_ID FROM Regimen_Fiscales

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRelacionProductos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRelacionProductos]
AS

SET DATEFORMAT dmy

SELECT ' ', Productos.vchDescripcion,  Canal.vchDescripcion, Productos.intProducto_ID, intProducto_Canal FROM Productos
LEFT OUTER JOIN Relacion_Matanza ON Productos.intProducto_ID = intProducto_Pie
LEFT OUTER JOIN Productos Canal ON intProducto_Canal = Canal.intProducto_ID
WHERE Productos.intTipoProducto_ID = (SELECT intTipoProducto_GanadoPie FROM Parametros)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRemisionCancelada]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRemisionCancelada]
@Consecutivo_ID  int
AS

SET DATEFORMAT dmy

SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS dtmFecha, intRemisionNo FROM Remisiones_Canceladas
WHERE intConsecutivo = @Consecutivo_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRemisiones]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRemisiones]
@RemisionNo	int,
@Almacen        int
AS

SET DATEFORMAT dmy

SELECT ' ', Remisiones.dtmFecha, Remisiones.intRemisionNo, Remisiones.mnyImporte, CASE WHEN CtasXCobrar.mnyAbonado = 0 THEN NULL ELSE CtasXCobrar.mnyAbonado END - CASE WHEN NOT Notas_Credito.intFactura_ID IS NULL AND Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN Notas_Credito.mnyImporte ELSE 0 END, CASE WHEN NOT Notas_Credito.intFactura_ID IS NULL AND Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN Notas_Credito.mnyImporte ELSE NULL END, Remisiones.mnySaldo, CASE WHEN CtasXCobrar.intFactura_ID = 0 THEN NULL ELSE CtasXCobrar.intFactura_ID END, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Remisiones
INNER JOIN CtasXCobrar ON Remisiones.intRemisionNo = CtasXCobrar.intRemisionNo AND Remisiones.intAlmacen_ID = CtasXCobrar.intAlmacen_ID
INNER JOIN Clientes ON Remisiones.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito GROUP BY intFactura_ID) Notas_Credito ON CtasXCobrar.intFactura_ID = Notas_Credito.intFactura_ID
WHERE (Remisiones.intRemisionNo = @RemisionNo AND @RemisionNo <> 0 OR @RemisionNo = 0)
       AND Remisiones.intAlmacen_ID = @Almacen
GROUP BY Remisiones.dtmFecha, Remisiones.intRemisionNo, Remisiones.mnyImporte, CtasXCobrar.mnyAbonado, CtasXCobrar.mnyAbonado, Notas_Credito.intFactura_ID, Detalle_CtasXCobrar.bitAplicada_NC, Notas_Credito.mnyImporte, Notas_Credito.intFactura_ID, Detalle_CtasXCobrar.bitAplicada_NC, Notas_Credito.mnyImporte, Remisiones.mnySaldo, CtasXCobrar.intFactura_ID, CtasXCobrar.intFactura_ID, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre
ORDER BY Remisiones.intRemisionNo

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRemisionesConParametros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRemisionesConParametros]
@Fecha_Ini	datetime,--char(30),
@Fecha_Fin	datetime,--char(30),
@RemisionNo	int,
@Cliente_ID	int,
@Almacen_ID	int
AS

SET DATEFORMAT dmy

SELECT ' ', 
	 Remisiones.dtmFecha, 
	 Remisiones.intRemisionNo, 
	 Remisiones.mnyImporte, 
	 CASE WHEN CtasXCobrar.mnyAbonado = 0 THEN NULL ELSE CtasXCobrar.mnyAbonado END - CASE WHEN NOT Notas_Credito.intFactura_ID IS NULL AND Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN CASE WHEN NOT Detalle_Notas_Credito.intRemisionNo IS NULL AND Detalle_Notas_Credito.bitAplicada = 1 THEN Detalle_Notas_Credito.mnyImporte ELSE Notas_Credito.mnyImporte END ELSE 0 END, 
	 CASE WHEN NOT Notas_Credito.intFactura_ID IS NULL AND Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN CASE WHEN NOT Detalle_Notas_Credito.intRemisionNo IS NULL AND Detalle_Notas_Credito.bitAplicada = 1 THEN Detalle_Notas_Credito.mnyImporte ELSE Notas_Credito.mnyImporte END ELSE 0 END, 
	 Remisiones.mnySaldo, 
	 CASE WHEN CtasXCobrar.intFactura_ID = 0 THEN NULL ELSE CtasXCobrar.intFactura_ID END, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
FROM Remisiones
INNER JOIN CtasXCobrar ON Remisiones.intRemisionNo = CtasXCobrar.intRemisionNo AND Remisiones.intAlmacen_ID = CtasXCobrar.intAlmacen_ID
INNER JOIN Clientes ON Remisiones.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON CtasXCobrar.intFactura_ID = Notas_Credito.intFactura_ID
LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitCancelada = 0
WHERE (CONVERT(SMALLDATETIME,CONVERT(CHAR,Remisiones.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin AND @Fecha_Ini <> '' OR @Fecha_Ini = '') 
       AND (Remisiones.intRemisionNo = @RemisionNo AND @RemisionNo <> 0 OR @RemisionNo = 0)
       AND (Remisiones.intCliente_ID = @Cliente_ID AND @Cliente_ID <> 0 OR @Cliente_ID = 0)
       AND (Remisiones.intAlmacen_ID = @Almacen_ID)
GROUP BY Remisiones.dtmFecha, Remisiones.intRemisionNo, Remisiones.mnyImporte, CtasXCobrar.mnyAbonado, CtasXCobrar.mnyAbonado, Notas_Credito.intFactura_ID, Detalle_CtasXCobrar.bitAplicada_NC, Notas_Credito.mnyImporte, Notas_Credito.intFactura_ID, Detalle_CtasXCobrar.bitAplicada_NC, Notas_Credito.mnyImporte, Remisiones.mnySaldo, CtasXCobrar.intFactura_ID, CtasXCobrar.intFactura_ID, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre, Detalle_Notas_Credito.intRemisionNo, Detalle_Notas_Credito.mnyImporte, Detalle_Notas_Credito.bitAplicada
--GROUP BY Remisiones.dtmFecha, 
--	      Remisiones.intRemisionNo, 
--	      Remisiones.mnyImporte, 
--	      CASE WHEN CtasXCobrar.mnyAbonado = 0 THEN NULL ELSE CtasXCobrar.mnyAbonado END - CASE WHEN NOT Notas_Credito.intFactura_ID IS NULL AND Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN CASE WHEN NOT Detalle_Notas_Credito.intRemisionNo IS NULL AND Detalle_Notas_Credito.bitAplicada = 1 THEN Detalle_Notas_Credito.mnyImporte ELSE Notas_Credito.mnyImporte END ELSE 0 END, 
--	      CASE WHEN NOT Notas_Credito.intFactura_ID IS NULL AND Detalle_CtasXCobrar.bitAplicada_NC = 1 THEN CASE WHEN NOT Detalle_Notas_Credito.intRemisionNo IS NULL AND Detalle_Notas_Credito.bitAplicada = 1 THEN Detalle_Notas_Credito.mnyImporte ELSE Notas_Credito.mnyImporte END ELSE 0 END, 
--	      Remisiones.mnySaldo, 
--	      CASE WHEN CtasXCobrar.intFactura_ID = 0 THEN NULL ELSE CtasXCobrar.intFactura_ID END, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
ORDER BY Remisiones.intRemisionNo

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRepartidor]
@Repartidor_ID      int,
@Todos                     int,
@Estatus                    int
AS

SET DATEFORMAT dmy

IF @Todos = 1
	SELECT * FROM Repartidores
	WHERE bitActivo = @Estatus AND (intRepartidor_ID = @Repartidor_ID AND @Repartidor_ID <> 0 OR @Repartidor_ID = 0) 
ELSE
	SELECT ' ', intRepartidor_ID, RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) AS vchNombre FROM Repartidores
	WHERE bitActivo = @Estatus AND (intRepartidor_ID = @Repartidor_ID AND @Repartidor_ID <> 0 OR @Repartidor_ID = 0)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosSumarioInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosSumarioInvFisico]
@InvFisico_ID		int
AS

SET DATEFORMAT dmy

SELECT ' ', Productos.vchDescripcion, COUNT(Detalle_Inventario_Fisico.intProducto_ID) FROM Detalle_Inventario_Fisico
INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
WHERE Detalle_Inventario_Fisico.intInventario_ID = @InvFisico_ID
GROUP BY Productos.vchDescripcion
ORDER BY Productos.vchDescripcion

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosTercero]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosTercero]
@Cliente_ID       int
AS

SET DATEFORMAT dmy

SELECT ' ', intCliente_Tercero_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre FROM Facturar_Terceros
WHERE bitActivo = 1 AND intCliente_ID = @Cliente_ID
ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosTipoProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosTipoProducto]
AS

SET DATEFORMAT dmy

SELECT *  FROM Tipo_Producto
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosTraspasos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosTraspasos]
	@Recibidos	bit,
	@Almacen_ID	int
AS
BEGIN
	SET DATEFORMAT dmy

	DECLARE @SQL varchar(MAX), @BaseDatos varchar(20), @Almacen_FROM int

	SET @Almacen_FROM = (SELECT DISTINCT intAlmacen_ID_FROM FROM Traspasos WHERE intAlmacen_ID_TO = @Almacen_ID)
	SET @BaseDatos = (SELECT BaseDatos FROM Almacenes WHERE intAlmacen_ID = @Almacen_FROM)

	SET @SQL = 'SELECT '''', dtmFecha, M.NoProductos, U.vchUsuario, T.intTraspaso_ID FROM ' + @BaseDatos + '.dbo.Traspasos T ' +
	           'INNER JOIN (SELECT intRemisionNo AS intTraspaso_ID, COUNT(*) AS NoProductos FROM ' + @BaseDatos + '.dbo.Movimientos WHERE intTipo_Movimiento = 206 GROUP BY intRemisionNo) M ON T.intTraspaso_ID = M.intTraspaso_ID ' +
	           'INNER JOIN ' + @BaseDatos + '.dbo.Usuarios U On T.intUsuario_ID = U.intUsuario_ID ' +
	           'WHERE bitRecibido = ' + CONVERT(varchar,@Recibidos) + ' AND intAlmacen_ID_TO = ' + CONVERT(varchar,@Almacen_ID) + ' ' +
	           'ORDER BY T.intTraspaso_ID'

	EXEC (@SQL)

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosUnidadMedida]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosUnidadMedida]
@Unidad_ID   int,
@Todos       int,
@Estatus     int
AS

SET DATEFORMAT dmy

IF @Todos = 1
	SELECT * FROM Unidad_Medida
	WHERE bitActivo = @Estatus AND (intUnidad_ID = @Unidad_ID AND @Unidad_ID <> 0 OR @Unidad_ID = 0)
ELSE
	SELECT ' ', intUnidad_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Unidad_Medida
	WHERE bitActivo = @Estatus AND (intUnidad_ID = @Unidad_ID AND @Unidad_ID <> 0 OR @Unidad_ID = 0)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosUsuario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosUsuario]
@Usuario     varchar(10)
AS

SET DATEFORMAT dmy

SELECT intUsuario_ID, vchContrasena AS vchPassword, vchNombreCompleto, bitSolo_Inventarios FROM Usuarios
WHERE bitActivo = 1 
      AND vchUsuario = @Usuario

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosVicera]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosVicera]
@Producto_ID  int,
@Detallado       int
AS

SET DATEFORMAT dmy

IF @Detallado = 1
	SELECT Viceras.intProducto_ID, Productos.vchDescripcion FROM Viceras
                INNER JOIN Productos ON Viceras.intProducto_ID = Productos.intProducto_ID
	WHERE intVicera_ID = @Producto_ID 
ELSE
	SELECT ' ', intProducto_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Productos
	WHERE bitActivo = 1 AND  intTipoProducto_ID = (SELECT intTipoProducto_Viceras FROM Parametros)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosVicerasASurtir]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosVicerasASurtir]
@Producto_ID	int,
@Tipo		int
AS

SET DATEFORMAT dmy

IF @Tipo = 0
	SELECT intProductoVicera_ID, vchDescripcion FROM Viceras_A_Surtir
	INNER JOIN Productos ON Viceras_A_Surtir.intProductoVicera_ID = Productos.intProducto_ID
	WHERE Viceras_A_Surtir.intProducto_ID = @Producto_ID
	ORDER BY vchDescripcion
ELSE
	SELECT ' ', intProductoVicera_ID, vchDescripcion FROM Viceras_A_Surtir
	INNER JOIN Productos ON Viceras_A_Surtir.intProductoVicera_ID = Productos.intProducto_ID
	WHERE Viceras_A_Surtir.intProducto_ID = @Producto_ID
	ORDER BY vchDescripcion

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDeposito_Bancario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDeposito_Bancario]
@Fecha                        datetime--varchar(30)
AS

SET DATEFORMAT dmy

SELECT mnyDeposito FROM Deposito_Bancario 
WHERE dtmFecha = @Fecha
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDeshueses]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDeshueses]
@Deshuese_ID	int,
@Status		int
AS

SET DATEFORMAT dmy

IF @Deshuese_ID = 0
	SELECT '', intDeshuese_ID, dtmFecha FROM Deshueses
	WHERE (bitProcesado = @Status AND @Status >= 0 OR @Status < 0)
	ORDER BY intDeshuese_ID
ELSE	
	SELECT Deshueses.*, ISNULL(intProducto_ID,0) AS intProducto_ID FROM Deshueses
	LEFT OUTER JOIN (SELECT intDeshuese_ID, intProducto_ID FROM Detalle_Deshueses WHERE intProducto_ID IN (SELECT DISTINCT intProducto_Canal FROM Relacion_Matanza) GROUP BY intDeshuese_ID, intProducto_ID) Productos ON Deshueses.intDeshuese_ID = Productos.intDeshuese_ID
	WHERE Deshueses.intDeshuese_ID = @Deshuese_ID AND (bitProcesado = @Status AND @Status >= 0 OR @Status < 0)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDeshuesesXOC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDeshuesesXOC]
@OrdenCompra	int
AS

SELECT dtmFecha, dtmFecha FROM VDeshuesesXOC
WHERE intOrdenCompra_ID = @OrdenCompra

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDetalleCierreInventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDetalleCierreInventario]
@Cierre_ID	int,
@Almacen_ID	int
AS

SELECT '', Productos.vchDescripcion, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Orden_Compra.dtmFecha IS NULL THEN Deshueses.dtmFecha ELSE Orden_Compra.dtmFecha END ELSE Matanzas.dtmFecha END, Detalle_Cierre_Inventario.intCanalNo, intExistencia, Detalle_Cierre_Inventario.mnyPeso, Detalle_Cierre_Inventario.intOrdenCompra_ID FROM Detalle_Cierre_Inventario
INNER JOIN Productos ON Detalle_Cierre_Inventario.intProducto_ID = Productos.intProducto_ID
LEFT OUTER JOIN Matanzas ON Detalle_Cierre_Inventario.intMatanza_ID = Matanzas.intMatanza_ID AND Detalle_Cierre_Inventario.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
LEFT OUTER JOIN Orden_Compra ON Detalle_Cierre_Inventario.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
LEFT OUTER JOIN Deshueses ON (Detalle_Cierre_Inventario.intMatanza_ID * -1) = Deshueses.intDeshuese_ID
WHERE intCierre_ID = @Cierre_ID
      AND intAlmacen_ID = @Almacen_ID
ORDER BY Productos.vchDescripcion, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Orden_Compra.dtmFecha IS NULL THEN Deshueses.dtmFecha ELSE Orden_Compra.dtmFecha END ELSE Matanzas.dtmFecha END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDetalleDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDetalleDeshuese]
@Deshuese_ID	int
AS

SET DATEFORMAT dmy

SELECT '', Productos.vchDescripcion, '', Productos_Compuestos.intProducto_ID FROM Detalle_Deshueses
INNER JOIN Deshueses ON Detalle_Deshueses.intDeshuese_ID = Deshueses.intDeshuese_ID
LEFT OUTER JOIN Relacion_Deshuese ON Detalle_Deshueses.intProducto_ID = Relacion_Deshuese.intProducto_ID
LEFT OUTER JOIN Productos_Compuestos ON Relacion_Deshuese.intProducto_Deshuese = Productos_Compuestos.intProductoCompuesto_ID
LEFT OUTER JOIN Productos ON Productos_Compuestos.intProducto_ID = Productos.intProducto_ID
WHERE Detalle_Deshueses.intDeshuese_ID = @Deshuese_ID
       AND Deshueses.bitProcesado = 0
GROUP BY Productos_Compuestos.intProducto_ID, Productos.vchDescripcion
ORDER BY Productos_Compuestos.intProducto_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDetalleRemision]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDetalleRemision]
	@Remision_ID	int,
	@Almacen		int
AS
BEGIN
	SET DATEFORMAT dmy

	SELECT ' ', vchDescripcion, Detalle_Remisiones.intCantidad, CASE WHEN Detalle_Remisiones.mnyPeso = 0 THEN NULL ELSE Detalle_Remisiones.mnyPeso END, CASE WHEN Detalle_Remisiones.mnyPrecio = 0 THEN NULL ELSE Detalle_Remisiones.mnyPrecio END, CASE WHEN Detalle_Remisiones.mnyImporte = 0 THEN NULL ELSE Detalle_Remisiones.mnyImporte END, CASE WHEN Detalle_Remisiones.mnyFlete = 0 THEN NULL ELSE Detalle_Remisiones.mnyFlete END, Movimientos.dtmFecha FROM Detalle_Remisiones
	INNER JOIN Movimientos ON Detalle_Remisiones.intMovimiento_ID = Movimientos.intMovimiento_ID
	INNER JOIN Productos ON Detalle_Remisiones.intProducto_ID = Productos.intProducto_ID
	WHERE Detalle_Remisiones.intRemisionNo = @Remision_ID

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDiferenciasCierreMenusal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDiferenciasCierreMenusal]
	@Fecha		smalldatetime,
	@Almacen	int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE
	@Cliente_Ini 	int, 
	@Cliente_Fin 	int,
	@Fecha_ini      smalldatetime,
	@Fecha_Fin      smalldatetime,
	@Foraneo		int,
	@IncluirPG		int,
	@TipoCliente	char(1)

	SET DATEFORMAT DMY

	SET @Fecha_ini = '01/01/2001'
	SET @Fecha_Fin = @Fecha
	SET @Foraneo = 2
	SET @IncluirPG = 1
	SET @TipoCliente = 'T'

	DELETE FROM Comparativo

	CREATE TABLE #Abonos (
	intRemisionNo	int,
	mnyAbonado	money)

	INSERT INTO #Abonos
	SELECT intRemisionNo, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar
	 INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
	 INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND Facturas.bitCancelada = 0
	 WHERE intAlmacen_ID = @Almacen
	 AND CtasXCobrar.intCliente_ID BETWEEN 1 AND 2000
	 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) BETWEEN @Fecha_ini AND @Fecha_Fin + ' 23:59'
			 AND Facturas.intCliente_ID = 1000
	 GROUP BY intRemisionNo

	--- Facturas
	INSERT INTO Comparativo (chrtipo, intCliente_ID, intFactura_ID, dtmFecha, mnyImporte, mnyAbonado, mnySaldo, intRemisionNo)
	SELECT 'F', Facturas.intCliente_ID, Facturas.intFactura_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.mnyImporte, ISNULL(Abonos.mnyAbonado,0) AS mnyAbonado, Facturas.mnyImporte - ISNULL(Abonos.mnyAbonado,0) - CASE WHEN Facturas.intCliente_ID <> 1000 THEN ISNULL(Notas_Credito.mnyImporte,0) ELSE 0 END  AS mnySaldo, 0 FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitAplicada = 0 AND Notas_Credito.bitCancelada = 0 AND Notas_Credito.dtmFecha BETWEEN @Fecha_ini AND @Fecha_fin + '23:59'
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar
					 INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
					 WHERE intAlmacen_ID = @Almacen
						AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
					 GROUP BY intFactura_ID
				   ) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
	WHERE Facturas.intCliente_ID BETWEEN 1000 AND 1000
		  AND (Facturas.intCliente_ID <>  1000 AND @IncluirPG = 0 OR @IncluirPG = 1)
		  AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
		  AND (Facturas.mnyImporte - ISNULL(Abonos.mnyAbonado,0)) <> 0
		  AND Facturas.bitCancelada = 0
		  AND (bitForaneo = @Foraneo AND  @Foraneo = 0 OR bitForaneo = @Foraneo AND  @Foraneo = 1 OR @Foraneo = 2)
		  AND (bitIncobrable = 1 AND @TipoCliente = 'I' OR bitIncobrable = 0 AND @TipoCliente = 'C' OR bitIncobrable >= 0 AND @TipoCliente = 'T')
	ORDER BY Facturas.intCliente_ID, Facturas.dtmFecha, Facturas.intFactura_ID


	--- Notas de Venta

	INSERT INTO Comparativo (chrtipo, intCliente_ID, intFactura_ID, dtmFecha, mnyImporte, mnyAbonado, mnySaldo, intRemisionNo)
	SELECT 'N', CtasXCobrar.intCliente_ID, CtasXCobrar.intFactura_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) AS dtmFecha, CtasXCobrar.mnyImporte, #Abonos.mnyAbonado, CtasXCobrar.mnyImporte - ISNULL(#Abonos.mnyAbonado,0) - ISNULL(Detalle_Notas_Credito.mnyImporte,0) AS mnySaldo, CtasXCobrar.intRemisionNo FROM CtasXCobrar
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND Facturas.bitCancelada = 0
	INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	INNER JOIN Remisiones ON CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo AND CtasXCobrar.intAlmacen_ID = Remisiones.intAlmacen_ID
	LEFT OUTER JOIN (SELECT Det.*, NC.dtmFecha FROM Detalle_Notas_Credito Det INNER JOIN Notas_Credito NC ON Det.intNota_Credito_ID = NC.intNota_Credito_ID) Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo  AND bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0 AND Detalle_Notas_Credito.dtmFecha BETWEEN @Fecha_ini AND @Fecha_fin + '23:59'
	LEFT OUTER JOIN #Abonos ON CtasXCobrar.intRemisionNo = #Abonos.intRemisionNo
	WHERE CtasXCobrar.intCliente_ID BETWEEN 1 AND 2000
		  AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
		  AND  CtasXCobrar.intAlmacen_ID = @Almacen
		  AND (Remisiones.bitFacturado = 1 AND Facturas.dtmFecha <= @Fecha_Fin + '23:59')
		  AND (CtasXCobrar.mnyImporte - ISNULL(#Abonos.mnyAbonado,0)) <> 0
				AND Facturas.intCliente_ID = 1000
		  AND (bitForaneo = @Foraneo AND  @Foraneo = 0 OR bitForaneo = @Foraneo AND  @Foraneo = 1 OR @Foraneo = 2)
		  AND (bitIncobrable = 1 AND @TipoCliente = 'I' OR bitIncobrable = 0 AND @TipoCliente = 'C' OR bitIncobrable >= 0 AND @TipoCliente = 'T')
	ORDER BY CtasXCobrar.intCliente_ID, CtasXCobrar.dtmFecha, CtasXCobrar.intRemisionNo


	SELECT SUM(mnySaldo) AS Saldo_Facturas FROM Comparativo
	WHERE chrTipo = 'F'

	SELECT SUM(mnySaldo) AS Saldo_Notas FROM Comparativo
	WHERE chrTipo = 'N'


	SELECT Comparativo.intFactura_ID, mnySaldo, mnyTotalAbonado, mnySaldo - mnyTotalAbonado AS mnyDif, Notas_Credito.mnyImporte, Notas_Credito.bitAplicada, Notas_Credito.bitCancelada FROM Comparativo
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnySaldo) AS mnyTotalAbonado FROM Comparativo WHERE chrTipo = 'N' GROUP BY intFactura_ID) Notas ON Comparativo.intFactura_ID = Notas.intFactura_ID
	LEFT OUTER JOIN Notas_Credito ON Comparativo.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitAplicada = 0
	WHERE chrTipo = 'F'
	  AND ((mnySaldo <> mnyTotalAbonado) OR mnySaldo < 0)
	ORDER BY Comparativo.intFactura_ID


	SELECT Notas.intFactura_ID, mnySaldo, ISNULL(mnyTotalFacturas,0) AS mnyTotalFacturas, ISNULL(mnyTotalFacturas,0) - mnySaldo AS mnyDif, Notas_Credito.mnyImporte, Notas_Credito.bitAplicada, Notas_Credito.bitCancelada
	FROM (SELECT intFactura_ID, SUM(mnySaldo) AS mnySaldo FROM Comparativo WHERE chrTipo = 'N' GROUP BY intFactura_ID) Notas
	LEFT OUTER JOIN (SELECT intFactura_ID, mnySaldo AS mnyTotalFacturas FROM Comparativo WHERE chrTipo = 'F') Facturas ON Notas.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitAplicada = 0
	WHERE ((mnySaldo <> ISNULL(mnyTotalFacturas ,0)) OR mnySaldo < 0)
	ORDER BY Notas.intFactura_ID

	DROP TABLE #Abonos
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDiferenciasInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDiferenciasInvFisico]
@InvFisico	int
AS

SET DATEFORMAT dmy

IF (SELECT bitAplicado FROM Inventario_Fisico WHERE intInventario_ID = @InvFisico) = 0
	SELECT '', Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, Existencias.intExistencia, COUNT(Detalle_Inventario_Fisico.intProducto_ID) AS InvFisico, COUNT(Detalle_Inventario_Fisico.intProducto_ID) - Existencias.intExistencia AS Diferencia FROM Detalle_Inventario_Fisico
	INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS intExistencia FROM Existencias GROUP BY intProducto_ID) Existencias ON Detalle_Inventario_Fisico.intProducto_ID = Existencias.intProducto_ID
	WHERE intInventario_ID = @InvFisico
	GROUP BY Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, Existencias.intExistencia
	ORDER BY Detalle_Inventario_Fisico.intProducto_ID
ELSE
	SELECT '', Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, Existencias.intExistencia, COUNT(Detalle_Inventario_Fisico.intProducto_ID) AS InvFisico, COUNT(Detalle_Inventario_Fisico.intProducto_ID) - Existencias.intExistencia AS Diferencia FROM Detalle_Inventario_Fisico
	INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS intExistencia FROM Inventario_Fisico_Existencias WHERE intInventario_ID = @InvFisico GROUP BY intProducto_ID) Existencias ON Detalle_Inventario_Fisico.intProducto_ID = Existencias.intProducto_ID
	WHERE intInventario_ID = @InvFisico
	GROUP BY Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, Existencias.intExistencia
	ORDER BY Detalle_Inventario_Fisico.intProducto_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerEstadoCuentaXCliente]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerEstadoCuentaXCliente]
@Cliente	int
AS

SET DATEFORMAT dmy
SET NOCOUNT ON

DECLARE @Saldo_Facturas money, @Saldo_NotaVenta money, @Fecha_Ini smalldatetime, @Fecha_Fin smalldatetime

SET @Fecha_Ini = '01/01/1900'
SET @Fecha_Fin = GETDATE()

SET @Saldo_NotaVenta = ISNULL((SELECT SUM(ISNULL(CtasXCobrar.mnyImporte,0) - (ISNULL(Abonos.mnyAbonado,0) +  ISNULL(Detalle_Notas_Credito.mnyImporte,0))) AS mnySaldo FROM CtasXCobrar
			       LEFT OUTER JOIN (SELECT intCtaXCobrar_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < DATEADD(day,1,@Fecha_Fin) GROUP BY intCtaXCobrar_ID) Abonos ON CtasXCobrar.intCtaXCobrar_ID = Abonos.intCtaXCobrar_ID
			       LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
			       LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
			       WHERE CtasXCobrar.intCliente_ID = @Cliente
			         AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) < DATEADD(day,1,@Fecha_Fin)
                                 AND Facturas.intCliente_ID = 1000),0)

SET @Saldo_Facturas = ISNULL((SELECT SUM(Facturas.mnyImporte - (ISNULL(mnyAbonado,0)) + ISNULL(Notas_Credito.mnyImporte,0)) FROM Facturas
			      LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar 
			                       LEFT OUTER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
			                       WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < DATEADD(day,1,@Fecha_Fin)
			                       GROUP BY intFactura_ID) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
			      LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
			      WHERE Facturas.intCliente_ID = @Cliente
			        AND Facturas.bitCancelada = 0
			        AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) < DATEADD(day,1,@Fecha_Fin)),0)
	
SELECT @Saldo_NotaVenta AS SaldoNotasVenta, @Saldo_Facturas AS SaldoFacturas

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerEstatusNotasXRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerEstatusNotasXRepartidor]
@Repartidor_ID	int,
@Folio_ID		int
AS

SET DATEFORMAT dmy
SET NOCOUNT ON

DECLARE @Folio_Ini	int, @Folio_Fin	int, @Cliente varchar(100), @Fecha smalldatetime, @Importe money

--SET @Repartidor_ID = 8
--SET @Folio_ID = 217

SET @Cliente = NULL
SET @Fecha = NULL
SET @Importe = NULL

SELECT @Folio_Ini = intFolio_Inicial, @Folio_Fin = intFolio_Final FROM Control_Folios_Remisiones WHERE intRepartidor_ID = @Repartidor_ID AND intConsecutivo = @Folio_ID

CREATE TABLE #Folios (
intFolio	int,
vchDescripcion	varchar(80),
dtmFecha	smalldatetime,
mnyImporte	money,
)

WHILE @Folio_Ini <= @Folio_Fin
BEGIN

	SELECT @Cliente = CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END, @Fecha = dtmFecha, @Importe = mnyImporte FROM CtasXCobrar
	LEFT OUTER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	WHERE intRemisionNo = @Folio_Ini
	
	IF @Cliente IS NULL
		SELECT @Cliente = 'NOTA DE VENTA CANCELADA', @Fecha = dtmFecha, @Importe = NULL FROM Remisiones_Canceladas WHERE intConsecutivo = @Folio_ID AND intRemisionNo = @Folio_Ini

	IF @Cliente IS NULL
		SELECT @Cliente = 'NOTA DE VENTA SIN REGISTRAR', @Fecha = NULL, @Importe = NULL

	INSERT INTO #Folios (intFolio, vchDescripcion, dtmFecha, mnyImporte) 
	         VALUES (@Folio_Ini, @Cliente, @Fecha, @Importe)

	SET @Folio_Ini = @Folio_Ini + 1
	SET @Cliente = NULL
	SET @Fecha = NULL
	SET @Importe = NULL

END

SELECT ' ', * FROM #Folios

DROP TABLE #Folios
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerExistenciasXAlmacen]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerExistenciasXAlmacen]
@Almacen   int
AS

SET DATEFORMAT dmy

SELECT '', Productos.vchDescripcion, intExistencia, CASE WHEN @Almacen = 1 OR mnyPeso = 0 THEN NULL ELSE mnyPeso END, CASE WHEN intCanalNo = 0 THEN NULL ELSE intCanalNo END AS intCanalNo, intOrdenCompra_ID, intMatanza_ID FROM Existencias
INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
WHERE intAlmacen_ID = @Almacen

UNION ALL

SELECT '*', Productos.vchDescripcion, intCantidad, CASE WHEN intTipoCompra <> 2 THEN NULL ELSE mnyPeso END AS intCanalNo, NULL, Matanzas.intOrdenCompra_ID, NULL AS intMatanza_ID FROM Matanzas
INNER JOIN Productos ON Matanzas.intProducto_ID = Productos.intProducto_ID
INNER JOIN Orden_Compra ON Matanzas.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
WHERE Matanzas.bitProcesado = 0 AND @Almacen = 1 AND Matanzas.bitCancelado = 0
ORDER BY Productos.vchDescripcion, intCanalNo

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerExistenciasXDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerExistenciasXDeshuese]
@Deshuese_ID	int,
@Producto_ID		int
AS

SELECT '',Detalle_Deshueses.intOrdenCompra_ID, Detalle_Deshueses.intCanalNo, Deshueses.dtmFecha,  1, mnyPeso, 0, intMatanza_ID, Detalle_Deshueses.intDeshuese_ID FROM Detalle_Deshueses
INNER JOIN Deshueses ON Detalle_Deshueses.intDeshuese_ID = Deshueses.intDeshuese_ID
LEFT OUTER JOIN (SELECT intOrdenCompra_ID, intCanalNo FROM Movimientos WHERE (intMatanza_ID * -1) = @Deshuese_ID AND chrOperacion = 'E' AND intOrdenCompra_ID > 0 GROUP BY intOrdenCompra_ID, intCanalNo) Movimientos ON Detalle_Deshueses.intOrdenCompra_ID = Movimientos.intOrdenCompra_ID AND Detalle_Deshueses.intCanalNo = Movimientos.intCanalNo
WHERE Detalle_Deshueses.intDeshuese_ID = @Deshuese_ID
       AND Detalle_Deshueses.intProducto_ID = @Producto_ID
       AND Movimientos.intOrdenCompra_ID IS NULL
ORDER BY Deshueses.dtmFecha

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerExistenciasXProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerExistenciasXProducto]
@Almacen     int,
@Producto     int,
@Deshuese  int
AS

SET DATEFORMAT dmy


IF @Deshuese = -2
	SELECT '',CASE WHEN intCanalNo = 0 THEN NULL ELSE intCanalNo END AS intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END,  CASE WHEN @Almacen = 1 OR Existencias.mnyPeso = 0 THEN NULL ELSE Existencias.mnyPeso END, intExistencia, Existencias.intProducto_ID, Existencias.intOrdenCompra_ID, Existencias.intMatanza_ID, intIdentificador_Unico, CASE WHEN intNoPiezas = 0 THEN 0 ELSE 1 END AS EsVicera FROM Existencias
	INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
	LEFT OUTER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID AND Existencias.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
	LEFT OUTER JOIN Orden_Compra ON Existencias.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
	WHERE intAlmacen_ID = @Almacen
	     AND   Existencias.intProducto_ID = @Producto
	ORDER BY intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END
ELSE
	IF @Deshuese = -1
		SELECT '',Existencias.intOrdenCompra_ID, CASE WHEN intCanalNo = 0 THEN NULL ELSE intCanalNo END AS intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Orden_Compra.dtmFecha IS NULL THEN Deshueses.dtmFecha ELSE Orden_Compra.dtmFecha END ELSE Matanzas.dtmFecha END,  intExistencia, CASE WHEN @Almacen = 1 OR Existencias.mnyPeso = 0 THEN NULL ELSE Existencias.mnyPeso END, 0, Existencias.intMatanza_ID, intIdentificador_Unico FROM Existencias
		INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
		LEFT OUTER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID AND Existencias.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
		LEFT OUTER JOIN Orden_Compra ON Existencias.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
		LEFT OUTER JOIN Deshueses ON (Existencias.intMatanza_ID * -1) = Deshueses.intDeshuese_ID
		WHERE intAlmacen_ID = @Almacen
		     AND   Productos.intProducto_ID = @Producto
--		ORDER BY intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END
		ORDER BY CASE WHEN @Almacen = 1 OR Existencias.mnyPeso = 0 THEN NULL ELSE Existencias.mnyPeso END
	ELSE
	BEGIN
		IF @Deshuese = 0
			SELECT '',CASE WHEN intCanalNo = 0 THEN NULL ELSE intCanalNo END AS intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END,  intExistencia, CASE WHEN @Almacen = 1 OR Existencias.mnyPeso = 0 THEN NULL ELSE Existencias.mnyPeso END, Existencias.intOrdenCompra_ID, 0, Existencias.intMatanza_ID, intIdentificador_Unico FROM Existencias
			INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
			LEFT OUTER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID AND Existencias.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
			LEFT OUTER JOIN Orden_Compra ON Existencias.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
			WHERE intAlmacen_ID = @Almacen
			     AND   Productos.intProducto_ID = @Producto
			     AND   Existencias.mnyPeso <> 0
			ORDER BY intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END

		IF @Deshuese = 1
			SELECT '',CASE WHEN intCanalNo = 0 THEN NULL ELSE intCanalNo END AS intCanalNo, dtmFecha,  intExistencia, Existencias.intMatanza_ID, Existencias.intOrdenCompra_ID, 0, Existencias.intMatanza_ID, IntIdentificador_Unico FROM Existencias
			INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
			INNER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID AND Existencias.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
			WHERE intAlmacen_ID = @Almacen
			     AND   Productos.intProducto_ID = @Producto
			     AND   mnyPeso = 0
			ORDER BY intCanalNo, dtmFecha

		IF @Deshuese = 2
			SELECT '', CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END,  intExistencia, CASE WHEN @Almacen = 1 OR Existencias.mnyPeso = 0 THEN NULL ELSE Existencias.mnyPeso END, CASE WHEN intCanalNo = 0 THEN NULL ELSE intCanalNo END AS intCanalNo, Existencias.intOrdenCompra_ID, intIdentificador_Unico FROM Existencias
			INNER JOIN Productos ON Existencias.intProducto_ID = Productos.intProducto_ID
			LEFT OUTER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID AND Existencias.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
			LEFT OUTER JOIN Orden_Compra ON Existencias.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
			WHERE intAlmacen_ID = @Almacen
			     AND   Productos.intProducto_ID = @Producto
			     AND   (Existencias.mnyPeso <> 0 OR Existencias.mnyPeso = 0 AND bitGenerar_SubProductos = 1)
			ORDER BY intCanalNo, CASE WHEN Matanzas.dtmFecha IS NULL THEN Orden_Compra.dtmFecha ELSE Matanzas.dtmFecha END
	END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerExistenciaTotalXProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerExistenciaTotalXProducto]
@Almacen   int,
@Producto  int
AS

SET DATEFORMAT dmy

SELECT SUM(intExistencia) AS intExistencia FROM Existencias
WHERE intAlmacen_ID = @Almacen
     AND   intProducto_ID = @Producto
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerFechaServidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerFechaServidor]
AS

SET DATEFORMAT dmy

SELECT GETDATE()
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerFoliosXRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerFoliosXRepartidor] 
@Repartidor	int,
@Folio		int
AS

SET DATEFORMAT dmy

IF @Folio = 0
	SELECT ' ', intFolio_Inicial, intFolio_Final, intConsecutivo FROM Control_Folios_Remisiones
	WHERE intRepartidor_ID = @Repartidor
ELSE
	SELECT 'Del ' + RTRIM(CONVERT(CHAR,intFolio_Inicial)) + ' Al ' + RTRIM(CONVERT(CHAR,intFolio_Final)) AS vchRangoFolios FROM Control_Folios_Remisiones
	WHERE intRepartidor_ID = @Repartidor AND intConsecutivo = @Folio
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerFormaPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerFormaPago]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT ROW_NUMBER() OVER(ORDER BY Codigo ASC) AS ID, Codigo + ' - ' + Descripcion AS Descripcion FROM c_FormaPago

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerImporteNC]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerImporteNC]
@Factura_ID 	int,
@TipoCuenta	char(1)
AS

SET DATEFORMAT dmy

IF @TipoCuenta = 'F'
	SELECT ISNULL(SUM(mnyImporte),0) AS mnyImporte FROM Notas_Credito
	WHERE intFactura_ID = @Factura_ID
	      AND bitAplicada = 0
	      AND bitCancelada = 0
ELSE
	SELECT ISNULL(SUM(mnyImporte),0) AS mnyImporte FROM Detalle_Notas_Credito
	WHERE intRemisionNo = @Factura_ID
	      AND bitAplicada = 0
	      AND bitCancelada = 0
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerInformacionDeshuese]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerInformacionDeshuese] 
@Deshuese_ID	int,
@TipoConsulta	char(1),
@Almacen_ID		int
AS

SET DATEFORMAT dmy

IF @TipoConsulta = 'H'
	SELECT '', Productos.vchDescripcion, intCanalNo, intOrdenCompra_ID, mnyPeso FROM Detalle_Deshueses
	INNER JOIN Productos ON Detalle_Deshueses.intProducto_ID = Productos.intProducto_ID
	WHERE intDeshuese_ID = @Deshuese_ID
	ORDER BY Productos.vchDescripcion
ELSE
	SELECT '', Productos.vchDescripcion AS Producto, Productos.mnyPrecio, Movimientos.mnyPeso, Movimientos.mnyPeso * Movimientos.mnyPrecio AS Importe  FROM Movimientos
	INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
	WHERE Movimientos.intAlmacen_ID = @Almacen_ID
	       AND (Movimientos.intCliente_ID < 0 AND Movimientos.intCliente_ID <> -999)
	       AND intMatanza_ID = (@Deshuese_ID * -1)
	ORDER BY Productos.vchDescripcion
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerKardex]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerKardex]
	@Producto_ID	int,
	@Fecha_Ini		datetime,
	@Fecha_Fin		datetime,
	@Almacen		int
AS
BEGIN
	SET NOCOUNT ON;
	SET DATEFORMAT dmy

	DECLARE @Fecha_Cierre smalldatetime, @Inv_Ini int

	SET DATEFORMAT MDY

	SELECT TOP 1 @Inv_Ini = Inv_Ini, @Fecha_Cierre = CONVERT(SMALLDATETIME,CONVERT(VARCHAR,DATEADD(d,0,dtmFecha_Aplicado),103),103) FROM Inventario_Fisico Cab
	INNER JOIN (SELECT intInventario_ID, intProducto_ID, COUNT(intProducto_ID) AS Inv_Ini FROM Detalle_Inventario_Fisico WHERE intProducto_ID = @Producto_ID GROUP BY intInventario_ID, intProducto_ID) Det ON Cab.intInventario_ID = Det.intInventario_ID
	WHERE dtmFecha_Aplicado <= @Fecha_Ini 
	ORDER BY dtmFecha_Aplicado DESC

	SELECT '', CONVERT(SMALLDATETIME,CONVERT(VARCHAR,Mov.dtmFecha,103),103), TM.vchDescripcion AS Movimiento, intCantidad, 0, Mov.mnyPrecio, CASE WHEN Mov.intCanalNo = 0 THEN NULL ELSE Mov.intCanalNo END, mnyPeso, CASE WHEN intRemisionNo = 0 THEN NULL ELSE intRemisionNo END, CASE WHEN intOrdenCompra_ID = 0 THEN NULL ELSE intOrdenCompra_ID END, CASE WHEN intMatanza_ID <= 0 THEN NULL ELSE intMatanza_ID END, Clientes.vchRazonSocial, ISNULL(@Inv_Ini,0) AS Inv_Ini, Inv_Fin
	FROM Movimientos Mov
	INNER JOIN Tipo_Movimiento TM ON Mov.intTipo_Movimiento = TM.intTipo_Movimiento
	INNER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS Inv_Fin FROM Existencias WHERE intAlmacen_ID = @Almacen AND intProducto_ID = @Producto_ID GROUP BY intProducto_ID) Existencia ON Mov.intProducto_ID = Existencia.intProducto_ID
	LEFT OUTER JOIN Clientes ON Mov.intCliente_ID = Clientes.intCliente_ID
	WHERE Mov.intProducto_ID = @Producto_ID
	  AND dtmFecha BETWEEN ISNULL(@Fecha_Cierre,@Fecha_Ini) AND @Fecha_Fin + '23:59'
--	  AND (Mov.intTipo_Movimiento <> 103 AND Mov.intTipo_Movimiento <> 203)
	ORDER BY dtmFecha

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerMetodoPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerMetodoPago]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT ROW_NUMBER() OVER(ORDER BY Metodo_Pago ASC) AS ID, Metodo_Pago + ' - ' + Descripcion AS Descripcion FROM c_MetodoPago

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerNuevaFechaCalculada]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerNuevaFechaCalculada]
@Fecha	datetime,
@ParteFecha	char(1),
@Numero	int
AS

SET DATEFORMAT dmy

IF @ParteFecha = 'm'
	SELECT DATEADD(mm,@Numero,@Fecha)

IF @ParteFecha = 'd'
	SELECT DATEADD(dd,@Numero,@Fecha)

IF @ParteFecha = 'y'
	SELECT DATEADD(yy,@Numero,@Fecha)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerProductosActivos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ObtenerProductosActivos]
@TipoProducto                     int,
@Generar_SubProductos  int,
@ProductoCajas                  int
AS

SET DATEFORMAT dmy

IF @ProductoCajas = -1
	SELECT ' ', Relacion_Deshuese.intProducto_Deshuese, vchDescripcion FROM Relacion_Deshuese
	INNER JOIN Productos ON Relacion_Deshuese.intProducto_Deshuese = Productos.intProducto_ID
	WHERE bitActivo = 1
	       AND Relacion_Deshuese.intProducto_ID = @Generar_SubProductos
	ORDER BY vchDescripcion
ELSE
	IF @ProductoCajas = 0
		SELECT ' ', intProducto_ID, vchDescripcion FROM Productos
		WHERE bitActivo = 1
	--	       AND bitGenerar_SubProductos = @Generar_SubProductos
		       AND ((intTipoProducto_ID = @TipoProducto AND @TipoProducto <> 0 OR @TipoProducto = 0)
		                  OR (intTipoProducto_ID = (SELECT intTipoProducto_GanadoPie FROM parametros) AND @TipoProducto <> 0 OR @TipoProducto = 0) AND @Generar_SubProductos = 0)
		ORDER BY vchDescripcion
	ELSE
		SELECT ' ', intProducto_ID, vchDescripcion FROM Productos
		WHERE bitActivo = 1
		       AND intUnidad_ID = (SELECT intUM_Cajas FROM Parametros)
		       AND bitGenerar_SubProductos = @Generar_SubProductos
		       AND intTipoProducto_ID = @TipoProducto
		ORDER BY vchDescripcion
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerProductosIncluyenViceras]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerProductosIncluyenViceras]
AS

SET DATEFORMAT dmy

SELECT ' ', intProducto_ID, vchDescripcion FROM Productos
WHERE bitActivo = 1 AND bitIncluyeViceras = 1

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerRemisionesXCliente]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerRemisionesXCliente]
@Cliente_ID		int,
@Almacen_ID		int = 0
AS 

SET DATEFORMAT dmy

IF @Almacen_ID = 0 SET @Almacen_ID = 2

SELECT ' ', CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103), intRemisionNo, vchOrden_Compra, mnyImporte FROM Remisiones
WHERE (Remisiones.intCliente_ID = @Cliente_ID AND @Cliente_ID <> 1000 OR @Cliente_ID = 1000)
      AND bitFacturado = 0
      AND intAlmacen_ID = @Almacen_ID
ORDER BY intRemisionNo
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerRemisionesXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerRemisionesXFactura]
@Factura_ID    int
AS

SET DATEFORMAT dmy

SELECT ' ', Detalle_Facturas.intRemisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103), mnyImporte, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END FROM Detalle_Facturas
INNER JOIN Remisiones ON Detalle_Facturas.intRemisionNo = Remisiones.intRemisionNo
INNER JOIN Clientes ON Remisiones.intCliente_ID = Clientes.intCliente_ID
WHERE (intFactura_ID = @Factura_ID AND @Factura_ID <> 0 OR @Factura_ID = 0)
ORDER BY Detalle_Facturas.intRemisionNo
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerSello]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerSello]
	@Folio_ID	int,
	@TipoDoc	char(1)
AS
BEGIN
	SET NOCOUNT ON;

	IF @TipoDoc = 'P'
		SELECT vchSello, txtXML_CFDI FROM Cab_Pagos
		WHERE intPago_ID = @Folio_ID
	ELSE
		IF @TipoDoc = 'F'
			SELECT vchSello,txtXML_CFDI FROM Cab_Ventas
			WHERE intFactura_ID = @Folio_ID
		ELSE
			SELECT vchSello,txtXML_CFDI FROM Cab_Notas_Credito
			WHERE intNota_Credito_ID = @Folio_ID

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerSigInventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerSigInventario]
AS

SET DATEFORMAT dmy

SELECT intContador_Inventarios + 1 FROM Control_Inventarios

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerUltimoDiaMes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerUltimoDiaMes]
@Fecha	datetime--char(30)
AS

SET DATEFORMAT dmy

--DECLARE @dtmFecha DATETIME

--SET @dtmFecha = CONVERT(DATETIME,@Fecha)

IF @Fecha <> ''
	SELECT DAY(DATEADD(d, -DAY(DATEADD(m,1,@Fecha)),DATEADD(m,1,@Fecha)))
ELSE
	SELECT DAY(DATEADD(d, -DAY(DATEADD(m,1,GETDATE())),DATEADD(m,1,GETDATE())))
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerUsoCFDI]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerUsoCFDI]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT ROW_NUMBER() OVER(ORDER BY Uso_CFDI ASC) AS ID, Uso_CFDI + ' - ' + [Descripción] AS Descripcion FROM c_UsoCFDI

END


GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerVentasXProducto]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerVentasXProducto]
@Producto_ID		int,
@CanalNo		int,
@Peso			money,
@Fecha_Ini		datetime,
@Fecha_Fin		datetime,
@Almacen		int
AS

SET DATEFORMAT dmy

SELECT ' ', CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, dtmFecha, intCantidad, mnyPrecio, intCanalNo, mnyPeso, intRemisionNo, intOrdenCompra_ID FROM Movimientos
INNER JOIN Clientes ON bitActivo = 1 AND Movimientos.intCliente_ID = Clientes.intCliente_ID
WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
  AND intProducto_ID = @Producto_ID
  AND (intCanalNo = @CanalNo AND @CanalNo <> 0 OR @CanalNo = 0)
  AND (mnyPeso = @Peso AND @Peso <> 0 OR @Peso = 0)
  AND chrOperacion = 'S'
  AND intAlmacen_ID = @Almacen
  AND bitTiene_Devolucion = 0
  AND Movimientos.intCliente_ID > 0
  AND mnyPrecio > 0
GROUP BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, dtmFecha, mnyPrecio, intRemisionNo, intCantidad, intCanalNo, intOrdenCompra_ID, mnyPeso
ORDER BY CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END, dtmFecha DESC

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerVentasXRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerVentasXRepartidor]
@Repartidor_ID	int,
@Fecha_Ini		smalldatetime,
@Fecha_Fin		smalldatetime
AS

SET DATEFORMAT dmy

SELECT ' ', CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END AS NombreCliente, dtmFecha, CtasXCobrar.intRemisionNo, Movs.Peso, mnyImporte, mnyAbonado, mnySaldo FROM Repartidores
LEFT OUTER JOIN Control_Folios_Remisiones ON Repartidores.intRepartidor_ID = Control_Folios_Remisiones.intRepartidor_ID
LEFT OUTER JOIN CtasXCobrar ON CtasXCobrar.intRemisionNo BETWEEN Control_Folios_Remisiones.intFolio_Inicial AND Control_Folios_Remisiones.intFolio_Final
LEFT OUTER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN (SELECT intRemisionNo, SUM(mnyPeso) AS Peso FROM Movimientos WHERE  chrOperacion = 'S' GROUP BY intRemisionNo) Movs ON CtasXCobrar.intRemisionNo = Movs.intRemisionNo
WHERE Repartidores.intRepartidor_ID = @Repartidor_ID
    AND dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
    AND mnySaldo > 0
ORDER BY 1, 2, 3
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteAbonos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteAbonos]
@Cliente_Ini	int,
@Cliente_Fin	int,
@Fecha_Ini	datetime,--char(30),
@Fecha_Fin	datetime,--char(30),
@TipoReporte	int,
@Almacen	int,
@TipoAbono	int
AS

SET DATEFORMAT dmy

IF @TipoReporte = 1	--  Abonos a Clientes
	SELECT CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END AS Cliente, CtasXCobrar.dtmFecha, intRemisionNo, CtasXCobrar.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, vDetalle_Abonos.dtmFecha_Abono, vDetalle_Abonos.mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbono, vSumarizado_Abonos.mnyAbonado + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbonado, (CtasXCobrar.mnyImporte - ISNULL(vSumarizado_Abonos.mnyAbonado,0)) AS Saldo, @Cliente_Ini AS Cliente_Ini, @Cliente_Fin AS Cliente_Fin FROM CtasXCobrar
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN vDetalle_Abonos ON CtasXCobrar.intCtaXCobrar_ID = vDetalle_Abonos.intCtaXCobrar_ID
	LEFT OUTER JOIN vSumarizado_Abonos ON CtasXCobrar.intCtaXCobrar_ID = vSumarizado_Abonos.intCtaXCobrar_ID
	LEFT OUTER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	WHERE CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	ORDER BY CtasXCobrar.intCliente_ID, CtasXCobrar.intCtaXCobrar_ID, vDetalle_Abonos.dtmFecha_Abono

IF @TipoReporte = 2	--  Abonos a Clientes Sumarizado
	SELECT CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END AS Cliente, CtasXCobrar.dtmFecha, CtasXCobrar.intRemisionNo, (CtasXCobrar.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - (ISNULL(Detalle_Notas_Credito.mnyImporte,0) + ISNULL(Notas_Credito.mnyImporte,0)) AS mnyImporte, vSumarizado_Abonos.mnyAbonado + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbonado, (CtasXCobrar.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - (ISNULL(vSumarizado_Abonos.mnyAbonado + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0),0) + ISNULL(Detalle_Notas_Credito.mnyImporte,0) + ISNULL(Notas_Credito.mnyImporte,0)) AS Saldo, @Cliente_Ini AS Cliente_Ini, @Cliente_Fin AS Cliente_Fin FROM CtasXCobrar
	LEFT OUTER JOIN vSumarizado_Abonos ON CtasXCobrar.intCtaXCobrar_ID = vSumarizado_Abonos.intCtaXCobrar_ID
	LEFT OUTER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND Facturas.bitCancelada = 0
	LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0 AND Facturas.intCliente_ID = 1000
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON CtasXCobrar.intFactura_ID = Notas_Credito.intFactura_ID AND Facturas.intCliente_ID <> 1000
	WHERE CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	ORDER BY CtasXCobrar.intCliente_ID, CtasXCobrar.intCtaXCobrar_ID

IF @TipoReporte = 3 	--  Abonos Detallados
	SELECT CtasXCobrar.intCliente_ID, CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END AS Cliente, CtasXCobrar.dtmFecha, CtasXCobrar.intFactura_ID, CtasXCobrar.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, mnyAbonado + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyAbonado, CtasXCobrar.mnySaldo, dtmFecha_Abono, mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS Abono FROM CtasXCobrar
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
	INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	WHERE CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	ORDER BY CtasXCobrar.intCliente_ID, CtasXCobrar.dtmFecha, CtasXCobrar.intRemisionNo

IF @TipoReporte = 4	--  Abonos a Facturas
	SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha_Abono, CtasXCobrar.intFactura_ID, SUM(mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) AS Abono, CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS Cliente FROM Detalle_CtasXCobrar
	INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_ID
	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	      AND CtasXCobrar.intAlmacen_ID = @Almacen
	GROUP BY dtmFecha_Abono, CtasXCobrar.intFactura_ID, Facturas.intCliente_Tercero, Clientes.vchRazonSocial, Clientes.vchApellidoPaterno, Clientes.vchApellidoMaterno, Clientes.vchNombre, Facturar_Terceros.vchRazonSocial, Facturar_Terceros.vchApellidoPaterno, Facturar_Terceros.vchApellidoMaterno, Facturar_Terceros.vchNombre
	ORDER BY dtmFecha_Abono, CtasXCobrar.intFactura_ID

IF @TipoReporte = 5	--  Abonos Sumarizados por Mes
	IF @TipoAbono = 1  -- Notas de Venta
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha, SUM((mnyAbono - ISNULL(Detalle_Notas_Credito.mnyImporte,0)) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) AS mnyAbonado, @Fecha_Ini AS Fecha_Ini, @Fecha_Fin AS Fecha_Fin FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
		INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitCancelada = 0 AND Detalle_Notas_Credito.bitAplicada = 1
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		    AND Facturas.intCliente_ID = 1000
		    AND Facturas.bitcancelada = 0
		GROUP BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)
		ORDER BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)
	ELSE  -- Facturas
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) AS dtmFecha, SUM(mnyAbono) AS mnyAbonado, @Fecha_Ini AS Fecha_Ini, @Fecha_Fin AS Fecha_Fin FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
		INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 1 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON CtasXCobrar.intFactura_ID = Notas_Credito.intFactura_ID
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		    AND Facturas.intCliente_ID <> 1000
		    AND Facturas.bitcancelada = 0
		GROUP BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)
		ORDER BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103)

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteAbonosSaldosProveedores]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ReporteAbonosSaldosProveedores]
@Proveedor_Ini 	int, 
@Proveedor_Fin 	int,
@Fecha_ini                     smalldatetime,
@Fecha_Fin                   smalldatetime,
@TipoReporte                char(1)
AS

SET DATEFORMAT dmy

IF @TipoReporte = 'S'
	SELECT Orden_Compra.intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Orden_Compra.intOrdenCompra_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) AS dtmFecha, CtasXPagar.mnyImporte, CtasXPagar.mnyAbonado, CtasXPagar.mnySaldo, @TipoReporte AS TipoReporte FROM Orden_Compra
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	INNER JOIN CtasXPagar ON Orden_Compra.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	WHERE Orden_Compra.bitCancelado = 0 AND Orden_Compra.intProveedor_ID BETWEEN @Proveedor_Ini AND @Proveedor_Fin
	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	      AND CtasXPagar.mnySaldo <> 0
	ORDER BY Orden_Compra.intProveedor_ID, Orden_Compra.dtmFecha, Orden_Compra.intOrdenCompra_ID

IF @TipoReporte = 'A'
	SELECT Orden_Compra.intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Orden_Compra.intOrdenCompra_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) AS dtmFecha, CtasXPagar.mnyImporte, CtasXPagar.mnyAbonado, CtasXPagar.mnySaldo, Detalle_CtasXPagar.dtmFecha_Abono, Detalle_CtasXPagar.mnyAbono, @TipoReporte AS TipoReporte FROM Orden_Compra
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	INNER JOIN CtasXPagar ON Orden_Compra.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	LEFT OUTER JOIN Detalle_CtasXPagar ON CtasXPagar.intCtaXPagar_ID = Detalle_CtasXPagar.intCtaXPagar_ID
	WHERE Orden_Compra.bitCancelado = 0 AND Orden_Compra.intProveedor_ID BETWEEN @Proveedor_Ini AND @Proveedor_Fin
	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	      AND CtasXPagar.mnySaldo <> 0
	ORDER BY Orden_Compra.intProveedor_ID, Orden_Compra.dtmFecha, Orden_Compra.intOrdenCompra_ID

IF @TipoReporte = 'C'
	SELECT Orden_Compra.intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Orden_Compra.intOrdenCompra_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) AS dtmFecha, vchDescripcion, intCantidad, intCantidad_Recibida, intCantidad - intCantidad_Recibida as intDisponible, @TipoReporte AS TipoReporte FROM Orden_Compra
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	INNER JOIN Detalle_Orden_Compra ON Orden_Compra.intOrdenCompra_ID = Detalle_Orden_Compra.intOrdenCompra_ID
	INNER JOIN Productos ON Detalle_Orden_Compra.intProducto_ID = Productos.intProducto_ID
	WHERE Orden_Compra.bitCancelado = 0 AND Orden_Compra.intProveedor_ID BETWEEN @Proveedor_Ini AND @Proveedor_Fin
	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	      AND (intCantidad - intCantidad_Recibida) > 0
	ORDER BY Orden_Compra.intProveedor_ID, Orden_Compra.dtmFecha, Orden_Compra.intOrdenCompra_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCabFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ReporteCabFactura]
	@Factura_ID		int, 
	@NumeroLetra	varchar(8000),
	@Sello			varchar(2000),
	@NombreEmpresa	varchar(100),
	@bitCopia       bit
AS

BEGIN
	SET NOCOUNT ON;
	
	DECLARE @RegimenFiscal varchar(200)

--	SET @NumeroLetra = 'CIENTO VEINTICINCO MIL PESOS 02/100 M.N.'

	SELECT @RegimenFiscal = vchNombre FROM Regimen_Fiscales

	SELECT  @NombreEmpresa AS vchRazonSocial,
			DG.vchRFC,
			DG.vchDireccion,
			DG.vchNoExterior,
			DG.vchNoInterior,
			DG.vchColonia,
			DG.vchCodigoPostal,
			DG.vchTelefono,		
			DG.vchCiudad,
			DG.vchEstado,
			DG.vchPais,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(C.vchRazonSocial) <> '' THEN RTRIM(C.vchRazonSocial) ELSE RTRIM(C.vchApellidoPaterno) + ' ' + RTRIM(C.vchApellidoMaterno) + ' ' + RTRIM(C.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS vchNombre_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchRFC ELSE Facturar_Terceros.vchRFC END AS vchRFC_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchDireccion ELSE Facturar_Terceros.vchDireccion END AS vchDireccion_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchCiudad ELSE Facturar_Terceros.vchCiudad END AS vchCiudad_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchEstado ELSE Facturar_Terceros.vchEstado END AS vchEstado_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchCodigoPostal ELSE Facturar_Terceros.vchCodigoPostal END AS vchCodigoPostal_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchTelefono ELSE Facturar_Terceros.vchTelefono END AS vchTelefono_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchPais ELSE Facturar_Terceros.vchPais END AS vchPais_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchNoExterior ELSE Facturar_Terceros.vchNoExterior END AS vchNoExterior_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchNoInterior ELSE Facturar_Terceros.vchNoInterior END AS vchNoInterior_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN C.vchColonia ELSE Facturar_Terceros.vchColonia END AS vchColonia_Cliente,
			CONVERT(SMALLDATETIME,CONVERT(CHAR,Cab.dtmFecha_Registro,103),103) AS dtmFecha,
			dtmFecha_Registro,
			Cab.intFactura_ID,
			C.vchMetodoPago AS vchTipo_Pago,
			DF.vchNo_Serie_Certificado,
			Cab.mnySubTotal,
			CONVERT(DECIMAL,Cab.mnyPIVA) AS mnyPIVA,
			Cab.mnyIVA,
			Cab.mnyTotal,
			@Sello AS vchSello_Emisor,
			Cab.vchCadena_Original_CFDI,
			@NumeroLetra AS TotalLetra,
			Cab.vchSerie_Cert_SAT,
			Cab.dtmFecha_Timbrado,
			Cab.vchFolio_Fiscal,
			Cab.vchSello_SAT,
			Cab.vchSello_CFD,
			Cab.vchCadena_Original_CFDI,
			Cab.vchXML_Timbre,
			Cab.txtXML_CFDI,
			Cab.intCliente_ID,
			1.00 AS mnyTipo_Cambio,
			'MXN' AS vchMoneda,
			Facturas.vchObservaciones,
			C.intPlazo,
			CONVERT(SMALLDATETIME,CONVERT(CHAR,DATEADD(d,intPlazo,dtmFecha_Registro),103),103) AS vchFecha_Vencimiento,
			LTRIM(RTRIM(CONVERT(VARCHAR,DAY(dtmFecha_Registro)))) AS vchFact_Dia,
			dbo.fObtenerNombreMes(dtmFecha_Registro) AS vchFact_Mes,
			LTRIM(RTRIM(CONVERT(VARCHAR,YEAR(dtmFecha_Registro)))) AS vchFact_Anno,
			dbo.fObtenerNombreMes(DATEADD(d,intPlazo,dtmFecha_Registro)) AS vchVenc_Mes,
			Cab.bitCancelada,
			@bitCopia AS bitCopia,
			C.vchFormaPago AS vchMetodoPago,
			C.vchCuentaBancaria,
			C.vchBanco,
			@RegimenFiscal AS RegimenFiscal,
			SUBSTRING(Cab.vchSello_CFD,LEN(Cab.vchSello_CFD) - 8 + 1, 8) AS Ultimos_Sello,
			C.vchUso_CFDI
	FROM Cab_Ventas Cab
	INNER JOIN Clientes C ON Cab.intCliente_ID = C.intCliente_ID
	INNER JOIN Facturas ON Cab.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_ID =  Facturar_Terceros.intCliente_ID AND Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID, Parametros DG, Datos_FacturaElectronica DF
	WHERE Cab.intFactura_ID = @Factura_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCabNotaCredito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ReporteCabNotaCredito]
	@Nota_Credito_ID		int, 
	@Importe_Con_Letra	varchar(8000),
	@Sello			varchar(2000),
	@Empresa	varchar(100),
	@bitCopia   bit
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @RegimenFiscal varchar(200)
	
	SELECT @RegimenFiscal = vchNombre FROM Regimen_Fiscales

	SELECT 	@Empresa as vchRazonSocial,
			DG.vchRFC,
			DG.vchDireccion,
			DG.vchNoExterior,
			DG.vchNoInterior,
			DG.vchColonia,
			DG.vchCodigoPostal,
			DG.vchTelefono,		
			DG.vchCiudad,
			DG.vchEstado,
			DG.vchPais,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS vchNombre_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END AS vchRFC_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchDireccion ELSE Facturar_Terceros.vchDireccion END AS vchDireccion_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCiudad ELSE Facturar_Terceros.vchCiudad END AS vchCiudad_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchEstado ELSE Facturar_Terceros.vchEstado END AS vchEstado_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCodigoPostal ELSE Facturar_Terceros.vchCodigoPostal END AS vchCodigoPostal_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchTelefono ELSE Facturar_Terceros.vchTelefono END AS vchTelefono_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchPais ELSE Facturar_Terceros.vchPais END AS vchPais_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchNoExterior ELSE Facturar_Terceros.vchNoExterior END AS vchNoExterior_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchNoInterior ELSE Facturar_Terceros.vchNoInterior END AS vchNoInterior_Cliente,
			CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchColonia ELSE Facturar_Terceros.vchColonia END AS vchColonia_Cliente,
			CONVERT(SMALLDATETIME,CONVERT(CHAR,Cab.dtmFecha_Registro,103),103) AS dtmFecha,
			Cab.dtmFecha_Registro,
			Cab.intNota_Credito_ID,
--			Cab.vchTipo_Pago,
			'CONTADO' AS vchTipo_Pago,
			DF.vchNo_Serie_Certificado,
			Cab.mnySubTotal,
			CONVERT(DECIMAL,Cab.mnyPIVA) AS mnyPIVA,
			Cab.mnyIVA,
			Cab.mnyTotal,
			Notas_Credito.mnyImporte AS Importe_Factura, 
			@Sello AS vchSello_Emisor,
			Cab.vchCadena_Original_CFDI,
			@Importe_Con_Letra AS TotalLetra,
			Cab.vchSerie_Cert_SAT,
			Cab.dtmFecha_Timbrado,
			Cab.vchFolio_Fiscal,
			Cab.vchSello_SAT,
			Cab.vchSello_CFD,
			Cab.vchCadena_Original_CFDI,
			Cab.vchXML_Timbre,
			Cab.txtXML_CFDI,
			Cab.intCliente_ID,
			1.00 AS mnyTipo_Cambio,
			'MXN' AS vchMoneda,
			Notas_Credito.vchObservaciones,
			Clientes.intPlazo,
			LTRIM(RTRIM(CONVERT(VARCHAR,DAY(dtmFecha_Registro)))) AS vchNC_Dia,
			dbo.fObtenerNombreMes(dtmFecha_Registro) AS vchNC_Mes,
			LTRIM(RTRIM(CONVERT(VARCHAR,YEAR(dtmFecha_Registro)))) AS vchNC_Anno,
			Cab.bitCancelada,
			@bitCopia AS bitCopia,
			ISNULL(Clientes.vchMetodoPago,'No identificado') As vchMetodoPago,
			Clientes.vchCuentaBancaria,
			Clientes.vchBanco,
			@RegimenFiscal AS RegimenFiscal,
			Clientes.vchUso_CFDI,
			SUBSTRING(Cab.vchSello_CFD,LEN(Cab.vchSello_CFD) - 8 + 1, 8) AS Ultimos_Sello
	FROM Cab_Notas_Credito Cab
	INNER JOIN Notas_Credito ON Cab.intNota_Credito_ID = Notas_Credito.intNota_Credito_ID
	INNER JOIN Facturas ON Notas_Credito.intFactura_ID = Facturas.intFactura_ID
	LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_Tercero <> 0 AND Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID AND Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID, Parametros DG, Datos_FacturaElectronica DF
	WHERE Cab.intNota_Credito_ID = @Nota_Credito_ID

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCabPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteCabPago]
	@Pago_ID		int,
	@TotalLetra		varchar(1000),
	@Sello			varchar(4000),
	@NombreEmpresa	varchar(100),
	@bitCopia       bit
AS

BEGIN
	SET NOCOUNT ON;
	SET DATEFORMAT DMY

	DECLARE @PAC_ID int, @RegimenFiscal varchar(200)

	SELECT @RegimenFiscal = vchNombre FROM Regimen_Fiscales

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

	SELECT  @NombreEmpresa AS vchRazonSocial,
			DG.vchRFC,
			DG.vchDireccion,
			DG.vchNoExterior,
			DG.vchNoInterior,
			DG.vchColonia,
			DG.vchCodigoPostal,
			DG.vchTelefono,		
			DG.vchCiudad,
			DG.vchEstado,
			DG.vchPais,
			@RegimenFiscal AS RegimenFiscal,


			RTRIM(C.vchRazonSocial) AS vchNombre_Cliente,
			C.vchRFC AS vchRFC_Cliente,
			C.vchDireccion AS vchDireccion_Cliente,
			C.vchCiudad AS vchCiudad_Cliente,
			C.vchEstado AS vchEstado_Cliente,
			C.vchCodigoPostal AS vchCodigoPostal_Cliente,
			C.vchTelefono AS vchTelefono_Cliente,
			C.vchPais AS vchPais_Cliente,
			C.vchNoExterior AS vchNoExterior_Cliente,
			C.vchNoInterior AS vchNoInterior_Cliente,
			C.vchColonia AS vchColonia_Cliente,
			C.vchUso_CFDI,

			DF.vchNo_Serie_Certificado,

			P.vchClaveProdServ,
			P.mnyCantidad,
			P.vchDescripcion,
			P.vchUnidad,
			P.mnyPrecio,
			P.mnyImporte,

			CONVERT(SMALLDATETIME,CONVERT(CHAR,P.dtmFecha_Pago,103),103) AS dtmFechaPago,
			dtmFecha_Registro,
			P.intPago_ID AS intPago_ID,
			C.vchFormaPago,
			P.mnyTotal AS mnyTotalPagado,
			@TotalLetra,
			
			@Sello AS vchSello_Emisor,
			
			P.vchCadena_Original_CFDI,
			P.vchSerie_Cert_SAT,
			P.dtmFecha_Timbrado,
			P.vchFolio_Fiscal_UUID,
			P.vchSello_SAT,
			P.vchSello_CFD,
			P.vchCadena_Original_CFDI,
			P.vchXML_Timbre,
			P.txtXML_CFDI,
			P.vchVersion_Timbre,

			DP.intCliente_ID,
			P.vchNotas AS vchObservaciones,

			P.bitCancelada,
			@bitCopia AS bitCopia,
			SUBSTRING(P.vchRfcProvCertifSAT,LEN(P.vchRfcProvCertifSAT) - 8 + 1, 8) AS Ultimos_Sello

	FROM Cab_Pagos P
	INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFactura_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID) DP ON P.intPago_ID = DP.intPago_ID
	INNER JOIN Clientes C ON DP.intCliente_ID = C.intCliente_ID, Datos_FacturaElectronica DF, Parametros DG
	WHERE P.intPago_ID = @Pago_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCierreInventario]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteCierreInventario]
@Cierre_ID	int,
@Almacen_ID	int
AS

SELECT Detalle_Cierre_Inventario.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Orden_Compra.dtmFecha IS NULL THEN Deshueses.dtmFecha ELSE Orden_Compra.dtmFecha END ELSE Matanzas.dtmFecha END AS dtmFecha, Detalle_Cierre_Inventario.intCanalNo, intExistencia, Detalle_Cierre_Inventario.mnyPeso, Detalle_Cierre_Inventario.intOrdenCompra_ID FROM Detalle_Cierre_Inventario
INNER JOIN Productos ON Detalle_Cierre_Inventario.intProducto_ID = Productos.intProducto_ID
INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
LEFT OUTER JOIN Matanzas ON Detalle_Cierre_Inventario.intMatanza_ID = Matanzas.intMatanza_ID AND Detalle_Cierre_Inventario.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
LEFT OUTER JOIN Orden_Compra ON Detalle_Cierre_Inventario.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID
LEFT OUTER JOIN Deshueses ON (Detalle_Cierre_Inventario.intMatanza_ID * -1) = Deshueses.intDeshuese_ID
WHERE intCierre_ID = @Cierre_ID
      AND intAlmacen_ID = @Almacen_ID
ORDER BY Detalle_Cierre_Inventario.intProducto_ID, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Orden_Compra.dtmFecha IS NULL THEN Deshueses.dtmFecha ELSE Orden_Compra.dtmFecha END ELSE Matanzas.dtmFecha END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCierreInventarioXKilos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteCierreInventarioXKilos]
@Cierre_ID		int
AS

SET DATEFORMAT dmy

SELECT DCI.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, SUM(intExistencia) AS Existencia, SUM(mnyPeso) AS Kilos, mnyPrecio, SUM(mnyPeso) * mnyPrecio AS Importe  FROM Detalle_Cierre_Inventario DCI
INNER JOIN Productos ON DCI.intProducto_ID = Productos.intProducto_ID
INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
WHERE intCierre_ID = @Cierre_ID
GROUP BY DCI.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, mnyPrecio
HAVING SUM(intExistencia) > 0
ORDER BY DCI.intProducto_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteClientes]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ReporteClientes]
@Cliente_Ini      int,
@Cliente_Fin     int,
@Estatus                 char(1),
@Foraneo                char(1),
@Facturar	int = 2
AS

SET DATEFORMAT dmy

--SELECT *, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS NombreCompleto FROM Proveedores
SELECT * FROM Clientes
WHERE (bitActivo = 1 AND @Estatus = 'A' OR bitActivo = 0 AND @Estatus = 'I' OR bitActivo >= 0 AND @Estatus ='T')
      AND (bitForaneo = 1 AND @Foraneo = 'F' OR bitForaneo = 0 AND @Foraneo = 'L' OR @Foraneo = 'T')
      AND intCliente_ID BETWEEN @Cliente_INI AND @Cliente_Fin
      AND(bitFacturar = 1 AND @Facturar = 1 OR bitFacturar = 0 AND @Facturar = 0 OR @Facturar = 2)
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteComprasAnuales]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ReporteComprasAnuales]
@Proveedor_Ini 	int, 
@Proveedor_Fin 	int,
@Fecha_Ini                     smalldatetime,
@Fecha_Fin                   smalldatetime,
@TipoReporte                char(1)
AS

SET DATEFORMAT dmy

IF @TipoReporte = 'S'
	SELECT Orden_Compra.intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, SUM(CtasXPagar.mnyImporte)  AS mnyTotalComprado, @TipoReporte AS TipoReporte, NULL AS dtmFecha, 0 AS mnyImporte, 0 AS intOrdenCompra_ID, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')) AS Direccion, RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado) AS Cd_Edo FROM Orden_Compra
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	INNER JOIN CtasXPagar ON Orden_Compra.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	WHERE Orden_Compra.bitCancelado = 0 AND Orden_Compra.intProveedor_ID BETWEEN @Proveedor_Ini AND @Proveedor_Fin
	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	GROUP BY Orden_Compra.intProveedor_ID, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')), RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado)
	ORDER BY mnyTotalComprado DESC, Orden_Compra.intProveedor_ID
ELSE
	SELECT Orden_Compra.intProveedor_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Orden_Compra.intOrdenCompra_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) AS dtmFecha, CtasXPagar.mnyImporte, SUM(CtasXPagar.mnyImporte)  AS mnyTotalComprado, @TipoReporte AS TipoReporte, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')) AS Direccion, RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado) AS Cd_Edo FROM Orden_Compra
	INNER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
	INNER JOIN CtasXPagar ON Orden_Compra.intOrdenCompra_ID = CtasXPagar.intOrdenCompra_ID
	WHERE Orden_Compra.bitCancelado = 0 AND Orden_Compra.intProveedor_ID BETWEEN @Proveedor_Ini AND @Proveedor_Fin
	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Orden_Compra.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	GROUP BY Orden_Compra.intProveedor_ID, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre, Orden_Compra.intOrdenCompra_ID, Orden_Compra.dtmFecha, CtasXPagar.mnyImporte, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')), RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado)
	ORDER BY mnyTotalComprado DESC, Orden_Compra.intProveedor_ID, Orden_Compra.dtmFecha, Orden_Compra.intOrdenCompra_ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCuentasVencidas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteCuentasVencidas]
@TipoReporte		char(1)
AS

SET DATEFORMAT dmy

IF @TipoReporte = 'R'
	SELECT CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchNombreCliente, intPlazo, CtasXCobrar.dtmFecha, intRemisionNo AS intClave, CtasXCobrar.mnyImporte, CASE WHEN mnyAbonado = 0 THEN NULL ELSE mnyAbonado END AS mnyAbonado, CtasXCobrar.mnySaldo, @TipoReporte AS chrTipoReporte FROM CtasXCobrar
	LEFT OUTER JOIN Facturas ON CtasxCobrar.intFactura_ID = Facturas.intFactura_ID
	INNER JOIN Clientes ON CtasxCobrar.intCliente_ID = Clientes.intCliente_ID
	WHERE CtasXCobrar.mnySaldo > 0
	      AND DATEDIFF(day, CtasXCobrar.dtmFecha, GETDATE()) > intPlazo
	      AND (Facturas.intCliente_ID = 1000 OR Facturas.intCliente_ID IS NULL)
	ORDER BY 2, 4
ELSE
	SELECT CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS vchNombreCliente, intPlazo, dtmFecha, intFactura_ID AS intClave, mnyImporte, CASE WHEN mnyImporte - mnySaldo = 0 THEN NULL ELSE mnyImporte - mnySaldo END AS mnyAbonado, mnySaldo, @TipoReporte AS chrTipoReporte FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	WHERE mnySaldo > 0
	      AND DATEDIFF(day, dtmFecha, GETDATE()) > intPlazo
	      AND Facturas.intCliente_ID <> 1000
	ORDER BY 2, 4

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCuentasXCobrar]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Sp_ReporteCuentasXCobrar]
@Cliente_Ini 	int, 
@Cliente_Fin 	int,
@Fecha_ini      smalldatetime,
@Fecha_Fin      smalldatetime,
@TipoReporte	char(1),
@Almacen		int,
@Foraneo		int,
@IncluirPG		int,
@TipoCliente	char(1)
AS

SET DATEFORMAT dmy
SET NOCOUNT ON

--set @Fecha_ini = '01/01/2001'
--set @Fecha_Fin = '31/01/2010'

IF @TipoReporte = 'F'	SELECT Facturas.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Facturas.intFactura_ID AS intremisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.mnyImporte, ISNULL(Abonos.mnyAbonado,0) AS mnyAbonado, Facturas.mnyImporte - ISNULL(Abonos.mnyAbonado,0) - CASE WHEN Facturas.intCliente_ID <>  1000   THEN ISNULL(Notas_Credito.mnyImporte,0) ELSE 0 END AS mnySaldo, @TipoReporte As TipoReporte FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN (SELECT SUM(mnyImporte) AS mnyImporte, intFactura_ID FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 AND dtmFecha BETWEEN @Fecha_ini AND @Fecha_fin + '23:59' GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar
			         INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
			         WHERE intAlmacen_ID = @Almacen
				        AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
			         GROUP BY intFactura_ID
			       ) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
	WHERE Facturas.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	      AND (Facturas.intCliente_ID <>  1000 AND @IncluirPG = 0 OR @IncluirPG = 1)
	      AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
	      AND (Facturas.mnyImporte - ISNULL(Abonos.mnyAbonado,0)) <> 0
	      AND Facturas.bitCancelada = 0
	      AND (bitForaneo = @Foraneo AND  @Foraneo = 0 OR bitForaneo = @Foraneo AND  @Foraneo = 1 OR @Foraneo = 2)
	      AND (bitIncobrable = 1 AND @TipoCliente = 'I' OR bitIncobrable = 0 AND @TipoCliente = 'C' OR bitIncobrable >= 0 AND @TipoCliente = 'T')
	ORDER BY Facturas.intCliente_ID, Facturas.dtmFecha, Facturas.intFactura_ID

--	SELECT Facturas.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Facturas.intFactura_ID AS intremisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.mnyImporte, Abonos.mnyAbonado, Facturas.mnySaldo, @TipoReporte As TipoReporte FROM Facturas
--	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
--	INNER JOIN (SELECT intFactura_ID, SUM(mnyAbonado) AS mnyAbonado FROM CtasXCobrar
--		           WHERE intAlmacen_ID = @Almacen
--	                         GROUP BY intFactura_ID
--	                        ) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
--	WHERE Facturas.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
--	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
--	      AND Facturas.mnySaldo <> 0
--	ORDER BY Facturas.intCliente_ID, Facturas.dtmFecha, Facturas.intFactura_ID
ELSE
BEGIN
	CREATE TABLE #Abonos (
	intRemisionNo	int,
	mnyAbonado	money)

	INSERT INTO #Abonos
	SELECT intRemisionNo, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar
	 INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
	 INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND Facturas.bitCancelada = 0
	 WHERE intAlmacen_ID = @Almacen
	 AND CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) BETWEEN @Fecha_ini AND @Fecha_Fin + ' 23:59'
			 AND Facturas.intCliente_ID = 1000
	 GROUP BY intRemisionNo


	SELECT CtasXCobrar.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, CtasXCobrar.intRemisionNo AS intRemisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) AS dtmFecha, CtasXCobrar.mnyImporte, #Abonos.mnyAbonado, CtasXCobrar.mnyImporte - ISNULL(#Abonos.mnyAbonado,0) - ISNULL(Detalle_Notas_Credito.mnyImporte,0) AS mnySaldo, @TipoReporte As TipoReporte FROM CtasXCobrar
	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND Facturas.bitCancelada = 0
	INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	INNER JOIN Remisiones ON CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo AND CtasXCobrar.intAlmacen_ID = Remisiones.intAlmacen_ID
	LEFT OUTER JOIN (SELECT Det.*, NC.dtmFecha FROM Detalle_Notas_Credito Det INNER JOIN Notas_Credito NC ON Det.intNota_Credito_ID = NC.intNota_Credito_ID) Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo  AND bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0 AND Detalle_Notas_Credito.dtmFecha BETWEEN @Fecha_ini AND @Fecha_fin + '23:59'
	LEFT OUTER JOIN #Abonos ON CtasXCobrar.intRemisionNo = #Abonos.intRemisionNo
--	LEFT OUTER JOIN (SELECT intRemisionNo, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar
--			         INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
--			         INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND Facturas.bitCancelada = 0
--			         WHERE intAlmacen_ID = @Almacen
--				 AND CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
--				 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Detalle_CtasXCobrar.dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
--                    			 AND Facturas.intCliente_ID = 1000
--			         GROUP BY intRemisionNo
--			       ) Abonos ON CtasXCobrar.intRemisionNo = Abonos.intRemisionNo
	WHERE CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
	      AND  CtasXCobrar.intAlmacen_ID = @Almacen
	      AND (Remisiones.bitFacturado = 1 AND Facturas.dtmFecha <= @Fecha_Fin + '23:59')
	      AND (CtasXCobrar.mnyImporte - ISNULL(#Abonos.mnyAbonado,0)) <> 0
                    AND Facturas.intCliente_ID = 1000
	      AND (bitForaneo = @Foraneo AND  @Foraneo = 0 OR bitForaneo = @Foraneo AND  @Foraneo = 1 OR @Foraneo = 2)
	      AND (bitIncobrable = 1 AND @TipoCliente = 'I' OR bitIncobrable = 0 AND @TipoCliente = 'C' OR bitIncobrable >= 0 AND @TipoCliente = 'T')
	ORDER BY CtasXCobrar.intCliente_ID, CtasXCobrar.dtmFecha, CtasXCobrar.intRemisionNo
END

--	SELECT CtasXCobrar.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, CtasXCobrar.intRemisionNo, CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) AS dtmFecha, CtasXCobrar.mnyImporte, CtasXCobrar.mnyAbonado, CtasXCobrar.mnySaldo, @TipoReporte As TipoReporte FROM CtasXCobrar
--	INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
--	INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID AND CtasXCobrar.intCliente_ID <> Facturas.intCliente_ID
--	INNER JOIN Remisiones ON CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo AND CtasXCobrar.intAlmacen_ID = Remisiones.intAlmacen_ID
--	WHERE CtasXCobrar.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
--	      AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
----                    AND Facturas.intCliente_ID = 1000
--	      AND  CtasXCobrar.intAlmacen_ID = @Almacen
--	      AND CtasXCobrar.mnySaldo <> 0
--	      AND Remisiones.bitFacturado = 1
--	ORDER BY CtasXCobrar.intCliente_ID, CtasXCobrar.dtmFecha, CtasXCobrar.intRemisionNo

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetalleInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteDetalleInvFisico]
@InvFisico_ID		int
AS

SET DATEFORMAT dmy

SELECT Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, mnyPeso, dtmFecha, dtmFecha_Aplicado, vchUsuario, @InvFisico_ID AS InvFisico_ID FROM Detalle_Inventario_Fisico
INNER JOIN Inventario_Fisico ON Detalle_Inventario_Fisico.intInventario_ID = Inventario_Fisico.intInventario_ID
INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
WHERE Detalle_Inventario_Fisico.intInventario_ID = @InvFisico_ID
ORDER BY Detalle_Inventario_Fisico.intProducto_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteDetFactura]
	@Factura_ID		int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  intRenglon,
			ISNULL(intCodigo,1) AS intCodigo,
			mnyCantidad, 
			CASE WHEN CB.vchDescripcion <> '' THEN CB.vchDescripcion ELSE vchProducto END + CASE WHEN C.vchAddenda <> '' THEN ' ( ' + RTRIM(LTRIM(CONVERT(VARCHAR,intNo_Cajas))) + ' Cajas )' ELSE '' END AS vchProducto, 
			mnyPeso,
			mnyPrecio AS mnyPrecio, 
			Det_Ventas.mnyImporte,
			vchUnidad
	FROM Det_Ventas
	INNER JOIN Facturas ON Det_Ventas.intFactura_ID = Facturas.intFactura_ID
	INNER JOIN Clientes C ON Facturas.intCliente_ID = C.intCliente_ID
	LEFT OUTER JOIN CodigoBarras_Proveedor CB ON Det_Ventas.vchCodigo_Barras = CB.vchCodigobarras_Proveedor
	WHERE Det_Ventas.intFactura_ID = @Factura_ID

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetNotaCredito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ReporteDetNotaCredito]
	@Nota_Credito_ID		int
AS

BEGIN
	SET NOCOUNT ON;

	SELECT 	intRenglon,
			Det.intNota_Credito_ID,
			CASE WHEN Det.intRemisionNo = 0 THEN Det.intFactura_ID ELSE intRemisionNo END AS intFactura_ID,
			Det.vchNotas AS vchProducto, 
			CASE WHEN Det.intRemisionNo = 0 THEN 'Factura No.' ELSE 'Remision No.' END AS TipoDoc,
			CONVERT(MONEY,1) AS mnyCantidad,
			Det.mnyImporte AS mnyPrecio, 
			Det.mnyImporte AS mnyImporte,
			Det.mnyImporte AS mnyTotal
	FROM Det_Notas_Credito Det
	WHERE Det.intNota_Credito_ID = @Nota_Credito_ID

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetPago]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteDetPago]
	@Folio_ID		int
AS

BEGIN
	SET NOCOUNT ON;
	
	SELECT  ROW_NUMBER() OVER(ORDER BY V.vchFolio_Fiscal ASC) AS Renglon,
			ISNULL(V.vchFolio_Fiscal,'') AS UUID,
			CONVERT(VARCHAR,P.intFactura_ID) + 'P' AS Folio, 
			C.vchMetodoPago AS Metodo, 
			P.mnySaldo_Anterior AS Saldo_Anterior, 
			P.mnySaldo_Pendiente AS Saldo_Pendiente,
			P.mnyMonto_Pagado AS Monto_pagado,
			V.mnyTotal AS Total,
			1 AS Orden 
	FROM Det_Pagos P
	LEFT OUTER JOIN Cab_Ventas V ON P.intFactura_ID = V.intFactura_ID
	LEFT OUTER JOIN Clientes C ON V.intCliente_ID = C.intCliente_ID
	WHERE P.intPago_ID = @Folio_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDiferenciasInvFisico]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteDiferenciasInvFisico]
@InvFisico	int
AS

SET DATEFORMAT dmy

IF (SELECT bitAplicado FROM Inventario_Fisico WHERE intInventario_ID = @InvFisico) = 0
	SELECT Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, ISNULL(Existencias.intExistencia,0) AS intExistencia, COUNT(Detalle_Inventario_Fisico.intProducto_ID) AS InvFisico, COUNT(Detalle_Inventario_Fisico.intProducto_ID) - ISNULL(Existencias.intExistencia,0) AS Diferencia, dtmFecha, dtmFecha_Aplicado, vchUsuario, @InvFisico AS InvFisico_ID FROM Detalle_Inventario_Fisico
	INNER JOIN Inventario_Fisico ON Detalle_Inventario_Fisico.intInventario_ID = Inventario_Fisico.intInventario_ID
	INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
	INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS intExistencia FROM Existencias GROUP BY intProducto_ID) Existencias ON Detalle_Inventario_Fisico.intProducto_ID = Existencias.intProducto_ID
	WHERE Detalle_Inventario_Fisico.intInventario_ID = @InvFisico
	GROUP BY Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, Existencias.intExistencia, dtmFecha, dtmFecha_Aplicado, vchUsuario
	ORDER BY Detalle_Inventario_Fisico.intProducto_ID
ELSE
	SELECT Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, ISNULL(Existencias.intExistencia,0) AS intExistencia, COUNT(Detalle_Inventario_Fisico.intProducto_ID) AS InvFisico, COUNT(Detalle_Inventario_Fisico.intProducto_ID) - ISNULL(Existencias.intExistencia,0)  AS Diferencia, dtmFecha, dtmFecha_Aplicado, vchUsuario, @InvFisico AS InvFisico_ID FROM Detalle_Inventario_Fisico
	INNER JOIN Inventario_Fisico ON Detalle_Inventario_Fisico.intInventario_ID = Inventario_Fisico.intInventario_ID
	INNER JOIN Usuarios ON Inventario_Fisico.intUsuario_ID = Usuarios.intUsuario_ID
	INNER JOIN Productos ON Detalle_Inventario_Fisico.intProducto_ID = Productos.intProducto_ID
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS intExistencia FROM Inventario_Fisico_Existencias WHERE intInventario_ID = @InvFisico GROUP BY intProducto_ID) Existencias ON Detalle_Inventario_Fisico.intProducto_ID = Existencias.intProducto_ID
	WHERE Detalle_Inventario_Fisico.intInventario_ID = @InvFisico
	GROUP BY Detalle_Inventario_Fisico.intProducto_ID, Productos.vchDescripcion, vchNombreCorto, Existencias.intExistencia, dtmFecha, dtmFecha_Aplicado, vchUsuario
	ORDER BY Detalle_Inventario_Fisico.intProducto_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteEstadoCuenta]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteEstadoCuenta]
@Cliente	int,
@Fecha_Ini	datetime,
@Fecha_Fin	datetime,
@TipoReporte  char(1)
AS

SET DATEFORMAT dmy
SET NOCOUNT ON

--SET @Cliente = 36
--SET @Fecha_Ini = '22/07/2010'
--SET @Fecha_Fin = '26/10/2010'
--SET @TipoReporte = 'F'

CREATE TABLE #Movimientos (
dtmFecha     smalldatetime,
intRemision  int,
mnyCargos    money,
mnyAbonos    money,
mnySaldo     money)

DECLARE @Saldo_Anterior money, @Saldo_Nuevo money, @dtmFecha smalldatetime, @intRemision varchar(10), @Cargo money, @Abono money, @Saldo_Diario money

IF @TipoReporte = 'R'
BEGIN
	SET @Saldo_Anterior = ISNULL((SELECT SUM(ISNULL(CtasXCobrar.mnyImporte,0) - (ISNULL(Abonos.mnyAbonado,0) +  ISNULL(Detalle_Notas_Credito.mnyImporte,0))) AS mnySaldo FROM CtasXCobrar
				      LEFT OUTER JOIN (SELECT intCtaXCobrar_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < @Fecha_Ini GROUP BY intCtaXCobrar_ID) Abonos ON CtasXCobrar.intCtaXCobrar_ID = Abonos.intCtaXCobrar_ID
				      LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
				      LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
				      WHERE CtasXCobrar.intCliente_ID = @Cliente
				        AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) < @Fecha_Ini
                                                             AND Facturas.intCliente_ID = 1000),0)
	
	SET @Saldo_Nuevo = ISNULL((SELECT SUM(ISNULL(CtasXCobrar.mnyImporte,0) - (ISNULL(Abonos.mnyAbonado,0) +  ISNULL(Detalle_Notas_Credito.mnyImporte,0))) AS mnySaldo FROM CtasXCobrar
				      LEFT OUTER JOIN (SELECT intCtaXCobrar_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < DATEADD(day,1,@Fecha_Fin) GROUP BY intCtaXCobrar_ID) Abonos ON CtasXCobrar.intCtaXCobrar_ID = Abonos.intCtaXCobrar_ID
				      LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
				      LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
				      WHERE CtasXCobrar.intCliente_ID = @Cliente
				        AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) < DATEADD(day,1,@Fecha_Fin)
                                                             AND Facturas.intCliente_ID = 1000),0)
	
	SET @Saldo_Diario = @Saldo_Anterior
	
	INSERT INTO #Movimientos (mnySaldo) VALUES (@Saldo_Anterior)
	
	DECLARE Movimientos_Cursor CURSOR FOR
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) AS dtmFecha, CtasXCobrar.intRemisionNo AS intRemisionNo, CtasXCobrar.mnyImporte - ISNULL(Detalle_Notas_Credito.mnyImporte,0), 0 AS Abonado FROM CtasXCobrar
		LEFT OUTER JOIN Detalle_Notas_Credito ON CtasXCobrar.intRemisionNo = Detalle_Notas_Credito.intRemisionNo AND Detalle_Notas_Credito.bitAplicada = 0 AND Detalle_Notas_Credito.bitCancelada = 0
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		WHERE CtasXCobrar.intCliente_ID = @Cliente
                                 AND Facturas.intCliente_ID = 1000
		       AND CONVERT(SMALLDATETIME,CONVERT(CHAR,CtasXCobrar.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		
		UNION
		
		SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103), CtasXCobrar.intRemisionNo AS intRemisionNo, 0, ISNULL(SUM(mnyAbono),0) AS mnyAbonado FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		       AND CtasXCobrar.intCliente_ID = @Cliente
                                 AND Facturas.intCliente_ID = 1000
		GROUP BY intRemisionNo, dtmFecha_Abono
        HAVING ISNULL(SUM(mnyAbono),0) > 0
		
		ORDER BY dtmFecha, intRemisionNo
END
ELSE
BEGIN
	SET @Saldo_Anterior = ISNULL((SELECT SUM((Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - (ISNULL(mnyAbonado,0) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - ISNULL(Notas_Credito.mnyImporte,0)) FROM Facturas
				              LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar 
				                                               LEFT OUTER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
				                                               WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < @Fecha_Ini
				                                               GROUP BY intFactura_ID) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
							LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
				              WHERE Facturas.intCliente_ID = @Cliente
				                  AND Facturas.bitCancelada = 0
				                  AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) < @Fecha_Ini),0)
	
	SET @Saldo_Nuevo = ISNULL((SELECT SUM((Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - (ISNULL(mnyAbonado,0) + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - ISNULL(Notas_Credito.mnyImporte,0)) FROM Facturas
				              LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyAbono) AS mnyAbonado FROM Detalle_CtasXCobrar 
				                                               LEFT OUTER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
				                                               WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) < DATEADD(day,1,@Fecha_Fin)
				                                               GROUP BY intFactura_ID) Abonos ON Facturas.intFactura_ID = Abonos.intFactura_ID
					LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
				              WHERE Facturas.intCliente_ID = @Cliente
				                  AND Facturas.bitCancelada = 0
				                  AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) < DATEADD(day,1,@Fecha_Fin)),0)
	
	SET @Saldo_Diario = @Saldo_Anterior

	INSERT INTO #Movimientos (mnySaldo) VALUES (@Saldo_Anterior)
	
	DECLARE Movimientos_Cursor CURSOR FOR
		SELECT CONVERT(SMALLDATETIME,CONVERT(VARCHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.intFactura_ID, (Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - ISNULL(Notas_Credito.mnyImporte,0), 0 AS Abonado FROM Facturas
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitAplicada = 0 AND bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
		WHERE Facturas.intCliente_ID = @Cliente
	                    AND Facturas.bitCancelada = 0
		      AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		
		UNION
		
		SELECT CASE WHEN dtmFecha_Abono IS NULL THEN CONVERT(SMALLDATETIME,CONVERT(VARCHAR,Facturas.dtmFecha,103),103) ELSE CONVERT(SMALLDATETIME,CONVERT(VARCHAR,dtmFecha_Abono,103),103) END, Facturas.intFactura_ID, 0, ISNULL(SUM(mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)),0) - ISNULL(NC.mnyImporte,0) AS mnyAbonado FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
		LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID 
		LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitCancelada = 0 GROUP BY intFactura_ID) NC ON CtasXCobrar.intFactura_ID = NC.intFactura_ID
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
		      AND Facturas.intCliente_ID = @Cliente
		      AND Facturas.bitCancelada = 0
		GROUP BY Facturas.intFactura_ID, CASE WHEN dtmFecha_Abono IS NULL THEN CONVERT(SMALLDATETIME,CONVERT(VARCHAR,Facturas.dtmFecha,103),103) ELSE CONVERT(SMALLDATETIME,CONVERT(VARCHAR,dtmFecha_Abono,103),103) END, NC.mnyImporte
		HAVING ISNULL(SUM(mnyAbono),0) > 0
	
		ORDER BY dtmFecha, Facturas.intFactura_ID
END

OPEN Movimientos_Cursor

FETCH NEXT FROM Movimientos_Cursor INTO @dtmFecha, @intRemision, @Cargo, @Abono

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Saldo_Diario = @Saldo_Diario + @Cargo - @Abono

	INSERT INTO #Movimientos (dtmFecha, intRemision, mnyCargos, mnyAbonos, mnySaldo) VALUES (@dtmFecha, @intRemision, @Cargo, @Abono, @Saldo_Diario)

	FETCH NEXT FROM Movimientos_Cursor INTO @dtmFecha, @intRemision, @Cargo, @Abono
END

INSERT INTO #Movimientos (mnySaldo) VALUES (@Saldo_Nuevo)

CLOSE Movimientos_Cursor
DEALLOCATE Movimientos_Cursor

SELECT *, @Saldo_Anterior AS Saldo_Ini, @Saldo_Nuevo AS Saldo_Fin, @TipoReporte AS TipoReporte FROM #Movimientos

DROP TABLE #Movimientos

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteFactura]
@Factura_ID		int,
@Importe_Con_Letra	varchar(300)
AS

SET DATEFORMAT dmy

SELECT  0 AS Orden,
	SUM(CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Cantidad ELSE Agrupacion.bitFacturacion_Cantidad END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.intCantidad ELSE 0 END) AS Cantidad,
	NULL AS Codigo, 
	CASE WHEN intAgrupacion_ID IS NULL  OR (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) AND (Movimientos.intTipoVicera_ID = 0 OR Productos.intNoPiezas = 0) THEN Productos.vchDEscripcion ELSE Agrupacion.vchDescripcion END AS Producto, 
--	CASE WHEN intAgrupacion_ID IS NULL  OR (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Productos.vchDEscripcion ELSE Agrupacion.vchDescripcion END AS Producto, 
	CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Precio ELSE Agrupacion.bitFacturacion_Precio END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.mnyPrecio ELSE NULL END AS Precio,
	SUM(CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Peso ELSE Agrupacion.bitFacturacion_Peso END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.mnyPeso * CASE WHEN intCantidad_Multiplicar = 0 THEN CASE WHEN Productos.chrClasificacion = 'K' THEN Movimientos.intCantidad ELSE 1 END ELSE intCantidad_Multiplicar END ELSE 0 END) AS Peso,
	SUM(ISNULL(Movimientos.mnyImporte,0)) AS Importe,
	@Importe_Con_Letra AS Importe_Letra,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS vchNombre,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END AS vchRFC,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchDireccion ELSE Facturar_Terceros.vchDireccion END AS vchDireccion,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCiudad ELSE Facturar_Terceros.vchCiudad END AS vchCiudad,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchEstado ELSE Facturar_Terceros.vchEstado END AS vchEstado,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCodigoPostal ELSE Facturar_Terceros.vchCodigoPostal END AS vchCodigoPostal,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchTelefono ELSE Facturar_Terceros.vchTelefono END AS vchTelefono,
	Facturas.intFactura_ID,
	Facturas.dtmFecha,
	Facturas.vchObservaciones
FROM Facturas
INNER JOIN Detalle_Facturas ON Facturas.intFactura_ID = Detalle_Facturas.intFactura_ID
INNER JOIN Movimientos ON Detalle_Facturas.intRemisionNo = Movimientos.intRemisionNo AND bitTiene_Devolucion = 0 AND chrOperacion = 'S'
INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN Agrupacion_Productos_Facturacion ON Movimientos.intProducto_ID = Agrupacion_Productos_Facturacion.intProducto_ID
LEFT OUTER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
LEFT OUTER JOIN Productos Agrupacion ON intAgrupacion_ID = Agrupacion.intProducto_ID
LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_ID =  Facturar_Terceros.intCliente_ID AND Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID 
WHERE Facturas.intFactura_Id = @Factura_ID	
GROUP BY CASE WHEN intAgrupacion_ID IS NULL AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.intProducto_ID ELSE intAgrupacion_ID END, 
	        CASE WHEN intAgrupacion_ID IS NULL  OR (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) AND (Movimientos.intTipoVicera_ID = 0 OR Productos.intNoPiezas = 0) THEN Productos.vchDEscripcion ELSE Agrupacion.vchDescripcion END, 
	        CASE WHEN CASE WHEN intAgrupacion_ID IS NULL THEN Productos.bitFacturacion_Precio ELSE Agrupacion.bitFacturacion_Precio END = 1 AND (Facturas.intCliente_ID <> 1000 AND Facturas.intCliente_ID <> 359) THEN Movimientos.mnyPrecio ELSE NULL END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchDireccion ELSE Facturar_Terceros.vchDireccion END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCiudad ELSE Facturar_Terceros.vchCiudad END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchEstado ELSE Facturar_Terceros.vchEstado END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCodigoPostal ELSE Facturar_Terceros.vchCodigoPostal END,
	        CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchTelefono ELSE Facturar_Terceros.vchTelefono END,
	       Facturas.intFactura_ID,
	       Facturas.dtmFecha,
	       Facturas.vchObservaciones

UNION

SELECT  1 AS Orden,
	0 AS Cantidad,
	NULL AS Codigo, 
	CASE WHEN SUM(ISNULL(Movimientos.mnyFlete,0)) > 0 THEN 'FLETE' ELSE '' END AS Producto, 
	0 AS Precio,
	0 AS Peso,
	SUM(ISNULL(Movimientos.mnyFlete,0)) AS Importe,
	@Importe_Con_Letra AS Importe_Letra,
	'' AS vchNombre,
	'' AS vchRFC,
	'' AS vchDireccion,
	'' AS vchCiudad,
	'' AS vchEstado,
	'' AS vchCodigoPostal,
	'' AS vchTelefono,
	0,
	NULL,
	NULL
FROM Facturas
INNER JOIN Detalle_Facturas ON Facturas.intFactura_ID = Detalle_Facturas.intFactura_ID
INNER JOIN Movimientos ON Detalle_Facturas.intRemisionNo = Movimientos.intRemisionNo AND bitTiene_Devolucion = 0 AND chrOperacion = 'S'
WHERE Facturas.intFactura_Id = @Factura_ID	
ORDER BY 1,4

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteInventarioDetallado]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteInventarioDetallado]
@Producto_Ini		int,
@Producto_Fin		int,
@Almacen_ID		int,
@TipoReporte		int,
@Fecha_Fin		datetime
AS

SET DATEFORMAT dmy

DECLARE @Fecha_Ini varchar(10), @Fecha_Inventario smalldatetime

SET @Fecha_Ini = '31/07/2007'
SET @Fecha_Inventario = (SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,MAX(dtmFecha),103),103) AS dtmFecha FROM Inventario_Fisico WHERE bitAplicado = 1)

IF @TipoReporte = 1	--  Inventario Detallado
	SELECT Productos.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, Existencia, intExistencia, Existencias.intOrdenCompra_ID, Existencias.intCanalNo, Existencias.mnyPeso, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Deshuese_Matanza.dtmFecha IS NULL THEN CONVERT(SMALLDATETIME, @Fecha_Inventario) ELSE Deshuese_Matanza.dtmFecha END ELSE Matanzas.dtmFecha END AS dtmFecha FROM Productos
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN Existencias ON Productos.intProducto_ID = Existencias.intProducto_ID AND Existencias.intAlmacen_ID = @Almacen_ID
	LEFT OUTER JOIN (SELECT SUM(intExistencia) AS Existencia, intProducto_ID, intAlmacen_ID FROM Existencias WHERE intAlmacen_ID = @Almacen_ID GROUP BY intProducto_ID, intAlmacen_ID) Existencia_Total ON Productos.intProducto_ID = Existencia_Total.intProducto_ID AND Existencias.intAlmacen_ID = Existencia_Total.intAlmacen_ID
	LEFT OUTER JOIN (SELECT intDeshuese_ID, intMatanza_ID, intOrdenCompra_ID, intProducto_ID FROM Detalle_Deshueses GROUP BY intDeshuese_ID, intMatanza_ID, intOrdenCompra_ID, intProducto_ID) Detalle_Deshueses ON (CASE WHEN Existencias.intMatanza_ID < 0 THEN -1 ELSE 1 END * Existencias.intMatanza_ID) = intDeshuese_ID AND Productos.intProducto_ID = Detalle_Deshueses.intProducto_ID --AND Existencias.intOrdenCompra_ID = Detalle_Deshueses.intOrdenCompra_ID AND Existencias.intCanalNo = Detalle_Deshueses.intCanalNo
	LEFT OUTER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID AND Existencias.intOrdenCompra_ID = Matanzas.intOrdenCompra_ID
	LEFT OUTER JOIN Matanzas Deshuese_Matanza ON Detalle_Deshueses.intMatanza_ID = Deshuese_Matanza.intMatanza_ID AND Detalle_Deshueses.intOrdenCompra_ID = Deshuese_Matanza.intOrdenCompra_ID
	WHERE Productos.intProducto_ID BETWEEN @Producto_Ini AND @Producto_Fin
	      AND Existencias.intAlmacen_ID = @Almacen_ID
	      AND Existencia > 0
	      AND CASE WHEN Matanzas.dtmFecha IS NULL THEN CONVERT(SMALLDATETIME, @Fecha_Ini) ELSE Matanzas.dtmFecha END <= @Fecha_Fin + '23:59'
--	GROUP BY Productos.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, Existencia, intExistencia, Existencias.intOrdenCompra_ID, Existencias.intCanalNo, Existencias.mnyPeso, CASE WHEN Matanzas.dtmFecha IS NULL THEN CASE WHEN Deshuese_Matanza.dtmFecha IS NULL THEN CONVERT(SMALLDATETIME, @Fecha_Inventario) ELSE Deshuese_Matanza.dtmFecha END ELSE Matanzas.dtmFecha END
	ORDER BY Productos.intProducto_ID

IF @TipoReporte = 2	--  Inventario X Kilos
	SELECT Productos.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, Existencia, SUM(mnyPeso) AS Kilos, mnyPrecio, SUM(mnyPeso) * mnyPrecio AS Importe  FROM Productos
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN Existencias ON Productos.intProducto_ID = Existencias.intProducto_ID AND Existencias.intAlmacen_ID = @Almacen_ID
	LEFT OUTER JOIN (SELECT SUM(intExistencia) AS Existencia, intProducto_ID, intAlmacen_ID FROM Existencias WHERE intAlmacen_ID = @Almacen_ID GROUP BY intProducto_ID, intAlmacen_ID) Existencia_Total ON Productos.intProducto_ID = Existencia_Total.intProducto_ID AND Existencias.intAlmacen_ID = Existencia_Total.intAlmacen_ID
	WHERE Productos.intProducto_ID BETWEEN @Producto_Ini AND @Producto_Fin
	       AND Existencias.intAlmacen_ID = @Almacen_ID
	       AND Existencia > 0
	GROUP BY Productos.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, Existencia, mnyPrecio
	ORDER BY Productos.intProducto_ID

IF @TipoReporte = 3	--  Inventario
	SELECT Productos.intProducto_ID, Productos.vchDescripcion, Unidad_Medida.vchNombreCorto, Existencia FROM Productos
	INNER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	LEFT OUTER JOIN (SELECT SUM(intExistencia) AS Existencia, Existencias.intProducto_ID, intAlmacen_ID FROM Existencias 
			         LEFT OUTER JOIN Matanzas ON Existencias.intMatanza_ID = Matanzas.intMatanza_ID
			         WHERE intAlmacen_ID = @Almacen_ID AND CASE WHEN Matanzas.dtmFecha IS NULL THEN CONVERT(DATETIME, @Fecha_Ini) ELSE Matanzas.dtmFecha END <= @Fecha_Fin + '23:59'
			         GROUP BY Existencias.intProducto_ID, intAlmacen_ID) Existencia_Total ON Productos.intProducto_ID = Existencia_Total.intProducto_ID AND Existencia_Total.intAlmacen_ID = @Almacen_ID
	WHERE Productos.intProducto_ID BETWEEN @Producto_Ini AND @Producto_Fin
	       AND Existencia_Total.intAlmacen_ID = @Almacen_ID
	       AND Existencia > 0
	ORDER BY Productos.intProducto_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteNotaCredito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ReporteNotaCredito]
@Nota_Credito		int,
@Importe_Con_Letra	varchar(300)
AS

SET DATEFORMAT dmy

SELECT intNota_Credito_ID, 
	Notas_Credito.intFactura_ID, 
	Facturas.mnyImporte, 
	Notas_Credito.vchObservaciones, 
	Notas_Credito.mnyImporte AS mnyDescuento, 
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS vchNombre,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchRFC ELSE Facturar_Terceros.vchRFC END AS vchRFC,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchDireccion ELSE Facturar_Terceros.vchDireccion END AS vchDireccion,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCiudad ELSE Facturar_Terceros.vchCiudad END AS vchCiudad,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchEstado ELSE Facturar_Terceros.vchEstado END AS vchEstado,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchCodigoPostal ELSE Facturar_Terceros.vchCodigoPostal END AS vchCodigoPostal,
	CASE WHEN Facturas.intCliente_Tercero = 0 THEN Clientes.vchTelefono ELSE Facturar_Terceros.vchTelefono END AS vchTelefono,
	@Importe_Con_Letra AS Importe_Letra,
	Notas_Credito.dtmFecha
FROM Notas_Credito
INNER JOIN Facturas ON Notas_Credito.intFactura_ID = Facturas.intFactura_ID
LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID AND Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID
WHERE intNota_Credito_ID = @Nota_Credito
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteNotasCredito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteNotasCredito]
@Fecha_Ini	datetime,--char(30),
@Fecha_Fin	datetime--char(30)
AS

SET DATEFORMAT dmy

SELECT Notas_Credito.dtmFecha, intNota_Credito_ID, Notas_Credito.intFactura_ID, Notas_Credito.mnyImporte, Notas_Credito.vchObservaciones, Notas_Credito.bitCancelada, bitAplicada, CASE WHEN Notas_Credito.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS Cliente FROM Notas_Credito
INNER JOIN Facturas ON Notas_Credito.intFactura_ID = Facturas.intFactura_ID
LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_ID = Facturar_Terceros.intCliente_ID AND Notas_Credito.intCliente_Tercero = Facturar_Terceros.intCliente_Tercero_ID
WHERE Notas_Credito.dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
      AND Notas_Credito.bitCancelada = 0
ORDER BY Notas_Credito.dtmFecha, intNota_Credito_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteNotasVentaXFactura]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteNotasVentaXFactura]
@Factura_ID	int
AS

SET DATEFORMAT dmy

SELECT Detalle_Facturas.intFactura_ID, Facturas.dtmFecha AS Fecha_Factura, Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS Importe_Factura, Detalle_Facturas.intRemisionNo, Remisiones.dtmFecha AS Fecha_NotaVenta, Remisiones.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS Importe_NotaVenta, CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END AS Cliente, CASE WHEN RTRIM(Cliente_Factura.vchRazonSocial) <> '' THEN RTRIM(Cliente_Factura.vchRazonSocial) ELSE RTRIM(Cliente_Factura.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Factura.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Factura.vchNombre) END AS Cliente_Factura FROM Detalle_Facturas
INNER JOIN Facturas ON Detalle_Facturas.intFactura_ID = Facturas.intFactura_ID
INNER JOIN Remisiones ON Detalle_Facturas.intRemisionNo = Remisiones.intRemisionNo
INNER JOIN Clientes On Remisiones.intCliente_ID = Clientes.intCliente_ID
INNER JOIN Clientes Cliente_Factura On Facturas.intCliente_ID = Cliente_Factura.intCliente_ID
WHERE Detalle_Facturas.intFactura_ID = @Factura_ID
ORDER BY Detalle_Facturas.intRemisionNo
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReportePolizas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReportePolizas]
@Fecha		datetime,
@TipoPoliza	char(1),
@Almacen_ID	int
AS

SET DATEFORMAT dmy

DECLARE @Total_Ventas_Contado money, @Total_Ventas_Credito money, @Total_Ventas_IVA money, @Cliente int, @Factura int, @Facturas varchar(100), @Cliente_Ant int, @Abono money, @Total_Abono money, @Total_Cliente money, @dtmFecha DATETIME, @Cliente_3ro int, @Cliente_3ro_Ant int, @Sumas_Iguales money

--SET @dtmFecha = CONVERT(SMALLDATETIME,@Fecha,103)
SET @dtmFecha = @Fecha

CREATE TABLE #Facturas(
intCliente_ID	int,
vchFacturas	varchar(100),
mnyAbono         money,
intCliente_3ro   int)

IF @TipoPoliza = 'D'
BEGIN
--	SET @Total_Ventas = ISNULL((SELECT SUM(Facturas.mnyImporte - ISNULL(Notas_Credito.mnyImporte,0)) FROM Facturas LEFT OUTER JOIN Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0WHERE Facturas.bitCancelada = 0 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) = @Fecha),0)
	SET @Total_Ventas_Contado = ISNULL((SELECT SUM(Facturas.mnyImporte - Cab.mnyIVA) FROM Facturas 
										INNER JOIN Cab_Ventas Cab ON Facturas.intFactura_ID = Cab.intFactura_ID
										LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte, bitCancelada FROM Notas_Credito GROUP BY intFactura_ID, bitCancelada) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0 
										WHERE intTipoPago = 2 AND Facturas.bitCancelada = 0 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) = @Fecha),0)
	SET @Total_Ventas_Credito = ISNULL((SELECT SUM(Facturas.mnyImporte - Cab.mnyIVA) FROM Facturas 
										INNER JOIN Cab_Ventas Cab ON Facturas.intFactura_ID = Cab.intFactura_ID
										LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte, bitCancelada FROM Notas_Credito GROUP BY intFactura_ID, bitCancelada) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0 
										WHERE intTipoPago = 1 AND Facturas.bitCancelada = 0 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) = @Fecha),0)

	SET @Total_Ventas_IVA = ISNULL((SELECT SUM(mnyIVA) FROM Cab_Ventas WHERE bitCancelada = 0 AND CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Registro,103),103) = @Fecha),0)

	DECLARE Facturas_Cursor CURSOR FOR
		SELECT intCliente_ID, intFactura_ID, intCliente_Tercero  FROM Facturas
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) = @Fecha
		       AND Facturas.bitCancelada = 0
		ORDER BY intCliente_ID, intFactura_ID

	SET @Facturas = '('
	SET @Cliente_Ant = 0
	SET @Cliente_3ro_Ant = 0

	OPEN Facturas_Cursor
	
	FETCH NEXT FROM Facturas_Cursor INTO @Cliente, @Factura, @Cliente_3ro
	
	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF @Cliente_Ant = 0
		BEGIN
			SET @Cliente_Ant = @Cliente
			SET @Cliente_3ro_Ant =  @Cliente_3ro
		END

		IF @Cliente <> @Cliente_Ant
		BEGIN
			SET @Facturas = SUBSTRING(RTRIM(@Facturas),1, LEN(RTRIM(@Facturas)) -1) + ')'
			INSERT INTO #Facturas (intCliente_ID, vchFacturas, intCliente_3ro) VALUES (@Cliente_Ant, @Facturas, @Cliente_3ro_Ant)
			SET @Facturas = '('
			SET @Cliente_Ant = @Cliente
			SET @Cliente_3ro_Ant = @Cliente_3ro
		END

		SET @Facturas = RTRIM(@Facturas) + RTRIM(CONVERT(CHAR,@Factura)) + ','

		FETCH NEXT FROM Facturas_Cursor INTO @Cliente, @Factura, @Cliente_3ro
	END

	SET @Facturas = SUBSTRING(RTRIM(@Facturas),1, LEN(RTRIM(@Facturas)) -1) + ')'
	INSERT INTO #Facturas (intCliente_ID, vchFacturas, intCliente_3ro) VALUES (@Cliente_Ant, @Facturas, @Cliente_3ro_Ant)

	CLOSE Facturas_Cursor
	DEALLOCATE Facturas_Cursor

	SELECT 1 AS Orden, '1103 - CLIENTES' AS Concepto, ' ' AS Facturas, 0 AS Importe, ISNULL(@Total_Ventas_Contado + @Total_Ventas_IVA,0) + ISNULL(@Total_Ventas_Credito,0) AS Debe, 0 AS Haber, @dtmFecha AS dtmFecha

	UNION

--	SELECT 2, CASE WHEN #Facturas.intCliente_3ro = 0 THEN CASE WHEN RTRIM(Cliente_Original.vchRazonSocial) <> '' THEN RTRIM(Cliente_Original.vchRazonSocial) ELSE RTRIM(Cliente_Original.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Original.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Original.vchNombre) END ELSE CASE WHEN RTRIM(Cliente_Tercero.vchRazonSocial) <> '' THEN RTRIM(Cliente_Tercero.vchRazonSocial) ELSE RTRIM(Cliente_Tercero.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Tercero.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Tercero.vchNombre) END END AS Cliente, CASE WHEN #Facturas.vchFacturas IS NULL THEN '' ELSE '  ' + RTRIM(#Facturas.vchFacturas) END AS Facturas, SUM(Facturas.mnyImporte - ISNULL(Notas_Credito.mnyImporte,0)), 0, 0, @dtmFecha AS dtmFecha FROM Facturas
	SELECT 2, RTRIM(Cliente_Original.vchCuentaContable) + ' - ' + CASE WHEN #Facturas.intCliente_3ro = 0 THEN CASE WHEN RTRIM(Cliente_Original.vchRazonSocial) <> '' THEN RTRIM(Cliente_Original.vchRazonSocial) ELSE RTRIM(Cliente_Original.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Original.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Original.vchNombre) END ELSE CASE WHEN RTRIM(Cliente_Tercero.vchRazonSocial) <> '' THEN RTRIM(Cliente_Tercero.vchRazonSocial) ELSE RTRIM(Cliente_Tercero.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Tercero.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Tercero.vchNombre) END END AS Cliente, CASE WHEN #Facturas.vchFacturas IS NULL THEN '' ELSE '  ' + RTRIM(#Facturas.vchFacturas) END AS Facturas, SUM(Facturas.mnyImporte), 0, 0, @dtmFecha AS dtmFecha FROM Facturas
	LEFT OUTER JOIN #Facturas  ON Facturas.intCliente_ID = #Facturas.intCliente_ID
	LEFT OUTER JOIN Clientes Cliente_Original ON Facturas.intCliente_ID = Cliente_Original.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros Cliente_Tercero ON #Facturas.intCliente_3ro = Cliente_Tercero.intCliente_Tercero_ID AND #Facturas.intCliente_ID = Cliente_Tercero.intCliente_ID
--	LEFT OUTER JOIN Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND Notas_Credito.bitCancelada = 0
	LEFT OUTER JOIN (SELECT intFactura_ID, SUM(mnyImporte) AS mnyImporte FROM Notas_Credito WHERE bitCancelada = 0 GROUP BY intFactura_ID) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID
	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) = CONVERT(SMALLDATETIME,@Fecha,103)
	       AND Facturas.bitCancelada = 0
	GROUP BY Facturas.intCliente_ID, Facturas.intCliente_Tercero, Cliente_Original.vchRazonSocial, Cliente_Original.vchApellidoPaterno, Cliente_Original.vchApellidoMaterno, Cliente_Original.vchNombre, Cliente_Tercero.vchRazonSocial, Cliente_Tercero.vchApellidoPaterno, Cliente_Tercero.vchApellidoMaterno, Cliente_Tercero.vchNombre, #Facturas.vchFacturas, #Facturas.intCliente_3ro, Cliente_Original.vchCuentaContable

	UNION

	SELECT 3 AS Orden, 'IVA X PAGAR' AS Concepto, ' ' AS Facturas, 0 AS Importe, 0 AS Debe, SUM(mnyIVA) AS Haber, @dtmFecha AS dtmFecha FROM Cab_Ventas
	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Registro,103),103) = CONVERT(SMALLDATETIME,@Fecha,103)
	       AND bitCancelada = 0

	UNION

	SELECT 4, '4100 - VENTAS', '' AS Facturas, 0, 0, 0, @dtmFecha AS dtmFecha

	UNION

	SELECT 5, '  ', '1 - CONTADO' AS Facturas, 0, 0, @Total_Ventas_Contado, @dtmFecha AS dtmFecha

	UNION

	SELECT 6, '  ', '2 - CREDITO' AS Facturas, 0, 0, @Total_Ventas_Credito, @dtmFecha AS dtmFecha
END
ELSE
BEGIN
	DECLARE Facturas_Cursor CURSOR FOR
		SELECT Facturas.intCliente_ID, CtasxCobrar.intFactura_ID, SUM((mnyAbono + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) - CASE WHEN bitAplicada_NC = 1 THEN ISNULL(Notas_Credito.mnyImporte,0) ELSE 0 END) AS mnyAbonado, ISNULL(Facturas.intCliente_Tercero,0)  FROM Detalle_CtasXCobrar
		INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID AND CtasXCobrar.intAlmacen_ID = @Almacen_ID
		INNER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
		LEFT OUTER JOIN (SELECT intFactura_ID, intRemisionNo, SUM(Notas_Credito.mnyImporte) AS mnyImporte FROM Notas_Credito 
						 LEFT OUTER JOIN Detalle_Notas_Credito ON Notas_Credito.intNota_Credito_ID = Detalle_Notas_Credito.intNota_Credito_ID
						 WHERE Notas_Credito.bitCancelada = 0 
						 GROUP BY intFactura_ID, intRemisionNo
						) Notas_Credito ON Facturas.intFactura_ID = Notas_Credito.intFactura_ID AND (CtasXCobrar.intRemisionNo = Notas_Credito.intRemisionNo AND Notas_Credito.intRemisionNo > 0 OR Notas_Credito.intRemisionNo IS NULL)
		WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha_Abono,103),103) = @Fecha
		GROUP BY Facturas.intCliente_ID, CtasxCobrar.intFactura_ID, Facturas.intCliente_Tercero
		ORDER BY Facturas.intCliente_ID, CtasxCobrar.intFactura_ID

	SET @Facturas = '('
	SET @Cliente_Ant = 0
	SET @Total_Abono = 0
	SET @Total_Cliente = 0
	
	OPEN Facturas_Cursor
	
	FETCH NEXT FROM Facturas_Cursor INTO @Cliente, @Factura, @Abono, @Cliente_3ro
	
	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF @Cliente_Ant = 0
		BEGIN
			SET @Cliente_Ant = @Cliente
			SET @Cliente_3ro_Ant =  @Cliente_3ro
		END

		IF @Cliente <> @Cliente_Ant
		BEGIN
			SET @Facturas = SUBSTRING(RTRIM(@Facturas),1, LEN(RTRIM(@Facturas)) -1) + ')'
			INSERT INTO #Facturas (intCliente_ID, vchFacturas, mnyAbono, intCliente_3ro) VALUES (@Cliente_Ant, @Facturas, @Total_Cliente, @Cliente_3ro_Ant)
			SET @Facturas = '('
			SET @Total_Cliente = 0
			SET @Cliente_Ant = @Cliente
			SET @Cliente_3ro_Ant = @Cliente_3ro
		END

		SET @Facturas = RTRIM(@Facturas) + RTRIM(CONVERT(CHAR,@Factura)) + ','
		SET @Total_Abono = @Total_Abono + @Abono
		SET @Total_Cliente = @Total_Cliente + @Abono

		FETCH NEXT FROM Facturas_Cursor INTO @Cliente, @Factura, @Abono, @Cliente_3ro
	END

	SET @Facturas = SUBSTRING(RTRIM(@Facturas),1, LEN(RTRIM(@Facturas)) -1) + ')'
	INSERT INTO #Facturas (intCliente_ID, vchFacturas, mnyAbono, intCliente_3ro) VALUES (@Cliente_Ant, @Facturas, @Total_Cliente, @Cliente_3ro_Ant)

	CLOSE Facturas_Cursor
	DEALLOCATE Facturas_Cursor

	SET @Sumas_Iguales = (SELECT mnyDeposito FROM Deposito_Bancario WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) = @Fecha)

	SELECT 1 AS Orden, '1021 - BANCOS' AS Concepto, '' AS Facturas, 0 AS Importe, 0 AS Debe, 0 AS Haber, CONVERT(SMALLDATETIME,@Fecha,103) AS dtmFecha, @Total_Abono AS Sumas_Iguales
--	SELECT 1 AS Orden, '1021 - BANCOS' AS Concepto, '' AS Facturas, 0 AS Importe, mnyDeposito AS Debe, 0 AS Haber, CONVERT(SMALLDATETIME,@Fecha,103) AS dtmFecha, @Total_Abono AS Sumas_Iguales FROM Deposito_Bancario 
--	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) = @Fecha

	UNION ALL

	SELECT 2, RTRIM(vchCuentaContable) + ' - ' + RTRIM(vchDescripcion) AS vchConcepto, '', 0, mnyDebe, mnyHaber, CONVERT(SMALLDATETIME,@Fecha,103) AS dtmFecha, @Total_Abono AS Sumas_Iguales FROM Conceptos_Poliza
	INNER JOIN Cuentas_Contables ON bitBanco = 1 AND Conceptos_Poliza.vchCuentaContable = vchNoCuenta
	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) = @Fecha

	UNION ALL

	SELECT 3, RTRIM(vchCuentaContable) + ' - ' + RTRIM(vchConcepto) AS vchConcepto, '', 0, mnyDebe, mnyHaber, CONVERT(SMALLDATETIME,@Fecha,103) AS dtmFecha, @Total_Abono AS Sumas_Iguales FROM Conceptos_Poliza
	INNER JOIN Cuentas_Contables ON bitBanco = 0 AND Conceptos_Poliza.vchCuentaContable = vchNoCuenta
	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) = @Fecha

	UNION ALL

	SELECT 4, '1103 - CLIENTES', '', 0,0, @Total_Abono, CONVERT(SMALLDATETIME,@Fecha,103) AS dtmFecha, @Total_Abono AS Sumas_Iguales

	UNION ALL

	SELECT 5, RTRIM(Cliente_Original.vchCuentaContable) + ' - ' + CASE WHEN #Facturas.intCliente_3ro = 0 THEN CASE WHEN RTRIM(Cliente_Original.vchRazonSocial) <> '' THEN RTRIM(Cliente_Original.vchRazonSocial) ELSE RTRIM(Cliente_Original.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Original.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Original.vchNombre) END ELSE CASE WHEN RTRIM(Cliente_Tercero.vchRazonSocial) <> '' THEN RTRIM(Cliente_Tercero.vchRazonSocial) ELSE RTRIM(Cliente_Tercero.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Tercero.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Tercero.vchNombre) END END,  CASE WHEN #Facturas.vchFacturas IS NULL THEN '' ELSE '  ' + RTRIM(#Facturas.vchFacturas) END AS Facturas, #Facturas.mnyAbono, 0, 0, CONVERT(SMALLDATETIME,@Fecha,103) AS dtmFecha, @Sumas_Iguales AS Sumas_Iguales FROM #Facturas
	LEFT OUTER JOIN Clientes Cliente_Original ON #Facturas.intCliente_ID = Cliente_Original.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros Cliente_Tercero ON #Facturas.intCliente_3ro = Cliente_Tercero.intCliente_Tercero_ID AND #Facturas.intCliente_ID = Cliente_Tercero.intCliente_ID

END

DROP TABLE #Facturas
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteProveedores]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ReporteProveedores]
@Proveedor_Ini      int,
@Proveedor_Fin     int,
@Estatus                 char(1)
AS

SET DATEFORMAT dmy

--SELECT *, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS NombreCompleto FROM Proveedores
SELECT * FROM Proveedores
WHERE (bitActivo = 1 AND @Estatus = 'A' OR bitActivo = 0 AND @Estatus = 'I' OR bitActivo >= 0 AND @Estatus ='T')
      AND intProveedor_ID BETWEEN @Proveedor_INI AND @Proveedor_Fin
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteRendimientos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteRendimientos]
@OrdenCompra	int,
@Reporte		char(1),
@Fecha			smalldatetime,
@Almacen_ID		int
AS
BEGIN

	SET DATEFORMAT dmy

	DECLARE @Peso_Ventas money, @Peso_Deshuese money, @Rendimiento money, @Peso_Compra money

	IF @Reporte = 'O'
		SELECT @Peso_Compra = mnyPeso FROM Orden_Compra 
		WHERE intOrdenCompra_ID = @OrdenCompra AND bitCancelado = 0
	ELSE
		SELECT @Peso_Compra = mnyTotal_Peso FROM Deshueses
		WHERE intDeshuese_ID = (@OrdenCompra * -1)
		
	SELECT @Peso_Ventas = SUM(mnyPeso) FROM Movimientos
	WHERE (intOrdenCompra_ID = @OrdenCompra AND @Reporte = 'O' OR intMatanza_ID = @OrdenCompra AND @Reporte = 'D')
		AND chrOperacion = 'S'
		AND intRemisionNo > 0
		AND intProducto_ID IN (SELECT intProducto_Canal FROM Relacion_Matanza)
		AND bitCancelado = 0
	
	SELECT @Peso_Deshuese = SUM(mnyPeso) FROM Movimientos
	WHERE (intOrdenCompra_ID = @OrdenCompra AND @Reporte = 'O' OR intMatanza_ID = @OrdenCompra AND @Reporte = 'D')
		AND chrOperacion = 'E'
		AND intCliente_ID <= 0  AND intCliente_ID <> -999
		AND bitCancelado = 0

	SET @Rendimiento = CASE WHEN (ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0)) > 0 THEN (ISNULL(@Peso_Deshuese,0) / (ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0))) * 100 ELSE 0 END

	IF @Reporte = 'O'
		SELECT SUM(Movimientos.intCantidad) AS NoCajas, Productos.vchDescripcion AS Producto, SUM(Movimientos.mnyPeso) AS Peso, Movimientos.mnyPrecio As Precio, SUM(Movimientos.mnyPeso * Movimientos.mnyPrecio) AS Importe, (ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0)) AS PesoNeto, Orden_Compra.mnyPrecio AS Costo, Movimientos.intOrdenCompra_ID AS OC, Orden_Compra.dtmFecha AS Fecha,  CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Proveedor, ISNULL(@Peso_Ventas,0) AS PesoVtas, ISNULL(@Peso_Compra,0) AS PesoCompra FROM Movimientos
		INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
		LEFT OUTER JOIN Orden_Compra ON Movimientos.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID AND Orden_Compra.bitCancelado = 0
		LEFT OUTER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
		LEFT OUTER JOIN (SELECT DISTINCT intProducto_Canal FROM Relacion_Matanza) Relacion_Matanza ON Movimientos.intProducto_ID = Relacion_Matanza.intProducto_Canal
		WHERE Movimientos.intAlmacen_ID = @Almacen_ID
		  AND Movimientos.bitCancelado = 0
		  AND chrOperacion = 'E'
		  AND Relacion_Matanza.intProducto_Canal IS NULL
		  AND Movimientos.intOrdenCompra_ID = @OrdenCompra AND @Reporte = 'O' 
		  AND Movimientos.dtmFecha BETWEEN @Fecha AND @Fecha + '23:59'
		GROUP BY Productos.vchDescripcion, Movimientos.mnyPrecio, Orden_Compra.mnyPeso, Orden_Compra.mnyPrecio, Movimientos.intOrdenCompra_ID, Orden_Compra.dtmFecha, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre
		ORDER BY Productos.vchDescripcion
	ELSE
		SELECT SUM(Movimientos.intCantidad) AS NoCajas, Productos.vchDescripcion AS Producto, SUM(Movimientos.mnyPeso) AS Peso, Movimientos.mnyPrecio As Precio, SUM(Movimientos.mnyPeso * Movimientos.mnyPrecio) AS Importe, (ISNULL(@Peso_Compra,0) - ISNULL(@Peso_Ventas,0)) AS PesoNeto, Orden_Compra.mnyPrecio AS Costo, Movimientos.intOrdenCompra_ID AS OC, Orden_Compra.dtmFecha AS Fecha,  CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Proveedor, ISNULL(@Peso_Ventas,0) AS PesoVtas, ISNULL(@Peso_Compra,0) AS PesoCompra FROM Movimientos
		INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
		LEFT OUTER JOIN Orden_Compra ON Movimientos.intOrdenCompra_ID = Orden_Compra.intOrdenCompra_ID AND Orden_Compra.bitCancelado = 0
		LEFT OUTER JOIN Proveedores ON Orden_Compra.intProveedor_ID = Proveedores.intProveedor_ID
		LEFT OUTER JOIN (SELECT DISTINCT intProducto_Canal FROM Relacion_Matanza) Relacion_Matanza ON Movimientos.intProducto_ID = Relacion_Matanza.intProducto_Canal
		WHERE Movimientos.intAlmacen_ID = @Almacen_ID
		  AND Movimientos.bitCancelado = 0
		  AND chrOperacion = 'E'
		  AND Relacion_Matanza.intProducto_Canal IS NULL
		  AND (Movimientos.intCliente_ID <= 0 AND Movimientos.intCliente_ID <> -999)
		  AND intMatanza_ID = @OrdenCompra AND @Reporte = 'D'
		GROUP BY Productos.vchDescripcion, Movimientos.mnyPrecio, Orden_Compra.mnyPeso, Orden_Compra.mnyPrecio, Movimientos.intOrdenCompra_ID, Orden_Compra.dtmFecha, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre
		ORDER BY Productos.vchDescripcion

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteSumarioVentasDiaria]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteSumarioVentasDiaria]
@Fecha_Ini	datetime,
@Fecha_Fin	datetime
AS

SET DATEFORMAT dmy

SELECT vchDescripcion AS Producto, SUM(intCantidad) AS Cantidad FROM Movimientos
INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
       AND chrOperacion = 'S'
       AND intRemisionNo > 0
       AND intCliente_ID > 0
       AND bitTiene_Devolucion = 0
       AND bitCancelado = 0
GROUP BY vchDescripcion
ORDER BY vchDescripcion

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteVentas]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteVentas]
@Cliente_Ini	int,
@Cliente_Fin	int,
@Fecha_Ini	datetime,--char(30),
@Fecha_Fin	datetime,--char(30),
@Reporte	int
AS

SET DATEFORMAT dmy

IF @Reporte = 1	--  Ventas con Factura
	SELECT dtmFecha, intFactura_ID, CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS Cliente, mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, vchObservaciones FROM Facturas
	LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_ID
	WHERE dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
	       AND Facturas.bitCancelada = 0
	ORDER BY Facturas.dtmFecha, Facturas.intFactura_ID

IF @Reporte = 2	--  Ventas con Factura por Cliente
	SELECT dtmFecha, intFactura_ID, CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS Cliente, mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, vchObservaciones FROM Facturas
	LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_ID
	WHERE dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
	       AND Facturas.intCliente_ID = @Cliente_Ini
	       AND Facturas.bitCancelada = 0
	ORDER BY Facturas.dtmFecha, Facturas.intFactura_ID

IF @Reporte = 3 	--  Ventas con Notas de Venta
	SELECT Facturas.dtmFecha AS Fecha_Factura, Facturas.intFactura_ID, CASE WHEN Facturas.intCliente_Tercero = 0 THEN CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END ELSE CASE WHEN RTRIM(Facturar_Terceros.vchRazonSocial) <> '' THEN RTRIM(Facturar_Terceros.vchRazonSocial) ELSE RTRIM(Facturar_Terceros.vchApellidoPaterno) + ' ' + RTRIM(Facturar_Terceros.vchApellidoMaterno) + ' ' + RTRIM(Facturar_Terceros.vchNombre) END END AS Cliente, Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS Importe_Factura, vchObservaciones, Detalle_Facturas.intRemisionNo, Remisiones.dtmFecha AS Fecha_NotaVenta, Remisiones.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS Importe_NotaVenta, CASE WHEN RTRIM(Cliente_Remision.vchRazonSocial) <> '' THEN RTRIM(Cliente_Remision.vchRazonSocial) ELSE RTRIM(Cliente_Remision.vchApellidoPaterno) + ' ' + RTRIM(Cliente_Remision.vchApellidoMaterno) + ' ' + RTRIM(Cliente_Remision.vchNombre) END AS Cliente_NotaVenta  FROM Facturas
	INNER JOIN Detalle_Facturas ON Facturas.intFactura_ID = Detalle_Facturas.intFactura_ID
	LEFT OUTER JOIN Remisiones ON Detalle_Facturas.intRemisionNo = Remisiones.intRemisionNo
	LEFT OUTER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	LEFT OUTER JOIN Facturar_Terceros ON Facturas.intCliente_Tercero = Facturar_Terceros.intCliente_ID
	LEFT OUTER JOIN Clientes Cliente_Remision ON Remisiones.intCliente_ID = Cliente_Remision.intCliente_ID
	WHERE Facturas.dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
	       AND Facturas.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	       AND Facturas.bitCancelada = 0
	ORDER BY Facturas.dtmFecha, Facturas.intFactura_ID, Detalle_Facturas.intRemisionNo, Remisiones.dtmFecha

IF @Reporte = 4 	--  Ventas X Dia
	SELECT CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS dtmFecha, vchDescripcion AS Producto, SUM(intCantidad) AS Cantidad, @Fecha_Ini AS Fecha_Ini, @Fecha_Fin AS Fecha_Fin FROM Movimientos
	INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
	WHERE CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin
	       AND chrOperacion = 'S'
	       AND intRemisionNo > 0
	       AND intCliente_ID > 0
	       AND bitTiene_Devolucion = 0
	       AND bitCancelado = 0
	GROUP BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103), vchDescripcion
	ORDER BY CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103), vchDescripcion

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteVentasAnuales]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteVentasAnuales]
@Fecha_Ini                 	smalldatetime,
@Fecha_Fin                	smalldatetime,
@TipoReporte             	char(1),
@Cliente_Ini 		int, 
@Cliente_Fin 		int
AS

SET DATEFORMAT dmy

IF @TipoReporte = 'S'
	SELECT Facturas.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, SUM(Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0))  AS mnyTotalVendido, @TipoReporte AS TipoReporte, NULL AS dtmFecha, 0 AS mnyImporte, '' AS intFactura_ID, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')) AS Direccion, RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado) AS Cd_Edo FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	WHERE Facturas.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	  AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
      AND Facturas.bitCancelada = 0
	GROUP BY Facturas.intCliente_ID, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')), RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado)
	ORDER BY mnyTotalVendido DESC, Facturas.intCliente_ID
ELSE
	SELECT Facturas.intCliente_ID, CASE WHEN RTRIM(vchRazonSocial) <> '' THEN RTRIM(vchRazonSocial) ELSE RTRIM(vchApellidoPaterno) + ' ' + RTRIM(vchApellidoMaterno) + ' ' + RTRIM(vchNombre) END AS Nombre, Facturas.intFactura_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) AS dtmFecha, Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0) AS mnyImporte, TotalVendido.mnyImporte AS mnyTotalVendido, @TipoReporte AS TipoReporte, vchRFC, RTRIM(vchDireccion) + ' ' + RTRIM(ISNULL(vchCodigoPostal,' ')) AS Direccion, RTRIM(vchCiudad) + ' ' + RTRIM(vchEstado) AS Cd_Edo FROM Facturas
	INNER JOIN Clientes ON Facturas.intCliente_ID = Clientes.intCliente_ID
	INNER JOIN (SELECT intCliente_ID, SUM(Facturas.mnyImporte + ISNULL(CONVERT(DECIMAL(18,2),Facturas.mnyIVA),0)) AS mnyImporte FROM Facturas 
		          WHERE Facturas.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
	      		  AND  CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
                  AND Facturas.bitCancelada = 0
		          GROUP BY Facturas.intCliente_ID
		         ) TotalVendido ON Facturas.intCliente_ID = TotalVendido.intCliente_ID
	WHERE Facturas.intCliente_ID BETWEEN @Cliente_Ini AND @Cliente_Fin
      AND CONVERT(SMALLDATETIME,CONVERT(CHAR,Facturas.dtmFecha,103),103) BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
      AND Facturas.bitCancelada = 0
--	GROUP BY Facturas.intCliente_ID, vchRazonSocial, vchApellidoPaterno, vchApellidoMaterno, vchNombre, Facturas.intFactura_ID, Facturas.dtmFecha, Facturas.mnyImporte
	ORDER BY mnyTotalVendido DESC, Facturas.intCliente_ID, Facturas.dtmFecha, Facturas.intFactura_ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteViceras]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteViceras]
@Fecha_Ini	datetime,--char(30),
@Fecha_Fin	datetime,--char(30)
@Almacen_ID	int
AS

SET DATEFORMAT dmy

SELECT dtmFecha, vchDescripcion, SUM(Entradas) AS Entradas, SUM(Salidas) AS Salidas, ISNULL(intExistencia,0) AS Existencia FROM 
(SELECT Movimientos.intProducto_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS dtmFecha, vchDescripcion, intCantidad AS Entradas, 0 As Salidas  FROM Movimientos
 INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
 WHERE Movimientos.intProducto_ID IN (SELECT intProducto_ID FROM Viceras GROUP BY intProducto_ID)
   AND intAlmacen_ID = @Almacen_ID
   AND chrOperacion = 'E'
   AND dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin

 UNION ALL

 SELECT Movimientos.intProducto_ID, CONVERT(SMALLDATETIME,CONVERT(CHAR,dtmFecha,103),103) AS dtmFecha, vchDescripcion, 0, intCantidad FROM Movimientos
 INNER JOIN Productos ON Movimientos.intProducto_ID = Productos.intProducto_ID
 WHERE Movimientos.intProducto_ID IN (SELECT intProducto_ID FROM Viceras GROUP BY intProducto_ID)
  AND intAlmacen_ID = @Almacen_ID
  AND chrOperacion = 'S'
   AND dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin
) Movimientos 
LEFT OUTER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS intExistencia FROM Existencias WHERE intAlmacen_ID = 2 GROUP BY intProducto_ID) Existencias ON Movimientos.intProducto_ID = Existencias.intProducto_ID
GROUP BY Movimientos.intProducto_ID, dtmFecha, vchDescripcion, intExistencia
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteVicerasSumarizado]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteVicerasSumarizado]
@Fecha_Ini	datetime,
@Fecha_Fin	datetime,
@Almacen_ID	int
AS

SET DATEFORMAT dmy

SELECT Productos.intProducto_ID, vchDescripcion, ISNULL(Entradas.Lunes,0) AS Ent_Lunes, ISNULL(Salidas.Lunes,0) AS Sal_Lunes, ISNULL(Entradas.Martes,0) AS Ent_Martes, ISNULL(Salidas.Martes,0) AS Sal_Martes, ISNULL(Entradas.Miercoles,0) AS Ent_Miercoles, ISNULL(Salidas.Miercoles,0) AS Sal_Miercoles, ISNULL(Entradas.Jueves,0) AS Ent_Jueves, ISNULL(Salidas.Jueves,0) AS Sal_Jueves, ISNULL(Entradas.Viernes,0) AS Ent_Viernes, ISNULL(Salidas.Viernes,0) AS Sal_Viernes, ISNULL(Entradas.Sabado,0) AS Ent_Sabado, ISNULL(Salidas.Sabado,0) AS Sal_Sabado, (ISNULL(Entradas.Lunes,0) + ISNULL(Entradas.Martes,0) + ISNULL(Entradas.Miercoles,0) + ISNULL(Entradas.Jueves,0) + ISNULL(Entradas.Viernes,0) + ISNULL(Entradas.Sabado,0)) AS Total_Entradas, (ISNULL(Salidas.Lunes,0) + ISNULL(Salidas.Martes,0) + ISNULL(Salidas.Miercoles,0) + ISNULL(Salidas.Jueves,0) + ISNULL(Salidas.Viernes,0) + ISNULL(Salidas.Sabado,0)) AS Total_Salidas, ISNULL(intExistencia,0) AS Existencia FROM Productos
LEFT OUTER JOIN (SELECT intProducto_ID, SUM(intExistencia) AS intExistencia FROM Existencias 
                 WHERE intAlmacen_ID = @Almacen_ID
		 GROUP BY intProducto_ID
                ) Existencias ON Productos.intProducto_ID = Existencias.intProducto_ID
LEFT OUTER JOIN (SELECT intProducto_ID, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 1 THEN intCantidad ELSE 0 END) AS Lunes, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 2 THEN intCantidad ELSE 0 END) AS Martes, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 3 THEN intCantidad ELSE 0 END) AS Miercoles, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 4 THEN intCantidad ELSE 0 END) AS Jueves, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 5 THEN intCantidad ELSE 0 END) AS Viernes, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 6 THEN intCantidad ELSE 0 END) AS Sabado FROM Movimientos
		 WHERE chrOperacion = 'E' AND dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + ' 23:59' 
		 GROUP BY intProducto_ID
                ) Entradas ON Productos.intProducto_ID = Entradas.intProducto_ID
LEFT OUTER JOIN (SELECT intProducto_ID, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 1 THEN intCantidad ELSE 0 END) AS Lunes, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 2 THEN intCantidad ELSE 0 END) AS Martes, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 3 THEN intCantidad ELSE 0 END) AS Miercoles, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 4 THEN intCantidad ELSE 0 END) AS Jueves, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 5 THEN intCantidad ELSE 0 END) AS Viernes, SUM(CASE WHEN DATEPART(dw, dtmFecha) = 6 THEN intCantidad ELSE 0 END) AS Sabado FROM Movimientos
		 WHERE chrOperacion = 'S' AND bitTiene_Devolucion = 0 AND dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + ' 23:59' 
		 GROUP BY intProducto_ID
                ) Salidas ON Productos.intProducto_ID = Salidas.intProducto_ID
WHERE Productos.intProducto_ID IN (SELECT intProducto_ID FROM Viceras GROUP BY intProducto_ID)
ORDER BY vchDescripcion

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteVtasXRepartidor]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteVtasXRepartidor]
@Repartidor_ID	int,
@Fecha_Ini		smalldatetime,
@Fecha_Fin		smalldatetime
AS

SET DATEFORMAT dmy

SELECT CASE WHEN RTRIM(Clientes.vchRazonSocial) <> '' THEN RTRIM(Clientes.vchRazonSocial) ELSE RTRIM(Clientes.vchApellidoPaterno) + ' ' + RTRIM(Clientes.vchApellidoMaterno) + ' ' + RTRIM(Clientes.vchNombre) END AS NombreCliente, 
	CASE WHEN CtasXCobrar.intCliente_ID = 100 THEN CtasXCobrar.mnyImporte ELSE 0 END AS CONTADO,
	CASE WHEN CtasXCobrar.intCliente_ID <> 100 THEN CtasXCobrar.mnyImporte ELSE 0 END AS CREDITO,
	ISNULL(Abonos.mnyAbono,0) AS ABONADO
FROM Repartidores
LEFT OUTER JOIN (SELECT intRepartidor_ID, intCliente_ID, SUM(mnyImporte) AS mnyImporte FROM Control_Folios_Remisiones 
                 LEFT OUTER JOIN CtasXCobrar ON CtasXCobrar.intRemisionNo BETWEEN Control_Folios_Remisiones.intFolio_Inicial AND Control_Folios_Remisiones.intFolio_Final
                 WHERE CtasXCobrar.dtmFecha BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59'
                   AND intRepartidor_ID = @Repartidor_ID
                 GROUP BY intRepartidor_ID, intCliente_ID
                ) CtasXCobrar ON Repartidores.intRepartidor_ID = CtasXCobrar.intRepartidor_ID
LEFT OUTER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
LEFT OUTER JOIN (SELECT intCliente_ID, SUM(mnyAbono) AS mnyAbono FROM vAbonosRemisionesXDia WHERE dtmFecha_Abono BETWEEN @Fecha_Ini AND @Fecha_Fin + '23:59' GROUP BY intCliente_ID) Abonos ON CtasXCobrar.intCliente_ID = Abonos.intCliente_ID
WHERE Repartidores.intRepartidor_ID = @Repartidor_ID
ORDER BY 1, 2
GO
/****** Object:  StoredProcedure [dbo].[Sp_SalidaInventario_Test]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_SalidaInventario_Test]
@OrdenMatanza_ID   int,
@OrdenCompra_ID    int,
@Producto_ID             int,
@NoCanal                    int,
@TipoVicera                int,
@Cliente_ID                int,
@RemisionNo              int,
@Cantidad                   int,
@Precio                        money,
@Peso                          money,
@Flete                           money,
@EsVicera                    bit,
@Clasificacion             char(1),
@Fecha                        varchar(30),
@Productos                 varchar(1000),
@SinPeso	           int,
@Productos_Sel         int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Movimiento_ID int, @CxC int, @Posicion int, @Cantidad_Tmp varchar(10), @Matanza_Tmp varchar(10), @Peso_Tmp varchar(10), @Canal_Tmp varchar(10), @Orden_Tmp varchar(10), @Caracter char(1), @Contador int, @Cantidad_Procesada bit, @Movimiento int, @Importe money, @Status_Vicera int, @Peso_Procesado int, @Canal_Procesado int, @Orden_Procesada int, @Matanza_Procesada int, @Primera_Vez bit, @Cantidad_Definitiva int, @Identificador_Procesado int, @Identificador_Tmp varchar(10)
DECLARE @Movimiento_ID_Cur int, @Producto_ID_Cur int, @Cantidad_Cur int, @Peso_Cur money, @NoCanal_Cur int, @OrdenCompra_ID_Cur int, @Matanza_ID_Cur int, @Importe_Cur money, @Identificador_Cur int

CREATE TABLE #Productos (
intMovimiento_ID      int,
intProducto_ID          int,
intCantidad                 int,
mnyPeso                     money,
intNoCanal                  int,
intOrdenCompra_ID  int,
intMatanza_ID           int,
intIdentificador           int,
mnyImporte                money)

SET @Primera_Vez = 1
SET @Posicion = 1
SET @Contador = LEN(@Productos)
SET @Cantidad_Procesada = 0
SET @Peso_Procesado = 0
SET @Canal_Procesado = 0
SET @Orden_Procesada = 0
SET @Matanza_Procesada = 0
SET @Identificador_Procesado = 0
SET @Cantidad_Tmp = ' '
SET @Peso_Tmp = ' '
SET @Canal_Tmp = ' '
SET @Orden_Tmp = ' '
SET @Matanza_Tmp = ' '
SET @Identificador_Tmp = ' '
SET @Movimiento = 1

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Productos,@Posicion,1) 

	IF @Cantidad_Procesada = 0
	BEGIN
		IF @Caracter <> '*'
			SET @Cantidad_Tmp = RTRIM(@Cantidad_Tmp) + @Caracter
		ELSE
			SET @Cantidad_Procesada = 1
	END

	IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 0 AND @Caracter <> '*'
	BEGIN
		IF @Caracter <> '-'
			SET @Peso_Tmp = RTRIM(@Peso_Tmp) + @Caracter
		ELSE
			SET @Peso_Procesado = 1
	END

	IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 0 AND @Caracter <> '-'
	BEGIN
		IF @Caracter <> '+'
			SET @Canal_Tmp = RTRIM(@Canal_Tmp) + @Caracter
		ELSE
			SET @Canal_Procesado = 1
	END

	IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 0 AND @Caracter <> '+'
	BEGIN
		IF @Caracter <> '#'
			SET @Orden_Tmp = RTRIM(@Orden_Tmp) + @Caracter
		ELSE
			SET @Orden_Procesada = 1
	END

	IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Matanza_Procesada = 0 AND @Caracter <> '#'
	BEGIN
		IF @Caracter <> '%'
			SET @Matanza_Tmp = RTRIM(@Matanza_Tmp) + @Caracter
		ELSE
			SET @Matanza_Procesada = 1
	END

	IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Matanza_Procesada = 1 AND @Identificador_Procesado = 0 AND @Caracter <> '%'
	BEGIN
		IF @Caracter <> ','
			SET @Identificador_Tmp = RTRIM(@Identificador_Tmp) + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Cantidad_Procesada = 1 AND @Peso_Procesado = 1 AND @Canal_Procesado = 1 AND @Orden_Procesada = 1 AND @Identificador_Procesado = 1 AND @Matanza_Procesada = 1
	BEGIN
--		SET @Cantidad_Definitiva = CASE WHEN @Cantidad <> @Cantidad_Tmp AND @Productos_Sel = 1 THEN @Cantidad ELSE @Cantidad_Tmp END
		SET @Importe = ROUND(CASE WHEN  @EsVicera = 1 AND @Clasificacion = 'K' 
							THEN @Precio * CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END 
						   WHEN  @EsVicera = 1 AND @Clasificacion = 'P'  
							THEN CONVERT(MONEY,@Cantidad_Tmp) * @Precio 
						   ELSE 
							@Precio * (CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END)
                                                                            END,2)

		INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyImporte, intIdentificador) VALUES (@Movimiento, @Producto_ID, @Cantidad_Tmp, CASE WHEN CONVERT(MONEY,@Peso_Tmp) = 0 THEN @Peso ELSE CONVERT(MONEY,@Peso_Tmp) END, @Canal_Tmp, @Orden_Tmp, @Matanza_Tmp, @Importe, @Identificador_Tmp)
		SET @Cantidad_Procesada = 0
		SET @Peso_Procesado = 0
		SET @Canal_Procesado = 0
		SET @Orden_Procesada = 0
		SET @Matanza_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Cantidad_Tmp = ' '
		SET @Peso_Tmp = ' '
		SET @Canal_Tmp = ' '
		SET @Orden_Tmp = ' '
		SET @Matanza_Tmp = ' '
		SET @Identificador_Tmp = ' '
		SET @Movimiento = @Movimiento + 1
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1

END

IF (SELECT COUNT(*) FROM #Productos) = 0
BEGIN
	SET @Importe = ROUND(CASE WHEN  @EsVicera = 1 AND @Clasificacion = 'K' THEN @Precio * @Peso WHEN  @EsVicera = 1 AND @Clasificacion = 'P'  THEN CONVERT(MONEY,@Cantidad) * @Precio ELSE @Precio * @Peso END,2)

	INSERT INTO #Productos (intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyImporte, intIdentificador) VALUES (1, @Producto_ID, @Cantidad, @Peso, @NoCanal, @OrdenCompra_ID, @OrdenMatanza_ID, @Importe, @Identificador_Tmp)
END

SET @Movimiento_ID = ISNULL((SELECT MAX(intMovimiento_ID) FROM Movimientos),0)
SET @CxC = ISNULL((SELECT MAX(intCtaXCobrar_ID) FROM CtasXCobrar),0) 

SELECT intMovimiento_ID, intProducto_ID, intCantidad, mnyPeso, intNoCanal, intOrdenCompra_ID, intMatanza_ID, mnyImporte, intIdentificador FROM #Productos
GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidaDatosFacturaElectronica]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_ValidaDatosFacturaElectronica]
(
	@Cliente Int,
	@Tercero Int
)	
As

Declare
	@Mensaje Varchar(400),
	@CP Varchar(15),
	@Pais varchar(20),
	@Suc Int,
	@Tipo Varchar(1),
	@Mov Int,
	@RFC Varchar(20),
	@Domicilio Varchar(500),
	@NoExt Varchar(10),
	@NoInt Varchar(10),
	@Colonia Varchar(100),
	@Ciudad Varchar(100)

IF @Tercero = 0
	SELECT @RFC = ISNULL(vchRFC,''),
		   @Domicilio = ISNULL(vchDireccion,''),
		   @NoExt = ISNULL(vchNoExterior,''),
		   @NoInt = ISNULL(vchNoInterior,''),
		   @Colonia = ISNULL(vchColonia,''),
		   @Ciudad = ISNULL(vchCiudad,''), 
		   @CP = ISNULL(vchCodigoPostal,''),
		   @Pais = ISNULL(vchPais,'')
	FROM Clientes
	WHERE intCliente_ID = @Cliente
ELSE
	SELECT @RFC = ISNULL(vchRFC,''),
		   @Domicilio = ISNULL(vchDireccion,''),
		   @NoExt = ISNULL(vchNoExterior,''),
		   @NoInt = ISNULL(vchNoInterior,''),
		   @Colonia = ISNULL(vchColonia,''),
		   @Ciudad = ISNULL(vchCiudad,''), 
		   @CP = ISNULL(vchCodigoPostal,''),
		   @Pais = ISNULL(vchPais,'')
	FROM Facturar_Terceros
	WHERE intCliente_ID = @Cliente AND intCliente_Tercero_ID = @Tercero

SET @Mensaje= ''

If Rtrim(ltrim(@RFC)) = '' 
BEGIN
	Set @Mensaje = 'El cliente no tiene RFC'
	goto Salir
END

If RTRIM(ltrim(@Domicilio)) = ''
BEGIN
	Set @Mensaje = 'El cliente no tiene especificado domicilio'
	goto Salir
END

If RTRIM(ltrim(@NoExt)) = '' And LTRIM(Rtrim(@NoInt)) = ''
BEGIN
	Set @Mensaje = 'El cliente no tiene especificado número interno o externo del domicilio'
	goto Salir
END

If RTRIM(ltrim(@Colonia)) = ''
BEGIN
	Set @Mensaje = 'El cliente no tiene especificada la colonia'
	goto Salir
END

If RTRIM(ltrim(@CP)) = '' Or LTRIM(Rtrim(@CP)) = '0'
BEGIN
	Set @Mensaje = 'El código postal del cliente es incorrecto'
	goto Salir
END

If RTRIM(ltrim(@Pais)) = ''
BEGIN
	Set @Mensaje = 'El cliente no tiene un pais asignado correctamente'
END

Salir:

SELECT @Mensaje AS vchMensaje

RETURN Case When Ltrim(Rtrim(@Mensaje)) = '' Then 0 Else 99 End

GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarCanal]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ValidarCanal]
@Producto_ID	int,
@Canal          int,
@Almacen_ID		int
AS

SET DATEFORMAT dmy

SELECT * FROM Existencias
WHERE intAlmacen_ID = @Almacen_ID
       AND intProducto_ID = @Producto_ID
       AND intCanalNo = @Canal
GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarClaveProdServ]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ValidarClaveProdServ]
	@Clave	varchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Valido bit

	SET @Valido = ISNULL((SELECT COUNT(*) FROM c_ClaveProdServ WHERE c_ClaveProdServ = @Clave),0)

	SELECT @Valido AS bitClaveValido

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarCodigos]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ValidarCodigos]
@Codigo_ID      int,
@TipoCodigo     char(1),
@Cliente_ID       int
AS

SET DATEFORMAT dmy

IF @TipoCodigo = 'A'
BEGIN
	SELECT * FROM Productos
	WHERE bitActivo = 1
                       AND intProducto_ID = @Codigo_ID
                       AND intTipoProducto_ID = (SELECT intTipoProducto_Producto FROM Parametros)
END

IF @TipoCodigo = 'C'
BEGIN
	SELECT * FROM Clientes
	WHERE bitActivo = 1
                       AND intCliente_ID = @Codigo_ID
END

IF @TipoCodigo = 'V'
BEGIN
	SELECT * FROM Productos
	WHERE bitActivo = 1
                       AND intProducto_ID = @Codigo_ID
                       AND intTipoProducto_ID = (SELECT intTipoProducto_Viceras FROM Parametros)
END

IF @TipoCodigo = 'P'
BEGIN
	SELECT * FROM Proveedores
	WHERE bitActivo = 1
                       AND intProveedor_ID = @Codigo_ID
END

IF @TipoCodigo = 'R'
BEGIN
	SELECT * FROM Remisiones
	WHERE intRemisionNo = @Codigo_ID
	      AND intCliente_ID <> @Cliente_ID
END

IF @TipoCodigo = 'F'
BEGIN
	SELECT * FROM Control_Folios_Remisiones
	WHERE @Codigo_ID BETWEEN intFolio_Inicial AND intFolio_Final
END

IF @TipoCodigo = 'X'
BEGIN
	SELECT * FROM Detalle_Facturas
	WHERE intRemisionNo = @Codigo_ID
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarCP]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ValidarCP]
	@CP	varchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Valido bit

	SET @Valido = ISNULL((SELECT COUNT(*) FROM c_CodigoPostal WHERE c_CodigoPostal = @CP),0)

	SELECT @Valido AS bitCPValido

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarLimiteCredito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ValidarLimiteCredito]
@Cliente_ID	int
AS

SET DATEFORMAT dmy

DECLARE @Excedio bit

IF @Cliente_ID <> 1000
BEGIN
	SET @Excedio = ISNULL((SELECT CASE WHEN SUM(mnySaldo) > Clientes.mnyLimiteCredito THEN 0 ELSE 1 END AS Excedio_Limite FROM CtasXCobrar
	                       INNER JOIN Clientes ON CtasXCobrar.intCliente_ID = Clientes.intCliente_ID
	                       WHERE CtasXCobrar.intCliente_ID = @Cliente_ID
	                       GROUP BY Clientes.mnyLimiteCredito),1)
	SELECT @Excedio	AS Excedio_Limite                     
END                      
ELSE
	SELECT 1 AS Excedio_Limite
GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarPassword]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ValidarPassword]
@TipoPassword	int
AS

SET DATEFORMAT dmy

SELECT CASE WHEN @TipoPassword = 0 THEN vchPassword_Utilerias ELSE vchPassword_Inv_Fisico END AS vchPassword FROM Parametros

GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidarUnidad]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ValidarUnidad]
	@Unidad	varchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Valido bit

	SET @Valido = ISNULL((SELECT COUNT(*) FROM c_ClaveUnidad WHERE Clave_Unidad = @Unidad),0)

	SELECT @Valido AS bitUMValido

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_VerificarClienteTerceros]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_VerificarClienteTerceros]
@Cliente_ID	int
AS

SET DATEFORMAT dmy

SELECT COUNT(*) FROM Facturar_Terceros
WHERE intCliente_ID = @Cliente_ID AND bitActivo = 1
GO
/****** Object:  StoredProcedure [dbo].[Sp_VerificarExisteNotaCredito]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_VerificarExisteNotaCredito]
@Remisiones		varchar(8000)
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Posicion int, @Identificador varchar(10), @Remision varchar(10), @Caracter char(1), @Contador int, @Remision_Procesada bit, @Identificador_Procesado  bit

CREATE TABLE #Remisiones (
intRemision_ID       int,
intIdentificador	      int)

SET @Posicion = 1
SET @Contador = LEN(@Remisiones)
SET @Remision_Procesada = 0
SET @Identificador_Procesado = 0
SET @Remision = ' '
SET @Identificador = ' '

WHILE @Contador <> 0
BEGIN

	SET @Caracter = SUBSTRING(@Remisiones,@Posicion,1) 

	IF @Remision_Procesada = 0
	BEGIN
		IF @Caracter <> '='
			SET @Remision = RTRIM(@Remision) + @Caracter
		ELSE
			SET @Remision_Procesada = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 0 and @Caracter <> '='
	BEGIN
		IF @Caracter <> ','
			SET @Identificador = @Identificador + @Caracter
		ELSE
			SET @Identificador_Procesado = 1
	END

	IF @Remision_Procesada = 1 AND @Identificador_Procesado = 1
	BEGIN
		INSERT INTO #Remisiones (intRemision_ID, intIdentificador) VALUES (@Remision, @Identificador)
		SET @Remision_Procesada = 0
		SET @Identificador_Procesado = 0
		SET @Remision = ' '
		SET @Identificador = ' '
	END

	SET @Posicion = @Posicion + 1
	SET @Contador = @Contador - 1
END

SET @Status = (SELECT COUNT(CtasXCobrar.intFactura_ID) FROM CtasXCobrar INNER JOIN Notas_Credito ON CtasXCobrar.intFactura_ID = Notas_Credito.intFactura_ID AND bitAplicada = 1 WHERE intRemisionNo IN (SELECT intRemision_ID FROM #Remisiones) )

DROP TABLE #Remisiones

IF @Status <> 0
	RETURN 99
ELSE
	RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[Sp_VerificarRemision]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_VerificarRemision]
	@Remision_ID	int
AS
BEGIN
	SET DATEFORMAT dmy

	IF (SELECT COUNT(*) FROM Remisiones WHERE intRemisionNo = @Remision_ID) > 0
		SELECT * FROM Remisiones
		WHERE intRemisionNo = @Remision_ID
		  AND mnyImporte > 0
	ELSE
		SELECT * FROM Facturas
		WHERE intFactura_ID = @Remision_ID
		  AND mnyImporte > 0
		
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_VerificarTipoAbono]    Script Date: 26/06/2018 07:16:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_VerificarTipoAbono]
@Cliente_ID	int,
@Operacion	char(1),
@Almacen        int
AS

SET DATEFORMAT dmy

DECLARE @Total_Remisiones int, @Total_Facturas int

SET @Total_Remisiones = 0
SET @Total_Facturas = 0

IF @Operacion = 'A'
BEGIN
	SET  @Total_Remisiones = ISNULL((SELECT COUNT(*) FROM Remisiones 
					           INNER JOIN CtasXCobrar ON Remisiones.intRemisionNo = CtasXCobrar.intRemisionNo
					           LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
					           WHERE Remisiones.intCliente_ID = @Cliente_ID 
						    AND (Facturas.intCliente_ID = 1000 AND @Almacen = 2 OR Facturas.intCliente_ID IS NULL AND @Almacen = 1)
						    AND Remisiones.intAlmacen_ID = @Almacen
						    AND bitFacturado = CASE WHEN @Almacen = 1 THEN 0 ELSE 1 END
						    AND Remisiones.mnySaldo <> 0),0)
		
	SET @Total_Facturas = ISNULL((SELECT COUNT(*) FROM Facturas
				   WHERE intCliente_ID = @Cliente_ID
				         AND Facturas.intCliente_ID <> 1000
				         AND bitCancelada = 0
				         AND intTipoPago = 1
				         AND mnySaldo <> 0),0)
END

IF @Operacion = 'C'
BEGIN
	SET  @Total_Remisiones = (SELECT COUNT(*) FROM Detalle_CtasXCobrar
				         INNER JOIN CtasXCobrar ON Detalle_CtasXCobrar.intCtaXCobrar_ID = CtasXCobrar.intCtaXCobrar_ID
				         INNER JOIN Remisiones ON CtasXCobrar.intRemisionNo = Remisiones.intRemisionNo AND Remisiones.intAlmacen_ID = @Almacen AND bitFacturado = CASE WHEN @Almacen = 1 THEN 0 ELSE 1 END
				         LEFT OUTER JOIN Facturas ON CtasXCobrar.intFactura_ID = Facturas.intFactura_ID
				         WHERE Remisiones.intCliente_ID = @Cliente_ID
					 AND (Facturas.intCliente_ID = 1000 AND @Almacen = 2 OR Facturas.intCliente_ID IS NULL AND @Almacen = 1))
		
	SET @Total_Facturas = (SELECT COUNT(*) FROM Detalle_Facturas
				   INNER JOIN Facturas On Detalle_Facturas.intFactura_ID = Facturas.intFactura_ID
				   INNER JOIN CtasXCobrar ON Detalle_Facturas.intRemisionNo = CtasXCobrar.intRemisionNo
				   INNER JOIN Detalle_CtasXCobrar ON CtasXCobrar.intCtaXCobrar_ID = Detalle_CtasXCobrar.intCtaXCobrar_ID
				   WHERE Facturas.intCliente_ID = @Cliente_ID 
                                                              AND Facturas.intCliente_ID <> 1000
				         AND bitCancelada = 0
				         AND intTipoPago = 1)
END

SELECT ISNULL(@Total_Remisiones,0) AS EncontroRemisiones, ISNULL(@Total_Facturas,0) AS EncontroFacturas

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Control_Facturas', @level2type=N'COLUMN',@level2name=N'intContador_Facturas'
GO
USE [master]
GO
ALTER DATABASE [Valco_FE] SET  READ_WRITE 
GO
