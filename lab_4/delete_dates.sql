USE [lab4_computer_configuration]
GO

--удалить данные всех записей из таблицы computer
TRUNCATE TABLE [dbo].[computer]
GO

--удалить данные всех записей из таблицы computer_2
TRUNCATE TABLE [dbo].[computer_2]
GO

--удалить данные всех записей из таблицы computer_price_2020
TRUNCATE TABLE [dbo].[computer_price_2020]
GO

--удалить данные из таблицы по условию
DELETE FROM [dbo].[computer]
WHERE [price] < 20000;

--удалить данные всех записей из таблицы equipment
TRUNCATE TABLE [dbo].[equipment]
GO

--удалить данные всех записей из таблицы component_part
TRUNCATE TABLE [dbo].[component_part]
GO

--удалить данные всех записей из таблицы manufacturer
TRUNCATE TABLE [dbo].[manufacturer]
GO