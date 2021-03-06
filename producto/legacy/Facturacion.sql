USE [master]
GO
/****** Object:  Database [Facturacion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
CREATE DATABASE [Facturacion]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Facturacion', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Facturacion.mdf' , SIZE = 18112KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Facturacion_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Facturacion.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Facturacion] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Facturacion].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Facturacion] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Facturacion] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Facturacion] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Facturacion] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Facturacion] SET ARITHABORT OFF 
GO
ALTER DATABASE [Facturacion] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Facturacion] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [Facturacion] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Facturacion] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Facturacion] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Facturacion] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Facturacion] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Facturacion] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Facturacion] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Facturacion] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Facturacion] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Facturacion] SET DATE_CORRELATION_OPTIMIZATION ON 
GO
ALTER DATABASE [Facturacion] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Facturacion] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Facturacion] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Facturacion] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Facturacion] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Facturacion] SET RECOVERY FULL 
GO
ALTER DATABASE [Facturacion] SET  MULTI_USER 
GO
ALTER DATABASE [Facturacion] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Facturacion] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Facturacion] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Facturacion] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Facturacion] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Facturacion', N'ON'
GO
USE [Facturacion]
GO
/****** Object:  UserDefinedTableType [dbo].[TablaUnSplit]    Script Date: 26/06/2018 07:18:18 p.m. ******/
CREATE TYPE [dbo].[TablaUnSplit] AS TABLE(
	[Contenido] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[CantidadConLetra]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CantidadConLetra]
(
    @Numero     money,
    @Paridad	money
)

RETURNS Varchar(180)
AS

BEGIN

	DECLARE @ImpLetra Varchar(180)

    DECLARE @lnEntero INT,
                    @lcRetorno VARCHAR(512),
                    @lnTerna INT,
                    @lcMiles VARCHAR(512),
                    @lcCadena VARCHAR(512),
                    @lnUnidades INT,
                    @lnDecenas INT,
                    @lnCentenas INT,
                    @lnFraccion INT
                    
    SELECT  @lnEntero = SUBSTRING(LTRIM(CONVERT(CHAR,@Numero)),1,CHARINDEX('.',LTRIM(CONVERT(CHAR,@Numero)))-1),
                    @lnFraccion = (@Numero - @lnEntero) * 100,
                    @lcRetorno = '',
                    @lnTerna = 1

  WHILE @lnEntero > 0
  BEGIN /* WHILE */
            -- Recorro terna por terna
            SELECT @lcCadena = ''
            SELECT @lnUnidades = @lnEntero % 10
            SELECT @lnEntero = CAST(@lnEntero/10 AS INT)
            SELECT @lnDecenas = @lnEntero % 10
            SELECT @lnEntero = CAST(@lnEntero/10 AS INT)
            SELECT @lnCentenas = @lnEntero % 10
            SELECT @lnEntero = CAST(@lnEntero/10 AS INT)
            -- Analizo las unidades
            SELECT @lcCadena =
            CASE /* UNIDADES */
              WHEN @lnUnidades = 1 THEN 'UN ' + @lcCadena
              WHEN @lnUnidades = 2 THEN 'DOS ' + @lcCadena
              WHEN @lnUnidades = 3 THEN 'TRES ' + @lcCadena
              WHEN @lnUnidades = 4 THEN 'CUATRO ' + @lcCadena
              WHEN @lnUnidades = 5 THEN 'CINCO ' + @lcCadena
              WHEN @lnUnidades = 6 THEN 'SEIS ' + @lcCadena
              WHEN @lnUnidades = 7 THEN 'SIETE ' + @lcCadena
              WHEN @lnUnidades = 8 THEN 'OCHO ' + @lcCadena
              WHEN @lnUnidades = 9 THEN 'NUEVE ' + @lcCadena
              ELSE @lcCadena
            END /* UNIDADES */
            -- Analizo las decenas
            SELECT @lcCadena =
            CASE /* DECENAS */
              WHEN @lnDecenas = 1 THEN
                CASE @lnUnidades
                  WHEN 0 THEN 'DIEZ '
                  WHEN 1 THEN 'ONCE '
                  WHEN 2 THEN 'DOCE '
                  WHEN 3 THEN 'TRECE '
                  WHEN 4 THEN 'CATORCE '
                  WHEN 5 THEN 'QUINCE '
                  WHEN 6 THEN 'DIEZ Y SEIS '
                  WHEN 7 THEN 'DIEZ Y SIETE '
                  WHEN 8 THEN 'DIEZ Y OCHO '
                  WHEN 9 THEN 'DIEZ Y NUEVE '
                END
              WHEN @lnDecenas = 2 THEN
              CASE @lnUnidades
                WHEN 0 THEN 'VEINTE '
                ELSE 'VEINTI' + @lcCadena
              END
              WHEN @lnDecenas = 3 THEN
              CASE @lnUnidades
                WHEN 0 THEN 'TREINTA '
                ELSE 'TREINTA Y ' + @lcCadena
              END
              WHEN @lnDecenas = 4 THEN
                CASE @lnUnidades
                    WHEN 0 THEN 'CUARENTA'
                    ELSE 'CUARENTA Y ' + @lcCadena
                END
              WHEN @lnDecenas = 5 THEN
                CASE @lnUnidades
                    WHEN 0 THEN 'CINCUENTA '
                    ELSE 'CINCUENTA Y ' + @lcCadena
                END
              WHEN @lnDecenas = 6 THEN
                CASE @lnUnidades
                    WHEN 0 THEN 'SESENTA '
                    ELSE 'SESENTA Y ' + @lcCadena
                END
              WHEN @lnDecenas = 7 THEN
                 CASE @lnUnidades
                    WHEN 0 THEN 'SETENTA '
                    ELSE 'SETENTA Y ' + @lcCadena
                 END
              WHEN @lnDecenas = 8 THEN
                CASE @lnUnidades
                    WHEN 0 THEN 'OCHENTA '
                    ELSE  'OCHENTA Y ' + @lcCadena
                END
              WHEN @lnDecenas = 9 THEN
                CASE @lnUnidades
                    WHEN 0 THEN 'NOVENTA '
                    ELSE 'NOVENTA Y ' + @lcCadena
                END
              ELSE @lcCadena
            END /* DECENAS */
            -- Analizo las centenas
            SELECT @lcCadena =
            CASE /* CENTENAS */
              WHEN @lnCentenas = 1 THEN 'CIENTO ' + @lcCadena
              WHEN @lnCentenas = 2 THEN 'DOSCIENTOS ' + @lcCadena
              WHEN @lnCentenas = 3 THEN 'TRESCIENTOS ' + @lcCadena
              WHEN @lnCentenas = 4 THEN 'CUATROCIENTOS ' + @lcCadena
              WHEN @lnCentenas = 5 THEN 'QUINIENTOS ' + @lcCadena
              WHEN @lnCentenas = 6 THEN 'SEISCIENTOS ' + @lcCadena
              WHEN @lnCentenas = 7 THEN 'SETECIENTOS ' + @lcCadena
              WHEN @lnCentenas = 8 THEN 'OCHOCIENTOS ' + @lcCadena
              WHEN @lnCentenas = 9 THEN 'NOVECIENTOS ' + @lcCadena
              ELSE @lcCadena
            END /* CENTENAS */
            -- Analizo la terna
            SELECT @lcCadena =
            CASE /* TERNA */
              WHEN @lnTerna = 1 THEN @lcCadena
              WHEN @lnTerna = 2 THEN @lcCadena + 'MIL '
              WHEN @lnTerna = 3 THEN @lcCadena + CASE WHEN @lnUnidades = 1 THEN 'MILLON ' ELSE 'MILLONES ' END
              WHEN @lnTerna = 4 THEN @lcCadena + 'MIL '
              ELSE ''
            END /* TERNA */
            -- Armo el retorno terna a terna
            SELECT @lcRetorno = @lcCadena  + @lcRetorno
            SELECT @lnTerna = @lnTerna + 1
   END /* WHILE */

   IF @lnTerna = 1
       SELECT @lcRetorno = 'CERO'
       
   DECLARE @sFraccion VARCHAR(15)

   SET @sFraccion = '00' + LTRIM(CAST(@lnFraccion AS varchar))

   SELECT @ImpLetra = RTRIM(@lcRetorno) + CASE WHEN @Paridad = 1 THEN ' PESOS ' ELSE ' DOLARES ' END + SUBSTRING(@sFraccion,LEN(@sFraccion)-1,2) + '/100 ' + CASE WHEN @Paridad = 1 THEN 'M.N.' ELSE '' END

   RETURN @ImpLetra

END


GO
/****** Object:  UserDefinedFunction [dbo].[Fmt_Espacios]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnSplit]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[fObtenerNombreMes]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[UnSplit]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Bitacora_Rep_Mensual_FE]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora_Rep_Mensual_FE](
	[intConsecutivo_ID] [int] IDENTITY(1,1) NOT NULL,
	[intUsuario_ID] [int] NOT NULL,
	[dtmFecha] [datetime] NOT NULL,
	[intSucursal_ID] [int] NOT NULL,
	[intMes] [int] NOT NULL,
	[intAño] [int] NOT NULL,
	[vchContenido] [text] NOT NULL,
 CONSTRAINT [PK_Bitacora_Rep_Mensual_FE] PRIMARY KEY CLUSTERED 
(
	[intConsecutivo_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[c_ClaveProdServ]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_ClaveUnidad]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_CodigoPostal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_FormaPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_Impuesto]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_MetodoPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_Moneda]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_Pais]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_RegimenFiscal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_TasaOCuota]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_TipoDeComprobante]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_TipoFactor]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[c_UsoCFDI]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Cab_Notas_Credito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cab_Notas_Credito](
	[intSucursal_ID] [int] NOT NULL,
	[intFolio_ID] [int] NOT NULL,
	[dmtFecha] [smalldatetime] NOT NULL,
	[dtmFecha_Registro] [smalldatetime] NOT NULL,
	[intCliente_ID] [int] NOT NULL,
	[vchMotivo] [varchar](100) NULL,
	[dtmFecha_Cancelacion] [smalldatetime] NULL,
	[vchTipo_Pago] [varchar](10) NOT NULL,
	[mnySubTotal] [money] NOT NULL,
	[mnyIVA] [money] NOT NULL,
	[mnyTotal] [money] NOT NULL,
	[mnyPIVA] [money] NOT NULL,
	[vchCadena_Original] [varchar](8000) NOT NULL,
	[vchSello] [varchar](2000) NOT NULL,
	[txtXMLFE] [text] NOT NULL,
	[vchSerie_Cert_SAT] [varchar](30) NOT NULL,
	[dtmFecha_Timbrado] [varchar](20) NOT NULL,
	[vchFolio_Fiscal] [varchar](40) NOT NULL,
	[vchSello_SAT] [varchar](8000) NOT NULL,
	[vchSello_CFD] [varchar](8000) NOT NULL,
	[vchCadena_Original_CFDI] [varchar](8000) NOT NULL,
	[vchXML_Timbre] [varchar](8000) NOT NULL,
	[txtXML_CFDI] [text] NOT NULL,
	[bitCancelada] [bit] NOT NULL,
 CONSTRAINT [PK_Cab_Notas_Credito_1] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[intFolio_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cab_Pagos]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cab_Pagos](
	[intSucursal_ID] [int] NOT NULL,
	[chrTipo_Documento] [char](1) NOT NULL,
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
	[intSucursal_ID] ASC,
	[chrTipo_Documento] ASC,
	[intPago_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cab_Ventas]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cab_Ventas](
	[intSucursal_ID] [int] NOT NULL CONSTRAINT [DF_Cab_Ventas_intSucursal_ID]  DEFAULT ((1)),
	[chrTipo_Documento] [char](1) NOT NULL,
	[intFolio_ID] [int] NOT NULL,
	[dmtFecha] [smalldatetime] NOT NULL,
	[dtmFecha_Registro] [smalldatetime] NOT NULL CONSTRAINT [DF_Cab_Ventas_dtmFecha_Registro]  DEFAULT (getdate()),
	[intCliente_ID] [int] NOT NULL,
	[vchMotivo] [varchar](100) NULL,
	[dtmFecha_Cancelacion] [smalldatetime] NULL,
	[vchTipo_Pago] [varchar](10) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchTipo_Pago]  DEFAULT (' '),
	[mnySubTotal] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnySubTotal]  DEFAULT ((0)),
	[mnyIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyIVA]  DEFAULT ((0)),
	[mnyRetIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyRetIVA]  DEFAULT ((0)),
	[mnyRetISR] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyRetISR]  DEFAULT ((0)),
	[mnyTotal] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyTotal]  DEFAULT ((0)),
	[mnyPIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyPIVA]  DEFAULT ((0)),
	[mnyPRetIVA] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyPRetIVA]  DEFAULT ((0)),
	[mnyPRetISR] [money] NOT NULL CONSTRAINT [DF_Cab_Ventas_mnyPRetISR]  DEFAULT ((0)),
	[vchCadena_Original] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchCadena_Original]  DEFAULT (''),
	[vchSello] [varchar](2000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSello]  DEFAULT (''),
	[txtXMLFE] [text] NOT NULL CONSTRAINT [DF_Cab_Ventas_txtXMLFE]  DEFAULT (''),
	[vchSerie_Cert_SAT] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSerie_Cert_SAT]  DEFAULT (''),
	[dtmFecha_Timbrado] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_dtmFecha_Timbrado]  DEFAULT (''),
	[vchFolio_Fiscal] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchFolio_Fiscal]  DEFAULT (''),
	[vchSello_SAT] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSello_SAT]  DEFAULT (''),
	[vchSello_CFD] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchSello_CFD]  DEFAULT (''),
	[vchCadena_Original_CFDI] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchCadena_Original_CFDI]  DEFAULT (''),
	[vchXML_Timbre] [varchar](8000) NOT NULL CONSTRAINT [DF_Cab_Ventas_vchXML_Timbre]  DEFAULT (''),
	[txtXML_CFDI] [text] NOT NULL CONSTRAINT [DF_Cab_Ventas_txtXML_CFDI]  DEFAULT (''),
	[bitCancelada] [bit] NOT NULL CONSTRAINT [DF_Cab_Ventas_nitCancelada]  DEFAULT ((0)),
	[vchMetodoPago] [varchar](10) NULL CONSTRAINT [DF_Cab_Ventas_vchMetodoPago]  DEFAULT (''),
 CONSTRAINT [PK_Cab_Ventas] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[chrTipo_Documento] ASC,
	[intFolio_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[intCliente_ID] [int] NOT NULL,
	[vchRazonSocial] [varchar](80) NULL,
	[vchDireccion] [varchar](60) NULL,
	[vchNoInterior] [varchar](10) NULL,
	[vchNoExterior] [varchar](10) NULL,
	[vchColonia] [varchar](50) NULL,
	[vchCiudad] [varchar](20) NULL,
	[vchEstado] [varchar](20) NULL,
	[vchPais] [varchar](20) NULL,
	[vchCodigoPostal] [varchar](5) NULL,
	[vchTelefono] [varchar](40) NULL,
	[vchRFC] [varchar](20) NULL,
	[vchEmail] [varchar](40) NULL,
	[vchReferencia] [varchar](50) NULL,
	[bitPersonaFisica] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitPersonaFisica]  DEFAULT ((0)),
	[bitFacturarXConcepto] [char](1) NOT NULL CONSTRAINT [DF_Clientes_bitFacturarXConcepto]  DEFAULT ((0)),
	[bitEnviarCorreo] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitEnviarCorreo]  DEFAULT ((0)),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Clientes_bitActivo]  DEFAULT ((1)),
	[vchMetodoPago] [varchar](30) NOT NULL CONSTRAINT [DF_Clientes_vchMetodoPago]  DEFAULT (''),
	[vchCuentaBancaria] [varchar](20) NOT NULL CONSTRAINT [DF_Clientes_vchCuentaBancaria]  DEFAULT (''),
	[vchBanco] [varchar](20) NOT NULL CONSTRAINT [DF_Clientes_vchBanco]  DEFAULT (''),
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
/****** Object:  Table [dbo].[Configuracion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Configuracion](
	[vchFacturas] [varchar](1000) NULL CONSTRAINT [DF_Configuracion_Facturas]  DEFAULT ('"d'),
	[vchHonorarios] [varchar](1000) NULL CONSTRAINT [DF_Configuracion_Honorarios]  DEFAULT ('"d'),
	[vchNotas_Credito] [varchar](1000) NULL CONSTRAINT [DF_Configuracion_Notas_Credito]  DEFAULT ('"d'),
	[vchSucursales] [varchar](1000) NULL CONSTRAINT [DF_Configuracion_Sucursales]  DEFAULT ('*'),
	[vchOtros] [varchar](100) NULL CONSTRAINT [DF_Configuracion_vchOtros]  DEFAULT ('"d'),
	[bitCancFolio_PAC] [bit] NOT NULL CONSTRAINT [DF_Configuracion_bitCancelarXPAC]  DEFAULT ((0)),
	[bitTimbrar] [bit] NOT NULL CONSTRAINT [DF_Configuracion_bitTimbrar]  DEFAULT ((0))
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Configuracion_Correo]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Control_Folios]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Control_Folios](
	[intSucursal_ID] [int] NOT NULL,
	[chrTipo_Documento] [char](1) NOT NULL,
	[vchSerie] [varchar](10) NOT NULL,
	[intFolio] [int] NOT NULL,
 CONSTRAINT [PK_Control_Folios] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[chrTipo_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Datos_CFDI]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Datos_CFDI](
	[vchCodigo_Usuario] [varchar](50) NOT NULL CONSTRAINT [DF_Datos_CFDI_vchCodigo_Usuario]  DEFAULT (''),
	[vchClave] [varchar](1000) NULL CONSTRAINT [DF_Datos_CFDI_vchClave]  DEFAULT (''),
	[vchCodigo_Proveedor] [varchar](50) NOT NULL CONSTRAINT [DF_Datos_CFDI_vchCodigo_Proveedor]  DEFAULT (''),
	[intSucursal_CFDI] [int] NOT NULL CONSTRAINT [DF_Datos_CFDI_intSucursal_CFDI]  DEFAULT ((0)),
	[intPAC_ID] [int] NULL,
	[vchVersion] [varchar](10) NOT NULL CONSTRAINT [DF_Datos_CFDI_intVersion]  DEFAULT ('')
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Datos_FacturaElectronica]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Datos_FacturaElectronica](
	[intSucursal_ID] [int] NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_Sucursal_ID]  DEFAULT ((1)),
	[imgCedula] [image] NULL,
	[vchVersion] [varchar](5) NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_Version]  DEFAULT (''),
	[dtmFecha_IniCertificado] [smalldatetime] NULL,
	[dtmFecha_FinCertificado] [smalldatetime] NULL,
	[vchCertificadoPEM] [varchar](4000) NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_CertificadoPEM]  DEFAULT (''),
	[vchCertificadoPublico] [varchar](max) NULL,
	[vchNo_Serie_Certificado] [varchar](50) NOT NULL CONSTRAINT [DF_Datos_FacturaElectronica_No_Serie_Certificado]  DEFAULT (''),
	[intPAC_ID] [int] NULL CONSTRAINT [DF_Datos_FacturaElectronica_intPAC_ID]  DEFAULT ((0)),
	[vchCertificado_Key_Pwd] [varchar](200) NULL,
 CONSTRAINT [PK_Datos_FacturaElectronica] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Det_Notas_Credito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Det_Notas_Credito](
	[intSucursal_ID] [int] NOT NULL,
	[intFolio_ID] [int] NOT NULL,
	[intRenglon] [int] NOT NULL,
	[intFactura_ID] [int] NOT NULL,
	[vchSerie_Factura] [varchar](20) NOT NULL,
	[vchNotas] [varchar](300) NOT NULL,
	[mnyImporte] [money] NOT NULL,
 CONSTRAINT [PK_Det_Notas_Credito_1] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[intFolio_ID] ASC,
	[intRenglon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Det_Pagos]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Det_Pagos](
	[intSucursal_ID] [int] NOT NULL,
	[chrTipo_Documento] [char](1) NOT NULL,
	[intPago_ID] [int] NOT NULL,
	[intFactura_ID] [int] NOT NULL,
	[intParcialidad] [smallint] NOT NULL,
	[mnySaldo_Anterior] [money] NOT NULL,
	[mnySaldo_Pendiente] [money] NOT NULL,
	[mnyMonto_Pagado] [money] NOT NULL,
 CONSTRAINT [PK_Det_Pagos] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[chrTipo_Documento] ASC,
	[intPago_ID] ASC,
	[intFactura_ID] ASC,
	[intParcialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Det_Retenciones]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Det_Retenciones](
	[intSucursal_ID] [int] NOT NULL,
	[chrTipo_Documento] [char](1) NOT NULL,
	[intFolio_ID] [int] NOT NULL,
	[intRenglon] [smallint] NOT NULL,
	[intRetencion_ID] [int] NOT NULL,
	[mnyPorcentaje] [money] NOT NULL,
	[mnyImporte] [money] NOT NULL,
 CONSTRAINT [PK_Det_Retenciones] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[chrTipo_Documento] ASC,
	[intFolio_ID] ASC,
	[intRenglon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Det_Ventas]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Det_Ventas](
	[intSucursal_ID] [int] NOT NULL,
	[chrTipo_Documento] [char](1) NOT NULL,
	[intFolio_ID] [int] NOT NULL,
	[intRenglon] [smallint] NOT NULL,
	[intProducto_ID] [int] NULL,
	[intUnidad_ID] [int] NULL,
	[mnyCantidad] [money] NOT NULL,
	[mnyPrecio] [money] NOT NULL,
	[mnyImporte] [money] NOT NULL,
	[vchDescripcion_Producto] [varchar](1000) NULL,
	[vchClaveProdServ] [varchar](50) NOT NULL CONSTRAINT [DF_Det_Ventas_vchClaveProdServ]  DEFAULT (''),
	[vchNoIdentificacion] [varchar](50) NOT NULL CONSTRAINT [DF_Det_Ventas_vchNoIdentificacion]  DEFAULT (''),
	[vchUnidad] [varchar](20) NOT NULL CONSTRAINT [DF_Det_Ventas_vchUnidad]  DEFAULT (''),
	[mnyPIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyPIVA]  DEFAULT ((0)),
	[mnyPRetISR] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyPRetISR]  DEFAULT ((0)),
	[mnyPRetIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyPRetIVA]  DEFAULT ((0)),
	[mnyIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyIVA]  DEFAULT ((0)),
	[mnyRetISR] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyRetISR]  DEFAULT ((0)),
	[mnyRetIVA] [money] NOT NULL CONSTRAINT [DF_Det_Ventas_mnyRetIVA]  DEFAULT ((0)),
 CONSTRAINT [PK_Det_Ventas_1] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC,
	[chrTipo_Documento] ASC,
	[intFolio_ID] ASC,
	[intRenglon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Error_Log]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Error_Log](
	[Error_Description] [varchar](8000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Errores]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Ivas]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Numero_Letra]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Numero_Letra](
	[intNumero] [int] NULL CONSTRAINT [DF_Numero_Letra_intNumero]  DEFAULT ((0)),
	[vchEspanol] [varchar](50) NULL,
	[vchIngles] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pacs_Autorizados]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Parametros]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Parametros](
	[intSucursal_ID] [int] NOT NULL,
	[vchRazonSocial] [varchar](80) NOT NULL,
	[vchDireccion] [varchar](60) NOT NULL,
	[vchNoInterior] [varchar](10) NULL,
	[vchNoExterior] [varchar](10) NOT NULL,
	[vchColonia] [varchar](50) NOT NULL,
	[vchCiudad] [varchar](20) NOT NULL,
	[vchEstado] [varchar](20) NOT NULL,
	[vchPais] [varchar](20) NOT NULL,
	[vchCodigoPostal] [varchar](5) NOT NULL,
	[vchTelefono] [varchar](40) NULL,
	[vchRFC] [varchar](20) NOT NULL,
	[vchRepresentante_Legal] [varchar](60) NULL,
	[imgLogotipo] [image] NULL,
	[vchReferencia] [varchar](50) NULL,
 CONSTRAINT [PK_Parametros] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[intProducto_ID] [int] NOT NULL,
	[vchDescripcion] [varchar](900) NULL,
	[intUnidad_ID] [int] NULL CONSTRAINT [DF_Articulos_intUnidad_ID]  DEFAULT ((0)),
	[mnyPrecio] [money] NULL CONSTRAINT [DF_Productos_mnyPrecio]  DEFAULT ((0)),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Articulos_bitActivo]  DEFAULT ((1)),
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
/****** Object:  Table [dbo].[Regimen_Fiscales]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  Table [dbo].[Retenciones]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Retenciones](
	[intRetencion_ID] [int] NOT NULL,
	[vchNombreRetencion] [varchar](20) NOT NULL CONSTRAINT [DF_Retenciones_vchNombreRetencion]  DEFAULT (''),
	[mnyPorcentajeRetencion] [money] NOT NULL CONSTRAINT [DF_Retenciones_mnyPorcentajeRetencion]  DEFAULT ((0)),
	[bitMillar] [bit] NOT NULL CONSTRAINT [DF_Retenciones_bitMillar]  DEFAULT ((0)),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Retenciones_bitActivo]  DEFAULT ((1)),
 CONSTRAINT [PK_Retenciones] PRIMARY KEY CLUSTERED 
(
	[intRetencion_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RetencionesXCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RetencionesXCliente](
	[intCliente_ID] [int] NOT NULL,
	[intRetencion_ID] [int] NOT NULL,
	[intOrden] [int] NOT NULL,
 CONSTRAINT [PK_RetencionesXCliente] PRIMARY KEY CLUSTERED 
(
	[intCliente_ID] ASC,
	[intRetencion_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursales](
	[intSucursal_ID] [int] NOT NULL,
	[vchDescripcion] [varchar](20) NULL,
	[vchDireccion] [varchar](60) NULL,
	[vchNoInterior] [varchar](10) NULL,
	[vchNoExterior] [varchar](10) NULL,
	[vchColonia] [varchar](50) NULL,
	[vchCiudad] [varchar](20) NULL,
	[vchEstado] [varchar](20) NULL,
	[vchPais] [varchar](20) NULL,
	[vchCodigoPostal] [varchar](5) NULL,
	[vchTelefono] [varchar](40) NULL,
	[vchReferencia] [varchar](50) NULL,
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Sucursales_bitActivo]  DEFAULT ((1)),
 CONSTRAINT [PK_Sucursal] PRIMARY KEY CLUSTERED 
(
	[intSucursal_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Unidad_Medida]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Unidad_Medida_bitActivo]  DEFAULT ((1)),
 CONSTRAINT [PK_Unidad_Medida] PRIMARY KEY CLUSTERED 
(
	[intUnidad_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[intUsuario_ID] [int] NOT NULL,
	[vchNombreCompleto] [varchar](80) NULL,
	[vchUsuario] [varchar](10) NULL,
	[vchContrasena] [varchar](100) NULL,
	[intSucursal_ID] [int] NOT NULL,
	[vchTipo_Usuario] [varchar](100) NOT NULL CONSTRAINT [DF_Usuarios_vchTipo_Usuario]  DEFAULT (''),
	[vchAccesos] [varchar](100) NULL,
	[bitMultiSucursal] [bit] NOT NULL CONSTRAINT [DF_Usuarios_bitMultiSucursal]  DEFAULT ((0)),
	[bitActivo] [bit] NOT NULL CONSTRAINT [DF_Usuarios_bitActivo]  DEFAULT ((0)),
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[intUsuario_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vRetencionesXFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vRetencionesXFactura]
AS

SELECT intSucursal_ID, chrTipo_Documento, intFolio_ID, intRenglon, '001' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPretISR / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPRetISR / 100.00)) AS Importe FROM Det_Ventas
WHERE mnyPRetISR >= 0

UNION ALL

SELECT intSucursal_ID, chrTipo_Documento, intFolio_ID, intRenglon, '002' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPretIVA / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPretIVA / 100.00)) AS Importe FROM Det_Ventas
WHERE mnyPRetIVA >= 0




GO
/****** Object:  View [dbo].[vTotal_Amortizacion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTotal_Amortizacion]
AS
SELECT     intSucursal_ID, chrTipo_Documento, intFolio_ID, SUM(mnyImporte) AS mnyTotalAmortizacion
FROM         dbo.Det_Retenciones
WHERE     (mnyPorcentaje = 0)
GROUP BY intSucursal_ID, chrTipo_Documento, intFolio_ID


GO
/****** Object:  View [dbo].[vTrasladosXFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vTrasladosXFactura]
AS

SELECT intSucursal_ID, chrTipo_Documento, intFolio_ID, intRenglon, '002' AS Impuesto, CONVERT(DECIMAL(18,2),mnyImporte) AS Base, 'Tasa' AS TipoFactor, CONVERT(DECIMAL(18,6),mnyPIVA / 100.00) AS TasaOCuota, CONVERT(DECIMAL(18,2), mnyImporte * CONVERT(DECIMAL(18,6),mnyPIVA / 100.00)) AS Importe FROM Det_Ventas
WHERE mnyPIVA > 0




GO
/****** Object:  View [dbo].[vUltimaParcialidadXFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vUltimaParcialidadXFactura]
AS
SELECT intSucursal_ID, chrTipo_Documento, intPago_ID, intFactura_ID, MAX(intParcialidad) AS intParcialidad FROM dbo.Det_Pagos
GROUP BY intSucursal_ID, chrTipo_Documento, intPago_ID, intFactura_ID


GO
/****** Object:  Index [IX_Cab_Ventas]    Script Date: 26/06/2018 07:18:18 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Cab_Ventas] ON [dbo].[Cab_Ventas]
(
	[intFolio_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bitacora_Rep_Mensual_FE] ADD  CONSTRAINT [DF_Bitacora_Rep_Mensual_FE_intUsuario_ID]  DEFAULT ((0)) FOR [intUsuario_ID]
GO
ALTER TABLE [dbo].[Bitacora_Rep_Mensual_FE] ADD  CONSTRAINT [DF_Bitacora_Rep_Mensual_FE_dtmFecha]  DEFAULT (getdate()) FOR [dtmFecha]
GO
ALTER TABLE [dbo].[Bitacora_Rep_Mensual_FE] ADD  CONSTRAINT [DF_Bitacora_Rep_Mensual_FE_intSucursal_ID]  DEFAULT ((0)) FOR [intSucursal_ID]
GO
ALTER TABLE [dbo].[Bitacora_Rep_Mensual_FE] ADD  CONSTRAINT [DF_Bitacora_Rep_Mensual_FE_intMes]  DEFAULT ((0)) FOR [intMes]
GO
ALTER TABLE [dbo].[Bitacora_Rep_Mensual_FE] ADD  CONSTRAINT [DF_Bitacora_Rep_Mensual_FE_intAño]  DEFAULT ((0)) FOR [intAño]
GO
ALTER TABLE [dbo].[Bitacora_Rep_Mensual_FE] ADD  CONSTRAINT [DF_Bitacora_Rep_Mensual_FE_vchContenido]  DEFAULT ('') FOR [vchContenido]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_intSucursal_ID]  DEFAULT ((1)) FOR [intSucursal_ID]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_dtmFecha_Registro]  DEFAULT (getdate()) FOR [dtmFecha_Registro]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchTipo_Pago]  DEFAULT (' ') FOR [vchTipo_Pago]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_mnySubTotal]  DEFAULT ((0)) FOR [mnySubTotal]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_mnyIVA]  DEFAULT ((0)) FOR [mnyIVA]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_mnyTotal]  DEFAULT ((0)) FOR [mnyTotal]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_mnyPIVA]  DEFAULT ((0)) FOR [mnyPIVA]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchCadena_Original]  DEFAULT ('') FOR [vchCadena_Original]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchSello]  DEFAULT ('') FOR [vchSello]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_txtXMLFE]  DEFAULT ('') FOR [txtXMLFE]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchSerie_Cert_SAT]  DEFAULT ('') FOR [vchSerie_Cert_SAT]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_dtmFecha_Timbrado]  DEFAULT ('') FOR [dtmFecha_Timbrado]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchFolio_Fiscal]  DEFAULT ('') FOR [vchFolio_Fiscal]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchSello_SAT]  DEFAULT ('') FOR [vchSello_SAT]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchSello_CFD]  DEFAULT ('') FOR [vchSello_CFD]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchCadena_Original_CFDI]  DEFAULT ('') FOR [vchCadena_Original_CFDI]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_vchXML_Timbre]  DEFAULT ('') FOR [vchXML_Timbre]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_txtXML_CFDI]  DEFAULT ('') FOR [txtXML_CFDI]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] ADD  CONSTRAINT [DF_Cab_Notas_Credito_nitCancelada]  DEFAULT ((0)) FOR [bitCancelada]
GO
ALTER TABLE [dbo].[Cab_Pagos] ADD  CONSTRAINT [DF_Pagos_intSucursal_ID]  DEFAULT ((1)) FOR [intSucursal_ID]
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
ALTER TABLE [dbo].[Det_Retenciones] ADD  CONSTRAINT [DF_Det_Retenciones_mnyPorcentaje]  DEFAULT ((0)) FOR [mnyPorcentaje]
GO
ALTER TABLE [dbo].[Det_Retenciones] ADD  CONSTRAINT [DF_Det_Retenciones_mnyImporte]  DEFAULT ((0)) FOR [mnyImporte]
GO
ALTER TABLE [dbo].[RetencionesXCliente] ADD  CONSTRAINT [DF_RetencionesXCliente_intOrden]  DEFAULT ((0)) FOR [intOrden]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito]  WITH CHECK ADD  CONSTRAINT [FK_Cab_Notas_Credito_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] CHECK CONSTRAINT [FK_Cab_Notas_Credito_Clientes]
GO
ALTER TABLE [dbo].[Cab_Notas_Credito]  WITH CHECK ADD  CONSTRAINT [FK_Cab_Notas_Credito_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Cab_Notas_Credito] CHECK CONSTRAINT [FK_Cab_Notas_Credito_Sucursales]
GO
ALTER TABLE [dbo].[Cab_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Pagos_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Cab_Pagos] CHECK CONSTRAINT [FK_Pagos_Sucursales]
GO
ALTER TABLE [dbo].[Cab_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Cab_Ventas_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[Cab_Ventas] CHECK CONSTRAINT [FK_Cab_Ventas_Clientes]
GO
ALTER TABLE [dbo].[Cab_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Cab_Ventas_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Cab_Ventas] CHECK CONSTRAINT [FK_Cab_Ventas_Sucursales]
GO
ALTER TABLE [dbo].[Control_Folios]  WITH CHECK ADD  CONSTRAINT [FK_Control_Folios_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Control_Folios] CHECK CONSTRAINT [FK_Control_Folios_Sucursales]
GO
ALTER TABLE [dbo].[Datos_FacturaElectronica]  WITH CHECK ADD  CONSTRAINT [FK_Datos_FacturaElectronica_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Datos_FacturaElectronica] CHECK CONSTRAINT [FK_Datos_FacturaElectronica_Sucursales]
GO
ALTER TABLE [dbo].[Det_Notas_Credito]  WITH CHECK ADD  CONSTRAINT [FK_Det_Notas_Credito_Cab_Notas_Credito] FOREIGN KEY([intSucursal_ID], [intFolio_ID])
REFERENCES [dbo].[Cab_Notas_Credito] ([intSucursal_ID], [intFolio_ID])
GO
ALTER TABLE [dbo].[Det_Notas_Credito] CHECK CONSTRAINT [FK_Det_Notas_Credito_Cab_Notas_Credito]
GO
ALTER TABLE [dbo].[Det_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Det_Pagos_Cab_Ventas] FOREIGN KEY([intFactura_ID])
REFERENCES [dbo].[Cab_Ventas] ([intFolio_ID])
GO
ALTER TABLE [dbo].[Det_Pagos] CHECK CONSTRAINT [FK_Det_Pagos_Cab_Ventas]
GO
ALTER TABLE [dbo].[Det_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Det_Pagos_Det_Pagos] FOREIGN KEY([intSucursal_ID], [chrTipo_Documento], [intPago_ID], [intFactura_ID], [intParcialidad])
REFERENCES [dbo].[Det_Pagos] ([intSucursal_ID], [chrTipo_Documento], [intPago_ID], [intFactura_ID], [intParcialidad])
GO
ALTER TABLE [dbo].[Det_Pagos] CHECK CONSTRAINT [FK_Det_Pagos_Det_Pagos]
GO
ALTER TABLE [dbo].[Det_Retenciones]  WITH CHECK ADD  CONSTRAINT [FK_Det_Retenciones_Cab_Ventas] FOREIGN KEY([intSucursal_ID], [chrTipo_Documento], [intFolio_ID])
REFERENCES [dbo].[Cab_Ventas] ([intSucursal_ID], [chrTipo_Documento], [intFolio_ID])
GO
ALTER TABLE [dbo].[Det_Retenciones] CHECK CONSTRAINT [FK_Det_Retenciones_Cab_Ventas]
GO
ALTER TABLE [dbo].[Det_Retenciones]  WITH CHECK ADD  CONSTRAINT [FK_Det_Retenciones_Retenciones] FOREIGN KEY([intRetencion_ID])
REFERENCES [dbo].[Retenciones] ([intRetencion_ID])
GO
ALTER TABLE [dbo].[Det_Retenciones] CHECK CONSTRAINT [FK_Det_Retenciones_Retenciones]
GO
ALTER TABLE [dbo].[Det_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Det_Ventas_Cab_Ventas] FOREIGN KEY([intSucursal_ID], [chrTipo_Documento], [intFolio_ID])
REFERENCES [dbo].[Cab_Ventas] ([intSucursal_ID], [chrTipo_Documento], [intFolio_ID])
GO
ALTER TABLE [dbo].[Det_Ventas] CHECK CONSTRAINT [FK_Det_Ventas_Cab_Ventas]
GO
ALTER TABLE [dbo].[Det_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Det_Ventas_Productos] FOREIGN KEY([intProducto_ID])
REFERENCES [dbo].[Productos] ([intProducto_ID])
GO
ALTER TABLE [dbo].[Det_Ventas] CHECK CONSTRAINT [FK_Det_Ventas_Productos]
GO
ALTER TABLE [dbo].[Det_Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Det_Ventas_Unidad_Medida] FOREIGN KEY([intUnidad_ID])
REFERENCES [dbo].[Unidad_Medida] ([intUnidad_ID])
GO
ALTER TABLE [dbo].[Det_Ventas] CHECK CONSTRAINT [FK_Det_Ventas_Unidad_Medida]
GO
ALTER TABLE [dbo].[Parametros]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Parametros] CHECK CONSTRAINT [FK_Parametros_Sucursales]
GO
ALTER TABLE [dbo].[Productos]  WITH NOCHECK ADD  CONSTRAINT [FK_Productos_Unidad_Medida] FOREIGN KEY([intUnidad_ID])
REFERENCES [dbo].[Unidad_Medida] ([intUnidad_ID])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Unidad_Medida]
GO
ALTER TABLE [dbo].[RetencionesXCliente]  WITH CHECK ADD  CONSTRAINT [FK_RetencionesXCliente_Clientes] FOREIGN KEY([intCliente_ID])
REFERENCES [dbo].[Clientes] ([intCliente_ID])
GO
ALTER TABLE [dbo].[RetencionesXCliente] CHECK CONSTRAINT [FK_RetencionesXCliente_Clientes]
GO
ALTER TABLE [dbo].[RetencionesXCliente]  WITH CHECK ADD  CONSTRAINT [FK_RetencionesXCliente_Retenciones] FOREIGN KEY([intRetencion_ID])
REFERENCES [dbo].[Retenciones] ([intRetencion_ID])
GO
ALTER TABLE [dbo].[RetencionesXCliente] CHECK CONSTRAINT [FK_RetencionesXCliente_Retenciones]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Sucursales] FOREIGN KEY([intSucursal_ID])
REFERENCES [dbo].[Sucursales] ([intSucursal_ID])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Sucursales]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizaBitacora]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ActualizaBitacora]
	@Usuario		int,
	@Sucursal_ID	int,
	@Mes			int,
	@Año			int,
	@Contenido		text
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Status int

	BEGIN TRANSACTION

    Insert Into Bitacora_Rep_Mensual_FE(intUsuario_ID, intSucursal_ID, intMes, intAño, vchContenido)
    VALUES (@usuario, @Sucursal_ID, @Mes, @Año, @Contenido)

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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarClaveProdServ]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarCliente]
	@Cliente_ID		int,
	@RazonSocial	varchar(80),
	@Direccion		varchar(60),
	@NoInterior		varchar(10),
	@NoExterior		varchar(10),
	@Colonia		varchar(50),
	@Ciudad			varchar(20),
	@Estado			varchar(20),
	@Pais			varchar(20),
	@CodigoPostal	varchar(10),
	@Telefono		varchar(40),
	@RFC			varchar(20),
	@Email			varchar(40),
	@Activo			int,
	@PersonaFisica	int,
	@FacturarXConc	int,
	@EnviarCorreo	int,
	@Operacion		char(1),
	@MetodoPago		varchar(300),
	@Ctabancaria	varchar(20),
	@Banco			varchar(20),
	@Uso_CFDI		varchar(10),
	@FormaPago		varchar(10)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intCliente_ID) FROM Clientes),0) + 1
		INSERT INTO Clientes (intCliente_ID, vchRazonSocial, vchDireccion, vchNoInterior, vchNoExterior, vchColonia, vchCiudad, vchEstado, vchPais, vchCodigoPostal, vchTelefono, vchRFC, vchEmail, bitPersonaFisica, bitFacturarXConcepto, bitEnviarCorreo, bitActivo, vchMetodoPago, vchCuentaBancaria, vchBanco, vchUso_CFDI, vchFormaPago) VALUES (@ID, @RazonSocial, @Direccion, @NoInterior, @NoExterior, @Colonia, @Ciudad, @Estado, @Pais, @CodigoPostal, @Telefono, @RFC, @Email, @PersonaFisica, @FacturarXConc, @EnviarCorreo, @Activo, REPLACE(REPLACE(@MetodoPago,';',','),'"',''), @CtaBancaria, @Banco,@Uso_CFDI, @FormaPago)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Clientes SET  vchRazonSocial = @RazonSocial, vchNoInterior = @NoInterior, vchNoExterior = @NoExterior, vchColonia =  @Colonia, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchRFC = @RFC, vchEmail = @Email, vchPais = @Pais, bitActivo = @Activo, bitPersonaFisica = @PersonaFisica, bitFacturarXConcepto = @FacturarXConc, bitEnviarCorreo = @EnviarCorreo, vchMetodoPago = REPLACE(REPLACE(@MetodoPago,';',','),'"',''), vchCuentaBancaria = @CtaBancaria, vchBanco = @Banco, vchUso_CFDI = @Uso_CFDI, vchFormaPago = @FormaPago
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

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarConfiguracion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarConfiguracion]
	@Facturas		varchar(1000),
	@Honorarios		varchar(1000),
	@NotasCredito	varchar(1000),
	@NoSucursales	varchar(1000),
	@Otros			varchar(1000)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int

	BEGIN TRANSACTION

	IF ISNULL((SELECT COUNT(*) FROM Configuracion),0) = 0
	BEGIN
		INSERT INTO Configuracion (vchFacturas, vchHonorarios, vchNotas_Credito, vchSucursales, vchOtros) VALUES (@Facturas, @Honorarios, @NotasCredito, @NoSucursales, @Otros)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Configuracion SET vchFacturas = @Facturas, vchHonorarios = @Honorarios, vchNotas_Credito = @NotasCredito, vchSucursales = @NoSucursales, vchOtros = @Otros
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarFactura]
	@Sucursal_ID	int,
	@Cliente_ID		int,
	@Tipo_Documento	char(1),
	@NoFolio		int,
	@IVA_ID			int,
	@Fecha_Param	varchar(50),
	@Productos		varchar(8000),
	@Forma_Pago		varchar(10),
	@Descuentos		varchar(8000),
	@MetodoPago		varchar(10)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @NoFolio <> ISNULL((SELECT intFolio + 1 FROM Control_Folios WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento),0) 
		GOTO ERROR

	DECLARE @Status int, @Xml xml, @Query_CUR varchar(MAX), @Renglon int, @RenglonRet int, @Posicion int, @Caracter char(1), @Contador int, @Producto_ID varchar(1000), @Cantidad varchar(100), @Precio varchar(100), @Cantidad_Procesada bit, @Precio_Procesado int, @Producto_Procesado int, @MaxLen int
	DECLARE @IVA decimal(18,2), @RetIVA decimal(18,2), @RetISR decimal(18,2), @SubTotal decimal(18,2), @Tot_IVA decimal(18,2), @Tot_RetIVA decimal(18,2), @Tot_RetISR decimal(18,2), @Fecha datetime, @Amortizacion decimal(18,2), @Persona_Fisica bit

	BEGIN TRY

		SET @Xml = CONVERT(XML,@Productos)
		SET @Fecha = CONVERT(DATETIME,@Fecha_Param)
		SET @MaxLen = (SELECT LEN(LTRIM(RTRIM(CONVERT(CHAR,MAX(intProducto_ID))))) FROM Productos)
		SET @Persona_Fisica = (SELECT bitPersonaFisica FROM Clientes WHERE intCliente_ID = @Cliente_ID)

		CREATE TABLE #Productos (
		intRenglon			int,
		intProducto_ID		int,
		mnyCantidad			decimal(18,2),
		mnyPrecio			decimal(18,2),
		vchProducto_Desc	varchar(2000),
		vchClaveProdServ	varchar(50),
		vchNoIdentificacion	varchar(50),
		vchUnidad			varchar(20))

		CREATE TABLE #Descuentos (
		intRenglon			int,
		intRetencion_ID		int,
		mnyPorcentaje		decimal(18,2),
		mnyImporte			decimal(18,2))

		SELECT @IVA = mnyIVA, @RetIVA = CASE WHEN @Tipo_Documento = 'H' AND @Persona_Fisica = 0 OR (@Tipo_Documento = 'F' AND mnyRetIVA <> 0) THEN mnyRetIVA ELSE 0 END, @RetISR = CASE WHEN @Tipo_Documento = 'H' AND @Persona_Fisica = 0 THEN mnyRetISR ELSE 0 END FROM Ivas WHERE intIva_ID = @IVA_ID

		SET @SubTotal = 0
		SET @Tot_IVA = 0
		SET @Tot_RetIVA = 0
		SET @Tot_RetISR = 0

	------------  Obtener datos de Productos

		INSERT INTO #Productos (intRenglon, intProducto_ID, mnyCantidad, mnyPrecio, vchProducto_Desc, vchClaveProdServ, vchNoIdentificacion, vchUnidad)
		SELECT Info.value('(Renglon/text())[1]','VARCHAR(100)') AS Ren,
				Info.value('(Producto_ID/text())[1]','VARCHAR(100)') AS ID,
				Info.value('(Cantidad/text())[1]','VARCHAR(100)') AS Cantidad,
				Info.value('(Precio/text())[1]','VARCHAR(100)') AS Precio,
				Info.value('(Descripcion/text())[1]','VARCHAR(100)') AS Descripcion,
				Info.value('(CveProdServ/text())[1]','VARCHAR(100)') AS CveProdServ,
				Info.value('(NoIdentificacion/text())[1]','VARCHAR(100)') AS NoIdentificacion,
				Info.value('(Unidad/text())[1]','VARCHAR(100)') AS Unidad
		FROM @Xml.nodes('/Productos/Producto') AS TEMPTABLE(Info)

		UPDATE #Productos SET vchProducto_Desc = REPLACE(vchProducto_Desc,'~','|')

		SET @Renglon = ISNULL((SELECT COUNT(*) FROM #Productos),0) + 1

	------------ Obtener Datos de Descuentos

		select * from #Productos

		SET @RenglonRet = @Renglon
		SET @Posicion = 1
		SET @Contador = LEN(@Descuentos)
		SET @Cantidad_Procesada = 0
		SET @Precio_Procesado = 0
		SET @Producto_Procesado = 0
		SET @Cantidad = ' '
		SET @Precio = ' '
		SET @Producto_ID = ''

		WHILE @Contador <> 0
		BEGIN

			SET @Caracter = SUBSTRING(@Descuentos,@Posicion,1) 

			IF @Producto_Procesado = 0
			BEGIN
				IF @Caracter <> '-'
					SET @Producto_ID = @Producto_ID + @Caracter
				ELSE
					SET @Producto_Procesado = 1
			END

			IF @Producto_Procesado = 1 AND @Cantidad_Procesada = 0 AND @Caracter <> '-'
			BEGIN
				IF @Caracter <> '='
					SET @Cantidad = RTRIM(@Cantidad) + @Caracter
				ELSE
					SET @Cantidad_Procesada = 1
			END

			IF @Producto_Procesado = 1 AND @Cantidad_Procesada = 1 AND @Precio_Procesado = 0 AND @Caracter <> '='
			BEGIN
				IF @Caracter <> ','
					SET @Precio = RTRIM(@Precio) + @Caracter
				ELSE
					SET @Precio_Procesado = 1
			END

			IF @Producto_Procesado = 1 AND @Cantidad_Procesada = 1 AND @Precio_Procesado = 1
			BEGIN
				INSERT INTO #Descuentos (intRenglon, intRetencion_ID, mnyPorcentaje, mnyImporte) 
				VALUES (@RenglonRet, CONVERT(INT,@Producto_ID), CONVERT(decimal(18,2),@Cantidad), CONVERT(decimal(18,2),@Precio))

				SET @Cantidad_Procesada = 0
				SET @Precio_Procesado = 0
				SET @Producto_Procesado = 0

				SET @Producto_ID = ' '
				SET @Cantidad = ' '
				SET @Precio = ' '
				SET @RenglonRet = @RenglonRet + 1
			END

			SET @Posicion = @Posicion + 1
			SET @Contador = @Contador - 1

		END

		SET @SubTotal = ISNULL((SELECT SUM(mnyCantidad * mnyPrecio) FROM #Productos),0)
		SET @Amortizacion = ISNULL((SELECT mnyImporte FROM #Descuentos WHERE mnyPorcentaje = 0),0)

		SET @SubTotal = @SubTotal - @Amortizacion
	
		SET @RetIVA = CASE WHEN @Persona_Fisica = 0 THEN @RetIVA ELSE 0 END
	
		SET @Tot_IVA = @SubTotal * (@IVA / CONVERT(decimal(18,2),100))
		SET @Tot_RetIVA = @SubTotal * CASE WHEN @Persona_Fisica = 0 THEN (@RetIVA / CONVERT(decimal(18,2),100)) ELSE 0 END
		SET @Tot_RetISR = @SubTotal * CASE WHEN @Persona_Fisica = 0 THEN (@RetISR / CONVERT(decimal(18,2),100)) ELSE 0 END

	--	BEGIN TRANSACTION

		UPDATE Control_Folios SET intFolio = intFolio + 1 
		WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento
		SET @Status = @@ROWCOUNT

		IF @Status <> 0
		BEGIN
			INSERT INTO Cab_Ventas (intSucursal_ID, chrTipo_Documento, intFolio_ID, dmtFecha, dtmFecha_Registro, intCliente_ID, vchTipo_Pago, mnySubTotal, mnyIVA, mnyRetIVA, mnyRetISR, mnyTotal, mnyPIVA, mnyPRetIVA, mnyPRetISR, vchMetodoPago)
			VALUES (@Sucursal_ID, @Tipo_Documento, @NoFolio, @Fecha, GETDATE(), @Cliente_ID, @Forma_Pago, @SubTotal, @Tot_IVA, @Tot_RetIVA, @Tot_RetISR, @SubTotal + @Tot_IVA - @Tot_RetIVA - @Tot_RetISR, @IVA, @RetIVA, @RetISR, @MetodoPago)
			SET @Status = @@ROWCOUNT
		END

		IF @Status <> 0
		BEGIN
			INSERT INTO Det_Ventas (intSucursal_ID, chrTipo_Documento, intFolio_ID, intRenglon, intProducto_ID, intUnidad_ID, mnyCantidad, mnyPrecio, mnyImporte, vchDescripcion_Producto, vchClaveProdServ, vchNoIdentificacion, vchUnidad, mnyPIVA, mnyPRetISR, mnyPRetIVA, mnyIVA, mnyRetISR, mnyRetIVA)
			SELECT @Sucursal_ID, @Tipo_Documento, @NoFolio, intRenglon, CASE WHEN ISNULL(vchProducto_Desc,'') <> '' THEN NULL ELSE #Productos.intProducto_ID END, CASE WHEN ISNULL(intUnidad_ID,0) = 0 THEN NULL ELSE intUnidad_ID END, mnyCantidad, #Productos.mnyPrecio, (mnyCantidad * #Productos.mnyPrecio), vchProducto_Desc, #Productos.vchClaveProdServ, #Productos.vchNoIdentificacion, #Productos.vchUnidad, 
				@IVA, 
				@RetISR, 
				@RetIVA, 
				(mnyCantidad * #Productos.mnyPrecio) * (@IVA / CONVERT(decimal(18,2),100)), 
				(mnyCantidad * #Productos.mnyPrecio) * CASE WHEN @Persona_Fisica = 0 THEN (@RetISR / CONVERT(decimal(18,2),100)) ELSE 0 END, 
				(mnyCantidad * #Productos.mnyPrecio) * CASE WHEN @Persona_Fisica = 0 THEN (@RetIVA / CONVERT(decimal(18,2),100)) ELSE 0 END 
			FROM #Productos 
			LEFT OUTER JOIN Productos ON #Productos.intProducto_ID = Productos.intProducto_ID
			SET @Status = @@ROWCOUNT

			IF @Status <> 0	AND ISNULL((SELECT COUNT(*) FROM #Descuentos),0) > 0
			BEGIN
				INSERT INTO Det_Ventas (intSucursal_ID, chrTipo_Documento, intFolio_ID, intRenglon, intProducto_ID, intUnidad_ID, mnyCantidad, mnyPrecio, mnyImporte, vchDescripcion_Producto, vchClaveProdServ, vchNoIdentificacion, vchUnidad, mnyPIVA, mnyPRetISR, mnyPRetIVA, mnyIVA, mnyRetISR, mnyRetIVA)
				SELECT @Sucursal_ID, @Tipo_Documento, @NoFolio, intRenglon, 0, 0, 0, mnyImporte, mnyImporte, vchNombreRetencion, '', '', '', 0, 0, 0, 0, 0, 0 FROM #Descuentos
				INNER JOIN Retenciones ON #Descuentos.intRetencion_ID = Retenciones.intRetencion_ID
				WHERE mnyPorcentaje = 0 AND mnyImporte > 0
			END
		END

		IF @Status <> 0 AND @Descuentos <> ''
		BEGIN
			INSERT INTO Det_Retenciones (intSucursal_ID, chrTipo_Documento, intFolio_ID, intRenglon, intRetencion_ID, mnyPorcentaje, mnyImporte)
			SELECT @Sucursal_ID, @Tipo_Documento, @NoFolio, intRenglon - @Renglon, intRetencion_ID, mnyPorcentaje, mnyImporte FROM #Descuentos
			SET @Status = @@ROWCOUNT
		END

	END TRY

	BEGIN CATCH
		INSERT INTO Error_log VALUES (ERROR_MESSAGE())
		RETURN ERROR_NUMBER()
	END CATCH

	IF @Status <> 0
	BEGIN
--		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
--		ROLLBACK TRANSACTION
		RETURN 99
	END

	DROP TABLE #Productos
	DROP TABLE #Descuentos

ERROR:

	INSERT INTO Error_Log VALUES ('Folio Erroneo: ' + CONVERT(VARCHAR,@NoFolio))
	RETURN 99

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarIva]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarNotaCredito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ActualizarNotaCredito]
	@Sucursal_ID	int,
	@Cliente_ID		int,
	@Folio_ID		int,
	@NoFolio		int,
	@Serie			varchar(10),
	@IVA_ID			int,
	@Fecha			datetime,
	@Conceptos		varchar(8000),
	@Tipo_Pago		varchar(10)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @NoFolio <> ISNULL((SELECT intFolio FROM Control_Folios WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = 'N'),0) 
		GOTO ERROR

	DECLARE @Status int, @Renglon int, @Posicion int, @Caracter char(1), @Contador int, @Concepto varchar(300), @Factura varchar(10), @Importe varchar(20), @Factura_Procesada bit, @Importe_Procesado int, @Concepto_Procesado int
	DECLARE @IVA money, @SubTotal money, @Tot_IVA money

	CREATE TABLE #Conceptos (
	intRenglon		int,
	vchFactura_ID	varchar(20),
	vchConcepto		varchar(300),
	mnyImporte		money)

	SET @IVA = (SELECT mnyIVA FROM Ivas WHERE intIva_ID = @IVA_ID)
	
	SET @SubTotal = 0
	SET @Tot_IVA = 0

	SET @Renglon = 1
	SET @Posicion = 1
	SET @Contador = LEN(@Conceptos)
	SET @Factura_Procesada = 0
	SET @Importe_Procesado = 0
	SET @Concepto_Procesado = 0
	SET @Factura = ' '
	SET @Importe = ' '
	SET @Concepto = ' '

	WHILE @Contador <> 0
	BEGIN

		SET @Caracter = SUBSTRING(@Conceptos,@Posicion,1) 

		IF @Factura_Procesada = 0
		BEGIN
			IF @Caracter <> '-'
				SET @Factura = RTRIM(@Factura) + @Caracter
			ELSE
				SET @Factura_Procesada = 1
		END

		IF @Factura_Procesada = 1 AND @Concepto_Procesado = 0 AND @Caracter <> '-'
		BEGIN
			IF @Caracter <> '+'
				SET @Concepto = RTRIM(@Concepto) + @Caracter
			ELSE
				SET @Concepto_Procesado = 1
		END

		IF @Factura_Procesada = 1 AND @Concepto_Procesado = 1 AND @Importe_Procesado = 0 AND @Caracter <> '+'
		BEGIN
			IF @Caracter <> ','
				SET @Importe = RTRIM(@Importe) + @Caracter
			ELSE
				SET @Importe_Procesado = 1
		END

		IF @Factura_Procesada = 1 AND @Concepto_Procesado = 1 AND @Importe_Procesado = 1
		BEGIN
			INSERT INTO #Conceptos (intRenglon, vchFactura_ID, vchConcepto, mnyImporte) 
			VALUES (@Renglon, @Factura, @Concepto, CONVERT(MONEY,@Importe))

			SET @Factura_Procesada = 0
			SET @Importe_Procesado = 0
			SET @Concepto_Procesado = 0

			SET @Concepto = ' '
			SET @factura = ' '
			SET @Importe = ' '
			SET @Renglon = @Renglon + 1
		END

		SET @Posicion = @Posicion + 1
		SET @Contador = @Contador - 1

	END

	SELECT * FROM #Conceptos

	SELECT @SubTotal = SUM(mnyImporte) FROM #Conceptos
	SET @Tot_IVA = @SubTotal * (@IVA / CONVERT(MONEY,100))

	BEGIN TRANSACTION

	UPDATE Control_Folios SET intFolio = intFolio + 1 
	WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = 'N'
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Cab_Notas_Credito (intSucursal_ID, intFolio_ID, dmtFecha, dtmFecha_Registro, intCliente_ID, vchTipo_Pago, mnySubTotal, mnyIVA, mnyTotal, mnyPIVA)
		VALUES (@Sucursal_ID, @NoFolio, @Fecha, GETDATE(), @Cliente_ID, @Tipo_Pago, @SubTotal, @Tot_IVA, @SubTotal + @Tot_IVA, @IVA)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		INSERT INTO Det_Notas_Credito (intSucursal_ID, intFolio_ID, intRenglon, intFactura_ID, vchSerie_Factura, vchNotas, mnyImporte)
		SELECT @Sucursal_ID, @NoFolio, intRenglon, CONVERT(int,SUBSTRING(#Conceptos.vchFactura_ID,1, CHARINDEX( '/',#Conceptos.vchFactura_ID, 1) - 1)), RTRIM(SUBSTRING(#Conceptos.vchFactura_ID,CHARINDEX( '/',#Conceptos.vchFactura_ID, 1) + 1 ,10)), #Conceptos.vchConcepto, #Conceptos.mnyImporte FROM #Conceptos
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

	DROP TABLE #Conceptos

ERROR:

	RETURN 99

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarPago]
	@Sucursal_ID	int,
	@Cliente_ID		int,
	@Tipo_Documento	char(1),
	@Pago_ID		int,
	@MontoPagado	decimal(18,2),
	@ClaveProdServ	varchar(10),
	@Notas			varchar(200),
	@Facturas		varchar(8000)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Pago_ID <> ISNULL((SELECT intFolio + 1 FROM Control_Folios WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento),0) 
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

	UPDATE Control_Folios SET intFolio = intFolio + 1 
	WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento

	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
		INSERT INTO Cab_Pagos (intSucursal_ID, chrTipo_Documento, intPago_ID, dtmFecha_Registro, dtmFecha_Pago, vchClaveProdServ, mnyCantidad, vchDescripcion, vchUnidad, mnyPrecio, mnyImporte, mnyTotal, vchNotas)
		VALUES (@Sucursal_ID, @Tipo_Documento, @Pago_ID, GETDATE(), GETDATE(), @ClaveProdServ, 1, 'Pago', 'ACT', 0, 0, @MontoPagado, @Notas)
		SET @Status = @@ROWCOUNT
	END

	IF @Status <> 0
	BEGIN
		INSERT INTO Det_Pagos (intSucursal_ID, chrTipo_Documento, intPago_ID, intFactura_ID, intParcialidad, mnySaldo_Anterior, mnyMonto_Pagado, mnySaldo_Pendiente)
		SELECT @Sucursal_ID, @Tipo_Documento, @Pago_ID, F.intFactura_ID, ISNULL(P.intParcialidad + 1,1), F.mnySaldoAnt, F.mnyImpPagado, F.mnySaldo  FROM #Facturas F
		LEFT OUTER JOIN vUltimaParcialidadXFactura P ON P.intSucursal_ID = @Sucursal_ID AND P.chrTipo_Documento = @Tipo_Documento AND F.intFactura_ID = P.intFactura_ID

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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarParametros]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarParametros]
	@Sucursal_ID	int,
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

	IF ISNULL((SELECT COUNT(*) FROM Parametros WHERE intSucursal_ID = @Sucursal_ID),0) = 0
	BEGIN
		INSERT INTO Parametros (intSucursal_ID, vchRazonSocial, vchDireccion, vchNoInterior, vchNoExterior, vchColonia, vchCiudad, vchEstado, vchPais, vchCodigoPostal, vchTelefono, vchRFC, vchRepresentante_Legal) VALUES (@Sucursal_ID, @RazonSocial, @Direccion, @NoInterior, @NoExterior, @Colonia, @Ciudad, @Estado, @Pais, @CodigoPostal, @Telefono, @RFC, @Representante)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Parametros SET  vchRazonSocial = @RazonSocial, vchNoInterior = @NoInterior, vchNoExterior = @NoExterior, vchColonia =  @Colonia, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchRFC = @RFC, vchRepresentante_Legal = @Representante, vchPais = @Pais
		WHERE intSucursal_ID = @Sucursal_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarProducto]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarProducto]
	@Producto_ID		int,
	@Descripcion		varchar(900),
	@Unidad_ID			int,
	@PrecioVta			money,
	@ClaveProdServ		varchar(50),
	@Unidad				varchar(20),
	@NoIdentificacion	varchar(50),
	@Activo				int,
	@Operacion			char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intProducto_ID) FROM Productos),0) + 1

		INSERT INTO Productos (intProducto_ID, vchDescripcion, intUnidad_ID, mnyPrecio, bitActivo, vchClaveProdServ, vchUnidad, vchNoIdentificacion) VALUES (@ID, @Descripcion, @Unidad_ID, @PrecioVta, @Activo, @ClaveProdServ, @Unidad, @NoIdentificacion)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Productos SET vchDescripcion = @Descripcion, intUnidad_ID = @Unidad_ID, mnyPrecio = @PrecioVta, bitActivo = @Activo, vchClaveProdServ = @ClaveProdServ, vchUnidad = @Unidad, vchNoIdentificacion = @NoIdentificacion
		WHERE intProducto_ID = @Producto_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRegimenFiscal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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

	DECLARE @ID int, @Status int

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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRetencion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ActualizarRetencion]
	@Retencion_ID	int,
	@Nombre			varchar(20),
	@Porcentaje		money,
	@Millar			int,
	@Activo			int,
	@Operacion		char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intRetencion_ID) FROM Retenciones),0) + 1
		INSERT INTO Retenciones (intRetencion_ID, vchNombreRetencion, mnyPorcentajeRetencion, bitMillar, bitActivo) VALUES (@ID, @Nombre, @Porcentaje, @Millar, @Activo)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Retenciones SET vchNombreRetencion = @Nombre, mnyPorcentajeRetencion = @Porcentaje, bitMillar = @Millar, bitActivo = @Activo
				 WHERE intRetencion_ID = @Retencion_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarRetencionesXCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarRetencionesXCliente]
@Cliente_ID		int,
@Retencion_ID	int,
@Orden			int
AS

SET DATEFORMAT dmy

DECLARE @Status int

INSERT INTO RetencionesXCliente (intCliente_ID, intRetencion_ID, intOrden) VALUES (@Cliente_ID, @Retencion_ID, @Orden)
SET @Status = @@ROWCOUNT

IF @Status <> 0
BEGIN
	RETURN 0
END
ELSE
BEGIN
	RETURN 99
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarSucursal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarSucursal]
	@Sucursal_ID	int,
	@Descripcion	varchar(20),
	@Direccion		varchar(60),
	@NoInterior		varchar(10),
	@NoExterior		varchar(10),
	@Colonia		varchar(50),
	@Ciudad			varchar(20),
	@Estado			varchar(20),
	@Pais			varchar(20),
	@CodigoPostal	varchar(10),
	@Telefono		varchar(40),
	@Activo			int,
	@Operacion		char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intSucursal_ID) FROM Sucursales),0) + 1
		INSERT INTO Sucursales (intSucursal_ID, vchDescripcion, vchDireccion, vchNoInterior, vchNoExterior, vchColonia, vchCiudad, vchEstado, vchPais, vchCodigoPostal, vchTelefono, bitActivo) VALUES (@ID, @Descripcion, @Direccion, @NoInterior, @NoExterior, @Colonia, @Ciudad, @Estado, @Pais, @CodigoPostal, @Telefono, @Activo)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Sucursales SET vchDescripcion = @Descripcion, bitActivo = @Activo, vchNoInterior = @NoInterior, vchNoExterior = @NoExterior, vchColonia =  @Colonia, vchDireccion = @Direccion, vchCiudad = @Ciudad, vchEstado = @Estado, vchCodigoPostal = @CodigoPostal, vchTelefono = @Telefono, vchPais = @Pais
				 WHERE intSucursal_ID = @Sucursal_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarUnidadMedida]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarUnidadMedida]
	@Unidad_ID		varchar(10),
	@Activo			int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	UPDATE c_ClaveUnidad SET Seleccionado = @Activo
	WHERE Clave_Unidad = @Unidad_ID
	
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
/****** Object:  StoredProcedure [dbo].[Sp_ActualizarUsuario]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ActualizarUsuario]
	@Usuario_ID		int,
	@Nombre			varchar(100),
	@Usuario		varchar(100),
	@Contraseña		varchar(100),
	@Sucursal_ID	int,
	@TipoUsuario	varchar(100),
	@Accesos		varchar(100),
	@Activo			int,
	@MultiSucursal	int,
	@Operacion		char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @ID int, @Status int

	BEGIN TRANSACTION

	IF @Operacion = 'I'
	BEGIN
		SET @ID = ISNULL((SELECT MAX(intUsuario_ID) FROM Usuarios),0) + 1
		INSERT INTO Usuarios (intUsuario_ID, vchNombreCompleto, vchUsuario, vchContrasena, intSucursal_ID, vchTipo_Usuario, vchAccesos, bitMultiSucursal, bitActivo) VALUES (@ID, @Nombre, @Usuario, @Contraseña, @Sucursal_ID, @TipoUsuario, @Accesos, @MultiSucursal, @Activo)
		SET @Status = @@ROWCOUNT
	END
	ELSE
	BEGIN
		UPDATE Usuarios SET vchNombreCompleto = @Nombre, vchUsuario = @Usuario, vchContrasena = @Contraseña, intSucursal_ID = @Sucursal_ID, vchTipo_Usuario = @TipoUsuario,  vchAccesos = @Accesos, bitActivo = @Activo, bitMultiSucursal = @MultiSucursal
		WHERE intUsuario_ID = @Usuario_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_CancelarFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_CancelarFactura]
	@Sucursal_ID	int,
	@Folio_ID		int,
	@Motivo			varchar(100),
	@TipoDocumento	char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int

--	BEGIN TRANSACTION

	UPDATE Cab_Ventas SET vchMotivo = @Motivo, dtmFecha_Cancelacion = GETDATE(), bitCancelada = 1
	WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @TipoDocumento
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
--		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
--		ROLLBACK TRANSACTION
		RETURN 99
	END

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CancelarNotaCredito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_CancelarNotaCredito]
	@Sucursal_ID	int,
	@Folio_ID		int,
	@Motivo			varchar(100)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int

--	BEGIN TRANSACTION

	UPDATE Cab_Notas_Credito SET vchMotivo = @Motivo, dtmFecha_Cancelacion = GETDATE(), bitCancelada = 1
	WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID
	SET @Status = @@ROWCOUNT

	IF @Status <> 0
	BEGIN
--		COMMIT TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
--		ROLLBACK TRANSACTION
		RETURN 99
	END

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXML]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CrearArchivoXML]
	@Folio_ID Int,
	@Tipo		char(1),
	@Sucursal	Int,
	@Sello		Varchar(8000)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie	varchar(20), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @XML_Conceptos XML, @PAC_ID int, @LugarExpedicion varchar(100)

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = @Tipo)
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
		CV.vchTipo_Pago,
		Rtrim(Ltrim(Convert(Char,Round(0.00,2)))),
		'I',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance',
		CV.vchMetodoPago,
		@LugarExpedicion As LugarExpedicion
	FROM Cab_Ventas CV
	INNER JOIN Datos_FacturaElectronica DFE On CV.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID
	WHERE CV.intSucursal_ID = @Sucursal AND CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #Emisor(rfc,nombre,RegimenFiscal)
	SELECT vchRFC,vchRAZONSOCIAL, (SELECT intRegimen_ID FROM REGIMEN_FISCALES) FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Receptor(rfc,nombre,UsoCFDI)
	Select Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL, CC.vchUso_CFDI FROM CAB_VENTAS CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID, REGIMEN_FISCALES RF
	Where CV.intSucursal_ID = @Sucursal And CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0),2)))),
			   Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2))))
		From CAB_VENTAS
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		--Select Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetIVA = 0 AND mnyRetISR = 0 Then Null Else ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0) End,2)))),
		--	   Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		--From CAB_VENTAS
		--Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe,TipoFactor,TasaOCuota)
		Select '002',	
			   Rtrim(Ltrim(Convert(Char,Round(mnyRetIVA,2)))),
			   'Tasa',
			   Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPRetIVA / 100.00))))
		From CAB_VENTAS CV 
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		  and mnyRetIVA >= 0
		Union
		Select '001', 
			   Rtrim(Ltrim(Convert(Char,Round(mnyRetISR,2)))), 
			   'Tasa',
			   Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPRetISR / 100.00))))
		From CAB_VENTAS CV 
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		  and mnyRetISR >= 0
		--Select Case When mnyRetIVA = 0 Then Null Else '002' End,	
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetIVA = 0 Then Null Else Round(mnyRetIVA,2) End))),
		--	   'Tasa',
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetIVA = 0 Then Null Else convert(decimal(18,6),mnyPRetIVA / 100.00) End)))
		--From CAB_VENTAS CV 
		--Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		--  and mnyRetIVA >= 0
		--Union
		--Select Case When mnyRetISR = 0 Then Null Else '001' End, 
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetISR = 0 Then Null Else Round(mnyRetISR,2) End))), 
		--	   'Tasa',
		--	   Rtrim(Ltrim(Convert(Char,Case When mnyRetISR = 0 Then Null Else convert(decimal(18,6),mnyPRetISR / 100.00) End)))
		--From CAB_VENTAS CV 
		--Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		--  and mnyRetISR >= 0
		
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,TipoFactor,tasaoCuota)
		Select  '002', 
				Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))),
				'Tasa',
			    Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPIVA / 100.00))))
		From CAB_VENTAS CV
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		 and mnyIVA > 0
		--Select  Case When mnyIVA = 0 AND mnyRetIVA = 0 Then Null Else '002' End, 
		--		Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 AND mnyRetIVA = 0 Then Null Else mnyIVA End,2)))),
		--		'Tasa',
		--	    case when mnyIVA = 0 then null else Rtrim(Ltrim(Convert(Char,convert(decimal(18,6),mnyPIVA / 100.00)))) end
		--From CAB_VENTAS CV
		--Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		-- and mnyIVA > 0

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	set @XML_Conceptos = (SELECT
	(
		SELECT CASE WHEN ISNULL(DV.vchClaveProdServ,'') <> '' THEN DV.vchClaveProdServ ELSE CA.vchClaveProdServ END AS ClaveProdServ, 
		       CU.Nombre AS Unidad, 
			   CASE WHEN ISNULL(DV.vchClaveProdServ,'') <> '' THEN DV.vchUnidad ELSE CA.vchUnidad END AS ClaveUnidad, 
			   CONVERT(DECIMAL(18,2),DV.mnyCantidad) AS Cantidad, 
			   CASE WHEN ISNULL(DV.vchClaveProdServ,'') <> '' THEN DV.vchNoIdentificacion ELSE CA.vchNoIdentificacion END AS NoIdentificacion, 
			   CASE WHEN ISNULL(DV.vchClaveProdServ,'') <> '' THEN DV.vchDescripcion_Producto ELSE CA.vchDescripcion END AS Descripcion, 
			   CONVERT(DECIMAL(18,2),DV.mnyPrecio) AS ValorUnitario, 
			   CONVERT(DECIMAL(18,2),DV.mnyImporte) AS Importe,
			( 
				SELECT (SELECT T.Impuesto, T.Base, T.TipoFactor, T.TasaOCuota, T.Importe
						FROM vTrasladosXFactura T
						WHERE DV.intSucursal_ID = T.intSucursal_ID AND DV.intFolio_ID = T.intFolio_ID AND DV.chrTipo_Documento = T.chrTipo_Documento AND DV.intRenglon = T.intRenglon
						FOR XML RAW('Traslado'),TYPE
						)
				FOR XML RAW('Traslados'),TYPE

			),
			( 
				SELECT (SELECT R.Impuesto, R.Base, R.TipoFactor, R.TasaOCuota, R.Importe
						FROM vRetencionesXFactura R
						WHERE DV.intSucursal_ID = R.intSucursal_ID AND DV.intFolio_ID = R.intFolio_ID AND DV.chrTipo_Documento = R.chrTipo_Documento AND DV.intRenglon = R.intRenglon
						FOR XML RAW('Retencion'),TYPE
						)
				FOR XML RAW('Retenciones'),TYPE

			)
		FROM Det_Ventas DV
		LEFT OUTER JOIN Productos CA ON DV.intProducto_ID = CA.intProducto_ID
		LEFT OUTER JOIN c_ClaveUnidad CU ON (DV.vchUnidad = CU.Clave_Unidad AND DV.vchUnidad <> '' OR CA.vchUnidad = CU.Clave_Unidad AND ISNULL(DV.vchUnidad,'') = '')
		WHERE intSucursal_ID = @Sucursal AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @Tipo
		FOR XML RAW('Concepto'), TYPE
	) FOR XML PATH(''), ROOT('Conceptos'))

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
--		   CondicionesDePago,
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
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXML_v32]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CrearArchivoXML_v32]
	@Folio_ID Int,
	@Tipo		char(1),
	@Sucursal	Int,
	@Sello		Varchar(8000)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie	varchar(20), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @PAC_ID int, @LugarExpedicion varchar(100)

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = @Tipo)
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

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, formaDePago,descuento,tipoDeComprobante,xsi,xmlns,xmlnsxsi,metodoDePago,LugarExpedicion,NumCtaPago)
	SELECT @Serie, 
		DFE.vchVersion, 
		@Folio_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
		CV.vchTipo_Pago,
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
	INNER JOIN Datos_FacturaElectronica DFE On CV.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID
	WHERE CV.intSucursal_ID = @Sucursal AND CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #Emisor(rfc,nombre)
	SELECT vchRFC,vchRAZONSOCIAL FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Domicilio(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	SELECT rtrim(vchDireccion),vchNoExterior,vchNoInterior,vchCOLONIA,vchCiudad,vchCiudad,
		vchEstado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais)),vchCODIGOPOSTAL, vchReferencia
	FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Receptor(rfc,nombre)
	Select Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL  FROM CAB_VENTAS CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	Where CV.intSucursal_ID = @Sucursal And CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #DomicilioReceptor (calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	Select cc.vchDireccion ,CC.vchNoExterior  ,CC.vchNoInterior  ,CC.vchCOLONIA ,CC.vchCIUDAD,CC.vchCiudad,
		CC.vchEstado,SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais))
		,CC.vchCODIGOPOSTAL,CC.vchReferencia
	From CAB_VENTAS CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	Where CV.intSucursal_ID = @Sucursal And CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #RegimenFiscal
	SELECT vchNombre FROM REGIMEN_FISCALES

	INSERT INTO #DomicilioSuc(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
		Select vchDireccion,vchNoExTerior ,vchNoInterior ,vchCOLONIA ,vchCiudad,vchCiudad,
			vchestado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais))
			,vchCODIGOPOSTAL,vchREFERENCIA
		From SUCURSALES SUC
		Where intSucursal_ID = @Sucursal
		
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

	INSERT INTO #Concepto(cantidad,unidad,noIdentificacion,descripcion,valorUnitario ,importe,no_renglon)
	Select Ltrim(Rtrim(Convert(Char,Round(VDV.mnycantidad,2)))),Rtrim(Ltrim(Isnull(UNI.vchNombreCorto,'.'))),
		Ltrim(Rtrim(CONVERT(Char,VDV.intProducto_ID))),
		dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(CASE WHEN VDV.vchDescripcion_Producto <> '' THEN VDV.vchDescripcion_Producto ELSE CA.vchDescripcion END,''))) ),
		Ltrim(Rtrim(Convert(Char,Round(VDV.mnyPrecio,2))))
	,Ltrim(Rtrim(Convert(Char,Round(mnyimporte,2)))),intRenglon
	From Det_Ventas VDV
	Inner Join Cab_VENTAS CV ON CV.intFolio_ID = VDV.intFolio_ID And CV.chrTipo_Documento = VDV.chrTipo_Documento And CV.intSucursal_ID = VDV.intSucursal_ID
	LEFT OUTER Join Productos CA On VDV.intProducto_ID = CA.intProducto_ID
	LEFT OUTER Join Unidad_Medida UNI On UNI.intUnidad_ID = CA.intUnidad_ID
	WHERE VDV.intFolio_ID = @Folio_ID And VDV.intSucursal_ID = @Sucursal And VDV.chrTipo_Documento = @Tipo
	Order By intRenglon

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetIVA = 0 AND mnyRetISR = 0 Then Null Else ISNULL(mnyRetIVA,0) + ISNULL(mnyRetISR,0) End,2)))),
			   Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		From CAB_VENTAS
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe)
		Select Case When mnyRetIVA = 0 Then Null Else 'IVA' End, 
			   Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetIVA = 0 Then Null Else mnyRetIVA End,2))))
		From CAB_VENTAS CV 
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		  and mnyRetIVA > 0
		Union
		Select Case When mnyRetISR = 0 Then Null Else 'ISR' End, 
			   Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetISR = 0 Then Null Else mnyRetISR End,2))))
		From CAB_VENTAS CV 
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		  and mnyRetISR > 0
		
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select Case When mnyIVA = 0 AND mnyRetIVA = 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 AND mnyRetIVA = 0 Then Null Else mnyIVA End,2))))
			, case when mnyIVA = 0 then null else Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) end
		From CAB_VENTAS CV
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		 and mnyIVA > 0

	INSERT INTO #Conceptos(Borrame)
	Select '1'

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	Set @XMLORIGINAL =
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
	(Select Isnull(Conceptos.Borrame,'') Borrame , Id_Borrado As Borrame2, Concepto.cantidad, Concepto.unidad, Concepto.noIdentificacion,
		 Concepto.descripcion, Concepto.valorUnitario, Concepto.importe
	From #Conceptos Conceptos, #Concepto Concepto
	Order By Concepto.no_renglon 
	For XML AUTO,TYPE),
	(SELECT totalImpuestosRetenidos, totalImpuestosTrasladados,
		  (Select DISTINCT Borrame,Id_Borrado As Borrame2,Retencion.impuesto, Retencion.importe As importe
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

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'ExpedidoEn','cfdi:ExpedidoEn'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'RegimenFiscal','cfdi:RegimenFiscal'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Domicilio','<cfdi:Domicilio'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Retencion','cfdi:Retencion'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

	SELECT CONVERT(XML,@XMLCHAR1)

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
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXMLHO]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_CrearArchivoXMLHO]
	@Folio_ID Int,
	@Tipo		char(1),
	@Sucursal	Int,
	@Sello		Varchar(8000)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie	varchar(20), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @PAC_ID int

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = @Tipo)

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
		xmlnsxsi varchar(300)
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

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, formaDePago,descuento,tipoDeComprobante, xsi,xmlns,xmlnsxsi)
	SELECT @Serie, 
		DFE.vchVersion, 
		@Folio_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
		CV.vchTipo_Pago,
		Rtrim(Ltrim(Convert(Char,Round(CV.mnySUBTOTAL,2)))),
		1.00,
        'MXN',
		Rtrim(Ltrim(Convert(Char,Round(cv.mnytotal,2)))),
		'Pago en una sola exhibicion',
		Rtrim(Ltrim(Convert(Char,Round(0.00,2)))),
		'ingreso',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance'
	FROM Cab_Ventas CV
	INNER JOIN Datos_FacturaElectronica DFE On CV.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	WHERE CV.intSucursal_ID = @Sucursal AND CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #Emisor(rfc,nombre)
	SELECT vchRFC,vchRAZONSOCIAL FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Domicilio(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	SELECT rtrim(vchDireccion),vchNoExterior,vchNoInterior,vchCOLONIA,vchCiudad,vchCiudad,
		vchEstado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais)),vchCODIGOPOSTAL, vchReferencia
	FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Receptor(rfc,nombre)
	Select Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL  FROM CAB_VENTAS CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	Where CV.intSucursal_ID = @Sucursal And CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #DomicilioReceptor (calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	Select cc.vchDireccion ,CC.vchNoExterior  ,CC.vchNoInterior  ,CC.vchCOLONIA ,CC.vchCIUDAD,CC.vchCiudad,
		CC.vchEstado,SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais))
		,CC.vchCODIGOPOSTAL,CC.vchReferencia
	From CAB_VENTAS CV
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID
	Where CV.intSucursal_ID = @Sucursal And CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @Tipo

	INSERT INTO #DomicilioSuc(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
		Select vchDireccion,vchNoExTerior ,vchNoInterior ,vchCOLONIA ,vchCiudad,vchCiudad,
			vchestado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais))
			,vchCODIGOPOSTAL,vchREFERENCIA
		From SUCURSALES SUC
		Where intSucursal_ID = @Sucursal
		
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

	INSERT INTO #Concepto(cantidad,unidad,noIdentificacion,descripcion,valorUnitario ,importe,no_renglon)
	Select Ltrim(Rtrim(Convert(Char,Round(VDV.mnycantidad,2)))),Rtrim(Ltrim(Isnull(UNI.vchDescripcion,''))),
		Ltrim(Rtrim(CONVERT(Char,CA.intProducto_ID))),
		dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(CA.vchDescripcion,''))) ),
		Ltrim(Rtrim(Convert(Char,Round(VDV.mnyPrecio,2))))
	,Ltrim(Rtrim(Convert(Char,Round(mnyimporte,2)))),intRenglon
	From Det_Ventas VDV
	Inner Join Cab_VENTAS CV ON CV.intFolio_ID = VDV.intFolio_ID And CV.chrTipo_Documento = VDV.chrTipo_Documento And CV.intSucursal_ID = VDV.intSucursal_ID
	Inner Join Productos CA On VDV.intProducto_ID = CA.intProducto_ID
	Inner Join Unidad_Medida UNI On UNI.intUnidad_ID = CA.intUnidad_ID
	WHERE VDV.intFolio_ID = @Folio_ID And VDV.intSucursal_ID = @Sucursal And VDV.chrTipo_Documento = @Tipo 
	Order By intRenglon

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetIVA = 0 Then Null Else mnyRetIVA + mnyRetISR End,2))))
			,Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		From CAB_VENTAS
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe)
		Select Case When mnyRetIVA = 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetIVA = 0 Then Null Else mnyRetIVA End,2))))
		From CAB_VENTAS CV 
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		 and mnyRetIVA > 0

	INSERT INTO #ImpuestosRetenidos(impuesto, importe)
		Select Case When mnyRetISR = 0 Then Null Else 'ISR' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When mnyRetISR = 0 Then Null Else mnyRetISR End,2))))
		From CAB_VENTAS CV 
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		 and mnyRetISR > 0

	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select Case When mnyIVA = 0 Then Null Else 'IVA' End, 
			Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 Then Null Else mnyIVA End,2))))
			, case when mnyIVA = 0 then null else Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) end
		From CAB_VENTAS CV
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal And chrTipo_Documento = @Tipo
		 and mnyIVA > 0

	INSERT INTO #Conceptos(Borrame)
	Select '1'

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	Set @XMLORIGINAL =
	(
	SELECT version,serie,folio,fecha,sello,tipoDeComprobante,
		formaDePago,condicionesDePago,noCertificado,certificado,
		subTotal,descuento,Moneda,TipoCambio,total,xsi "xsi:schemaLocation",xmlnsxsi "xmlns:xsi",
		  (SELECT rfc,nombre,
		  (SELECT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,
				pais,codigoPostal
		   FROM #Domicilio "DomicilioFiscal"
		   FOR XML AUTO, TYPE),
		  (SELECT DISTINCT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #DomicilioSuc  "ExpedidoEn"
		   FOR XML AUTO, TYPE)
	FROM #Emisor "Emisor"
	FOR XML AUTO, TYPE),
		  (SELECT DISTINCT rfc,nombre,calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal
		   FROM #Receptor Receptor,#DomicilioReceptor  "Domicilio"
		   FOR XML AUTO, TYPE),
	(Select Isnull(Conceptos.Borrame,'') Borrame , Id_Borrado As Borrame2, Concepto.cantidad, Concepto.unidad, Concepto.noIdentificacion,
		 Concepto.descripcion, Concepto.valorUnitario, Concepto.importe
	From #Conceptos Conceptos, #Concepto Concepto
	Order By Concepto.no_renglon 
	For XML AUTO,TYPE),
	(SELECT totalImpuestosRetenidos, totalImpuestosTrasladados,
		  (Select Borrame,Id_Borrado As Borrame2,Retencion.impuesto, Retencion.importe As importe
			From #Retenciones "Retenciones", #ImpuestosRetenidos "Retencion"
			group by Borrame,Id_Borrado,Retencion.impuesto, Retencion.importe
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

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'ExpedidoEn','cfdi:ExpedidoEn'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Domicilio','<cfdi:Domicilio'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

	SELECT CONVERT(XML,@XMLCHAR1)

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

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearArchivoXMLNC]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearArchivoXMLNC]
(
	@Folio_ID	Int,
	@Sucursal	Int,
	@Sello		Varchar(8000)
)
AS	

BEGIN

	SET NOCOUNT ON

	DECLARE @Serie	varchar(20), @Impuesto_Retenido money, @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @PAC_ID int

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Impuesto_Retenido = 0
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = 'N')

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
		xmlnsxsi varchar(300)
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

	INSERT INTO #Comprobante(serie,[version],folio,fecha,sello,noCertificado,certificado,condicionesDePago, subTotal,TipoCambio,Moneda,total, formaDePago,descuento,tipoDeComprobante, xsi,xmlns,xmlnsxsi)
	SELECT @Serie, 
		DFE.vchVersion, 
		@Folio_ID, 
		Ltrim(Rtrim(CONVERT(Char,Year(NC.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(NC.dtmFecha_Registro)))),2) +'-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(NC.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,NC.dtmFecha_Registro,108))),
		@Sello,
		Left(vchNo_Serie_Certificado,20),
		Case When Ltrim(Rtrim(vchCertificadoPublico)) = '' Then Null Else Ltrim(Rtrim(vchCertificadoPublico)) End As certificado,
		NC.vchTipo_Pago,
		Rtrim(Ltrim(Convert(Char,Round(NC.mnySUBTOTAL,2)))),
		1.00,
        'MXN',
		Rtrim(Ltrim(Convert(Char,Round(NC.mnytotal,2)))),
		'Pago en una sola exhibicion',
		NULL,
		'egreso',
		'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd',
		'http://www.sat.gob.mx/cfd/3',
		'http://www.w3.org/2001/XMLSchema-instance'
	FROM Cab_Notas_Credito NC
	INNER JOIN Datos_FacturaElectronica DFE On NC.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	WHERE NC.intSucursal_ID = @Sucursal AND NC.intFolio_ID = @Folio_ID 

	INSERT INTO #Emisor(rfc,nombre)
	SELECT vchRFC,vchRAZONSOCIAL FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Domicilio(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	SELECT rtrim(vchDireccion),vchNoExterior,vchNoInterior,vchCOLONIA,vchCiudad,vchCiudad,
		vchEstado,SUBSTRING(vchPais,CHARINDEX('-',vchPais,1 )+1,LEN(vchPais)),vchCODIGOPOSTAL, vchReferencia
	FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Receptor(rfc,nombre)
	Select Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL  FROM Cab_Notas_Credito NC
	Inner Join CLientes CC On NC.intCLIENTE_ID = CC.intCLIENTE_ID
	Where NC.intSucursal_ID = @Sucursal And NC.intFolio_ID = @Folio_ID

	INSERT INTO #DomicilioReceptor (calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
	Select cc.vchDireccion ,CC.vchNoExterior  ,CC.vchNoInterior  ,CC.vchCOLONIA ,CC.vchCIUDAD,CC.vchCiudad,
		CC.vchEstado,SUBSTRING(CC.vchPais,CHARINDEX('-',CC.vchPais,1 )+1,LEN(CC.vchPais))
		,CC.vchCODIGOPOSTAL,CC.vchReferencia
	From Cab_Notas_Credito NC
	Inner Join CLientes CC ON NC.intCLIENTE_ID = CC.intCLIENTE_ID
	Where NC.intSucursal_ID = @Sucursal And NC.intFolio_ID = @Folio_ID

	INSERT INTO #DomicilioSuc(calle,noExterior,NoInterior,colonia,localidad,municipio,estado,pais,codigoPostal,referencia)
		Select vchDireccion, vchNoExterior,vchNoInterior,vchColonia,vchCiudad,vchCiudad,
			vchestado,vchPais ,vchCodigoPostal,vchREFERENCIA
		From SUCURSALES SUC
		Where intSucursal_ID = @Sucursal
		
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
			NULL,
			Ltrim(Rtrim(CONVERT(Char,'001'))),
			dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(vchNotas,''))) ),
			Ltrim(Rtrim(Convert(Char,Round(VDV.mnyImporte,2)))),
			Ltrim(Rtrim(Convert(Char,Round(VDV.mnyimporte,2))))
	From Det_Notas_Credito VDV
	Inner Join Cab_Notas_Credito NC ON NC.intFolio_ID = VDV.intFolio_ID And  NC.intSucursal_ID = VDV.intSucursal_ID
	WHERE VDV.intFolio_ID = @Folio_ID And VDV.intSucursal_ID = @Sucursal 
	Order By intRenglon

	INSERT INTO #Impuestos(totalImpuestosRetenidos,totalImpuestosTrasladados)
		Select Rtrim(Ltrim(Convert(Char,Round(Case When @Impuesto_Retenido = 0 Then Null Else @Impuesto_Retenido End,2)))),
			   Case When mnyIVA = 0 Then Null Else Rtrim(Ltrim(Convert(Char,Round(mnyIVA,2)))) End
		From Cab_Notas_Credito
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal 
				
	INSERT INTO #ImpuestosRetenidos(impuesto,importe)
		Select Case When @Impuesto_Retenido = 0 Then Null Else 'IVA' End, 
			   Rtrim(Ltrim(Convert(Char,Round(Case When @Impuesto_Retenido = 0 Then Null Else @Impuesto_Retenido End,2))))
		From Cab_Notas_Credito NC
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal 
		  AND @Impuesto_Retenido > 0
			
	INSERT INTO #ImpuestosTrasladados(impuesto,importe,tasa)
		Select Case When mnyIVA = 0 Then Null Else 'IVA' End, 
			   Rtrim(Ltrim(Convert(Char,Round(Case When mnyIVA = 0 Then Null Else mnyIVA End,2)))),
			   case when mnyIVA = 0 then null else Rtrim(Ltrim(Convert(Char,Round(mnyPIVA,2)))) end
		From Cab_Notas_Credito NC
		Where intFolio_ID = @Folio_ID And intSucursal_ID = @Sucursal
		 and mnyIVA > 0

	INSERT INTO #Conceptos(Borrame)
	Select '1'

	INSERT INTO #Traslados(Borrame)
	Select '1'
	From #ImpuestosTrasladados

	INSERT INTO #Retenciones(Borrame)
	Select '1'
	From #ImpuestosRetenidos

	Set @XMLORIGINAL =
	(
	SELECT version,
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
		xsi "xsi:schemaLocation",xmlnsxsi "xmlns:xsi",
		(SELECT rfc,nombre,
		  (SELECT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal FROM #Domicilio "DomicilioFiscal"
		   FOR XML AUTO, TYPE),
		  (SELECT DISTINCT calle,noExterior,noInterior,colonia,localidad,referencia,municipio,estado,pais,codigoPostal FROM #DomicilioSuc  "ExpedidoEn"
		   FOR XML AUTO, TYPE)
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
	FOR XML AUTO, TYPE)

	SET @XMLCHAR1 =  CONVERT(varchar(MAX),@XMLORIGINAL)

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd"','xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" '))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Emisor','cfdi:Emisor'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Comprobante','<cfdi:Comprobante'))

    SET @XMLCHAR1 = (Replace(@XMLCHAR1,'</Comprobante','</cfdi:Comprobante'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'ExpedidoEn','cfdi:ExpedidoEn'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Receptor','cfdi:Receptor'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Domicilio','<cfdi:Domicilio'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Concepto','cfdi:Concepto'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'<Impuestos','<cfdi:Impuestos'))

	SET @XMLCHAR1 = (Replace(@XMLCHAR1,'Traslado','cfdi:Traslado'))

	SET @XMLCHAR1 = (REPLACE(@XMLCHAR1,'</Impuestos>','</cfdi:Impuestos>'))

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

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginal]
(
	@Sucursal_ID	Int,
	@Folio_ID		Int,
	@Tipo_Documento	char(1)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @Serie varchar(20), @PAC_ID int, @RegimenFiscales Varchar(MAX), @LugarExpedicion varchar(100)

	SET @LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = @Tipo_Documento)

	SET @RegimenFiscales = (SELECT intRegimen_ID FROM Regimen_Fiscales)
	
	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull(DFE.[vchVersion],''))) 
		+ '|' + @Serie
		+ '|' + RTRIM(CONVERT(VARCHAR,CV.intFolio_ID))
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108)))
		+ '|' + CV.vchTipo_Pago
		+ '|' + DFE.vchNo_Serie_Certificado
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,CV.mnySubTotal),'')))
		+ '|' + Ltrim(Rtrim(0.00))
		+ '|' + 'MXN'
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,CV.mnyTotal),'')))
		+ '|' + 'I'
		+ '|' + CV.vchMetodoPago COLLATE Latin1_General_CI_AS
		+ '|' + @LugarExpedicion
--		+ '|' + 'Pago en una sola exhibicion'
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchRazonSocial) ,'')))
		+ '|' + Isnull(@RegimenFiscales,'')
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),'')))
		+ '|' + CC.vchUso_CFDI As Campo,
		0 as Renglon2
	FROM Cab_Ventas CV
	INNER JOIN Datos_FacturaElectronica DFE ON CV.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Parametros DG On DG.intSucursal_ID = DFE.intSucursal_ID
	Left Join Sucursales Suc On DG.intSucursal_ID = Suc.intSucursal_ID
	Left Join Clientes CC On CC.intCliente_ID = CV.intCliente_ID
	WHERE CV.intFolio_ID = @Folio_ID AND CV.intSucursal_ID = @Sucursal_ID AND CV.chrTipo_Documento = @Tipo_Documento
		
	UNION

	SELECT 2 As Renglon,
	         '|' + VDV.vchClaveProdServ
		   + '|' + CASE WHEN VDV.vchNoIdentificacion <> '' THEN VDV.vchNoIdentificacion ELSE Rtrim(Ltrim(Ltrim(Rtrim(CONVERT(Char,VDV.intProducto_ID))))) END
	       + '|' + Ltrim(Rtrim(Isnull(Convert(Char,VDV.mnycantidad),'')))
		   + '|' + VDV.vchUnidad
		   + '|' + ISNULL(CU.[Nombre],'N/A')
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CASE WHEN VDV.vchDescripcion_Producto <> '' THEN VDV.vchDescripcion_Producto ELSE CA.vchDescripcion END),''))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(VDV.mnyPrecio,2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))

		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))
		   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else '002' End 					
		   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'Tasa' End 					
		   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0))))) End
		   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End

		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0))))
	       + '|' + '001'
	       + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetISR / 100.00,0)))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyRetISR)))

		   + '|' + Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0))))
	       + '|' + '002'
	       + '|' + 'Tasa'
		   + '|' + Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetIVA / 100.00,0)))))
	       + '|' + LTRIM(Rtrim(Convert(Char,mnyRetIVA)))

		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0)))) End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else '001' End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else 'Tasa' End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetISR / 100.00,0))))) End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else LTRIM(Rtrim(Convert(Char,mnyRetISR))) End

		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyImporte,0)))) End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else '002' End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else 'Tasa' End
		   --+ '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPRetIVA / 100.00,0))))) End
	    --   + '|' + Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else LTRIM(Rtrim(Convert(Char,mnyRetIVA))) End

		   + '|' + '', 
		   intRenglon AS Renglon2
	FROM Det_Ventas VDV
	LEFT OUTER JOIN Productos CA ON VDV.intProducto_ID = CA.intProducto_ID
	LEFT OUTER JOIN Unidad_Medida UNI ON UNI.intUnidad_ID = CA.intUnidad_ID
	LEFT OUTER JOIN c_ClaveUnidad CU ON VDV.vchUnidad = RTRIM(CU.Clave_Unidad)
	WHERE VDV.intFolio_ID = @Folio_ID AND VDV.intSucursal_ID = @Sucursal_ID AND VDV.chrTipo_Documento = @Tipo_Documento

	UNION

	SELECT 3 As Renglon, 

	          '|' +  '001'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0))))

	        + '|' +  '002'
			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0))))

			+ '|' +  Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0))))

	  --        '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else '001' End
			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) End

	  --      + '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else '002' End
			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) End

			--+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0)))) End

			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else '002' End 					
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'Tasa' End 					
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,CONVERT(DECIMAL(18,6),Isnull(mnyPIVA / 100.00,0))))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End

			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End,

		   3 As Renglon2
	FROM Cab_Ventas
	WHERE intFolio_ID = @Folio_ID AND intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento
	
	ORDER BY Renglon, Renglon2

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginal_v32]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Sp_CrearCadenaOriginal_v32]
(
	@Sucursal_ID	Int,
	@Folio_ID		Int,
	@Tipo_Documento	char(1)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @PAC_ID int, @RegimenFiscales Varchar(MAX), @LugarExpedicion varchar(100)

	SET	@LugarExpedicion = (SELECT vchCiudad + ',' + vchEstado FROM Parametros)

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

	DECLARE @Tabla AS TablaUnSplit
	  
	INSERT INTO @Tabla
	SELECT vchNombre FROM Regimen_Fiscales
		  
	SET @RegimenFiscales = (SELECT dbo.UnSplit(@Tabla,'|'))
	
	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull([vchVersion],''))) 
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108)))
		+ '|' + 'ingreso' 
		+ '|' + 'Pago en una sola exhibicion' 
		+ '|' + CV.vchTipo_Pago
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,mnySubTotal),'')))
		+ '|' + Ltrim(Rtrim(0.00))
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + 'MXN'
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,mnyTotal),'')))
		+ '|' + Isnull(cc.vchMetodoPago,'No Identificado') --MétododePago
		+ '|' + @LugarExpedicion  --LugarExpedicion
		+ '|' + Case When Len(Isnull(cc.vchCuentaBancaria,'')) < 4 Then '0000' Else cc.vchCuentaBancaria End
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchRazonSocial) ,'')))
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
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNOExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(SUBSTRING(dbo.Fmt_espacios(Suc.vchPais),CHARINDEX('-',dbo.Fmt_espacios(Suc.vchPais),1 )+1,LEN(Suc.vchPais)),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCodigoPostal),''))) 
		+ '|' + Isnull(@RegimenFiscales,'') --RegimenFiscal
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchDireccion),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchNoExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchCiudad),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(SUBSTRING(dbo.Fmt_espacios(CC.vchPais),CHARINDEX('-',dbo.Fmt_espacios(CC.vchPais),1 )+1,LEN(CC.vchPais)),'')))
		+ '|' + Ltrim(Rtrim(Isnull(CC.vchCodigoPostal,''))) As Campo, 0 as Renglon2
	FROM Cab_Ventas CV
	INNER JOIN Datos_FacturaElectronica DFE ON CV.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Parametros DG On DG.intSucursal_ID = DFE.intSucursal_ID
	Left Join Sucursales Suc On DG.intSucursal_ID = Suc.intSucursal_ID
	Left Join Clientes CC On CC.intCliente_ID = CV.intCliente_ID
	WHERE CV.intFolio_ID = @Folio_ID AND CV.intSucursal_ID = @Sucursal_ID AND CV.chrTipo_Documento = @Tipo_Documento
		
	UNION

	SELECT 2 As Renglon, 
	         '|' + Ltrim(Rtrim(Isnull(Convert(Char,VDV.mnycantidad),'')))
		   + '|' + Rtrim(Ltrim(Isnull(UNI.vchNombreCorto,'.'))) 
		   + '|' + Rtrim(Ltrim(Ltrim(Rtrim(CONVERT(Char,VDV.intProducto_ID)))))
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CASE WHEN VDV.vchDescripcion_Producto <> '' THEN VDV.vchDescripcion_Producto ELSE CA.vchDescripcion END),''))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(VDV.mnyPrecio,2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))
		   + '|' + ''
		   + '|' + ''
		   + '|' + '', intRenglon AS Renglon2
	FROM Det_Ventas VDV
	LEFT OUTER JOIN Productos CA ON VDV.intProducto_ID = CA.intProducto_ID
	LEFT OUTER JOIN Unidad_Medida UNI ON UNI.intUnidad_ID = CA.intUnidad_ID
	WHERE VDV.intFolio_ID = @Folio_ID AND VDV.intSucursal_ID = @Sucursal_ID AND VDV.chrTipo_Documento = @Tipo_Documento

	UNION

	SELECT 3 As Renglon, 
	          '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetISR = 0) Then '' Else 'ISR' End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' OR (@Tipo_Documento = 'H' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) End
	        + '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else 'IVA' End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' OR (@Tipo_Documento = 'F' AND mnyRetIVA = 0) Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0) + Isnull(mnyRetISR,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else 'IVA' End 					
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyPIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End, 
		   3 As Renglon2
	FROM Cab_Ventas
	WHERE intFolio_ID = @Folio_ID AND intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento
	
	ORDER BY Renglon, Renglon2

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalComplemento]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginalComplemento]
(
	@Folio_ID		Int,
	@Sucursal_ID	int,
	@TipoDocumento	char(1)
)

As

Set NoCount On

IF @TipoDocumento <> 'N'
	Select 1 As Renglon, 
		  '|' + Ltrim(Rtrim(Isnull('1.0',''))) 
        + '|' + Ltrim(Rtrim(Isnull(CV.vchFolio_Fiscal,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CV.dtmFecha_Timbrado,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CV.vchSello_CFD,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CV.vchSerie_Cert_SAT,''))) As Campo
	FROM Cab_Ventas CV
	WHERE CV.intSucursal_ID = @Sucursal_ID AND CV.intFolio_ID = @Folio_ID AND CV.chrTipo_Documento = @TipoDocumento
	GROUP BY vchFolio_Fiscal, CV.dtmFecha_Timbrado, CV.vchSello_CFD, CV.vchSerie_Cert_SAT
ELSE
	Select 1 As Renglon, 
		  '|' + Ltrim(Rtrim(Isnull('1.0',''))) 
        + '|' + Ltrim(Rtrim(Isnull(CN.vchFolio_Fiscal,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CN.dtmFecha_Timbrado,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CN.vchSello_CFD,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CN.vchSerie_Cert_SAT,''))) As Campo
	FROM Cab_Notas_Credito CN
	WHERE CN.intSucursal_ID = @Sucursal_ID AND CN.intFolio_ID = @Folio_ID
	GROUP BY vchFolio_Fiscal, CN.dtmFecha_Timbrado, CN.vchSello_CFD, CN.vchSerie_Cert_SAT


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalComplementoPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginalComplementoPago]
(
	@Pago_ID		Int,
	@Sucursal_ID	int,
	@TipoDocumento	char(1)
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
	WHERE intSucursal_ID = @Sucursal_ID AND intPago_ID = @Pago_ID AND chrTipo_Documento = 'P'
	GROUP BY vchFolio_Fiscal_UUID, dtmFecha_Timbrado, vchSello_CFD, vchSello_SAT, vchRfcProvCertifSAT, [vchSerie_Cert_SAT]

GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalHO]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginalHO]
(
	@Sucursal_ID	Int,
	@Folio_ID		Int,
	@Tipo_Documento	char(1)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @PAC_ID int

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

	Select 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull([vchVersion],''))) 
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(CV.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(CV.dtmFecha_Registro)))),2)	+ '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(CV.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,CV.dtmFecha_Registro,108)))
		+ '|' + 'ingreso' 
		+ '|' + 'Pago en una sola exhibicion' 
		+ '|' + CV.vchTipo_Pago
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,mnySubTotal),'')))
		+ '|' + Ltrim(Rtrim(0.00))
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + 'MXN'
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,mnyTotal),'')))
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' AND UPPER(DG.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(DG.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchRazonSocial) ,'')))
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
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNOExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(SUBSTRING(dbo.Fmt_espacios(Suc.vchPais),CHARINDEX('-',dbo.Fmt_espacios(Suc.vchPais),1 )+1,LEN(Suc.vchPais)),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(Suc.vchCodigoPostal),''))) 
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchDireccion),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchNoExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchCiudad),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(SUBSTRING(dbo.Fmt_espacios(CC.vchPais),CHARINDEX('-',dbo.Fmt_espacios(CC.vchPais),1 )+1,LEN(CC.vchPais)),'')))
		+ '|' + Ltrim(Rtrim(Isnull(CC.vchCodigoPostal,''))) As Campo, 0 as Renglon2
	FROM Cab_Ventas CV
	INNER JOIN Datos_FacturaElectronica DFE ON CV.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Parametros DG On DG.intSucursal_ID = DFE.intSucursal_ID
	Left Join Sucursales Suc On DG.intSucursal_ID = Suc.intSucursal_ID
	Left Join Clientes CC On CC.intCliente_ID = CV.intCliente_ID
	WHERE CV.intFolio_ID = @Folio_ID AND CV.intSucursal_ID = @Sucursal_ID AND CV.chrTipo_Documento = @Tipo_Documento
		
	UNION

	SELECT 2 As Renglon, 
	         '|' + Ltrim(Rtrim(Isnull(Convert(Char,VDV.mnycantidad),'')))
		   + '|' + Rtrim(Ltrim(Isnull(UNI.vchDescripcion,''))) 
		   + '|' + Rtrim(Ltrim(Ltrim(Rtrim(CONVERT(Char,CA.intProducto_ID)))))
		   + '|' + dbo.Fmt_espacios(RTRIM(Ltrim(Isnull(dbo.Fmt_espacios(CA.vchDescripcion),''))))
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(VDV.mnyPrecio,2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,mnyImporte)))
		   + '|' + ''
		   + '|' + ''
		   + '|' + '', intRenglon AS Renglon2
	FROM Det_Ventas VDV
	INNER JOIN Productos CA ON VDV.intProducto_ID = CA.intProducto_ID
	INNER JOIN Unidad_Medida UNI ON UNI.intUnidad_ID = CA.intUnidad_ID
	WHERE VDV.intFolio_ID = @Folio_ID AND VDV.intSucursal_ID = @Sucursal_ID AND VDV.chrTipo_Documento = @Tipo_Documento

	UNION

	SELECT 3 As Renglon, 
			  '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else 'ISR' End 					
--			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyPRetISR,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetISR,0)))) End
	        + '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else 'IVA' End
--			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyPRetIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA + mnyRetISR,0)))) End
	        + '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else 'IVA' End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyPIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End
			+ '|' +  Case When Ltrim(Rtrim(Convert(Char,Isnull(mnyRetIVA,0)))) = '0.00' Then '' Else Ltrim(Rtrim(Convert(Char,Isnull(mnyIVA,0)))) End,
		   3 As Renglon2
	FROM Cab_Ventas
	WHERE intFolio_ID = @Folio_ID AND intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento
	
	ORDER BY Renglon, Renglon2

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalNC]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_CrearCadenaOriginalNC]
(
	@Sucursal_ID	Int,
	@Folio_ID		Int,
	@Tipo			char(1)
)

AS

BEGIN

	SET NOCOUNT ON

	DECLARE @IVA_Retenido money, @PAC_ID int

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	
	SET @IVA_Retenido = 0

	SELECT 1 As Renglon, 
	      '|' + Ltrim(Rtrim(Isnull([vchVersion],''))) 
		+ '|' + Ltrim(Rtrim(CONVERT(Char,Year(NC.dtmFecha_Registro)))) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Month(NC.dtmFecha_Registro)))),2) + '-' + Right('00' + Ltrim(Rtrim(CONVERT(Char,Day(NC.dtmFecha_Registro)))),2) + 'T' + Ltrim(Rtrim(CONVERT(Char,NC.dtmFecha_Registro,108)))
		+ '|' + 'egreso' 
		+ '|' + 'Pago en una sola exhibicion' 
		+ '|' + NC.vchTipo_Pago
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,ROUND(mnySubTotal,2)),'')))
		+ '|' + ''
		+ '|' + Ltrim(Rtrim(Isnull(CONVERT(Char,1.00),'')))
		+ '|' + 'MXN'
		+ '|' + LTRIM(Rtrim(Isnull(Convert(Char,(ROUND(mnyTotal,2))),'')))
		+ '|' + Case When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(DG.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(DG.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchRazonSocial) ,'')))
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
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchDireccion),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchNoExterior),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchNoInterior),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchColonia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchCiudad),'')))
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchReferencia),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchCiudad),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchEstado),''))) 
		+ '|' + Ltrim(Rtrim(Isnull(CC.vchPais,'')))
		+ '|' + Ltrim(Rtrim(Isnull(CC.vchCodigoPostal,''))) As Campo, 0 AS REN2
	FROM Cab_Notas_Credito NC
	INNER JOIN Datos_FacturaElectronica DFE ON NC.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Parametros DG On DG.intSucursal_ID = DFE.intSucursal_ID
	Left Join Sucursales Suc On DG.intSucursal_ID = Suc.intSucursal_ID
	Left Join Clientes CC On CC.intCliente_ID = NC.intCliente_ID
	WHERE NC.intFolio_ID = @Folio_ID AND NC.intSucursal_ID = @Sucursal_ID

	UNION

	Select 2 As Renglon, 
			 '|' +  Ltrim(Rtrim(Isnull(Convert(Char,1.00),'')))
		   + '|' + Rtrim(Ltrim(Isnull('',''))) 
		   + '|' + Rtrim(Ltrim('001'))
		   + '|' + RTRIM(Ltrim(Isnull(Case When vchNotas = '' Then 'NOTA DE CREDITO' Else vchNotas End,''))) 
		   + '|' + Ltrim(Rtrim(CONVERT(Char,Round(mnyImporte,2))))
		   + '|' + LTRIM(Rtrim(Convert(Char,Round(mnyImporte,2))))
		   + '|' + ''
		   + '|' + ''
		   + '|' + '',intRenglon AS REN2
	From Det_Notas_Credito DMC
	Where DMC.intFolio_ID = @Folio_ID And DMC.intSucursal_ID = @Sucursal_ID

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
	WHERE intFolio_ID = @Folio_ID AND intSucursal_ID = @Sucursal_ID

	Order By Renglon, Ren2

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearCadenaOriginalPagos]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[Sp_CrearCadenaOriginalPagos]
(
	@Sucursal_ID	Int,
	@Pago_ID		Int,
	@Tipo_Documento	char(1)
)
AS

BEGIN

	SET NOCOUNT ON

	DECLARE @Serie varchar(20), @Serie_Factura varchar(20), @PAC_ID int, @RegimenFiscales Varchar(MAX), @LugarExpedicion varchar(100), @Folio_Pago int

	SET @LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = 'P')
	SET @Folio_Pago = (select intFolio FROM Control_Folios WHERE chrTipo_Documento = 'P')
	SET @Serie_Factura = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = @Tipo_Documento)

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
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(DG.vchRazonSocial) ,'')))
		+ '|' + Isnull(@RegimenFiscales,'')
		+ '|' + Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(CC.vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' And UPPER(CC.vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRFC),''))) End
		+ '|' + Ltrim(Rtrim(Isnull(dbo.Fmt_espacios(CC.vchRazonSocial),'')))
		+ '|' + CC.vchUso_CFDI COLLATE Latin1_General_CI_AS As Campo,
		0 as Renglon2
	FROM Cab_Pagos P
	INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID) DP ON P.intPago_ID = DP.intPago_ID
	INNER JOIN Datos_FacturaElectronica DFE ON P.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Parametros DG On DG.intSucursal_ID = DFE.intSucursal_ID
	Left Join Sucursales Suc On DG.intSucursal_ID = Suc.intSucursal_ID
	Left Join Clientes CC On DP.intCliente_ID = CC.intCliente_ID
	WHERE P.intSucursal_ID = @Sucursal_ID AND P.chrTipo_Documento = 'P' AND P.intPago_ID = @Pago_ID
		
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
		   + '|' + DP.vchTipo_Pago COLLATE Latin1_General_CI_AS
		   + '|' + 'MXN'
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),P.mnyTotal))))
		   + '|', 
		   
		   0 AS Renglon2
	FROM Cab_Pagos P
	INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID, CV.vchTipo_Pago FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID) DP ON P.intPago_ID = DP.intPago_ID
	Left Join Clientes CC On DP.intCliente_ID = CC.intCliente_ID
	WHERE P.intPago_ID = @Pago_ID AND P.intSucursal_ID = @Sucursal_ID AND P.chrTipo_Documento = 'P'

	UNION

	SELECT 3 As Renglon,
		   + CV.vchFolio_Fiscal
		   + '|' + @Serie_Factura
		   + '|' + LTRIM(Rtrim(Convert(Char,DP.intFactura_ID)))
		   + '|' + 'MXN'
		   + '|' + CV.vchMetodoPago COLLATE Latin1_General_CI_AS
		   + '|' + LTRIM(Rtrim(CONVERT(Char,DP.intParcialidad)))
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),DP.mnySaldo_Anterior))))
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),DP.mnyMonto_Pagado)))) 
		   + '|' + LTRIM(Rtrim(Convert(Char,CONVERT(DECIMAL(18,2),DP.mnySaldo_Pendiente))))
		   + '|', 
		   DP.intParcialidad AS Renglon2
	FROM Det_Pagos DP
	INNER JOIN Cab_Pagos P ON DP.intSucursal_ID = P.intSucursal_ID AND DP.intPago_ID = P.intPago_ID
	INNER JOIN Cab_Ventas CV ON CV.chrTipo_Documento = @Tipo_Documento AND DP.intSucursal_ID = CV.intSucursal_ID AND DP.intFactura_ID = CV.intFolio_ID
	Left Join Clientes CC On CV.intCliente_ID = CC.intCliente_ID
	WHERE DP.intPago_ID = @Pago_ID AND DP.intSucursal_ID = @Sucursal_ID AND DP.chrTipo_Documento = 'P'

	ORDER BY Renglon, Renglon2

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_CrearComplementoPagoXML]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CrearComplementoPagoXML]
	@Pago_ID	Int,
	@Tipo		char(1),
	@Sucursal	Int,
	@Sello		Varchar(8000)
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @Serie varchar(20), @Parcialidad smallint, @Forma_Pago varchar(10), @XMLCHAR1 Varchar(Max), @XMLORIGINAL XML, @XML_Conceptos XML, @XML_Complemento XML, @PAC_ID int, @LugarExpedicion varchar(100)

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
	SET @Serie = (select vchSerie FROM Control_Folios WHERE chrTipo_Documento = @Tipo)
	SET	@LugarExpedicion = (SELECT vchCodigoPostal FROM Parametros)
	SET @Forma_Pago = (SELECT DISTINCT CV.vchTipo_Pago FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID)
	
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
	SELECT CV.vchFolio_Fiscal AS IdDocumento, @Serie AS Serie, CV.intFolio_ID AS Folio, CV.vchMetodoPago AS MetodoDePagoDR, 'MXN' AS MonedaDR, DP.mnySaldo_Anterior AS ImpSaldoAnt, DP.mnySaldo_Pendiente AS ImpSaldoInsoluto, DP.mnyMonto_Pagado, P.intParcialidad AS ImpPagado 
	FROM vUltimaParcialidadXFactura P
	INNER JOIN Det_Pagos DP ON P.intSucursal_ID = dp.intSucursal_ID AND P.chrTipo_Documento = DP.chrTipo_Documento AND P.intFactura_ID = DP.intFactura_ID AND P.intParcialidad = DP.intParcialidad 
	INNER JOIN Cab_Ventas CV ON P.intSucursal_ID = CV.intSucursal_ID AND P.intFactura_ID = CV.intFolio_ID AND CV.chrTipo_Documento = @Tipo
	INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID
	WHERE P.intSucursal_ID = @Sucursal 
	  AND P.intPago_ID = @Pago_ID 
	  AND P.chrTipo_Documento = 'P'


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
	FROM Cab_Pagos P
	INNER JOIN Datos_FacturaElectronica DFE On P.intSucursal_ID = DFE.intSucursal_ID AND DFE.intPAC_ID = @PAC_ID
	WHERE P.intSucursal_ID = @Sucursal AND P.intPago_ID = @Pago_ID AND P.chrTipo_Documento = 'P'

	INSERT INTO #Emisor(rfc,nombre,RegimenFiscal)
	SELECT vchRFC,vchRAZONSOCIAL, (SELECT intRegimen_ID FROM REGIMEN_FISCALES) FROM Parametros
	WHERE intSucursal_ID = @Sucursal

	INSERT INTO #Receptor(rfc,nombre,UsoCFDI)
	Select DISTINCT Case When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) <> 'MEXICO' Then 'XEXX010101000' When Ltrim(Rtrim(Isnull(CC.vchRFC,''))) = '' AND UPPER(vchPais) = 'MEXICO' Then 'XAXX010101000' Else Ltrim(Rtrim(Isnull(CC.vchRFC,''))) End, CC.vchRAZONSOCIAL, CC.vchUso_CFDI FROM Det_Pagos P
	INNER JOIN CAB_VENTAS CV ON cv.chrTipo_Documento = @Tipo AND P.intSucursal_ID = CV.intSucursal_ID AND P.intFactura_ID = CV.intFolio_ID
	Inner Join CLientes CC On CV.intCLIENTE_ID = CC.intCLIENTE_ID, REGIMEN_FISCALES RF
	Where P.intSucursal_ID = @Sucursal And P.intpago_ID = @Pago_ID AND P.chrTipo_Documento = 'P'

	set @XML_Conceptos = (SELECT
	(
		SELECT P.vchClaveProdServ AS ClaveProdServ, 
			   CONVERT(DECIMAL(18,0),P.mnyCantidad) AS Cantidad, 
		       P.vchUnidad AS ClaveUnidad, 
			   P.vchDescripcion AS Descripcion, 
			   CONVERT(DECIMAL(18,0),P.mnyPrecio) AS ValorUnitario, 
			   CONVERT(DECIMAL(18,0),P.mnyImporte) AS Importe
		FROM Cab_Pagos P
		WHERE P.intSucursal_ID = @Sucursal AND P.chrTipo_Documento = 'P' AND P.intPago_ID = @Pago_ID
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
		WHERE P.intSucursal_ID = @Sucursal AND P.chrTipo_Documento = 'P' AND P.intPago_ID = @Pago_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarClaveProdServ]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarCliente]
	@Cliente_ID  int
AS

BEGIN
	SET NOCOUNT ON;

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
		
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarIva]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarProducto]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarProducto]
	@Producto_ID  int
AS

BEGIN
	SET NOCOUNT ON;

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
		
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRegimenFiscal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRetencion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_EliminarRetencion]
	@Retencion_ID  int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	DELETE FROM Retenciones WHERE intRetencion_ID = @Retencion_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarRetencionesXCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_EliminarRetencionesXCliente]
@Cliente_ID  int
AS

SET DATEFORMAT dmy

DECLARE @Status int, @Error int

BEGIN TRANSACTION

DELETE FROM RetencionesXCLiente WHERE intCliente_ID = @Cliente_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarSucursal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarSucursal]
	@Sucursal_ID  int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	DELETE FROM Sucursales WHERE intSucursal_ID = @Sucursal_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarUnidadMedida]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarUnidadMedida]
	@Unidad_ID  varchar(600)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	UPDATE c_ClaveUnidad SET Seleccionado = 0 WHERE Clave_Unidad = SUBSTRING(@Unidad_ID,1,CHARINDEX('-',@Unidad_ID) -1)

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
/****** Object:  StoredProcedure [dbo].[Sp_EliminarUsuario]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_EliminarUsuario]
	@Usuario_ID  int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	DECLARE @Status int, @Error int

	BEGIN TRANSACTION

	DELETE FROM Usuarios WHERE intUsuario_ID = @Usuario_ID
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
/****** Object:  StoredProcedure [dbo].[Sp_ExisteReporteMesAnterior]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ExisteReporteMesAnterior]
	-- Add the parameters for the stored procedure here
	@Sucursal_ID	int,
	@Año			int
AS

BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT Isnull(Max(intMes),0) MaxMes FROM Reporte_Mensual_FE
    WHERE intSucursal_ID = @Sucursal_ID
      AND intAno_Aprobacion = @Año
   
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCertificado]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
	@Sucursal_ID	int
AS

BEGIN
	SET NOCOUNT ON;

    SELECT vchCertificadoPEM FROM Datos_FacturaElectronica
    WHERE intSucursal_ID = @Sucursal_ID AND intPAC_ID IN (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)
  
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerCveProdServ]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosCfgCorreo]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosCliente]
	@Cliente_ID	int,
	@Todos		int,
	@Estatus	int
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @ManejaRetenciones int

	SET DATEFORMAT dmy
	SET @ManejaRetenciones = ISNULL((SELECT COUNT(*) FROM RetencionesXCliente WHERE intCliente_ID = @Cliente_ID),0)

	IF @Todos = 1
		SELECT *, CASE WHEN @ManejaRetenciones > 0 THEN 1 ELSE 0 END AS bitManejaRetenciones FROM Clientes
		WHERE bitActivo = @Estatus AND intCliente_ID = @Cliente_ID 
	ELSE
		SELECT ' ', intCliente_ID, RTRIM(vchRazonSocial) AS Nombre FROM Clientes
		WHERE bitActivo = @Estatus AND (intCliente_ID = @Cliente_ID AND @Cliente_ID <> 0 OR @Cliente_ID = 0)
		ORDER BY RTRIM(vchRazonSocial)

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosConfiguracion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosConfiguracion]
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT * FROM Configuracion

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleFactura]
	@Sucursal_ID	int,
	@Folio_ID		int,
	@TipoDocumento	char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT ' ', CASE WHEN LTRIM(RTRIM(CONVERT(CHAR,mnyCantidad))) <> '0.00' THEN LTRIM(RTRIM(CONVERT(CHAR,mnyCantidad))) ELSE '' END, CASE WHEN vchDescripcion_Producto <> '' THEN vchDescripcion_Producto ELSE Productos.vchDescripcion END, ISNULL(Unidad_Medida.vchDescripcion,'.'), Det_Ventas.mnyPrecio, mnyImporte, 0 AS Orden, intRenglon FROM Det_Ventas
	LEFT OUTER JOIN Productos ON Det_Ventas.intProducto_ID = Productos.intProducto_ID
	LEFT OUTER JOIN Unidad_Medida ON Productos.intUnidad_ID = Unidad_Medida.intUnidad_ID
	WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @TipoDocumento

	UNION
	
	SELECT  ' ',
			'' AS mnyCantidad, 
			RTRIM(Retenciones.vchNombreRetencion) + ' ' + CASE WHEN mnyPorcentaje <> 0 THEN LTRIM(RTRIM(CONVERT(CHAR,mnyPorcentaje))) + '%' ELSE '' END + ' ' + CASE WHEN bitMillar = 1 AND mnyPorcentaje <> 0 THEN 'Millar' ELSE '' END AS vchProducto, 
			'.' AS vchUnidad,
			mnyImporte AS mnyPrecio, 
			mnyImporte,
			1 AS Orden,
			intRenglon
	FROM Det_Retenciones
	LEFT OUTER JOIN Retenciones ON Det_Retenciones.intRetencion_ID = Retenciones.intRetencion_ID
	WHERE mnyPorcentaje > 0 AND intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @TipoDocumento

	ORDER BY Orden, intRenglon

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosDetalleNotaCredito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosDetalleNotaCredito]
	@Sucursal_ID	int,
	@Folio_ID		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT ' ', RTRIM(CONVERT(CHAR,intFactura_ID)) + ' '+ vchSerie_Factura , vchNotas, mnyImporte FROM Det_Notas_Credito
	WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosEmpresa]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosEmpresa]
AS

SET DATEFORMAT dmy

SELECT *  FROM Parametros

GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFacturaElectronica]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFacturaElectronica]
	@Sucursal_ID	int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT * FROM Datos_FacturaElectronica
	WHERE intSucursal_ID = @Sucursal_ID AND intPAC_ID IN (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosFacturaRecibo]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ObtenerDatosFacturaRecibo]
	@Sucursal_ID	int,
	@Folio_ID		int,
	@Tipo_Documento	char(1),
	@Opcion			int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Opcion = 0
		SELECT '', Clientes.vchRazonSocial, intFolio_ID, dtmFecha_Registro, mnyTotal FROM Cab_Ventas
		INNER JOIN Clientes ON Cab_Ventas.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND intSucursal_ID = @Sucursal_ID AND (chrTipo_Documento = @Tipo_Documento AND @Tipo_Documento <> '' OR @Tipo_Documento = '')
		ORDER BY intFolio_ID

	IF @Opcion = 1
		SELECT '', Clientes.vchRazonSocial, intFolio_ID, dtmFecha_Registro, mnyTotal, bitCancelada AS Estatus, vchRFC + '-' + RTRIM(LTRIM(CONVERT(CHAR,intFolio_ID))) + '.PDF' FROM Cab_Ventas
		INNER JOIN Clientes ON Cab_Ventas.intCliente_ID = Clientes.intCliente_ID
		WHERE intSucursal_ID = @Sucursal_ID AND (chrTipo_Documento = @Tipo_Documento AND @Tipo_Documento <> '' OR @Tipo_Documento = '')
		ORDER BY intFolio_ID

	IF @Opcion = 2
	BEGIN
		IF @Tipo_Documento = 'F'
			IF ISNULL((SELECT COUNT(*) FROM Det_Notas_Credito WHERE intFactura_ID = @Folio_ID),0) > 0 RETURN -99

		SELECT Cab_Ventas.*, Clientes.*, ISNULL(vTotal_Amortizacion.mnyTotalAmortizacion,0) AS mnyTotalAmortizacion, ISNULL(P.mnySaldo_Pendiente,Cab_Ventas.mnyTotal) AS mnySaldoAnterior FROM Cab_Ventas
		INNER JOIN Clientes ON Cab_Ventas.intCliente_ID = Clientes.intCliente_ID
		LEFT OUTER JOIN vTotal_Amortizacion ON Cab_Ventas.intSucursal_ID = vTotal_Amortizacion.intSucursal_ID AND Cab_Ventas.intFolio_ID = vTotal_Amortizacion.intFolio_ID AND Cab_Ventas.chrTipo_Documento = vTotal_Amortizacion.chrTipo_Documento
		LEFT OUTER JOIN (SELECT intSucursal_ID, intFactura_ID, MAX(intParcialidad) AS intParcialidad FROM vUltimaParcialidadXFactura GROUP BY intSucursal_ID, intFactura_ID) UP ON Cab_Ventas.intSucursal_ID = UP.intSucursal_ID AND Cab_Ventas.intFolio_ID = UP.intFactura_ID
		LEFT OUTER JOIN Det_Pagos P ON Cab_Ventas.intSucursal_ID = P.intSucursal_ID AND Cab_Ventas.intFolio_ID = P.intFactura_ID AND UP.intParcialidad = P.intParcialidad
		WHERE Cab_Ventas.bitCancelada = 0 AND Cab_Ventas.intSucursal_ID = @Sucursal_ID AND Cab_Ventas.intFolio_ID = @Folio_ID AND Cab_Ventas.chrTipo_Documento = @Tipo_Documento
	END

	IF @Opcion = 3
		SELECT Cab_Ventas.*, Clientes.* FROM Cab_Ventas
		INNER JOIN Clientes ON Cab_Ventas.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @Tipo_Documento

	IF @Opcion = 4
		SELECT '', Clientes.vchRazonSocial, P.intPago_ID, P.dtmFecha_Pago, P.mnyTotal, P.bitCancelada AS Estatus, vchRFC + '-' + RTRIM(LTRIM(CONVERT(CHAR,P.intPago_ID))) + '.PDF' FROM Cab_Pagos P
		INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID) DP ON P.intPago_ID = DP.intPago_ID
		INNER JOIN Clientes ON DP.intCliente_ID = Clientes.intCliente_ID
		WHERE P.intSucursal_ID = @Sucursal_ID AND (P.chrTipo_Documento = @Tipo_Documento AND @Tipo_Documento <> '' OR @Tipo_Documento = '')
		ORDER BY P.intPago_ID

	IF @Opcion = 5
		SELECT '', Clientes.vchRazonSocial, P.intPago_ID, P.dtmFecha_Pago, mnyTotal FROM Cab_Pagos P
		INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID) DP ON P.intPago_ID = DP.intPago_ID
		INNER JOIN Clientes ON DP.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND P.intSucursal_ID = @Sucursal_ID AND (P.chrTipo_Documento = @Tipo_Documento AND @Tipo_Documento <> '' OR @Tipo_Documento = '')
		ORDER BY P.intPago_ID

	IF @Opcion = 6
		SELECT P.*, Clientes.* FROM Cab_Pagos P
		INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID) DP ON P.intPago_ID = DP.intPago_ID
		INNER JOIN Clientes ON DP.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND P.intSucursal_ID = @Sucursal_ID AND P.intPago_ID = @Folio_ID AND P.chrTipo_Documento = 'P'

END



GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosIva]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosNotaCredito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosNotaCredito]
	@Sucursal_ID	int,
	@Folio_ID		int,
	@Todos			int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = -1
		SELECT ' ', Clientes.vchRazonSocial, intFolio_ID, dtmFecha_Registro, mnyTotal, bitCancelada, vchRFC + '-' + RTRIM(LTRIM(CONVERT(CHAR,intFolio_ID))) + '.PDF' FROM Cab_Notas_Credito
		INNER JOIN Clientes ON Cab_Notas_Credito.intCliente_ID = Clientes.intCliente_ID
		WHERE intSucursal_ID = @Sucursal_ID
		ORDER BY intFolio_ID

	IF @Todos = 0
		SELECT ' ', Clientes.vchRazonSocial, intFolio_ID, dtmFecha_Registro, mnyTotal FROM Cab_Notas_Credito
		INNER JOIN Clientes ON Cab_Notas_Credito.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND intSucursal_ID = @Sucursal_ID
		ORDER BY intFolio_ID

	IF @Todos = 1
		SELECT Cab_Notas_Credito.*, Clientes.* FROM Cab_Notas_Credito
		INNER JOIN Clientes ON Cab_Notas_Credito.intCliente_ID = Clientes.intCliente_ID
		WHERE bitCancelada = 0 AND intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosPAC]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosPACPredeterminado]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosPACPredeterminado] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM Pacs_Autorizados WHERE bitPredeterminado = 1
	
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosParametros]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosParametros]
	@Sucursal_ID	int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT P.*, DF.vchCertificado_Key_Pwd FROM Parametros P, Datos_FacturaElectronica DF
	WHERE P.intSucursal_ID = @Sucursal_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosProducto]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosProducto]
	@Producto_ID	int,
	@Todos			int,
	@Estatus		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT Productos.*, CU.Nombre AS vchNombreCorto FROM Productos
		INNER JOIN c_ClaveUnidad CU ON Productos.vchUnidad = CU.Clave_Unidad
		WHERE Productos.bitActivo = @Estatus 
		  AND intProducto_ID = @Producto_ID
		  AND intProducto_ID > 0
	ELSE
		SELECT ' ', intProducto_ID, SUBSTRING(Rtrim(vchDescripcion),1,50) AS vchDescripcion FROM Productos
		WHERE intProducto_ID > 0 AND bitActivo = @Estatus AND (intProducto_ID = @Producto_ID AND @Producto_ID <> 0 OR @Producto_ID = 0)

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRegimenes]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRegimenFiscal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRetencion]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRetencion]
	@Retencion_ID	int,
	@Todos			int,
	@Estatus		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT * FROM Retenciones
		WHERE bitActivo = @Estatus AND (intRetencion_ID = @Retencion_ID AND @Retencion_ID <> 0 OR @Retencion_ID = 0)
	ELSE
		SELECT ' ', intRetencion_ID, vchNombreRetencion FROM Retenciones
		WHERE bitActivo = @Estatus AND (intRetencion_ID = @Retencion_ID AND @Retencion_ID <> 0 OR @Retencion_ID = 0)

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRetencionesSinAsignar]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRetencionesSinAsignar]
@Cliente_ID   int
AS

SET DATEFORMAT dmy

SELECT Retenciones.intRetencion_ID, Retenciones.vchNombreRetencion FROM Retenciones
LEFT OUTER JOIN RetencionesXCLiente ON Retenciones.intRetencion_ID = RetencionesXCLiente.intRetencion_ID AND RetencionesXCLiente.intCliente_ID = @Cliente_ID
WHERE bitActivo = 1
	AND RetencionesXCLiente.intRetencion_ID IS NULL
ORDER BY RetencionesXCLiente.intOrden


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosRetencionesXCliente]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosRetencionesXCliente]
@Cliente_ID	int,
@Tipo		int
AS

SET DATEFORMAT dmy

IF @Tipo = 1 
	SELECT RetencionesXCliente.intRetencion_ID, Retenciones.vchNombreRetencion FROM RetencionesXCliente
	INNER JOIN Retenciones ON RetencionesXCliente.intRetencion_ID = Retenciones.intRetencion_ID
	WHERE intCliente_ID = @Cliente_ID 
	ORDER BY intOrden 

IF @Tipo = 2
	SELECT ' ', Retenciones.vchNombreRetencion, mnyPorcentajeRetencion, 0, 1, RetencionesXCliente.intRetencion_ID, Retenciones.bitMillar FROM RetencionesXCliente
	INNER JOIN Retenciones ON RetencionesXCliente.intRetencion_ID = Retenciones.intRetencion_ID
	WHERE intCliente_ID = @Cliente_ID 
	ORDER BY intOrden 


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosSucursal]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosSucursal]
	@Sucursal_ID	int,
	@Todos			int,
	@Estatus		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT * FROM Sucursales
		WHERE bitActivo = @Estatus AND (intSucursal_ID = @Sucursal_ID AND @Sucursal_ID <> 0 OR @Sucursal_ID = 0)
	ELSE
		SELECT ' ', intSucursal_ID, Rtrim(vchDescripcion) AS vchDescripcion FROM Sucursales
		WHERE bitActivo = @Estatus AND (intSucursal_ID = @Sucursal_ID AND @Sucursal_ID <> 0 OR @Sucursal_ID = 0)
		
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosUnidadMedida]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerDatosUnidadMedida]
	@Unidad_ID	varchar(10),
	@Todos		int,
	@Estatus	int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Todos = 1
		SELECT ROW_NUMBER() OVER(ORDER BY Clave_Unidad ASC) AS intUnidad_ID, Clave_Unidad + ' - ' + Nombre AS vchDescripcion FROM c_ClaveUnidad
		WHERE ISNULL(Seleccionado,0) = 1 AND (Clave_Unidad = @Unidad_ID AND @Unidad_ID <> 0 OR @Unidad_ID = 0)
	ELSE
		SELECT ' ', ROW_NUMBER() OVER(ORDER BY Clave_Unidad ASC) AS intUnidad_ID, Clave_Unidad + ' - ' + Nombre AS vchDescripcion FROM c_ClaveUnidad
		WHERE ISNULL(Seleccionado,0) = @Estatus AND (Clave_Unidad = @Unidad_ID AND @Unidad_ID <> 0 OR @Unidad_ID = 0)

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerDatosUsuario]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerDatosUsuario]
	@Usuario     varchar(10),
	@Estatus	 int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	IF @Usuario <> ""
		SELECT vchContrasena AS vchPassword, vchNombreCompleto, intSucursal_ID, intUsuario_ID, vchTipo_Usuario, vchUsuario, bitActivo, vchAccesos, bitMultiSucursal FROM Usuarios
		WHERE bitActivo = @Estatus
			  AND vchUsuario = @Usuario

	IF @Usuario = ""
		SELECT '',intUsuario_ID, vchUsuario FROM Usuarios
--		WHERE intUsuario_ID > 0 AND bitActivo = @Estatus
		WHERE bitActivo = @Estatus
		  
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerFechaServidor]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerFechaServidor]
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT GETDATE()
	
END



GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerFormaPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerMetodoPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerPaises]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerPaises]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT ROW_NUMBER() OVER(ORDER BY Pais ASC) AS ID, Pais + ' - ' + Descripcion AS Descripcion FROM c_Pais

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerProductosActivos]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ObtenerProductosActivos]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ' ', intProducto_ID, vchDescripcion FROM Productos
	WHERE bitActivo = 1 AND intProducto_ID > 0
	
END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerSello]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ObtenerSello]
	@Folio_ID		int,
	@Sucursal_ID	int,
	@TipoDoc		char(1)
AS

BEGIN
	SET NOCOUNT ON;

	IF @TipoDoc = 'P'
		SELECT vchSello, txtXML_CFDI FROM Cab_Pagos
		WHERE intSucursal_ID = @Sucursal_ID AND intPago_ID = @Folio_ID
	ELSE
		IF @TipoDoc <> 'N'
			SELECT vchSello, txtXML_CFDI FROM Cab_Ventas
			WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @TipoDoc
		ELSE
			SELECT vchSello, txtXML_CFDI FROM Cab_Notas_Credito
			WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerSiguienteFolio]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_ObtenerSiguienteFolio]
	@Sucursal_ID	int,
	@Tipo_Documento	char(1)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Nuevo_Folio int, @Serie varchar(10), @Certificado_Vencido bit, @DiasRestantes int, @PAC_ID int
	
	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

	SELECT @Nuevo_Folio = (intFolio + 1), @Serie = vchSerie, @Certificado_Vencido = CASE WHEN DATEDIFF(d,GETDATE(), dtmFecha_FinCertificado) <= 0 THEN 1 ELSE 0 END, @DiasRestantes = DATEDIFF(d,GETDATE(), dtmFecha_FinCertificado) FROM Control_Folios
	INNER JOIN Datos_FacturaElectronica FE ON Control_Folios.intSucursal_ID = FE.intSucursal_ID AND intPAC_ID = @PAC_ID
	WHERE Control_Folios.intSucursal_ID = @Sucursal_ID AND chrTipo_Documento = @Tipo_Documento
	
	IF @Nuevo_Folio = 0
		RETURN -99
	
	SELECT @Nuevo_Folio AS Sig_Folio, @Serie AS Serie, @Certificado_Vencido AS Certificado_Vencido, @DiasRestantes AS Dias_Restantes

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerUsoCFDI]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCabFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ReporteCabFactura]
	@Factura_ID		int, 
	@Sucursal_ID	int,
	@Tipo_Doc		char(1),
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
			CONVERT(SMALLDATETIME,CONVERT(CHAR,Cab.dtmFecha_Registro,103),103) AS dtmFecha,
			dtmFecha_Registro,
			Cab.intFOLIO_ID AS intFactura_ID,
			Cab.vchMetodoPago AS vchTipo_Pago,
			DF.vchNo_Serie_Certificado,
			Cab.mnySubTotal,
			CONVERT(DECIMAL,Cab.mnyPIVA) AS mnyPIVA,
			Cab.mnyIVA,
			Cab.mnyTotal,
			@Sello AS vchSello_Emisor,
			Cab.vchCadena_Original_CFDI,
			dbo.CantidadConLetra(Cab.mnyTotal,1) AS TotalLetra,
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
			'' as vchObservaciones,
			7 AS intPlazo,
			CONVERT(SMALLDATETIME,CONVERT(CHAR,DATEADD(d,30,dtmFecha_Registro),103),103) AS vchFecha_Vencimiento,
			LTRIM(RTRIM(CONVERT(VARCHAR,DAY(dtmFecha_Registro)))) AS vchFact_Dia,
			dbo.fObtenerNombreMes(dtmFecha_Registro) AS vchFact_Mes,
			LTRIM(RTRIM(CONVERT(VARCHAR,YEAR(dtmFecha_Registro)))) AS vchFact_Anno,
			dbo.fObtenerNombreMes(DATEADD(d,30,dtmFecha_Registro)) AS vchVenc_Mes,
			Cab.bitCancelada,
			@bitCopia AS bitCopia,
			Cab.vchTipo_Pago AS vchMetodoPago,
			Case When Len(Isnull(C.vchCuentaBancaria,'')) < 4 Then '0000' Else C.vchCuentaBancaria End AS vchCuentaBancaria,
			C.vchBanco,
			@RegimenFiscal AS RegimenFiscal,
			mnyRetIVA,
			mnyRetISR,
			mnyPRetISR,
			mnyPRetIVA,
			SUBSTRING(Cab.vchSello_CFD,LEN(Cab.vchSello_CFD) - 8 + 1, 8) AS Ultimos_Sello,
			C.vchUso_CFDI
	FROM Cab_Ventas Cab
	INNER JOIN Clientes C ON Cab.intCliente_ID = C.intCliente_ID
	INNER JOIN Datos_FacturaElectronica DF ON Cab.intSucursal_ID = DF.intSucursal_ID AND DF.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN c_MetodoPago M ON C.vchMetodoPago = M.Metodo_Pago COLLATE SQL_Latin1_General_CP1_CI_AS OR C.vchMetodoPago = M.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS, Parametros DG
	WHERE cab.intSucursal_ID = @Sucursal_ID AND Cab.intFolio_ID = @Factura_ID AND Cab.chrTipo_Documento = @Tipo_Doc

END

GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCabNotaCredito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
	@Nota_Credito_ID	int,
	@Sucursal_ID		int,
	@Tipo_Doc			char(1),
	@Sello				varchar(2000),
	@Empresa			varchar(100),
	@bitCopia			bit
AS

BEGIN
	SET NOCOUNT ON;

	DECLARE @PAC_ID int

	SET @PAC_ID = (SELECT intPAC_ID FROM Pacs_Autorizados WHERE bitPredeterminado = 1)

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
			RTRIM(Clientes.vchRazonSocial) AS vchNombre_Cliente,
			Clientes.vchRFC AS vchRFC_Cliente,
			Clientes.vchDireccion AS vchDireccion_Cliente,
			Clientes.vchCiudad AS vchCiudad_Cliente,
			Clientes.vchEstado AS vchEstado_Cliente,
			Clientes.vchCodigoPostal AS vchCodigoPostal_Cliente,
			Clientes.vchTelefono AS vchTelefono_Cliente,
			Clientes.vchPais AS vchPais_Cliente,
			Clientes.vchNoExterior AS vchNoExterior_Cliente,
			Clientes.vchNoInterior AS vchNoInterior_Cliente,
			Clientes.vchColonia AS vchColonia_Cliente,
			CONVERT(SMALLDATETIME,CONVERT(CHAR,Cab.dtmFecha_Registro,103),103) AS dtmFecha,
			Cab.dtmFecha_Registro,
			Cab.intFolio_ID,
			Cab.vchTipo_Pago,
			DF.vchNo_Serie_Certificado,
			Cab.mnySubTotal,
			CONVERT(DECIMAL,Cab.mnyPIVA) AS mnyPIVA,
			Cab.mnyIVA,
			Cab.mnyTotal,
			0 AS Importe_Factura, 
			@Sello AS vchSello_Emisor,
			Cab.vchCadena_Original_CFDI,
			dbo.CantidadConLetra(Cab.mnyTotal,1) AS TotalLetra,
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
			'' AS vchObservaciones,
			7 AS intPlazo,
			LTRIM(RTRIM(CONVERT(VARCHAR,DAY(dtmFecha_Registro)))) AS vchNC_Dia,
			dbo.fObtenerNombreMes(dtmFecha_Registro) AS vchNC_Mes,
			LTRIM(RTRIM(CONVERT(VARCHAR,YEAR(dtmFecha_Registro)))) AS vchNC_Anno,
			Cab.bitCancelada,
			@bitCopia AS bitCopia
	FROM Cab_Notas_Credito Cab
	INNER JOIN Datos_FacturaElectronica DF ON Cab.intSucursal_ID = DF.intSucursal_ID AND DF.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Clientes ON Cab.intCliente_ID = Clientes.intCliente_ID, Parametros DG
	WHERE Cab.intFolio_ID = @Nota_Credito_ID AND Cab.intSucursal_ID = @Sucursal_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteCabPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteCabPago]
	@Pago_ID		int, 
	@Sucursal_ID	int,
	@Tipo_Doc		char(1),
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
			DP.vchTipo_Pago AS vchFormaPago,
			P.mnyTotal AS mnyTotalPagado,
			dbo.CantidadConLetra(P.mnyTotal,1) AS TotalLetra,
			
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
	INNER JOIN (SELECT DISTINCT P.intPago_ID, C.intCliente_ID, CV.vchTipo_Pago FROM Det_Pagos P INNER JOIN Cab_Ventas CV ON P.intFactura_ID = CV.intFolio_ID INNER JOIN Clientes C ON CV.intCliente_ID = C.intCliente_ID WHERE P.intPago_ID = @Pago_ID) DP ON P.intPago_ID = DP.intPago_ID
	INNER JOIN Clientes C ON DP.intCliente_ID = C.intCliente_ID
	INNER JOIN Datos_FacturaElectronica DF ON P.intSucursal_ID = DF.intSucursal_ID AND DF.intPAC_ID = @PAC_ID
	LEFT OUTER JOIN Metodo_Pago M ON C.vchMetodoPago = M.Clave OR C.vchMetodoPago = M.Descripcion, Parametros DG
	WHERE P.intSucursal_ID = @Sucursal_ID AND P.intPago_ID = @Pago_ID AND P.chrTipo_Documento = 'P'

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteClientes]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ReporteClientes]
	@Cliente_Ini	int,
	@Cliente_Fin	int,
	@Estatus		char(1),
	@Foraneo		char(1),
	@Facturar		int
AS

BEGIN
	SET NOCOUNT ON;

	SET DATEFORMAT dmy

	SELECT * FROM Clientes
	WHERE (bitActivo = 1 AND @Estatus = 'A' OR bitActivo = 0 AND @Estatus = 'I' OR bitActivo >= 0 AND @Estatus ='T')
--		  AND (bitForaneo = 1 AND @Foraneo = 'F' OR bitForaneo = 0 AND @Foraneo = 'L' OR @Foraneo = 'T')
--		  AND intCliente_ID BETWEEN @Cliente_INI AND @Cliente_Fin
--		  AND(bitFacturar = 1 AND @Facturar = 1 OR bitFacturar = 0 AND @Facturar = 0 OR @Facturar = 2)
		  
END



GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetFactura]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteDetFactura]
	@Folio_ID		int,
	@Sucursal_ID	int,
	@Tipo_Doc		char(1)
AS

BEGIN
	SET NOCOUNT ON;
	
	IF ISNULL((SELECT COUNT(*) FROM Det_retenciones WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID AND chrTipo_Documento = @Tipo_Doc),0) = 0
		SELECT  intRenglon,
				ISNULL(Det_Ventas.intProducto_ID,intRenglon) AS intCodigo,
				mnyCantidad, 
				CASE WHEN vchDescripcion_Producto <> '' THEN vchDescripcion_Producto ELSE Productos.vchDescripcion END AS vchProducto, 
				Det_Ventas.mnyPrecio AS mnyPrecio, 
				mnyImporte,
				CASE WHEN ISNULL(Det_Ventas.intUnidad_ID,0) = 0 THEN CASE WHEN CHARINDEX(' ',CU.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS) > 0 THEN SUBSTRING(CU.Nombre,1,CHARINDEX(' ',CU.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS)) ELSE CU.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS END ELSE Unidad_Medida.vchNombreCorto END AS vchUnidad,
				1 AS Orden 
		FROM Det_Ventas
		LEFT OUTER JOIN Productos ON Det_Ventas.intProducto_ID = Productos.intProducto_ID
		LEFT OUTER JOIN Unidad_Medida ON Det_Ventas.intUnidad_ID = Unidad_Medida.intUnidad_ID
		LEFT OUTER JOIN c_ClaveUnidad CU ON Det_Ventas.vchUnidad COLLATE Latin1_General_CI_AS = CU.Clave_Unidad
		WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID and Det_Ventas.chrTipo_Documento = @Tipo_Doc

	ELSE
		SELECT  intRenglon,
				ISNULL(Det_Ventas.intProducto_ID,intRenglon) AS intCodigo,
				mnyCantidad, 
				CASE WHEN vchDescripcion_Producto <> '' THEN vchDescripcion_Producto ELSE Productos.vchDescripcion END AS vchProducto, 
				Det_Ventas.mnyPrecio AS mnyPrecio, 
				mnyImporte,
				CASE WHEN ISNULL(Det_Ventas.intUnidad_ID,0) = 0 THEN CASE WHEN CHARINDEX(' ',CU.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS) > 0 THEN SUBSTRING(CU.Nombre,1,CHARINDEX(' ',CU.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS)) ELSE CU.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS END ELSE Unidad_Medida.vchNombreCorto END AS vchUnidad,
				1 AS Orden 
		FROM Det_Ventas
		LEFT OUTER JOIN Productos ON Det_Ventas.intProducto_ID = Productos.intProducto_ID
		LEFT OUTER JOIN Unidad_Medida ON Det_Ventas.intUnidad_ID = Unidad_Medida.intUnidad_ID
		LEFT OUTER JOIN c_ClaveUnidad CU ON Det_Ventas.vchUnidad = CU.Clave_Unidad
		WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID and Det_Ventas.chrTipo_Documento = @Tipo_Doc
	
		UNION ALL

		SELECT 0, 0, 0, '', 0, 0, '.', 2

		UNION ALL

		SELECT 0, 0, 0, 'DESCUENTOS:', 0, 0, '', 3

		UNION ALL

		SELECT  0,
				0 AS intCodigo,
				0 AS mnyCantidad, 
				'      ' + RTRIM(Retenciones.vchNombreRetencion) + ' ' + CASE WHEN mnyPorcentaje <> 0 THEN LTRIM(RTRIM(CONVERT(CHAR,mnyPorcentaje))) + '%' ELSE '' END + ' ' + CASE WHEN bitMillar = 1 AND mnyPorcentaje <> 0 THEN 'Millar' ELSE '' END AS vchProducto, 
				mnyImporte AS mnyPrecio, 
				0,
				'' AS vchUnidad,
				4 AS Orden 
		FROM Det_Retenciones
		LEFT OUTER JOIN Retenciones ON Det_Retenciones.intRetencion_ID = Retenciones.intRetencion_ID
		WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID and chrTipo_Documento = @Tipo_Doc AND mnyPorcentaje <> 0

		UNION ALL

		SELECT  0,
				0,
				0, 
				'TOTAL DESCUENTOS:' AS vchProducto, 
				SUM(mnyImporte) AS mnyPrecio,
				0 AS mnyImporte,
				'' AS vchUnidad,
				5 AS Orden 
		FROM Det_Retenciones
		WHERE intSucursal_ID = @Sucursal_ID AND intFolio_ID = @Folio_ID and chrTipo_Documento = @Tipo_Doc AND mnyPorcentaje <> 0

		UNION ALL

		SELECT 0, 0, 0, '', 0, 0, '.', 6

		UNION ALL

		SELECT  0,
				0,
				0, 
				'NETO A RECIBIR' AS vchProducto, 
				Cab_Ventas.mnyTotal - Det_Retenciones.mnyImporte AS mnyPrecio, 
				0,
				'' AS vchUnidad,
				7 AS Orden 
		FROM Cab_Ventas
		LEFT OUTER JOIN (SELECT intSucursal_ID, intFolio_ID, chrTipo_Documento, SUM(MNYiMPORTE) AS mnyImporte FROM Det_Retenciones WHERE mnyPorcentaje <> 0 GROUP BY intSucursal_ID, intFolio_ID, chrTipo_Documento) Det_Retenciones ON Cab_Ventas.intSucursal_ID = Det_Retenciones.intsucursal_ID AND Cab_Ventas.intFolio_ID = Det_Retenciones.intFolio_ID AND Cab_Ventas.chrTipo_Documento = Det_Retenciones.chrTipo_Documento
		WHERE Cab_Ventas.intSucursal_ID = @Sucursal_ID AND Cab_Ventas.intFolio_ID = @Folio_ID and Cab_Ventas.chrTipo_Documento = @Tipo_Doc

		ORDER BY Orden, intRenglon

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetNotaCredito]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
	@Nota_Credito_ID	int,
	@Sucursal_ID		int,
	@Tipo_Doc			char(1)
AS

BEGIN
	SET NOCOUNT ON;

	SELECT 	intRenglon,
			Det.intFolio_ID,
			Det.intFactura_ID AS intFactura_ID,
			Det.vchNotas AS vchProducto, 
			'Factura No.' AS TipoDoc,
			CONVERT(MONEY,1) AS mnyCantidad,
			Det.mnyImporte AS mnyPrecio, 
			Det.mnyImporte AS mnyImporte,
			Det.mnyImporte AS mnyTotal
	FROM Det_Notas_Credito Det
	WHERE Det.intFolio_ID = @Nota_Credito_ID AND Det.intSucursal_ID = @Sucursal_ID

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ReporteDetPago]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ReporteDetPago]
	@Folio_ID		int,
	@Sucursal_ID	int,
	@Tipo_Doc		char(1)
AS

BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Serie varchar(10)

	SET @Serie = (SELECT vchSerie FROM Control_Folios WHERE intSucursal_ID = @Sucursal_ID AND chrTipo_Documento <> @Tipo_Doc)

	SELECT  ROW_NUMBER() OVER(ORDER BY V.vchFolio_Fiscal ASC) AS Renglon,
			ISNULL(V.vchFolio_Fiscal,'') AS UUID,
			CONVERT(VARCHAR,P.intFactura_ID) + @Serie AS Folio, 
			C.vchMetodoPago AS Metodo, 
			P.mnySaldo_Anterior AS Saldo_Anterior, 
			P.mnySaldo_Pendiente AS Saldo_Pendiente,
			P.mnyMonto_Pagado AS Monto_pagado,
			V.mnyTotal AS Total,
			1 AS Orden 
	FROM Det_Pagos P
	LEFT OUTER JOIN Cab_Ventas V ON P.intSucursal_ID = V.intSucursal_ID AND P.intFactura_ID = V.intFolio_ID AND V.chrTipo_Documento <> @Tipo_Doc
	LEFT OUTER JOIN Clientes C ON V.intCliente_ID = C.intCliente_ID
	WHERE P.intSucursal_ID = @Sucursal_ID AND P.intPago_ID = @Folio_ID AND P.chrTipo_Documento = 'P'

END


GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidaDatosFacturaElectronica]    Script Date: 26/06/2018 07:18:18 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Sp_ValidaDatosFacturaElectronica]
(
	@Cliente Int
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
/****** Object:  StoredProcedure [dbo].[Sp_ValidarClaveProdServ]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ValidarCP]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_ValidarUnidad]    Script Date: 26/06/2018 07:18:18 p.m. ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Det_Retenciones"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTotal_Amortizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTotal_Amortizacion'
GO
USE [master]
GO
ALTER DATABASE [Facturacion] SET  READ_WRITE 
GO
