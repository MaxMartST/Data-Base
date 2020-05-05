USE [lab_5_hotel_complex]
GO
-- 1. �������� ������� �����.
ALTER TABLE [booking]
  ADD FOREIGN KEY (id_client) REFERENCES [client] (id_client);

ALTER TABLE [room_in_booking]
  ADD FOREIGN KEY (id_booking) REFERENCES [booking] (id_booking);

ALTER TABLE [room_in_booking]
  ADD FOREIGN KEY (id_room) REFERENCES [room] (id_room);

ALTER TABLE [room]
  ADD FOREIGN KEY (id_hotel) REFERENCES [hotel] (id_hotel);


ALTER TABLE [room]
  ADD FOREIGN KEY (id_room_category) REFERENCES [room_category] (id_room_category);

--2. ������ ���������� � �������� ��������� �������, ����������� � ������� ��������� ����� �� 1 ������ 2019�.
--		����� ���������� ������ ���������� � room_in_booking �� client

SELECT [c].[id_client], [c].name, [c].phone
	FROM [client] AS [c] INNER JOIN [booking] AS [b] 
		ON [c].id_client = [b].id_client
		INNER JOIN [room_in_booking] AS [r_i_b] 
		ON [b].id_booking = [r_i_b].id_booking
		INNER JOIN [room] AS [r] 
		ON [r_i_b].id_room = [r].id_room
		INNER JOIN [room_category] AS [r_c] 
		ON [r].id_room_category = [r_c].id_room_category
		INNER JOIN [hotel] AS [h] 
		ON [r].id_hotel = [h].id_hotel
	WHERE [h].name = '������' AND [r_c].name = '����' AND [r_i_b].checkin_date <= '2019-04-01' AND '2019-04-01' <= [r_i_b].checkout_date;
--����� ������� ������ � ��������� �� ��� ������?

--3. ���� ������ ��������� ������� ���� �������� �� 22 ������.
SELECT [r].number, [h].name
	FROM [room] AS [r] INNER JOIN [room_in_booking] AS [r_i_b]
		ON [r].id_room = [r_i_b].id_room 
		INNER JOIN [booking] AS [b]
		ON [r_i_b].id_booking = [b].id_booking
		INNER JOIN [hotel] AS [h]
		ON [r].id_hotel = [h].id_hotel
	WHERE [r].number NOT IN (
		SELECT [r].number
			FROM [room_in_booking] AS [r_i_b] INNER JOIN [room] AS [r]
			ON [r_i_b].id_room = [r].id_room
		WHERE (([r_i_b].checkin_date <= '2019-04-22' AND [r_i_b].checkout_date > '2019-04-22') OR [b].booking_date = '2019-04-22')
	)
;

--4. ���� ���������� ����������� � ��������� ������� �� 23 ����� �� ������ ��������� �������
SELECT [r_c].id_room_category AS Category, COUNT([r_c].id_room_category) AS Qty_category 
	FROM [room_category] AS [r_c] 
		INNER JOIN [room] AS [r] ON [r_c].id_room_category = [r].id_room_category
		INNER JOIN [hotel] AS [h] ON [h].id_hotel = [r].id_hotel
		INNER JOIN [room_in_booking] AS [r_i_b] ON [r].id_room = [r_i_b].id_room
	WHERE [h].name IN (
		SELECT [h].name
			FROM [hotel] 
				INNER JOIN [room] AS [r] ON [r].id_hotel = [h].id_hotel
				INNER JOIN [room_in_booking] AS [r_i_b] ON [r].id_room = [r_i_b].id_room
			WHERE ((MONTH([r_i_b].checkin_date) >= 3 AND MONTH([r_i_b].checkout_date) <=3) AND (DAY([r_i_b].checkin_date) >= 23 AND DAY([r_i_b].checkout_date) > 23) 
				AND [h].name = '������')
	)
	GROUP BY [r_c].id_room_category
;

SELECT [r_c].id_room_category AS Category, COUNT([r_c].id_room_category) AS Qty_category,
	(SELECT name FROM room_category WHERE id_room_category = [r_c].id_room_category)
	FROM [room_category] AS [r_c]
		INNER JOIN [room] AS [r] ON [r_c].id_room_category = [r].id_room_category
		INNER JOIN [room_in_booking] AS [r_i_b] ON [r].id_room = [r_i_b].id_room
	WHERE [r_i_b].id_room IN (
		SELECT id_room 
			FROM hotel AS [h]
				INNER JOIN [room] AS [r] ON [h].id_hotel = [r].id_hotel
			WHERE [h].name = N'������'
	) AND [r_i_b].checkin_date >= '2019-03-23' AND [r_i_b].checkout_date < '2019-03-23'
	GROUP BY [r_c].id_room_category
;

--5. ���� ������ ��������� ����������� �������� �� ���� �������� ��������� �������, ��������� � ������ � ��������� ���� ������.
SELECT [c].name AS Name_client, [r_i_b].checkout_date AS Checkout_date
	FROM [client] AS [c] 
		INNER JOIN [booking] AS [b] ON [c].id_client = [b].id_client
		INNER JOIN [room_in_booking] AS [r_i_b] ON [b].id_booking = [r_i_b].id_booking
		INNER JOIN (
			SELECT [r].id_room, MAX(checkout_date)
				FROM room_in_booking AS [r_i_b]
				INNER JOIN [room] AS [r] ON [r_i_b].id_room = [r].id_room
				INNER JOIN [hotel] AS [h] ON [r].id_hotel = [h].id_hotel
			WHERE [r_i_b].checkout_date BETWEEN '2019-04-01' AND '2019-04-30' AND [h].name = N'������'
			GROUP BY [r].id_room
		) last_checkout (id_room, checkout_date) ON [r_i_b].id_room = last_checkout.id_room AND [r_i_b].checkout_date = last_checkout.checkout_date
;

--6. �������� �� 2 ��� ���� ���������� � ��������� ������� ���� �������� ������ ��������� �������, ������� ���������� 10 ���.

UPDATE [room_in_booking]
	SET
		checkout_date = DATEADD(day, 3, checkout_date)
	FROM [room_in_booking] AS [r_i_b]
		INNER JOIN [room] AS [r] ON [r_i_b].id_room = [r].id_room
		INNER JOIN [hotel] AS [h] ON [r].id_hotel = [h].id_hotel
		INNER JOIN [room_category] AS [r_c] ON [r].id_room_category = [r_c].id_room_category
WHERE [r_i_b].checkin_date = '2019-05-10' AND [h].name = N'������' AND [r_c].name = N'������' 

--7. ����� ��� "��������������" �������� ����������. ���������� ���������: �� ����� ���� ������������ ���� ����� �� ���� ���� ��������� ���, 
--�.�. ������ ���������� ���������� �������� � ���� �����. 
--������ � ������� room_in_booking � id_room_in_booking = 5 � 2154 �������� �������� ������������� ���������, ������� ���������� �����. 
--�������������� ������ ������� ������ ��������� ���������� � ���� ������������� �������.

SELECT [r_i_b_1].*, [r_i_b_2].*
	FROM [room_in_booking] AS [r_i_b_1]
		INNER JOIN [room_in_booking] AS [r_i_b_2] ON [r_i_b_1].id_room = [r_i_b_2].id_room AND [r_i_b_1].id_room_in_booking != [r_i_b_2].id_room_in_booking
	WHERE [r_i_b_1].checkin_date BETWEEN [r_i_b_2].checkin_date AND [r_i_b_2].checkout_date 
		OR [r_i_b_1].checkout_date BETWEEN [r_i_b_2].checkin_date AND [r_i_b_2].checkout_date
;

SELECT [r_i_b_1].*, [r_i_b_2].*
	FROM [room_in_booking] AS [r_i_b_1]
		INNER JOIN [room_in_booking] AS [r_i_b_2] ON [r_i_b_1].id_room = [r_i_b_2].id_room AND [r_i_b_1].id_room_in_booking != [r_i_b_2].id_room_in_booking
	WHERE NOT ([r_i_b_1].checkout_date <= [r_i_b_2].checkin_date OR [r_i_b_1].checkin_date >= [r_i_b_2].checkout_date) 
;

SELECT [r_i_b_1].*, [r_i_b_2].*
	FROM [room_in_booking] AS [r_i_b_1]
		INNER JOIN [room_in_booking] AS [r_i_b_2] ON [r_i_b_1].id_room = [r_i_b_2].id_room AND [r_i_b_1].id_room_in_booking != [r_i_b_2].id_room_in_booking
	WHERE 
		([r_i_b_1].checkin_date >= [r_i_b_2].checkin_date AND [r_i_b_1].checkout_date <= [r_i_b_2].checkout_date)  
		OR ([r_i_b_1].checkin_date < [r_i_b_2].checkin_date AND [r_i_b_1].checkout_date > [r_i_b_2].checkout_date)
		OR ([r_i_b_1].checkin_date <= [r_i_b_2].checkin_date AND [r_i_b_1].checkout_date <= [r_i_b_2].checkout_date)
		OR ([r_i_b_1].checkin_date >= [r_i_b_2].checkin_date AND [r_i_b_1].checkout_date >= [r_i_b_2].checkout_date)
;

--8. ������� ������������ � ����������.
USE [lab_5_hotel_complex]
GO

SET TRANSACTION ISOLATION LEVEL
    READ COMMITTED

BEGIN TRANSACTION

SET IDENTITY_INSERT [dbo].[booking] ON 
INSERT [dbo].[booking] ([id_booking], [id_client], [booking_date]) VALUES (5000, 86, CAST(N'2020-05-01' AS Date))
SET IDENTITY_INSERT [dbo].[booking] OFF 

SET IDENTITY_INSERT [dbo].[client] ON
INSERT [dbo].[client] ([id_client], [name], [phone]) VALUES (500, N'������ ���� ��������', N'7(7800)111-11-11')
SET IDENTITY_INSERT [dbo].[client] OFF

SET IDENTITY_INSERT [dbo].[hotel] ON
INSERT [dbo].[hotel] ([id_hotel], [name], [stars]) VALUES (500, N'������', 3)
SET IDENTITY_INSERT [dbo].[hotel] OFF

SET IDENTITY_INSERT [dbo].[room] ON 
INSERT [dbo].[room] ([id_room], [id_hotel], [id_room_category], [number], [price]) VALUES (500, 500, 3, N'28', 8504.0000)
SET IDENTITY_INSERT [dbo].[room] OFF

SET IDENTITY_INSERT [dbo].[room_category] ON 
INSERT [dbo].[room_category] ([id_room_category], [name], [square]) VALUES (500, N'������', 30)
SET IDENTITY_INSERT [dbo].[room_category] OFF

SET IDENTITY_INSERT [dbo].[room_in_booking] ON 
INSERT [dbo].[room_in_booking] ([id_room_in_booking], [id_booking], [id_room], [checkin_date], [checkout_date]) VALUES (5000, 5000, 209, CAST(N'2020-05-04' AS Date), CAST(N'2020-05-09' AS Date))
SET IDENTITY_INSERT [dbo].[room_in_booking] OFF

COMMIT