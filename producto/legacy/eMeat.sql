USE [master]
GO
/****** Object:  Database [eMeatControlValco]    Script Date: 26/06/2018 07:17:37 p.m. ******/
CREATE DATABASE [eMeatControlValco]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CO_SAMovil', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\eMeatControlValcoNew.mdf' , SIZE = 129472KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CO_SAMovil_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\eMeatControlValcoNew_1.ldf' , SIZE = 321088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [eMeatControlValco] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [eMeatControlValco].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [eMeatControlValco] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [eMeatControlValco] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [eMeatControlValco] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [eMeatControlValco] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [eMeatControlValco] SET ARITHABORT OFF 
GO
ALTER DATABASE [eMeatControlValco] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [eMeatControlValco] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [eMeatControlValco] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [eMeatControlValco] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [eMeatControlValco] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [eMeatControlValco] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [eMeatControlValco] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [eMeatControlValco] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [eMeatControlValco] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [eMeatControlValco] SET  DISABLE_BROKER 
GO
ALTER DATABASE [eMeatControlValco] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [eMeatControlValco] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [eMeatControlValco] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [eMeatControlValco] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [eMeatControlValco] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [eMeatControlValco] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [eMeatControlValco] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [eMeatControlValco] SET RECOVERY FULL 
GO
ALTER DATABASE [eMeatControlValco] SET  MULTI_USER 
GO
ALTER DATABASE [eMeatControlValco] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [eMeatControlValco] SET DB_CHAINING OFF 
GO
ALTER DATABASE [eMeatControlValco] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [eMeatControlValco] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [eMeatControlValco] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'eMeatControlValco', N'ON'
GO
USE [eMeatControlValco]
GO
/****** Object:  User [Zar]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE USER [Zar] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gil]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE USER [gil] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [emc]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE USER [emc] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Zar]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [Zar]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Zar]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Zar]
GO
ALTER ROLE [db_owner] ADD MEMBER [emc]
GO
/****** Object:  UserDefinedFunction [dbo].[fnAge]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnAge]  (@BirthDate DATETIME)
RETURNS @Age TABLE(Years  INT,
                   Months INT,
                   Days   INT)
AS
  BEGIN
    DECLARE  @EndDate     DATETIME, @Anniversary DATETIME
    SET @EndDate = Getdate()
    SET @Anniversary = Dateadd(yy,Datediff(yy,@BirthDate,@EndDate),@BirthDate)
    
    INSERT @Age
    SELECT Datediff(yy,@BirthDate,@EndDate) - (CASE
                                                 WHEN @Anniversary > @EndDate THEN 1
                                                 ELSE 0
                                               END), 0, 0
     UPDATE @Age     SET    Months = Month(@EndDate - @Anniversary) - 1
    UPDATE @Age     SET    Days = Day(@EndDate - @Anniversary) - 1
    RETURN
  END

GO
/****** Object:  Table [dbo].[Almacenes]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Almacenes](
	[IdAlmacen] [int] IDENTITY(17,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[TipoAlmacen] [varchar](50) NULL,
 CONSTRAINT [PK__Almacenes__5070F446] PRIMARY KEY NONCLUSTERED 
(
	[IdAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Articulos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Articulos](
	[idArticulo] [int] IDENTITY(1,1) NOT NULL,
	[idFamilia] [int] NULL,
	[SubFamilia] [int] NULL,
	[ArtClave] [float] NOT NULL,
	[ArtClaveAlterna] [nvarchar](255) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[descripcion_corta] [nvarchar](255) NOT NULL,
	[Cont] [float] NULL,
	[idUnidad] [int] NULL,
	[PiezasxCaja] [int] NULL,
	[Costoxpza] [float] NULL,
	[Costoxcaja] [float] NULL,
	[Costoprod] [float] NULL,
	[PzasxEmp] [int] NULL,
	[Tipo_Articulo] [nvarchar](255) NULL,
	[Origen] [nvarchar](255) NULL,
	[Fecha] [datetime] NULL,
	[Activo] [bit] NULL,
	[Categoria] [varchar](15) NULL,
	[FechaModificacion] [datetime] NULL CONSTRAINT [DF_Articulos_FechaModificacion]  DEFAULT (getdate()),
	[idAlmacen] [int] NULL,
	[costoUnidadMedida] [float] NULL,
	[ultimoCosto] [float] NULL,
	[costoPromedio] [float] NULL,
	[tipoEtiqueta] [varchar](2) NULL,
	[precioVenta] [float] NULL,
	[Sobrante] [bit] NULL CONSTRAINT [DF_Articulos_Sobrante]  DEFAULT ((0)),
 CONSTRAINT [PK_Articulos] PRIMARY KEY CLUSTERED 
(
	[idArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchEtiquetado]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchEtiquetado](
	[idBatchEtiquetado] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Fecha] [datetime] NULL,
	[Estatus] [bit] NULL,
	[idusuario] [int] NULL,
 CONSTRAINT [PK_BatchEtiquetado] PRIMARY KEY CLUSTERED 
(
	[idBatchEtiquetado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchEtiquetadoDetalle]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchEtiquetadoDetalle](
	[idBatchEtiquetadoDet] [int] IDENTITY(1,1) NOT NULL,
	[idBatchEtiquetado] [int] NULL,
	[Etiqueta] [varchar](25) NULL,
	[Procesado] [bit] NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[BatchEtiquetadoDetalle] ADD [EtiquetaReemplazo] [varchar](25) NULL
 CONSTRAINT [PK_BatchEtiquetadoDetalle] PRIMARY KEY CLUSTERED 
(
	[idBatchEtiquetadoDet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchEtiquetadoDetalleErrores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchEtiquetadoDetalleErrores](
	[idBatchEtiquetadoErroresDet] [int] IDENTITY(1,1) NOT NULL,
	[idBatchEtiquetado] [int] NULL,
	[Etiqueta] [varchar](25) NULL,
 CONSTRAINT [PK_BatchEtiquetadoDetalleErrores] PRIMARY KEY CLUSTERED 
(
	[idBatchEtiquetadoErroresDet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClasificacionCanales]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClasificacionCanales](
	[idClasificacionCanal] [int] IDENTITY(1,1) NOT NULL,
	[Clasificacion] [varchar](50) NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
 CONSTRAINT [PK_ClasificacionCanales] PRIMARY KEY CLUSTERED 
(
	[idClasificacionCanal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [int] IDENTITY(251,1) NOT NULL,
	[CLIENTE] [varchar](40) NULL,
	[IdTipoPrecio] [int] NOT NULL CONSTRAINT [DF_Clientes_IdTipoPrecio]  DEFAULT ((999)),
	[Direccion] [varchar](60) NULL,
	[NUM] [int] NULL,
	[COLONIA] [varchar](30) NULL,
	[Calle1] [varchar](50) NULL,
	[Calle2] [varchar](50) NULL,
	[TELEFONO] [varchar](20) NULL,
	[Celular] [varchar](20) NULL,
	[CIUDAD] [varchar](25) NULL,
	[DIA] [varchar](15) NULL,
	[RFC] [varchar](15) NULL,
	[Contado] [char](1) NULL,
	[Sector] [varchar](30) NULL,
	[ZONA] [varchar](20) NULL,
	[IdVendedor] [int] NULL,
	[client] [varchar](30) NULL,
	[fecha] [datetime] NULL,
	[UsrCreador] [int] NULL,
	[CodPos] [int] NULL,
	[Contacto] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[DiaLlamada] [varchar](15) NULL,
	[TodoArticulos] [char](1) NULL,
	[deuda] [float] NULL CONSTRAINT [DF_Clientes_saldo]  DEFAULT ((0)),
	[credito] [int] NULL CONSTRAINT [DF_Clientes_credito]  DEFAULT ((1)),
	[saldoFavor] [float] NULL CONSTRAINT [DF_Clientes_saldoFavor]  DEFAULT ((0)),
	[contadoPendiente] [float] NULL CONSTRAINT [DF_Clientes_contadoPendiente]  DEFAULT ((0)),
	[Lunes] [char](1) NULL,
	[Martes] [char](1) NULL,
	[Miercoles] [char](1) NULL,
	[Jueves] [char](1) NULL,
	[Viernes] [char](1) NULL,
	[Sabado] [char](1) NULL,
	[Domingo] [char](1) NULL,
	[DiasCredito] [int] NULL,
	[MontoCredito] [float] NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClientesMercanciaABordo]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientesMercanciaABordo](
	[idMercanciaABordo] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [varchar](25) NOT NULL,
	[NombreCliente] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_ClientesMercanciaABordo] PRIMARY KEY CLUSTERED 
(
	[idMercanciaABordo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteSucursales]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClienteSucursales](
	[idClienteSucursal] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [varchar](20) NULL,
	[Descripcion] [varchar](40) NULL,
	[Direccion] [varchar](70) NULL,
	[Telefono] [varchar](15) NULL,
	[Contacto] [varchar](30) NULL,
 CONSTRAINT [PK_ClienteSucursales] PRIMARY KEY CLUSTERED 
(
	[idClienteSucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CodificacionesCodigos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CodificacionesCodigos](
	[idCodificacion] [int] IDENTITY(1,1) NOT NULL,
	[idProveedor] [int] NOT NULL,
	[codigoArtInicial] [int] NULL,
	[codigoArtFinal] [int] NULL,
	[pesoInicial] [int] NOT NULL,
	[pesoFinal] [int] NOT NULL,
	[decimales] [int] NOT NULL,
	[longitudMinima] [int] NULL,
	[longitudMaxima] [int] NULL,
	[unidadMedida] [varchar](3) NOT NULL,
	[fechaCreacion] [datetime] NOT NULL CONSTRAINT [DF_CodificacionesCodigos_fechaCreacion]  DEFAULT (getdate()),
	[PuntoDecimal] [bit] NOT NULL CONSTRAINT [DF_codificacion_codigos_puntodecimal]  DEFAULT ((0)),
 CONSTRAINT [PK_DefinicionCodigosProveedor] PRIMARY KEY CLUSTERED 
(
	[idCodificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CodigosClientes]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CodigosClientes](
	[idCodigoCliente] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idArticulo] [int] NOT NULL,
	[Codigo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CodigosClientes] PRIMARY KEY CLUSTERED 
(
	[idCodigoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CodigosProveedores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CodigosProveedores](
	[idCodigoProveedor] [int] IDENTITY(1,1) NOT NULL,
	[idProveedor] [int] NOT NULL,
	[idArticulo] [int] NOT NULL,
	[Codigo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CodigosProveedores] PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC,
	[idArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Configuraciones]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Configuraciones](
	[idConfig] [tinyint] NOT NULL,
	[inventarioNegativo] [bit] NULL CONSTRAINT [DF_Configuraciones_InventarioNegativo]  DEFAULT ((0)),
	[seleccionarAlmacen] [bit] NULL CONSTRAINT [DF_Configuraciones_SeleccionarAlmacen]  DEFAULT ((1)),
	[conf1] [varchar](20) NULL,
	[conf2] [varchar](20) NULL,
	[conf3] [varchar](20) NULL,
	[conf4] [varchar](20) NULL,
	[conf5] [varchar](20) NULL,
	[bool1] [bit] NULL CONSTRAINT [DF_Configuraciones_bool1]  DEFAULT ((0)),
	[bool2] [bit] NULL CONSTRAINT [DF_Configuraciones_bool2]  DEFAULT ((0)),
	[bool3] [bit] NULL CONSTRAINT [DF_Configuraciones_bool3]  DEFAULT ((0)),
	[bool4] [bit] NULL CONSTRAINT [DF_Configuraciones_bool4]  DEFAULT ((0)),
	[bool5] [bit] NULL CONSTRAINT [DF_Configuraciones_bool5]  DEFAULT ((0)),
	[num1] [int] NULL CONSTRAINT [DF_Configuraciones_num1]  DEFAULT ((0)),
	[num2] [int] NULL CONSTRAINT [DF_Configuraciones_num2]  DEFAULT ((0)),
	[num3] [int] NULL CONSTRAINT [DF_Configuraciones_num3]  DEFAULT ((0)),
	[num4] [int] NULL CONSTRAINT [DF_Configuraciones_num4]  DEFAULT ((0)),
	[num5] [int] NULL CONSTRAINT [DF_Configuraciones_num5]  DEFAULT ((0)),
 CONSTRAINT [PK_Configuraciones] PRIMARY KEY CLUSTERED 
(
	[idConfig] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[consecutivo]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[consecutivo](
	[id] [int] NOT NULL,
	[consecutivo] [int] NULL,
	[fecha] [varchar](8) NULL,
 CONSTRAINT [PK_consecutivo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Constantes]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Constantes](
	[idConstante] [int] NOT NULL CONSTRAINT [DF_Constantes_idConstante]  DEFAULT ((1)),
	[elegirAlmacen] [bit] NULL,
	[inventariosNegativos] [bit] NULL,
	[costoEmbalaje] [float] NULL,
 CONSTRAINT [PK_Constantes] PRIMARY KEY CLUSTERED 
(
	[idConstante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[corte]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[corte](
	[IDcorte] [int] IDENTITY(1,1) NOT NULL,
	[peso] [float] NULL,
	[IDlote] [varchar](10) NULL,
	[idarticulo] [int] NULL,
	[Etiqueta] [varchar](30) NULL,
	[fecha] [datetime] NULL,
	[eliminado] [char](1) NULL,
	[vendido] [char](1) NULL,
	[agregado] [float] NULL,
	[Inventariado] [bit] NULL,
	[Consecutivo] [smallint] NULL,
	[Caducidad] [datetime] NULL,
	[clasificacion] [int] NULL,
	[grado] [smallint] NULL,
 CONSTRAINT [PK_corte] PRIMARY KEY CLUSTERED 
(
	[IDcorte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[costeoArticulosLote]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[costeoArticulosLote](
	[idCosteoLoteArticulo] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [varchar](10) NOT NULL,
	[idArticulo] [int] NOT NULL,
	[costo] [float] NULL,
	[fechaRegistro] [datetime] NOT NULL CONSTRAINT [DF_costeoArticulosLote_fechaRegistro]  DEFAULT (getdate()),
	[precioVenta] [float] NULL,
	[pesoArticulo] [float] NULL,
	[costoTotal] [float] NULL,
	[precioTotal] [float] NULL,
 CONSTRAINT [PK_costeoArticulosLote] PRIMARY KEY CLUSTERED 
(
	[idCosteoLoteArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Etiquetas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Etiquetas](
	[idEtiqueta] [int] IDENTITY(1,1) NOT NULL,
	[idArticulo] [int] NULL,
	[etiqueta] [varchar](75) NOT NULL,
	[cantidad] [float] NULL,
	[idUnidadMedida] [int] NULL,
	[idRecepcion] [int] NULL,
	[eliminado] [bit] NULL,
	[vendido] [bit] NULL,
	[inventariado] [bit] NULL,
	[caducidad] [datetime] NULL,
	[fechaEntrada] [datetime] NULL CONSTRAINT [DF_Etiquetas_fecha]  DEFAULT (getdate()),
	[fechaSalida] [datetime] NULL CONSTRAINT [DF_Etiquetas_fechaSalida]  DEFAULT (getdate()),
	[idCorte] [int] NULL,
 CONSTRAINT [PK_Etiquetas] PRIMARY KEY CLUSTERED 
(
	[idEtiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EtiquetasFaltantes]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EtiquetasFaltantes](
	[idEtiquetaFaltante] [int] IDENTITY(1,1) NOT NULL,
	[etiqueta] [varchar](30) NOT NULL,
	[nota] [varchar](20) NULL,
	[fecha] [datetime] NOT NULL CONSTRAINT [DF_EtiquetasFaltantes_fecha]  DEFAULT (getdate()),
	[idusuario] [int] NULL,
 CONSTRAINT [PK_EtiquetasFaltantes] PRIMARY KEY CLUSTERED 
(
	[idEtiquetaFaltante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EtiquetasLog]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EtiquetasLog](
	[idEtiquetaLog] [int] IDENTITY(1,1) NOT NULL,
	[Etiqueta] [varchar](30) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Modulo] [varchar](15) NOT NULL,
	[EdoGral] [varchar](10) NOT NULL,
	[TipoMov] [int] NULL,
	[Fecha] [datetime] NOT NULL CONSTRAINT [DF_EtiquetasLog_Fecha]  DEFAULT (getdate()),
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_EtiquetasLog] PRIMARY KEY CLUSTERED 
(
	[idEtiquetaLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Existencia]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Existencia](
	[IdExistencia] [int] IDENTITY(1,1) NOT NULL,
	[IdAlmacen] [int] NULL,
	[IdArticulo] [int] NOT NULL,
	[Cantidad] [numeric](18, 2) NULL,
	[Lote] [varchar](11) NULL,
	[Fecha] [datetime] NULL,
	[FechaCad] [datetime] NULL,
 CONSTRAINT [PK__Existencia__59FA5E80] PRIMARY KEY NONCLUSTERED 
(
	[IdExistencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familia]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familia](
	[idFamilia] [int] IDENTITY(1,1) NOT NULL,
	[FamClave] [varchar](3) NULL,
	[FamDescripcion] [varchar](50) NULL,
 CONSTRAINT [PK__Familia__00551192] PRIMARY KEY NONCLUSTERED 
(
	[idFamilia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FolioMov]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FolioMov](
	[IdFolioMov] [int] IDENTITY(1,1) NOT NULL,
	[FolioMov] [int] NOT NULL,
	[IdMovimiento] [int] NOT NULL,
	[TipoMov] [varchar](20) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_FolioMov] PRIMARY KEY CLUSTERED 
(
	[IdFolioMov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FoliosPedidos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[FoliosPedidos](
	[IdFolioPed] [int] IDENTITY(1,1) NOT NULL,
	[FolioPed] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[DescProducto] [varchar](50) NULL,
	[KgPedidos] [float] NULL,
	[PzPedidos] [float] NULL,
	[Unidad] [varchar](20) NULL,
	[CantidadSurtida] [float] NULL,
	[CantidadAceptada] [float] NULL,
	[precio] [float] NULL,
	[CjConfirmadas] [int] NULL,
	[impuesto] [float] NULL,
	[total] [float] NULL,
	[porcentaje] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[FoliosPedidos] ADD [observaciones] [varchar](max) NULL
ALTER TABLE [dbo].[FoliosPedidos] ADD [urgente] [bit] NULL
ALTER TABLE [dbo].[FoliosPedidos] ADD [TipoPago] [varchar](50) NULL
ALTER TABLE [dbo].[FoliosPedidos] ADD [Fecha] [smalldatetime] NULL
 CONSTRAINT [PK_FolioPed] PRIMARY KEY CLUSTERED 
(
	[IdFolioPed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FoliosPedidosAProduccion]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoliosPedidosAProduccion](
	[IdFolioPedidoAProduccion] [int] IDENTITY(1,1) NOT NULL,
	[IdFolioPed] [int] NOT NULL,
	[FolioPed] [int] NOT NULL,
 CONSTRAINT [PK_FoliosPedidosAProduccion] PRIMARY KEY CLUSTERED 
(
	[IdFolioPedidoAProduccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoliosPedidosPorSurtir]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoliosPedidosPorSurtir](
	[IdFolioPedidoSurtir] [int] IDENTITY(1,1) NOT NULL,
	[IdFolioPed] [int] NOT NULL,
	[FolioPed] [int] NOT NULL,
 CONSTRAINT [PK_FoliosPedidosPorSurtir] PRIMARY KEY CLUSTERED 
(
	[IdFolioPedidoSurtir] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InfoBD]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InfoBD](
	[id] [smallint] NOT NULL,
	[Version] [varchar](50) NULL,
	[Mayor] [smallint] NULL,
	[Menor] [smallint] NULL,
	[FechaVersion] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InfoMovil]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InfoMovil](
	[MayorM] [smallint] NULL,
	[RevisionM] [smallint] NULL,
	[FechaVersionM] [datetime] NULL,
	[FechaActualizacionM] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InfoSys]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InfoSys](
	[Version] [varchar](50) NULL,
	[Mayor] [smallint] NULL,
	[Revision] [smallint] NULL,
	[FechaVersion] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventario](
	[idinventario] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[descripcion] [varchar](100) NULL,
	[ajustado] [char](1) NULL,
	[ConsecutivoTarima] [int] NULL,
	[idAlmacen] [int] NULL,
 CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED 
(
	[idinventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioEtiquetas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventarioEtiquetas](
	[idInventarioEtiqueta] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NULL,
	[idCorte] [int] NULL,
	[Etiqueta] [varchar](75) NULL,
	[Empaquetado] [bit] NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_InventarioEtiquetas] PRIMARY KEY CLUSTERED 
(
	[idInventarioEtiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioEtiquetasErrores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventarioEtiquetasErrores](
	[idInventarioEtiquetaErr] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NULL,
	[Etiqueta] [varchar](25) NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_InventarioEtiquetasErr] PRIMARY KEY CLUSTERED 
(
	[idInventarioEtiquetaErr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioEtiquetasErroresL]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventarioEtiquetasErroresL](
	[idInventarioEtiquetaErrL] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NULL,
	[Etiqueta] [varchar](25) NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_InventarioEtiquetasErrL] PRIMARY KEY CLUSTERED 
(
	[idInventarioEtiquetaErrL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioEtiquetasErroresT]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[InventarioEtiquetasErroresT](
	[idInventarioEtiquetaErrT] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NULL,
	[Etiqueta] [varchar](25) NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_InventarioEtiquetasErrT] PRIMARY KEY CLUSTERED 
(
	[idInventarioEtiquetaErrT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioEtiquetasL]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventarioEtiquetasL](
	[idInventarioEtiquetaL] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NULL,
	[idEtiqueta] [int] NULL,
	[Etiqueta] [varchar](75) NULL,
	[Empaquetado] [bit] NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_InventarioEtiquetasL] PRIMARY KEY CLUSTERED 
(
	[idInventarioEtiquetaL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioEtiquetasT]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[InventarioEtiquetasT](
	[idInventarioEtiquetaT] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NULL,
	[idEtiqueta] [int] NULL,
	[Etiqueta] [varchar](75) NULL,
	[Empaquetado] [bit] NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_InventarioEtiquetasT] PRIMARY KEY CLUSTERED 
(
	[idInventarioEtiquetaT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioL]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventarioL](
	[idinventarioL] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[descripcion] [varchar](100) NULL,
	[ajustado] [char](1) NULL,
	[Lote] [varchar](15) NULL,
 CONSTRAINT [PK_InventarioL] PRIMARY KEY CLUSTERED 
(
	[idinventarioL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioProducto]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioProducto](
	[idInventarioProducto] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NULL,
	[peso] [numeric](18, 2) NULL,
	[peso2] [numeric](18, 2) NULL,
	[idInventario] [int] NULL,
 CONSTRAINT [PK_InventarioProducto] PRIMARY KEY CLUSTERED 
(
	[idInventarioProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventarioProductoL]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioProductoL](
	[idInventarioProductoL] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NULL,
	[peso] [numeric](18, 2) NULL,
	[peso2] [numeric](18, 2) NULL,
	[idInventario] [int] NULL,
 CONSTRAINT [PK_InventarioProductoL] PRIMARY KEY CLUSTERED 
(
	[idInventarioProductoL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventarioProductoT]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioProductoT](
	[idInventarioProductoT] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NULL,
	[peso] [numeric](18, 2) NULL,
	[peso2] [numeric](18, 2) NULL,
	[idInventario] [int] NULL,
 CONSTRAINT [PK_InventarioProductoT] PRIMARY KEY CLUSTERED 
(
	[idInventarioProductoT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventariosTemporal]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventariosTemporal](
	[codigoArt] [varchar](10) NULL,
	[idAlmacen] [int] NULL,
	[cantidad] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioT]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventarioT](
	[idinventarioT] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[descripcion] [varchar](100) NULL,
	[ajustado] [char](1) NULL,
	[ConsecutivoTarima] [int] NULL,
	[idAlmacen] [int] NULL,
 CONSTRAINT [PK_InventarioT] PRIMARY KEY CLUSTERED 
(
	[idinventarioT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioTarimas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioTarimas](
	[idInventarioTarima] [int] IDENTITY(1,1) NOT NULL,
	[idInventario] [int] NOT NULL,
	[idTarima] [int] NOT NULL,
	[NumTarima] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Ajustado] [bit] NOT NULL,
 CONSTRAINT [PK_InventarioTarimas] PRIMARY KEY CLUSTERED 
(
	[idInventarioTarima] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LiquidacionArt]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LiquidacionArt](
	[IdLiquidacionArt] [int] IDENTITY(1,1) NOT NULL,
	[IdFolioMov] [int] NULL,
	[IdArticulo] [int] NULL,
	[Cargado] [float] NULL,
	[Vendido] [float] NULL,
	[Devuelto] [float] NULL,
	[ExistenciaSis] [float] NULL,
	[ExistenciaReal] [float] NULL,
	[Diferencia] [float] NULL,
	[idVendedor] [int] NULL,
	[FolioLiq] [int] NULL,
 CONSTRAINT [PK_LiquidacionArt] PRIMARY KEY CLUSTERED 
(
	[IdLiquidacionArt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LiquidacionEfec]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LiquidacionEfec](
	[IdLiquidacionEfec] [int] IDENTITY(1,1) NOT NULL,
	[FolioMov] [int] NULL,
	[CreditoSis] [float] NULL,
	[CreditoReal] [float] NULL,
	[CreditoDif] [float] NULL,
	[EfectivoSis] [float] NULL,
	[EfectivoReal] [float] NULL,
	[EfectivoDif] [float] NULL,
	[ChequesSis] [float] NULL,
	[ChequesReal] [float] NULL,
	[ChequesDif] [float] NULL,
	[TarjetaSis] [float] NULL,
	[TarjetaReal] [float] NULL,
	[TarjetaDif] [float] NULL,
	[ValesSis] [float] NULL,
	[ValesReal] [float] NULL,
	[ValesDif] [float] NULL,
	[SPEISis] [float] NULL,
	[SPEIReal] [float] NULL,
	[SPEIDif] [float] NULL,
	[OtroSis] [float] NULL,
	[OtroReal] [float] NULL,
	[OtroDif] [float] NULL,
	[TotalSis] [float] NULL,
	[TotalReal] [float] NULL,
	[TotalDif] [float] NULL,
	[Bonificacion] [float] NULL,
	[IdVendedor] [int] NULL,
	[Vendedor] [varchar](50) NULL,
	[Fecha] [datetime] NULL,
	[UsrCreador] [int] NULL,
 CONSTRAINT [PK_LiquidacionEfec] PRIMARY KEY CLUSTERED 
(
	[IdLiquidacionEfec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lotecanal]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lotecanal](
	[IDlote] [varchar](10) NOT NULL,
	[IDfolio] [int] NULL,
	[pesoinicial] [numeric](18, 2) NULL CONSTRAINT [DF_lotecanal_pesoinicial]  DEFAULT ((0)),
	[pesofinal] [numeric](18, 2) NULL CONSTRAINT [DF_lotecanal_pesofinal]  DEFAULT ((0)),
	[costoinicial] [float] NULL,
	[costofinal] [float] NULL,
	[costosIndirectos] [float] NULL,
	[manoObra] [float] NULL,
	[numfactura] [int] NULL,
	[consecutivo] [int] NULL,
	[fecha] [datetime] NULL,
	[estado] [varchar](50) NULL,
	[cierrefecha] [datetime] NULL,
	[descripcion] [varchar](100) NULL,
	[idUsrInicio] [int] NULL,
	[idUsrCierre] [int] NULL,
	[Sobrante] [float] NULL CONSTRAINT [DF_lotecanal_Sobrante]  DEFAULT ((0)),
	[idProveedor] [int] NULL,
	[costo] [float] NULL,
	[costoEmbalaje] [float] NULL,
 CONSTRAINT [PK_lotecanal] PRIMARY KEY CLUSTERED 
(
	[IDlote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LotesEtiquetaErrores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LotesEtiquetaErrores](
	[idLoteEtiqErr] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [varchar](10) NULL,
	[Etiqueta] [varchar](30) NULL,
	[Estatus] [varchar](40) NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_LotesProdErrores] PRIMARY KEY CLUSTERED 
(
	[idLoteEtiqErr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movimientos](
	[IdMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoMov] [int] NULL,
	[IdArticulo] [int] NULL,
	[IdAlmaOrig] [int] NULL,
	[IdAlmaDest] [int] NULL,
	[Cantidad] [float] NULL,
	[Costo] [float] NULL,
	[CostoPromedio] [float] NULL,
	[Existencia] [float] NULL,
	[Fecha] [datetime] NULL,
	[idcliente] [int] NULL,
	[precio] [float] NULL,
	[idvendedor] [int] NULL,
	[idusuariocreador] [int] NULL,
	[cliente] [varchar](100) NULL,
	[idventa] [int] NULL,
	[referencia] [int] NULL,
	[invNeg] [bit] NULL CONSTRAINT [DF_Movimientos_invNeg]  DEFAULT ((0)),
 CONSTRAINT [PK_Movimientos] PRIMARY KEY CLUSTERED 
(
	[IdMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Origen]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Origen](
	[idorigen] [int] IDENTITY(1,1) NOT NULL,
	[idlote] [varchar](10) NULL,
	[peso] [numeric](18, 2) NULL,
	[idarticulo] [int] NULL,
	[idalmacen] [int] NULL,
	[pedaceria] [char](1) NULL,
	[etiqueta] [varchar](40) NULL,
	[artclave] [float] NULL,
 CONSTRAINT [PK_Origen] PRIMARY KEY CLUSTERED 
(
	[idorigen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PesoSinHumedad]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PesoSinHumedad](
	[idPesoHumedad] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [varchar](10) NULL,
	[idArticulo] [int] NULL,
	[Cantidad] [float] NULL,
	[Fecha] [datetime] NULL,
	[idUsuario] [int] NULL,
 CONSTRAINT [PK_PesoSinHumedad] PRIMARY KEY CLUSTERED 
(
	[idPesoHumedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrecioCliente]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioCliente](
	[idPrecioCliente] [int] IDENTITY(1,1) NOT NULL,
	[idArticulo] [int] NULL,
	[idCliente] [int] NULL,
	[Cantidad] [int] NULL,
	[PrecioCompra] [float] NULL,
	[PrecioVenta] [float] NULL,
	[FechaCreacion] [datetime] NULL,
	[usrCreador] [smallint] NULL,
	[FechaUltimaMod] [datetime] NULL,
	[usrUltimaMod] [smallint] NULL,
 CONSTRAINT [PK_PrecioCliente] PRIMARY KEY CLUSTERED 
(
	[idPrecioCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Precios]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Precios](
	[IdPrecio] [int] IDENTITY(51,1) NOT NULL,
	[IdArticulo] [int] NULL,
	[IdTipoPrecio] [int] NULL,
	[Precio] [float] NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_Precios] PRIMARY KEY CLUSTERED 
(
	[IdPrecio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PrecioTipoCliente]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioTipoCliente](
	[idPrecioTipoC] [int] IDENTITY(1,1) NOT NULL,
	[idArticulo] [int] NULL,
	[idTipoCliente] [int] NOT NULL,
	[Cantidad] [int] NULL,
	[PrecioCompra] [float] NULL,
	[PrecioVenta] [float] NULL,
	[FechaCreacion] [datetime] NULL,
	[usrCreador] [smallint] NULL,
	[FechaUltimaMod] [datetime] NULL,
	[usrUltimaMod] [smallint] NULL,
 CONSTRAINT [PK_PrecioTipoCliente] PRIMARY KEY CLUSTERED 
(
	[idPrecioTipoC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedores](
	[idProveedor] [int] IDENTITY(1,1) NOT NULL,
	[activo] [bit] NULL,
	[nombre] [varchar](100) NULL,
	[razonSocial] [varchar](100) NULL,
	[direccion] [varchar](100) NULL,
	[numeroExterior] [int] NULL,
	[numeroInterior] [int] NULL,
	[colonia] [varchar](50) NULL,
	[codigoPostal] [int] NULL,
	[ciudad] [varchar](50) NULL,
	[pais] [varchar](50) NULL,
	[telefono1] [varchar](15) NULL,
	[telefono2] [varchar](15) NULL,
	[email] [varchar](50) NULL,
	[metodoPago] [varchar](25) NULL,
	[RFC] [varchar](13) NULL,
	[claveSagarpa] [varchar](24) NULL,
	[fechaCreacion] [datetime] NULL CONSTRAINT [DF_Proveedores_fechaCreacion]  DEFAULT (getdate()),
	[fechaModificacion] [datetime] NULL CONSTRAINT [DF_Proveedores_fechaModificacion]  DEFAULT (getdate()),
	[creditoActivo] [bit] NULL,
	[montoCredito] [int] NULL,
	[contacto] [varchar](50) NULL,
	[moneda] [varchar](3) NULL,
	[otro] [varchar](200) NULL,
 CONSTRAINT [PK__Proveedores__7C8480AE] PRIMARY KEY NONCLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RecepcionEtiquetas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[RecepcionEtiquetas](
	[idRecepcion] [int] IDENTITY(1,1) NOT NULL,
	[idProveedor] [int] NOT NULL,
	[comentario] [varchar](100) NULL,
	[fecha] [datetime] NOT NULL CONSTRAINT [DF_RecepcionEtiquetas_fecha]  DEFAULT (getdate()),
	[idUsrCreador] [int] NULL,
 CONSTRAINT [PK_RecepcionEtiquetas] PRIMARY KEY CLUSTERED 
(
	[idRecepcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RelacionFolios]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RelacionFolios](
	[idRelacionFolios] [int] IDENTITY(1,1) NOT NULL,
	[FolioMov] [int] NOT NULL,
	[idAlmacen] [int] NOT NULL,
	[Estatus] [char](1) NOT NULL,
	[fechainicio] [datetime] NOT NULL,
	[fechacierre] [datetime] NULL,
	[LiqValores] [char](1) NULL,
	[KMInicio] [int] NULL,
	[KMFin] [int] NULL,
	[ValorCarga] [float] NULL,
 CONSTRAINT [PK_RelacionFolios] PRIMARY KEY CLUSTERED 
(
	[idRelacionFolios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RelacionFPedidos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RelacionFPedidos](
	[FolioPed] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[FechaCaptura] [datetime] NOT NULL,
	[FechaSalida] [datetime] NULL,
	[FechaEntrega] [datetime] NULL,
	[FechaEntregado] [datetime] NULL,
	[Estatus] [char](1) NOT NULL,
	[Origen] [varchar](10) NOT NULL,
	[Kilometros] [float] NULL,
	[FechaLlegada] [datetime] NULL,
	[FechaTermino] [datetime] NULL,
	[idSucursal] [int] NULL,
	[Sucursal] [varchar](50) NULL,
	[Contacto] [varchar](150) NULL,
	[Credito] [int] NULL,
	[idAlmacen] [int] NULL,
	[tipoCliente] [int] NULL,
	[MercanciaABordo] [bit] NULL,
	[notas] [varchar](250) NULL,
 CONSTRAINT [PK_RelacionFPedidos] PRIMARY KEY CLUSTERED 
(
	[FolioPed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[relacionfVentas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[relacionfVentas](
	[folioVenta] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[fechaVenta] [datetime] NULL,
	[factura] [varchar](5) NULL,
	[idvendedor] [int] NULL,
	[folioliq] [int] NULL,
	[idAlmacen] [int] NULL,
	[saldoUsado] [float] NULL,
	[facturado] [char](1) NULL,
 CONSTRAINT [PK_relacionfVentas] PRIMARY KEY CLUSTERED 
(
	[folioVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[roles]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[schema_migrations]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schema_migrations](
	[version] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sobrantes]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sobrantes](
	[idSobrante] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [varchar](10) NOT NULL,
	[idArticulo] [int] NOT NULL,
	[peso] [float] NOT NULL,
 CONSTRAINT [PK_Sobrantes] PRIMARY KEY CLUSTERED 
(
	[idSobrante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubFamilia]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubFamilia](
	[IdSubFamilia] [int] IDENTITY(1,1) NOT NULL,
	[SubFamClave] [varchar](3) NULL,
	[SubFamDescripcion] [varchar](50) NULL,
 CONSTRAINT [PK__SubFamilia__023D5A04] PRIMARY KEY NONCLUSTERED 
(
	[IdSubFamilia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursales](
	[idSucursal] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NOT NULL,
	[RazonSocial] [varchar](50) NULL,
	[RFC] [varchar](13) NULL,
	[Direccion1] [varchar](50) NULL,
	[Direccion2] [varchar](50) NULL,
	[Direccion3] [varchar](50) NULL,
	[PagWeb] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[FAX] [varchar](20) NULL,
	[Slogan] [varchar](50) NULL,
	[Otro] [varchar](50) NULL,
	[Logo1] [image] NULL,
	[Logo2] [image] NULL,
 CONSTRAINT [PK_Sucursales] PRIMARY KEY CLUSTERED 
(
	[idSucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tarimas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tarimas](
	[idTarima] [int] IDENTITY(1,1) NOT NULL,
	[CodigoTarima] [varchar](30) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Activa] [bit] NOT NULL,
 CONSTRAINT [PK_Tarimas] PRIMARY KEY CLUSTERED 
(
	[idTarima] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TarimasDetalle]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TarimasDetalle](
	[idTarimaDetalle] [int] IDENTITY(1,1) NOT NULL,
	[idTarima] [int] NOT NULL,
	[idCorte] [int] NOT NULL,
	[Etiqueta] [varchar](30) NOT NULL,
	[Numero] [int] NULL,
 CONSTRAINT [PK_TarimasDetalle] PRIMARY KEY CLUSTERED 
(
	[idTarimaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TarimasDetalleT]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TarimasDetalleT](
	[idTarimaDetalleT] [int] IDENTITY(1,1) NOT NULL,
	[idTarima] [int] NOT NULL,
	[idEtiqueta] [int] NOT NULL,
	[Etiqueta] [varchar](30) NOT NULL,
	[Numero] [int] NULL,
 CONSTRAINT [PK_TarimasDetalleT] PRIMARY KEY CLUSTERED 
(
	[idTarimaDetalleT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TarimasT]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TarimasT](
	[idTarimaT] [int] IDENTITY(1,1) NOT NULL,
	[CodigoTarima] [varchar](30) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Activa] [bit] NOT NULL,
 CONSTRAINT [PK_TarimasT] PRIMARY KEY CLUSTERED 
(
	[idTarimaT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoCliente]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoCliente](
	[IdTipoCliente] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [varchar](50) NULL,
 CONSTRAINT [PK_TipoCliente] PRIMARY KEY CLUSTERED 
(
	[IdTipoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoMov]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoMov](
	[IdTipoMov] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Tipo] [varchar](1) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[IdTipoMov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoPrecios]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoPrecios](
	[IdTipoPrecio] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoCliente] [int] NULL,
	[NombreCliente] [varchar](20) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[NOListaPrecios] [bit] NULL,
 CONSTRAINT [PK_TipoPrecios] PRIMARY KEY CLUSTERED 
(
	[IdTipoPrecio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Umedida]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Umedida](
	[UMedidaId] [int] NOT NULL,
	[Unidad] [varchar](20) NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Umedida] ADD [Tipo] [varchar](50) NULL
PRIMARY KEY NONCLUSTERED 
(
	[UMedidaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[users]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](255) NULL,
	[last_name] [nvarchar](255) NULL,
	[address1] [nvarchar](255) NULL,
	[address2] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[role_id] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[encrypted_password] [nvarchar](255) NOT NULL DEFAULT (N''),
	[reset_password_token] [nvarchar](255) NULL,
	[reset_password_sent_at] [datetime] NULL,
	[remember_created_at] [datetime] NULL,
	[sign_in_count] [int] NULL DEFAULT ((0)),
	[current_sign_in_at] [datetime] NULL,
	[last_sign_in_at] [datetime] NULL,
	[current_sign_in_ip] [nvarchar](255) NULL,
	[last_sign_in_ip] [nvarchar](255) NULL,
	[confirmation_token] [nvarchar](255) NULL,
	[confirmed_at] [datetime] NULL,
	[confirmation_sent_at] [datetime] NULL,
	[unconfirmed_email] [nvarchar](255) NULL,
	[failed_attempts] [int] NULL DEFAULT ((0)),
	[unlock_token] [nvarchar](255) NULL,
	[locked_at] [datetime] NULL,
	[authentication_token] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[usuario]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[loginID] [int] IDENTITY(11,1) NOT NULL,
	[username] [varchar](20) NOT NULL,
	[contrasena] [varchar](20) NOT NULL,
	[nivel] [int] NOT NULL,
	[estatus] [char](1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Paterno] [varchar](50) NULL,
	[Domicilio] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[FechaAlta] [datetime] NULL,
	[idSucursal] [int] NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[loginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vendedores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vendedores](
	[idvendedor] [int] IDENTITY(10,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Paterno] [varchar](50) NULL,
	[Materno] [varchar](50) NULL,
	[Telefono] [varchar](17) NULL,
	[FechaAlta] [datetime] NOT NULL,
	[Clave] [int] NULL,
	[IdAlmacen] [int] NULL,
	[IdAlmacenDev] [int] NULL,
	[Activo] [char](1) NULL,
 CONSTRAINT [PK_Vendedores] PRIMARY KEY CLUSTERED 
(
	[idvendedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VentaEtiquetaErrores]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[VentaEtiquetaErrores](
	[idVentaEtiqErr] [int] IDENTITY(1,1) NOT NULL,
	[idventa] [int] NULL,
	[Etiqueta] [varchar](50) NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[VentaEtiquetaErrores] ADD [Estatus] [varchar](50) NULL
ALTER TABLE [dbo].[VentaEtiquetaErrores] ADD [Fecha] [datetime] NULL
 CONSTRAINT [PK_VentaProdErrores] PRIMARY KEY CLUSTERED 
(
	[idVentaEtiqErr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ventakilos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ventakilos](
	[IDventa] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[Cliente] [varchar](100) NULL,
	[fecha] [datetime] NULL,
	[monto] [float] NULL,
	[estado] [char](1) NULL,
	[FechaCaducidad] [datetime] NULL,
	[FechaEmpaque] [datetime] NULL,
	[Comentario] [varchar](50) NULL,
	[idUsrCreador] [int] NULL,
 CONSTRAINT [PK_ventaskilos] PRIMARY KEY CLUSTERED 
(
	[IDventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ventaproducto]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ventaproducto](
	[idventaproducto] [int] IDENTITY(1,1) NOT NULL,
	[idventa] [int] NOT NULL,
	[peso] [numeric](18, 2) NULL,
	[idarticulo] [int] NULL,
	[xCantidad] [float] NULL,
	[etiqueta] [varchar](75) NULL,
	[NoCaja] [smallint] NULL,
	[TipoEtiqueta] [char](2) NULL,
	[precioVenta] [float] NULL,
 CONSTRAINT [PK_ventaproducto] PRIMARY KEY CLUSTERED 
(
	[idventaproducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idClienteMAB]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idClienteMAB] ON [dbo].[ClientesMercanciaABordo]
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CodificacionesCodigos]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CodificacionesCodigos] ON [dbo].[CodificacionesCodigos]
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Etiquetas]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Etiquetas] ON [dbo].[Etiquetas]
(
	[etiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_schema_migrations]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_schema_migrations] ON [dbo].[schema_migrations]
(
	[version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_users_on_authentication_token]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE NONCLUSTERED INDEX [index_users_on_authentication_token] ON [dbo].[users]
(
	[authentication_token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_users_on_confirmation_token]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE NONCLUSTERED INDEX [index_users_on_confirmation_token] ON [dbo].[users]
(
	[confirmation_token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_users_on_email]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [index_users_on_email] ON [dbo].[users]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_users_on_reset_password_token]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE NONCLUSTERED INDEX [index_users_on_reset_password_token] ON [dbo].[users]
(
	[reset_password_token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_users_on_unlock_token]    Script Date: 26/06/2018 07:17:38 p.m. ******/
CREATE NONCLUSTERED INDEX [index_users_on_unlock_token] ON [dbo].[users]
(
	[unlock_token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientesMercanciaABordo] ADD  CONSTRAINT [DF_ClientesMercanciaABordo_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ClientesMercanciaABordo] ADD  CONSTRAINT [DF_ClientesMercanciaABordo_fechaCreacion]  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[RelacionFPedidos] ADD  CONSTRAINT [DF_RelacionFPedidos_FechaCaptura]  DEFAULT (getdate()) FOR [FechaCaptura]
GO
ALTER TABLE [dbo].[Articulos]  WITH CHECK ADD  CONSTRAINT [FK_Articulos_Familia] FOREIGN KEY([idFamilia])
REFERENCES [dbo].[Familia] ([idFamilia])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Familia]
GO
ALTER TABLE [dbo].[Articulos]  WITH CHECK ADD  CONSTRAINT [FK_Articulos_Umedida] FOREIGN KEY([idUnidad])
REFERENCES [dbo].[Umedida] ([UMedidaId])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Umedida]
GO
ALTER TABLE [dbo].[BatchEtiquetadoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_BatchEtiquetadoDetalle_BatchEtiquetado] FOREIGN KEY([idBatchEtiquetado])
REFERENCES [dbo].[BatchEtiquetado] ([idBatchEtiquetado])
GO
ALTER TABLE [dbo].[BatchEtiquetadoDetalle] CHECK CONSTRAINT [FK_BatchEtiquetadoDetalle_BatchEtiquetado]
GO
ALTER TABLE [dbo].[BatchEtiquetadoDetalleErrores]  WITH CHECK ADD  CONSTRAINT [FK_BatchEtiquetadoDetalleErr_BatchEtiquetado] FOREIGN KEY([idBatchEtiquetado])
REFERENCES [dbo].[BatchEtiquetado] ([idBatchEtiquetado])
GO
ALTER TABLE [dbo].[BatchEtiquetadoDetalleErrores] CHECK CONSTRAINT [FK_BatchEtiquetadoDetalleErr_BatchEtiquetado]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Clientes_Vendedores] FOREIGN KEY([IdVendedor])
REFERENCES [dbo].[Vendedores] ([idvendedor])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Vendedores]
GO
ALTER TABLE [dbo].[CodificacionesCodigos]  WITH CHECK ADD  CONSTRAINT [FK_DefinicionCodigosProveedor_Proveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[CodificacionesCodigos] CHECK CONSTRAINT [FK_DefinicionCodigosProveedor_Proveedores]
GO
ALTER TABLE [dbo].[CodigosProveedores]  WITH CHECK ADD  CONSTRAINT [FK_CodigosProveedores_Articulos] FOREIGN KEY([idArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[CodigosProveedores] CHECK CONSTRAINT [FK_CodigosProveedores_Articulos]
GO
ALTER TABLE [dbo].[CodigosProveedores]  WITH CHECK ADD  CONSTRAINT [FK_CodigosProveedores_Proveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[CodigosProveedores] CHECK CONSTRAINT [FK_CodigosProveedores_Proveedores]
GO
ALTER TABLE [dbo].[corte]  WITH CHECK ADD  CONSTRAINT [FK_corte_lotecanal] FOREIGN KEY([IDlote])
REFERENCES [dbo].[lotecanal] ([IDlote])
GO
ALTER TABLE [dbo].[corte] CHECK CONSTRAINT [FK_corte_lotecanal]
GO
ALTER TABLE [dbo].[costeoArticulosLote]  WITH CHECK ADD  CONSTRAINT [FK_costeoArticulosLote_lotecanal] FOREIGN KEY([idLote])
REFERENCES [dbo].[lotecanal] ([IDlote])
GO
ALTER TABLE [dbo].[costeoArticulosLote] CHECK CONSTRAINT [FK_costeoArticulosLote_lotecanal]
GO
ALTER TABLE [dbo].[Etiquetas]  WITH CHECK ADD  CONSTRAINT [FK_Etiquetas_RecepcionEtiquetas] FOREIGN KEY([idRecepcion])
REFERENCES [dbo].[RecepcionEtiquetas] ([idRecepcion])
GO
ALTER TABLE [dbo].[Etiquetas] CHECK CONSTRAINT [FK_Etiquetas_RecepcionEtiquetas]
GO
ALTER TABLE [dbo].[Etiquetas]  WITH CHECK ADD  CONSTRAINT [FK_Etiquetas_Umedida] FOREIGN KEY([idUnidadMedida])
REFERENCES [dbo].[Umedida] ([UMedidaId])
GO
ALTER TABLE [dbo].[Etiquetas] CHECK CONSTRAINT [FK_Etiquetas_Umedida]
GO
ALTER TABLE [dbo].[Existencia]  WITH CHECK ADD  CONSTRAINT [FK_Existencia_Almacenes] FOREIGN KEY([IdAlmacen])
REFERENCES [dbo].[Almacenes] ([IdAlmacen])
GO
ALTER TABLE [dbo].[Existencia] CHECK CONSTRAINT [FK_Existencia_Almacenes]
GO
ALTER TABLE [dbo].[Existencia]  WITH CHECK ADD  CONSTRAINT [FK_Existencia_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[Existencia] CHECK CONSTRAINT [FK_Existencia_Articulos]
GO
ALTER TABLE [dbo].[FoliosPedidos]  WITH CHECK ADD  CONSTRAINT [FK_FoliosPedidos_RelacionFPedidos] FOREIGN KEY([FolioPed])
REFERENCES [dbo].[RelacionFPedidos] ([FolioPed])
GO
ALTER TABLE [dbo].[FoliosPedidos] CHECK CONSTRAINT [FK_FoliosPedidos_RelacionFPedidos]
GO
ALTER TABLE [dbo].[FoliosPedidosAProduccion]  WITH CHECK ADD  CONSTRAINT [FK_FoliosPedidosAProduccion_FoliosPedidos1] FOREIGN KEY([IdFolioPed])
REFERENCES [dbo].[FoliosPedidos] ([IdFolioPed])
GO
ALTER TABLE [dbo].[FoliosPedidosAProduccion] CHECK CONSTRAINT [FK_FoliosPedidosAProduccion_FoliosPedidos1]
GO
ALTER TABLE [dbo].[FoliosPedidosPorSurtir]  WITH CHECK ADD  CONSTRAINT [FK_FoliosPedidosPorSurtir_FoliosPedidos1] FOREIGN KEY([IdFolioPed])
REFERENCES [dbo].[FoliosPedidos] ([IdFolioPed])
GO
ALTER TABLE [dbo].[FoliosPedidosPorSurtir] CHECK CONSTRAINT [FK_FoliosPedidosPorSurtir_FoliosPedidos1]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[Almacenes] ([IdAlmacen])
GO
ALTER TABLE [dbo].[InventarioEtiquetas]  WITH CHECK ADD  CONSTRAINT [FK_InventarioEtiquetas_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventario] ([idinventario])
GO
ALTER TABLE [dbo].[InventarioEtiquetas] CHECK CONSTRAINT [FK_InventarioEtiquetas_Inventario]
GO
ALTER TABLE [dbo].[InventarioEtiquetasErrores]  WITH CHECK ADD  CONSTRAINT [FK_InventarioEtiquetasErr_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventario] ([idinventario])
GO
ALTER TABLE [dbo].[InventarioEtiquetasErrores] CHECK CONSTRAINT [FK_InventarioEtiquetasErr_Inventario]
GO
ALTER TABLE [dbo].[InventarioEtiquetasErroresL]  WITH CHECK ADD  CONSTRAINT [FK_InventarioEtiquetasErrL_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[InventarioL] ([idinventarioL])
GO
ALTER TABLE [dbo].[InventarioEtiquetasErroresL] CHECK CONSTRAINT [FK_InventarioEtiquetasErrL_Inventario]
GO
ALTER TABLE [dbo].[InventarioEtiquetasErroresT]  WITH CHECK ADD  CONSTRAINT [FK_InventarioEtiquetasErrT_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[InventarioT] ([idinventarioT])
GO
ALTER TABLE [dbo].[InventarioEtiquetasErroresT] CHECK CONSTRAINT [FK_InventarioEtiquetasErrT_Inventario]
GO
ALTER TABLE [dbo].[InventarioEtiquetasL]  WITH CHECK ADD  CONSTRAINT [FK_InventarioEtiquetasL_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[InventarioL] ([idinventarioL])
GO
ALTER TABLE [dbo].[InventarioEtiquetasL] CHECK CONSTRAINT [FK_InventarioEtiquetasL_Inventario]
GO
ALTER TABLE [dbo].[InventarioEtiquetasT]  WITH CHECK ADD  CONSTRAINT [FK_InventarioEtiquetasT_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[InventarioT] ([idinventarioT])
GO
ALTER TABLE [dbo].[InventarioEtiquetasT] CHECK CONSTRAINT [FK_InventarioEtiquetasT_Inventario]
GO
ALTER TABLE [dbo].[InventarioProducto]  WITH CHECK ADD  CONSTRAINT [FK_InventarioProducto_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventario] ([idinventario])
GO
ALTER TABLE [dbo].[InventarioProducto] CHECK CONSTRAINT [FK_InventarioProducto_Inventario]
GO
ALTER TABLE [dbo].[InventarioProductoL]  WITH CHECK ADD  CONSTRAINT [FK_InventarioProductoL_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[InventarioL] ([idinventarioL])
GO
ALTER TABLE [dbo].[InventarioProductoL] CHECK CONSTRAINT [FK_InventarioProductoL_Inventario]
GO
ALTER TABLE [dbo].[InventarioProductoT]  WITH CHECK ADD  CONSTRAINT [FK_InventarioProductoT_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[InventarioT] ([idinventarioT])
GO
ALTER TABLE [dbo].[InventarioProductoT] CHECK CONSTRAINT [FK_InventarioProductoT_Inventario]
GO
ALTER TABLE [dbo].[InventarioT]  WITH CHECK ADD FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[Almacenes] ([IdAlmacen])
GO
ALTER TABLE [dbo].[InventarioTarimas]  WITH CHECK ADD  CONSTRAINT [FK_InventarioTarimas_Inventario] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventario] ([idinventario])
GO
ALTER TABLE [dbo].[InventarioTarimas] CHECK CONSTRAINT [FK_InventarioTarimas_Inventario]
GO
ALTER TABLE [dbo].[InventarioTarimas]  WITH CHECK ADD  CONSTRAINT [FK_InventarioTarimas_Inventario1] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventario] ([idinventario])
GO
ALTER TABLE [dbo].[InventarioTarimas] CHECK CONSTRAINT [FK_InventarioTarimas_Inventario1]
GO
ALTER TABLE [dbo].[InventarioTarimas]  WITH CHECK ADD  CONSTRAINT [FK_InventarioTarimas_Tarimas] FOREIGN KEY([idTarima])
REFERENCES [dbo].[Tarimas] ([idTarima])
GO
ALTER TABLE [dbo].[InventarioTarimas] CHECK CONSTRAINT [FK_InventarioTarimas_Tarimas]
GO
ALTER TABLE [dbo].[LiquidacionArt]  WITH CHECK ADD  CONSTRAINT [FK_LiquidacionArt_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[LiquidacionArt] CHECK CONSTRAINT [FK_LiquidacionArt_Articulos]
GO
ALTER TABLE [dbo].[LiquidacionArt]  WITH CHECK ADD  CONSTRAINT [FK_LiquidacionArt_FolioMov] FOREIGN KEY([IdFolioMov])
REFERENCES [dbo].[FolioMov] ([IdFolioMov])
GO
ALTER TABLE [dbo].[LiquidacionArt] CHECK CONSTRAINT [FK_LiquidacionArt_FolioMov]
GO
ALTER TABLE [dbo].[LotesEtiquetaErrores]  WITH CHECK ADD  CONSTRAINT [FK_LotesEtiquetaErrores_lotecanal] FOREIGN KEY([idLote])
REFERENCES [dbo].[lotecanal] ([IDlote])
GO
ALTER TABLE [dbo].[LotesEtiquetaErrores] CHECK CONSTRAINT [FK_LotesEtiquetaErrores_lotecanal]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK__Movimient__idcli__531856C7] FOREIGN KEY([idcliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK__Movimient__idcli__531856C7]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK__Movimient__idven__55009F39] FOREIGN KEY([idvendedor])
REFERENCES [dbo].[Vendedores] ([idvendedor])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK__Movimient__idven__55009F39]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_Almacenes] FOREIGN KEY([IdAlmaDest])
REFERENCES [dbo].[Almacenes] ([IdAlmacen])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_Almacenes]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Movimientos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_Articulos]
GO
ALTER TABLE [dbo].[Movimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Movimientos_TipoMov] FOREIGN KEY([IdTipoMov])
REFERENCES [dbo].[TipoMov] ([IdTipoMov])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_TipoMov]
GO
ALTER TABLE [dbo].[Origen]  WITH CHECK ADD  CONSTRAINT [FK_Origen_lotecanal] FOREIGN KEY([idlote])
REFERENCES [dbo].[lotecanal] ([IDlote])
GO
ALTER TABLE [dbo].[Origen] CHECK CONSTRAINT [FK_Origen_lotecanal]
GO
ALTER TABLE [dbo].[PesoSinHumedad]  WITH CHECK ADD  CONSTRAINT [FK_PesoSinHumedad_lotecanal] FOREIGN KEY([idLote])
REFERENCES [dbo].[lotecanal] ([IDlote])
GO
ALTER TABLE [dbo].[PesoSinHumedad] CHECK CONSTRAINT [FK_PesoSinHumedad_lotecanal]
GO
ALTER TABLE [dbo].[PrecioCliente]  WITH CHECK ADD  CONSTRAINT [FK_PrecioCliente_Articulos] FOREIGN KEY([idArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[PrecioCliente] CHECK CONSTRAINT [FK_PrecioCliente_Articulos]
GO
ALTER TABLE [dbo].[PrecioCliente]  WITH CHECK ADD  CONSTRAINT [FK_PrecioCliente_Clientes] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[PrecioCliente] CHECK CONSTRAINT [FK_PrecioCliente_Clientes]
GO
ALTER TABLE [dbo].[Precios]  WITH CHECK ADD  CONSTRAINT [FK_Precios_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[Precios] CHECK CONSTRAINT [FK_Precios_Articulos]
GO
ALTER TABLE [dbo].[Precios]  WITH CHECK ADD  CONSTRAINT [FK_Precios_TipoPrecios] FOREIGN KEY([IdTipoPrecio])
REFERENCES [dbo].[TipoPrecios] ([IdTipoPrecio])
GO
ALTER TABLE [dbo].[Precios] CHECK CONSTRAINT [FK_Precios_TipoPrecios]
GO
ALTER TABLE [dbo].[PrecioTipoCliente]  WITH CHECK ADD  CONSTRAINT [FK_PrecioTipoCliente_Articulos] FOREIGN KEY([idArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
GO
ALTER TABLE [dbo].[PrecioTipoCliente] CHECK CONSTRAINT [FK_PrecioTipoCliente_Articulos]
GO
ALTER TABLE [dbo].[PrecioTipoCliente]  WITH CHECK ADD  CONSTRAINT [FK_PrecioTipoCliente_TipoCliente] FOREIGN KEY([idTipoCliente])
REFERENCES [dbo].[TipoCliente] ([IdTipoCliente])
GO
ALTER TABLE [dbo].[PrecioTipoCliente] CHECK CONSTRAINT [FK_PrecioTipoCliente_TipoCliente]
GO
ALTER TABLE [dbo].[RecepcionEtiquetas]  WITH CHECK ADD  CONSTRAINT [FK_RecepcionEtiquetas_Proveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[RecepcionEtiquetas] CHECK CONSTRAINT [FK_RecepcionEtiquetas_Proveedores]
GO
ALTER TABLE [dbo].[TarimasDetalle]  WITH CHECK ADD  CONSTRAINT [FK_TarimasDetalle_Tarimas] FOREIGN KEY([idTarima])
REFERENCES [dbo].[Tarimas] ([idTarima])
GO
ALTER TABLE [dbo].[TarimasDetalle] CHECK CONSTRAINT [FK_TarimasDetalle_Tarimas]
GO
ALTER TABLE [dbo].[TarimasDetalleT]  WITH CHECK ADD  CONSTRAINT [FK_TarimasDetalleT_Tarimas] FOREIGN KEY([idTarima])
REFERENCES [dbo].[TarimasT] ([idTarimaT])
GO
ALTER TABLE [dbo].[TarimasDetalleT] CHECK CONSTRAINT [FK_TarimasDetalleT_Tarimas]
GO
ALTER TABLE [dbo].[TipoPrecios]  WITH CHECK ADD  CONSTRAINT [FK_TipoPrecios_TipoCliente] FOREIGN KEY([IdTipoCliente])
REFERENCES [dbo].[TipoCliente] ([IdTipoCliente])
GO
ALTER TABLE [dbo].[TipoPrecios] CHECK CONSTRAINT [FK_TipoPrecios_TipoCliente]
GO
ALTER TABLE [dbo].[Vendedores]  WITH CHECK ADD  CONSTRAINT [FK_Vendedores_Almacenes] FOREIGN KEY([IdAlmacen])
REFERENCES [dbo].[Almacenes] ([IdAlmacen])
GO
ALTER TABLE [dbo].[Vendedores] CHECK CONSTRAINT [FK_Vendedores_Almacenes]
GO
ALTER TABLE [dbo].[VentaEtiquetaErrores]  WITH CHECK ADD  CONSTRAINT [FK_VentaEtiquetaErrores_ventakilos] FOREIGN KEY([idventa])
REFERENCES [dbo].[ventakilos] ([IDventa])
GO
ALTER TABLE [dbo].[VentaEtiquetaErrores] CHECK CONSTRAINT [FK_VentaEtiquetaErrores_ventakilos]
GO
ALTER TABLE [dbo].[Constantes]  WITH CHECK ADD CHECK  (([idConstante]=(1)))
GO
/****** Object:  StoredProcedure [dbo].[CalculaArtLiquidacion]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalculaArtLiquidacion] 
	-- Add the parameters for the stored procedure here
	@alma int,
	@folioliq int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--select art.descripcion,art.cont contenido,umed.unidad unidad,fam.famdescripcion,art.artclave clave,sum(mov.cantidad) Cargado,isnull((select sum(cantidad) from movimientos where idtipomov=1 and (fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate())) and idarticulo=art.idarticulo and idalmadest=@alma),'0') Vendido,isnull((select sum(cantidad) from movimientos where (idtipomov=3 or idtipomov=6) and fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate()) and idarticulo=art.idarticulo and idalmadest=@alma),'0') Devuelto,exis.cantidad Existencia,art.idarticulo from Existencia exis inner join Articulos art on (art.idarticulo=exis.idarticulo) inner join umedida umed on (art.idunidad=umed.umedidaid) inner join familia fam on (art.idfamilia=fam.idfamilia) inner join movimientos mov on (mov.idmovimiento in(select idmovimiento from movimientos where idmovimiento in(Select idmovimiento from foliomov where tipomov='Carga' and foliomov=(select foliomov from relacionfolios where fechainicio=(select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma)) and idarticulo=art.idarticulo and idalmadest=@alma)))  where exis.idalmacen=@alma group by art.idarticulo,art.descripcion,art.cont,umed.unidad,fam.famdescripcion,art.artclave,exis.cantidad
--select art.descripcion,art.cont contenido,umed.unidad unidad,fam.famdescripcion,art.artclave clave,sum(mov.cantidad) Cargado,isnull((select sum(cantidad) from movimientos where idtipomov=1 and (fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate())) and idarticulo=art.idarticulo and idalmadest=@alma),'0') Vendido,isnull((select sum(cantidad*precio) from movimientos where idtipomov=1 and (fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate())) and idarticulo=art.idarticulo and idalmadest=@alma),'0') '$ Ventas',isnull((select sum(cantidad) from movimientos where (idtipomov=3 or idtipomov=6) and fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate()) and idarticulo=art.idarticulo and idalmadest=@alma),'0') Devuelto,exis.cantidad Existencia,art.idarticulo from Existencia exis inner join Articulos art on (art.idarticulo=exis.idarticulo) inner join umedida umed on (art.idunidad=umed.umedidaid) inner join familia fam on (art.idfamilia=fam.idfamilia) inner join movimientos mov on (mov.idmovimiento in(select idmovimiento from movimientos where idmovimiento in(Select idmovimiento from foliomov where tipomov='Carga' and foliomov=(select foliomov from relacionfolios where fechainicio=(select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma)) and idarticulo=art.idarticulo and idalmadest=@alma)))  where exis.idalmacen=@alma group by art.idarticulo,art.descripcion,art.cont,umed.unidad,fam.famdescripcion,art.artclave,exis.cantidad
--(select foliomov from relacionfolios where fechainicio=(select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma))
    select art.artclave Clave,art.descripcion Descripción,art.cont Contenido,umed.unidad Unidad,fam.famdescripcion Familia,sum(mov.cantidad) Cargado,isnull((select sum(cantidad) from movimientos where idtipomov=1 and (fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate())) and idarticulo=art.idarticulo and idalmadest=@alma),'0') Vendido,isnull((select sum(cantidad*precio) from movimientos where idtipomov=1 and (fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate())) and idarticulo=art.idarticulo and idalmadest=@alma),'0') '$ Ventas',isnull((select sum(cantidad) from movimientos where (idtipomov=3 or idtipomov=6) and fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate()) and idarticulo=art.idarticulo and idalmadest=@alma),'0') + (isnull((select sum(cantidad) from movimientos where (idtipomov=5) and fecha between (select max(fechainicio) fechainicio from relacionfolios where idalmacen=@alma) and dateadd(day,1,getdate()) and idarticulo=art.idarticulo and idalmaorig=@alma),'0')) 'Devuelto Descargado',exis.cantidad Existencia,SPACE(10) AS 'Sobrante Ruta',art.idarticulo IDArticulo,SPACE(10) AS 'Dif.' from Existencia exis inner join Articulos art on (art.idarticulo=exis.idarticulo) inner join umedida umed on (art.idunidad=umed.umedidaid) inner join familia fam on (art.idfamilia=fam.idfamilia) inner join movimientos mov on (mov.idmovimiento in(select idmovimiento from movimientos where idmovimiento in(Select idmovimiento from foliomov where tipomov='Carga' and foliomov=(@folioliq) and idarticulo=art.idarticulo and idalmadest=@alma)))  where exis.idalmacen=@alma group by art.idarticulo,art.descripcion,art.cont,umed.unidad,fam.famdescripcion,art.artclave,exis.cantidad 

END



GO
/****** Object:  StoredProcedure [dbo].[FinalizaInventario]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FinalizaInventario] 
	--Add the parameters for the stored procedure here
	@idInventario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	Update corte set Inventariado=0 where Inventariado=1

	Update corte set Inventariado=1, Vendido='N', Eliminado='N' where idCorte in (Select idCorte from InventarioEtiquetas where idInventario=@idInventario and Empaquetado=0)
	Update corte set Inventariado=1, Vendido='N', Eliminado='N' where idCorte in (Select idCorte from TarimasDetalle where idTarima in (Select idTarima from Inventariotarimas where idInventario=@idInventario))

	Update Tarimas set Activa = 0
	Update Tarimas set Activa = 1 where idtarima in (Select idtarima from InventarioTarimas where idInventario=@idInventario)
	Update InventarioTarimas set Ajustado=1 where idInventario=@idInventario
    Update Inventario set ajustado='S' where idinventario=@idInventario

END





GO
/****** Object:  StoredProcedure [dbo].[FinalizaInventarioL]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FinalizaInventarioL] 
	--Add the parameters for the stored procedure here
	@idInventario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	--Update corte set Inventariado=0 where Inventariado=1
	Update corte Set Inventariado = 0 Where idCorte in (Select idCorte from corte, articulos 
		where articulos.artclave = corte.idarticulo and idlote = (Select Lote from InventarioL where idInventarioL = @idInventario)) --and idcorte not in (Select idEtiqueta from InventarioEtiquetasL where idInventario = @idInventario)

	Update corte set Inventariado=1, Vendido='N',Eliminado='N' where idCorte in (Select idEtiqueta from InventarioEtiquetasL where idInventario = @idInventario and Empaquetado=0)
	--Update corte set Inventariado=1, Vendido='N',Eliminado='N' where idCorte in (Select idCorte from TarimasDetalle where idTarima in (Select idTarima from Inventariotarimas where idInventario=@idInventario))

	--Update Tarimas set Activa = 0
	--Update Tarimas set Activa = 1 where idtarima in (Select idtarima from InventarioTarimas where idInventario=@idInventario)
	--Update InventarioTarimas set Ajustado=1 where idInventario=@idInventario
    Update InventarioL set ajustado='S' where idinventarioL = @idInventario

END
GO
/****** Object:  StoredProcedure [dbo].[FinalizaInventarioTerceros]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FinalizaInventarioTerceros] 
	--Add the parameters for the stored procedure here
	@idInventario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	Update Etiquetas set inventariado=0 where inventariado=1

	Update Etiquetas set inventariado=1, vendido=0,eliminado=0 where idEtiqueta in (Select idEtiqueta from InventarioEtiquetasT where idInventario=@idInventario and Empaquetado=0)
	Update Etiquetas set Inventariado=1, Vendido=0,eliminado=0 where idEtiqueta in (Select idEtiqueta from TarimasDetalleT where idTarima in (Select idTarima from Inventariotarimas where idInventario=@idInventario))

	Update TarimasT set Activa = 0
	Update TarimasT set Activa = 1 where idTarimaT in (Select idtarima from InventarioTarimas where idInventario=@idInventario)
	Update InventarioTarimas set Ajustado=1 where idInventario=@idInventario
    Update InventarioT set ajustado='S' where idinventarioT=@idInventario

END

GO
/****** Object:  StoredProcedure [dbo].[PA_LiquidaArticulo]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PA_LiquidaArticulo]
	-- Add the parameters for the stored procedure here
	@IdFolioMov int, 
	@IdArticulo int, 
	@ExisSis float, 
	@ExisReal float,
	@Cargado float,
	@Vendido float,
	@Devuelto float,
	@folioliquidacion float
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    Declare @Diferencia float
    -- Insert statements for procedure here
	set @Diferencia=@ExisReal-@ExisSis
--select dif_equipo from diferencias_equipo where equipo=@equipo and [plan]=@plan
	insert into liquidacionart (IdFolioMov,IdArticulo,ExistenciaSis,ExistenciaReal,Diferencia,cargado,vendido,devuelto,folioliq) values (@IdFolioMov,@IdArticulo,@ExisSis,@ExisReal,@Diferencia,@Cargado,@Vendido,@Devuelto,@folioliquidacion)
END	

GO
/****** Object:  StoredProcedure [dbo].[Sp_ActPartesCanal]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActPartesCanal]
(@strLote nvarchar(12))
WITH 
EXECUTE AS CALLER
AS
update Existencia set BitDelantero = 0, BitTrasero = 0, BitPina = 0, BitPistola = 0, CantMerma = 0
where Lote = @strLote
GO
/****** Object:  StoredProcedure [dbo].[Sp_CoRecepciona]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CoRecepciona]
(@intAlmacen int, @intFolio int, @DatFecha datetime, @Observaciones varchar(50), @intUMedida int)
WITH 
EXECUTE AS CALLER
AS
insert into existencia (Lote, NoCanal, Cantidad, UMedida, CveArt, Descripcion, Fecha, FechaCad, Decomiso, FolioRastro, NoAlmacen, TipoMov, DetMovimiento)
(select '', '', ComCantArt, @intUMedida , ComCveArt, ComDescart, @DatFecha , '', '', '', @intAlmacen , 'E', @Observaciones
from Compra
where ComFolio = @intFolio)
GO
/****** Object:  StoredProcedure [dbo].[Sp_IvRptAlmacen]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_IvRptAlmacen]
(@intAlmacen int=null, @strTipoMov varchar(1)=null, @dteFechaInicio datetime=null, @dteFechaFin datetime=null, @dteFechaCad datetime=null, @strCveArt nvarchar(12)=null)
WITH 
EXECUTE AS CALLER
AS
SELECT CveArt, NoCanal, Cantidad, Umedida.Unidad , Descripcion, Fecha, FechaCad, TipoMov, DetMovimiento
FROM Existencia
INNER JOIN UMedida ON Existencia.Umedida = Umedida.UmedidaId
WHERE CveArt LIKE Coalesce(@strCveArt, CveArt) AND NoAlmacen LIKE Coalesce(@intAlmacen, NoAlmacen) AND Cantidad > 0 AND TipoMov LIKE Coalesce(@strTipoMov, TipoMov)
AND dbo.Existencia.Fecha BETWEEN Coalesce(@dteFechaInicio, Fecha) AND Coalesce(@dteFechaFin, Fecha) AND FechaCad = COALESCE(@dteFechaCad, FechaCad)
GO
/****** Object:  StoredProcedure [dbo].[Sp_TmpSalida]    Script Date: 26/06/2018 07:17:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_TmpSalida]
WITH 
EXECUTE AS CALLER
AS
truncate table TmpSalida;
insert into tmpsalida
select cveart, sum (cantidad) as Entrada, '0' as Salida, Umedida, Descripcion, Fecha, FechaCad, NoAlmacen, DetMovimiento
FROM existencia WHERE tipomov = 'E' AND NoCanal = '0'
group by cveart, Umedida, Descripcion, Fecha, FechaCad, NoAlmacen, DetMovimiento
union
select cveart, '0' as Entrada, sum (cantidad) as Salida, Umedida, Descripcion, Fecha, FechaCad, NoAlmacen, DetMovimiento
FROM existencia WHERE tipomov = 'S' AND NoCanal = '0'
group by cveart, Umedida, Descripcion, Fecha, FechaCad, NoAlmacen, DetMovimiento
GO
USE [master]
GO
ALTER DATABASE [eMeatControlValco] SET  READ_WRITE 
GO
