USE [master]
GO
/****** Object:  Database [lab4_computer_configuration]    Script Date: 31.03.2020 14:39:42 ******/
CREATE DATABASE [lab4_computer_configuration]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'lab4_computer_configuration', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\lab4_computer_configuration.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'lab4_computer_configuration_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\lab4_computer_configuration_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [lab4_computer_configuration] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lab4_computer_configuration].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [lab4_computer_configuration] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET ARITHABORT OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [lab4_computer_configuration] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [lab4_computer_configuration] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET  DISABLE_BROKER 
GO
ALTER DATABASE [lab4_computer_configuration] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [lab4_computer_configuration] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [lab4_computer_configuration] SET  MULTI_USER 
GO
ALTER DATABASE [lab4_computer_configuration] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [lab4_computer_configuration] SET DB_CHAINING OFF 
GO
ALTER DATABASE [lab4_computer_configuration] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [lab4_computer_configuration] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [lab4_computer_configuration] SET DELAYED_DURABILITY = DISABLED 
GO
USE [lab4_computer_configuration]
GO
/****** Object:  Table [dbo].[component_equipment]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[component_equipment](
	[id_equipment] [int] NOT NULL,
	[id_component] [int] NOT NULL,
 CONSTRAINT [DF_component_equipment] PRIMARY KEY CLUSTERED 
(
	[id_equipment] ASC,
	[id_component] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[component_part]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[component_part](
	[id_component] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](45) NULL,
	[id_type] [int] NOT NULL,
	[id_manufacturer] [int] NOT NULL,
	[relcase_date] [date] NULL,
	[life_time] [date] NULL,
	[price] [money] NULL,
 CONSTRAINT [DF_component_part_id_component] PRIMARY KEY CLUSTERED 
(
	[id_component] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[computer]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[computer](
	[id_computer] [int] IDENTITY(1,1) NOT NULL,
	[price] [decimal](18, 0) NULL,
	[id_equiment] [int] NULL,
 CONSTRAINT [PK_computer] PRIMARY KEY CLUSTERED 
(
	[id_computer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[computer_2]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[computer_2](
	[id_computer] [int] IDENTITY(1,1) NOT NULL,
	[price] [decimal](18, 0) NULL,
	[id_equiment] [int] NULL,
 CONSTRAINT [PK_computer_2] PRIMARY KEY CLUSTERED 
(
	[id_computer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[computer_price_2020]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[computer_price_2020](
	[id_computers] [int] IDENTITY(1,1) NOT NULL,
	[price] [decimal](18, 0) NULL,
	[id_equiment] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[equipment]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment](
	[id_equipment] [int] IDENTITY(1,1) NOT NULL,
	[id_type] [int] NULL,
	[price] [decimal](18, 0) NULL,
 CONSTRAINT [DF_equipment_id_equipment] PRIMARY KEY CLUSTERED 
(
	[id_equipment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[manufacturer]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[manufacturer](
	[id_manufacturer] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NULL,
 CONSTRAINT [DF_manufacturer_id_manufacturer] PRIMARY KEY CLUSTERED 
(
	[id_manufacturer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type_component]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[type_component](
	[id_type] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](45) NULL,
 CONSTRAINT [DF_type_component_id_type] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type_equipment]    Script Date: 31.03.2020 14:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[type_equipment](
	[id_type] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NULL,
 CONSTRAINT [DF_type_equipmen_id_type] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[component_part] ON 

INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (1, N'Intel Core i5-9500F', 2, 1, CAST(N'2019-04-23' AS Date), CAST(N'2022-04-23' AS Date), 192.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (2, N'AMD Ryzen 5 2600X', 2, 2, CAST(N'2018-04-19' AS Date), CAST(N'2021-04-19' AS Date), 229.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (3, N'Gigabyte B365M AORUS ELITE', 1, 3, CAST(N'2019-05-24' AS Date), CAST(N'2021-05-01' AS Date), 90.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (4, N'ASUS PRIME B360M-A', 1, 6, CAST(N'2018-03-23' AS Date), CAST(N'2023-05-17' AS Date), 97.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (5, N'ASRock A320M-HDV', 1, 12, CAST(N'2017-07-27' AS Date), CAST(N'2020-09-12' AS Date), 55.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (6, N'A320M-A PRO', 1, 6, CAST(N'2019-12-05' AS Date), CAST(N'2023-06-27' AS Date), 45.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (7, N'nVidia GeForce PCI-E', 3, 6, CAST(N'2019-04-23' AS Date), CAST(N'2022-04-23' AS Date), 201.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (8, N'PCI-E RX 590 ARMOR', 3, 4, CAST(N'2019-12-05' AS Date), CAST(N'2023-06-27' AS Date), 180.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (9, N'HyperX', 4, 13, CAST(N'2017-07-21' AS Date), CAST(N'2020-09-15' AS Date), 72.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (10, N'M378A1', 4, 12, CAST(N'2015-01-21' AS Date), CAST(N'2020-09-15' AS Date), 76.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (11, N'Litepower', 5, 11, CAST(N'2020-02-15' AS Date), CAST(N'2024-05-27' AS Date), 97.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (12, N'Proton', 5, 9, CAST(N'2019-04-23' AS Date), CAST(N'2022-04-23' AS Date), 92.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (13, N'View 21', 6, 8, CAST(N'2020-02-15' AS Date), CAST(N'2024-05-27' AS Date), 82.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (14, N'Z7 NEO', 6, 9, CAST(N'2019-04-23' AS Date), CAST(N'2022-04-23' AS Date), 98.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (15, N'Minitower BAA-101', 6, 8, CAST(N'2015-01-21' AS Date), CAST(N'2020-09-15' AS Date), 23.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (16, N'Verkho 2 Dual', 7, 16, CAST(N'2019-05-03' AS Date), CAST(N'2024-06-24' AS Date), 15.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (17, N'ICE BLADE 200M', 7, 8, CAST(N'2020-02-15' AS Date), CAST(N'2024-05-27' AS Date), 20.0000)
INSERT [dbo].[component_part] ([id_component], [title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price]) VALUES (18, N'CK-11508', 7, 9, CAST(N'2019-05-03' AS Date), CAST(N'2024-06-24' AS Date), 10.0000)
SET IDENTITY_INSERT [dbo].[component_part] OFF
SET IDENTITY_INSERT [dbo].[computer] ON 

INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (1, CAST(64890 AS Decimal(18, 0)), 1)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (2, CAST(53290 AS Decimal(18, 0)), 2)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (3, CAST(38838 AS Decimal(18, 0)), 3)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (7, CAST(11154 AS Decimal(18, 0)), 4)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (8, CAST(12500 AS Decimal(18, 0)), 5)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (9, CAST(16700 AS Decimal(18, 0)), 6)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (10, CAST(1000 AS Decimal(18, 0)), 1)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (11, CAST(12000 AS Decimal(18, 0)), 1)
INSERT [dbo].[computer] ([id_computer], [price], [id_equiment]) VALUES (12, CAST(23356 AS Decimal(18, 0)), 2)
SET IDENTITY_INSERT [dbo].[computer] OFF
SET IDENTITY_INSERT [dbo].[computer_2] ON 

INSERT [dbo].[computer_2] ([id_computer], [price], [id_equiment]) VALUES (1, CAST(11154 AS Decimal(18, 0)), 4)
INSERT [dbo].[computer_2] ([id_computer], [price], [id_equiment]) VALUES (2, CAST(12500 AS Decimal(18, 0)), 5)
INSERT [dbo].[computer_2] ([id_computer], [price], [id_equiment]) VALUES (3, CAST(16700 AS Decimal(18, 0)), 6)
SET IDENTITY_INSERT [dbo].[computer_2] OFF
SET IDENTITY_INSERT [dbo].[computer_price_2020] ON 

INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (1, CAST(64890 AS Decimal(18, 0)), 1)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (2, CAST(53290 AS Decimal(18, 0)), 2)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (3, CAST(38838 AS Decimal(18, 0)), 3)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (4, CAST(38900 AS Decimal(18, 0)), 3)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (5, CAST(57000 AS Decimal(18, 0)), 2)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (6, CAST(65670 AS Decimal(18, 0)), 3)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (7, CAST(89890 AS Decimal(18, 0)), 1)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (8, CAST(71750 AS Decimal(18, 0)), 2)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (9, CAST(45670 AS Decimal(18, 0)), 3)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (10, CAST(12799 AS Decimal(18, 0)), 4)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (11, CAST(14560 AS Decimal(18, 0)), 5)
INSERT [dbo].[computer_price_2020] ([id_computers], [price], [id_equiment]) VALUES (12, CAST(17980 AS Decimal(18, 0)), 6)
SET IDENTITY_INSERT [dbo].[computer_price_2020] OFF
SET IDENTITY_INSERT [dbo].[equipment] ON 

INSERT [dbo].[equipment] ([id_equipment], [id_type], [price]) VALUES (1, 2, CAST(64890 AS Decimal(18, 0)))
INSERT [dbo].[equipment] ([id_equipment], [id_type], [price]) VALUES (2, 2, CAST(53290 AS Decimal(18, 0)))
INSERT [dbo].[equipment] ([id_equipment], [id_type], [price]) VALUES (3, 2, CAST(41000 AS Decimal(18, 0)))
INSERT [dbo].[equipment] ([id_equipment], [id_type], [price]) VALUES (4, 1, CAST(11154 AS Decimal(18, 0)))
INSERT [dbo].[equipment] ([id_equipment], [id_type], [price]) VALUES (5, 1, CAST(12500 AS Decimal(18, 0)))
INSERT [dbo].[equipment] ([id_equipment], [id_type], [price]) VALUES (6, 1, CAST(16700 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[equipment] OFF
SET IDENTITY_INSERT [dbo].[manufacturer] ON 

INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (1, N'Intel')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (2, N'AMD')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (3, N'Gigabyte')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (4, N'Radeon')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (5, N'nVidia')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (6, N'ASUS')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (7, N'Chieftec')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (8, N'Cooler Master')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (9, N'Zalman')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (10, N'A-Data')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (11, N'Seagate Barracuda')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (12, N'ASRock')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (13, N'Kingston')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (14, N'Aerocool')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (15, N'Toshiba')
SET IDENTITY_INSERT [dbo].[manufacturer] OFF
SET IDENTITY_INSERT [dbo].[type_component] ON 

INSERT [dbo].[type_component] ([id_type], [type]) VALUES (1, N'Материнская плата')
INSERT [dbo].[type_component] ([id_type], [type]) VALUES (2, N'Процессор')
INSERT [dbo].[type_component] ([id_type], [type]) VALUES (3, N'Видеокарта')
INSERT [dbo].[type_component] ([id_type], [type]) VALUES (4, N'Оперативная память')
INSERT [dbo].[type_component] ([id_type], [type]) VALUES (5, N'Блок питания')
INSERT [dbo].[type_component] ([id_type], [type]) VALUES (6, N'Корпус')
INSERT [dbo].[type_component] ([id_type], [type]) VALUES (7, N'Система охлаждения')
SET IDENTITY_INSERT [dbo].[type_component] OFF
SET IDENTITY_INSERT [dbo].[type_equipment] ON 

INSERT [dbo].[type_equipment] ([id_type], [name]) VALUES (1, N'office')
INSERT [dbo].[type_equipment] ([id_type], [name]) VALUES (2, N'game')
SET IDENTITY_INSERT [dbo].[type_equipment] OFF
USE [master]
GO
ALTER DATABASE [lab4_computer_configuration] SET  READ_WRITE 
GO
