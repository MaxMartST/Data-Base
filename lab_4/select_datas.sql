USE [lab_4_computer_configuration]
GO
--выборка нескольких аргументов из таблицы component_parts
SELECT [title], [price] 
FROM [component_part];

--выборка cо всеми атрибутами
SELECT * FROM [component_part]; 

--выборка условием по атрибуту
SELECT * FROM [component_part] 
WHERE [relcase_date] > '2020-01-01';

--выборка с сортировкой по возрастанию ASC
SELECT *
FROM [component_part]
ORDER BY [price] ASC;

--выборка с сортировкой по убыванию DESC
SELECT *
FROM [component_part]
ORDER BY [price] DESC;

--выборка с сортировкой по двум атрибутам (title, relcase_date) + ограничение вывода количества записей
SELECT TOP 10*
FROM [component_part]
ORDER BY [title], [relcase_date];

--выборка с сортировкой по первому атрибуту, из списка извлекаемых
SELECT [relcase_date], [title] 
FROM [component_part]
ORDER BY 1 DESC;

--выборка, извлечь из таблицы не всю дату, а только год
SELECT [title], YEAR([relcase_date])AS [date] 
FROM [component_part]
ORDER BY [relcase_date] DESC;

--выборка MIN
SELECT MIN([price]) AS [price]
FROM [component_part];

--выборка MAX
SELECT MAX([price]) AS [price]
FROM [component_part];

--выборка AVG
SELECT AVG([price]) AS [среднее арифметическое]
FROM [component_part];

--выборка SUM
SELECT SUM([price]) AS [сумма стоимости всех компьютеров]
FROM [equipment];

--выборка COUNT
SELECT COUNT(*) AS [всего собранных компьютеров]
FROM [equipment];

--выборка компонентов производителей, выпускающих больше двух видов комплектующих 
SELECT * FROM [component_part]
WHERE [id_manufacturer] IN(
	SELECT [id_manufacturer]
	FROM [component_part]
	GROUP BY [id_manufacturer]
	HAVING COUNT(*) > 2
); 

-- найти сколько компьютеров у каждой комплектации
SELECT id_equiment, COUNT(*) as  cnt FROM computer
GROUP BY id_equiment
HAVING COUNT(*) > 1
ORDER BY 2 DESC

--найти компании, чей доход с продаж комплектующих в единственном экземпляре, привышает 100 условных единиц
SELECT [id_manufacturer], SUM([price]) as [total_income]
FROM [component_part]
GROUP BY [id_manufacturer]
HAVING SUM([price]) > 100

--стоимость сборки соответствует её типу
SELECT [id_equipment], [price], [name]
FROM [equipment] AS [eq]
LEFT JOIN [type_equipment] AS [t_eq] ON [eq].id_type = [t_eq].id_type;

--LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT*
FROM [manufacturer] AS [m]
LEFT JOIN [component_part] AS [c_p] ON [m].id_manufacturer = [c_p].id_manufacturer
WHERE [m].name != 'A-Data'
;

--RIGHT JOIN. Получить такую же выборку, как и в 5.1
--отсортировать первые 10 компаний и их товаров по цене 
SELECT TOP 10 [name], [title], [price]
FROM [manufacturer] AS [m]
RIGHT JOIN [component_part] AS [c_p] ON [m].id_manufacturer = [c_p].id_manufacturer
ORDER BY [price] ASC;

--LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
--вывести комплектующие типа: материнская плата не старше 2018 года, компании ASUS
SELECT [type], [title], [relcase_date], [price], [name]
FROM [type_component] AS [t_с]
INNER JOIN [component_part] AS [c_p] ON [t_с].id_type = [c_p].id_type
LEFT JOIN [manufacturer] AS [m] ON [c_p].id_manufacturer = [m].id_manufacturer
WHERE[t_с].type = 'Материнская плата' AND [c_p].relcase_date > '2018/01/01' AND [m].name = 'ASUS'
;

--FULL OUTER JOIN двух таблиц 
SELECT * 
FROM [computer]
UNION ALL
SELECT * 
FROM [computer_price_2020];

--Написать запрос с WHERE IN (подзапрос)
--вывести компьютеры цена которых привышает максимально дорогую сборку
SELECT*
FROM [computer]
	WHERE [price] > (
		SELECT MAX([price])
		FROM [equipment]
	);

--вывести компьютеры офисной комплектации не дороже 16000 условных единиц 
SELECT [c].id_computer, [c].price
FROM [computer] AS[c]
INNER JOIN [equipment] AS [e] ON [e].id_equipment = [c].id_equiment
LEFT JOIN [type_equipment] AS [t_e] ON [e].id_type = [t_e].id_type
	WHERE [t_e].name = 'office' AND [e].price < 16000
;