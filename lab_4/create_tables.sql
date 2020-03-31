USE [lab4_computer_configuration]
GO

/****** Object:  Table [dbo].[Computers]    Script Date: 16.03.2020 11:45:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[computer](
	[id_computers] [int] IDENTITY (1,1) NOT NULL,
	[price] [decimal](18, 0) NULL,
	[id_equiment] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[computer_price_2020](
	[id_computers] [int] IDENTITY (1,1) NOT NULL,
	[price] [decimal](18, 0) NULL,
	[id_equiment] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[computer]
ADD CONSTRAINT [DF_computer_id_computer] PRIMARY KEY CLUSTERED (id_computer)
GO

CREATE TABLE [dbo].[type_equipment](
	[id_type] [int] IDENTITY (1,1) NOT NULL,
	[name] [varchar](45) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[type_equipment]
ADD CONSTRAINT [DF_type_equipmen_id_type] PRIMARY KEY CLUSTERED (id_type)
GO

CREATE TABLE [dbo].[equipment](
	[id_equipment] [int] IDENTITY (1,1) NOT NULL,
	[id_type] [int] NULL,
	[price] [decimal](18, 0) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[equipment]
ADD CONSTRAINT [DF_equipment_id_equipment] PRIMARY KEY CLUSTERED (id_equipment)
GO

CREATE TABLE [dbo].[component_equipment](
	[id_equipment] [int] NOT NULL,
	[id_component] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[component_equipment]
ADD CONSTRAINT [DF_component_equipment] PRIMARY KEY CLUSTERED (id_equipment, id_component)
GO

CREATE TABLE [dbo].[type_component](
	[id_type] [int] IDENTITY (1,1) NOT NULL,
	[type] [varchar](45) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[type_component]
ADD CONSTRAINT [DF_type_component_id_type] PRIMARY KEY CLUSTERED (id_type)
GO


USE [lab4_computer_configuration]
GO
CREATE TABLE [dbo].[manufacturer](
	[id_manufacturer] [int] IDENTITY (1,1) NOT NULL,
	[name] [varchar](45) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[manufacturer]
ADD CONSTRAINT [DF_manufacturer_id_manufacturer] PRIMARY KEY CLUSTERED (id_manufacturer)
GO

CREATE TABLE [dbo].[component_part](
	[id_component] [int] IDENTITY (1,1) NOT NULL,
	[title] [varchar](45) NULL,
	[id_type] [int] NOT NULL,
	[id_manufacturer] [int] NOT NULL,
	[relcase_date] DATE,
	[life_time] DATE,
	[price] [money] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[component_part]
ADD CONSTRAINT [DF_component_part_id_component] PRIMARY KEY CLUSTERED (id_component)
GO