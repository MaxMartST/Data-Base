USE [lab4_computer_configuration]
GO

-- инициализация таблицы computer с указанием списка полей таблицы computer
INSERT INTO [dbo].[computer]
	([price], [id_equiment])
VALUES
	(64890, 1),
	(53290, 2),
	(38838, 3),
	(38900, 3),
	(57000, 2),
	(68900, 1)
GO

-- инициализация таблицы computer с указанием списка полей таблицы computer_2
INSERT INTO [dbo].[computer_2]
	([price], [id_equiment])
VALUES
	(11154, 4),
	(12500, 5),
	(16700, 6)
GO

-- инициализация таблицы computer с указанием списка полей таблицы computer_price_2020
INSERT INTO [dbo].[computer_price_2020]
	([price], [id_equiment])
VALUES
	(64890, 1),
	(53290, 2),
	(38838, 3),
	(38900, 3),
	(57000, 2),
	(65670, 3),
	(89890, 1),
	(71750, 2),
	(45670, 3),
	(12799, 4),
	(14560, 5),
	(17980, 6)
GO

-- инициализация таблицы computer с чтением значения из другой таблицы
INSERT INTO [dbo].[computer] 
	([price], [id_equiment]) 
SELECT 
	[price], [id_equiment] 
FROM [dbo].[computer_2]
GO

-- инициализация таблицы computer с указанием списка полей таблицы type_equipment
INSERT INTO [dbo].[type_equipment]
	([name])
VALUES
	('office'),
	('game')
GO

-- инициализация таблицы computer с указанием списка полей таблицы type_equipment
INSERT INTO [dbo].[equipment]
	([price])
SELECT 
	[price]
FROM [dbo].[computer];
GO

--инициализация таблицы type_componenent
INSERT INTO [dbo].[type_component]
	([type])
VALUES
	('Материнская плата'),
	('Процессор'),
	('Видеокарта'),
	('Оперативная память'),
	('Блок питания'),
	('Корпус'),
	('Система охлаждения')
GO

--инициализация таблицы manufacturer
INSERT INTO [dbo].[manufacturer]
	([name])
VALUES
	('Intel'),
	('AMD'),
	('Gigabyte'),
	('Radeon'),
	('nVidia'),
	('ASUS'),
	('Chieftec'),
	('Cooler Master'),
	('Zalman'),
	('A-Data'),
	('Seagate Barracuda'),
	('ASRock'),
	('Kingston'),
	('Aerocool'),
	('Toshiba')
GO

--инициализация таблицы component_parts
INSERT INTO [dbo].[component_part]
	([title], [id_type], [id_manufacturer], [relcase_date], [life_time], [price])
VALUES
	('Intel Core i5-9500F', 2, 1, '2019/04/23', '2022/04/23', 192),
	('AMD Ryzen 5 2600X', 2, 2, '2018/04/19', '2021/04/19', 229),
	('Gigabyte B365M AORUS ELITE', 1, 3, '2019/05/24', '2021/05/01', 90),
	('ASUS PRIME B360M-A', 1, 6, '2018/03/23', '2023/05/17', 97),
	('ASRock A320M-HDV', 1, 12, '2017/07/27', '2020/09/12', 55),
	('A320M-A PRO', 1, 6, '2019/12/05', '2023/06/27', 45),
	('nVidia GeForce PCI-E', 3, 6, '2019/04/23', '2022/04/23', 201),
	('PCI-E RX 590 ARMOR', 3, 4, '2019/12/05', '2023/06/27', 180),
	('HyperX', 4, 13, '2017/07/21', '2020/09/15', 72),
	('M378A1', 4, 12, '2015/01/21', '2020/09/15', 76),
	('Litepower', 5, 11, '2020/02/15', '2024/05/27', 97),
	('Proton', 5, 9, '2019/04/23', '2022/04/23', 92),
	('View 21', 6, 8, '2020/02/15', '2024/05/27', 82),
	('Z7 NEO', 6, 9, '2019/04/23', '2022/04/23', 98),
	('Minitower BAA-101', 6, 8, '2015/01/21', '2020/09/15', 23),
	('Verkho 2 Dual', 7, 16, '2019/05/03', '2024/06/24', 15),
	('ICE BLADE 200M', 7, 8, '2020/02/15', '2024/05/27', 20),
	('CK-11508', 7, 9, '2019/05/03', '2024/06/24', 10)
GO