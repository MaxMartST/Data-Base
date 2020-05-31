USE [lab_6_pharmacy]
GO
--добавил

--1. Добавить внешние ключи.
--dealer.id_company => company.id_company
ALTER TABLE [dealer]
	ADD CONSTRAINT FK_dealer_company FOREIGN KEY(id_company) REFERENCES [company](id_company);

--production.id_company => company.id_company
ALTER TABLE [production]
	ADD CONSTRAINT FK_production_company FOREIGN KEY(id_company) REFERENCES [company](id_company);

--production.id_company => medicine.id_medicine
ALTER TABLE [production]
	ADD CONSTRAINT FK_production_medicine FOREIGN KEY(id_medicine) REFERENCES [medicine](id_medicine);

--order.id_production => production.id_production
ALTER TABLE [order]
	ADD CONSTRAINT FK_order_production FOREIGN KEY(id_production) REFERENCES [production](id_production);

--order.id_dealer => dealer.id_dealer
ALTER TABLE [order]
	ADD CONSTRAINT FK_order_dealer FOREIGN KEY(id_dealer) REFERENCES [dealer](id_dealer);

--order.id_pharmacy => pharmacy.id_pharmacy
ALTER TABLE [order]
	ADD CONSTRAINT FK_order_pharmacy FOREIGN KEY(id_pharmacy) REFERENCES [pharmacy](id_pharmacy);

--2. Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.
SELECT [o].[id_order], [med].name AS [medicine], [com].name AS [company], [phar].name AS [pharmacy], [o].date AS [date], [o].quantity AS [quantity]
	FROM [order] AS [o]
		INNER JOIN [production] AS [p] ON [o].id_production = [p].id_production
		INNER JOIN (SELECT * FROM [medicine] AS [m] WHERE [m].name = N'Кордерон') [med] ON [p].id_medicine = [med].id_medicine
		INNER JOIN (SELECT * FROM [company] AS [c] WHERE [c].name = N'Аргус') [com] ON [p].id_company = [com].id_company
		INNER JOIN [pharmacy] AS [phar] ON [o].id_pharmacy = [phar].id_pharmacy
;

--3. Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января.
SELECT [o].id_order, [m].name AS [medicine], [com].name, [o].date 
	FROM [order] AS [o]
		INNER JOIN [production] AS [p] ON [o].id_production = [p].id_production
		INNER JOIN (SELECT * FROM [company] AS [c] WHERE [c].name = N'Фарма') [com] ON [p].id_company = [com].id_company
		INNER JOIN [medicine] AS [m] ON [p].id_medicine = [m].id_medicine
	WHERE NOT ([o].date >= '2019-01-25')
;

--4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов.
SELECT (SELECT name FROM [company] AS [com] WHERE [com].id_company = [c].id_company), 
COUNT(*) AS [count order], MIN([p].rating) AS [min rating], MAX([p].rating) AS [max rating]
	FROM [order] AS [o]
		INNER JOIN [production] AS [p] ON [o].id_production = [p].id_production
		INNER JOIN [company] AS [c] ON [p].id_company = [c].id_company
		INNER JOIN [medicine] AS [m] ON [p].id_medicine = [m].id_medicine
	GROUP BY [c].id_company
	HAVING COUNT(*) >= 120
;

--5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. 
--Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT [p].name, [d].name, [c].name
	FROM [company] AS [c]
		INNER JOIN [dealer] AS [d] ON [c].id_company = [d].id_company
		INNER JOIN [order] AS [o] ON [d].id_dealer = [o].id_dealer
		LEFT JOIN [pharmacy] AS [p] ON [o].id_pharmacy = [p].id_pharmacy AND [c].name = N'AstraZeneca'
;

--6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE [production]
	SET
		price = price * 0.8
	FROM [production] AS [p]
		INNER JOIN [order] AS [o] ON [p].id_production = [o].id_production
		INNER JOIN [medicine] AS [m] ON [p].id_medicine = [m].id_medicine
	WHERE [p].price > 3000 AND [m].cure_duration <= 7
;