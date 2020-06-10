USE [lab_7_university]
GO

--1. Добавить внешние ключи.
--lesson.id_teacher => teacher.id_teacher
ALTER TABLE [lesson]
	ADD CONSTRAINT FK_lesson_teacher FOREIGN KEY(id_teacher) REFERENCES [teacher](id_teacher);

--lesson.id_subject => subject.id_subject
ALTER TABLE [lesson]
	ADD CONSTRAINT FK_lesson_subject FOREIGN KEY(id_subject) REFERENCES [subject](id_subject);

--lesson.id_group => group.id_group
ALTER TABLE [lesson]
	ADD CONSTRAINT FK_lesson_group FOREIGN KEY(id_group) REFERENCES [group](id_group);

--mark.id_lesson => lesson.id_lesson
ALTER TABLE [mark]
	ADD CONSTRAINT FK_mark_lesson FOREIGN KEY(id_lesson) REFERENCES [lesson](id_lesson);
	
--mark.id_lesson => student.id_student
ALTER TABLE [mark]
	ADD CONSTRAINT FK_mark_student FOREIGN KEY(id_student) REFERENCES [student](id_student);

--student.id_group => group.id_group
ALTER TABLE [student]
	ADD CONSTRAINT FK_student_group FOREIGN KEY(id_group) REFERENCES [group](id_group);

--2. Выдать оценки студентов по информатике если они обучаются данному предмету. 
--Оформить выдачу данных с использованием view. 
-- удаление View
DROP VIEW computer_science_grades
GO  

CREATE VIEW computer_science_grades 
AS
SELECT [s].name AS [name student], [m].mark 
	FROM [lesson] AS [les]
		INNER JOIN (SELECT [s].id_subject, [s].name FROM [subject] AS [s] WHERE [s].name = N'Информатика') [sub] ON [les].id_subject = [sub].id_subject
		INNER JOIN [mark] AS [m] ON [les].id_lesson = [m].id_lesson
		INNER JOIN [student] AS [s] ON [m].id_student = [s].id_student
;
GO

SELECT * FROM computer_science_grades
GO

--3. Дать информацию о должниках с указанием фамилии студента и названия предмета. 
--Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе. 
--Оформить в виде процедуры, на входе идентификатор группы. 
CREATE PROCEDURE [debtors_in_a_group]
	@groupID AS INT
AS
	IF @groupID NOT BETWEEN 1 AND 4
		BEGIN
			SELECT 'Group with id: ' +  CAST(@groupID AS varchar(12)) + ' not found' AS [error messeg]
			RETURN
		END;
	SELECT [st].[name]
		FROM [group] AS [g]
		INNER JOIN [student] AS [st] ON [g].id_group = [st].id_group AND [g].id_group = @groupID
		LEFT JOIN [mark] AS [m] ON [st].id_student = [m].id_student
	WHERE [m].mark IS NULL
GO

DECLARE @groupID AS INT = 3;
EXECUTE [debtors_in_a_group] @groupID;

IF OBJECT_ID('debtors_in_a_group','P') IS NOT NULL
	DROP PROC debtors_in_a_group
GO

SELECT *
	FROM [group] AS [g]
	INNER JOIN [student] AS [st] ON [g].id_group = [st].id_group
	LEFT JOIN [mark] AS [m] ON [st].id_student = [m].id_student
	--RIGHT JOIN [lesson] AS [les] ON [m].id_lesson = [les].id_lesson
WHERE [m].mark IS NULL
;

SELECT [sub].name , COUNT([les].id_lesson)
	FROM [lesson] AS [les]
		RIGHT JOIN [subject] AS [sub] ON [les].id_subject = [sub].id_subject
	GROUP BY [sub].name 
;

--4. Дать среднюю оценку студентов по каждому предмету для тех предметов, 
--по которым занимается не менее 35 студентов.

SELECT (SELECT name FROM [subject] AS [s] WHERE [sub].id_subject = [s].id_subject ) AS [subject],
		SUM([m].mark) / COUNT([m].mark) AS[average]
	FROM [lesson] AS [l]
		INNER JOIN [subject] AS [sub] ON [l].id_subject = [sub].id_subject
		INNER JOIN [group] AS [g] ON [l].id_group = [g].id_group
		INNER JOIN [student] AS [st] ON [g].id_group = [st].id_group
		LEFT JOIN [mark] AS [m] ON [st].id_student = [m].id_student
	GROUP BY [sub].id_subject
	HAVING COUNT(DISTINCT [st].id_student) >= 35
; 

--5. Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты. 
--При отсутствии оценки заполнить значениями NULL поля оценки.

SELECT [st].name AS [student], [g].name AS [group], [l].date AS [date], [sub].name AS [subject], [m].mark AS [mark]
	FROM [student] AS [st]
		INNER JOIN (SELECT * FROM [group] AS [gr] WHERE [gr].name = N'ВМ') [g] ON [st].id_group = [g].id_group
		INNER JOIN [lesson] AS [l] ON [g].id_group = [l].id_group
		INNER JOIN [subject] AS [sub] ON [l].id_subject = [sub].id_subject
		LEFT JOIN [mark] AS [m] ON [st].id_student = [m].id_student AND [l].id_lesson = [m].id_lesson
;
GO

--6. Всем студентам специальности ПС, 
--получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл.

CREATE VIEW increase_score AS
	SELECT [st].name AS [student],
			[g].name AS [group],
			[l].date AS [date],
			[sub].name AS [subject],
			[mar].mark AS [mark]
		FROM [student] AS [st]
			INNER JOIN (SELECT * FROM [group] AS [gr] WHERE [gr].name = N'ПС') [g] ON [st].id_group = [g].id_group
			INNER JOIN (SELECT * FROM [lesson] AS [les] WHERE [les].date <= '2019-05-12') AS [l] ON [g].id_group = [l].id_group
			INNER JOIN (SELECT * FROM [subject] AS [s] WHERE [s].name = N'БД' ) [sub] ON [l].id_subject = [sub].id_subject
			INNER JOIN (SELECT * FROM [mark] AS [m] WHERE [m].mark < 5) [mar] ON [mar].id_lesson = [l].id_lesson AND [mar].id_student = [st].id_student
GO

BEGIN  TRANSACTION
UPDATE increase_score
SET [mark] = [mark] + 1

ROLLBACK

DROP VIEW increase_score
GO 

--7. Добавить необходимые индексы.
--индекс subject по name
CREATE NONCLUSTERED INDEX [IX_subject_name] ON [dbo].[subject]
(
	[name] ASC
)
--удаление
DROP INDEX [IX_subject_name] ON [dbo].[subject]

--индекс lesson по id_subject
CREATE NONCLUSTERED INDEX [IX_lesson_id_subject] ON [dbo].[lesson]
(
	[id_subject] ASC
)
--удаление
DROP INDEX [IX_lesson_id_subject] ON [dbo].[lesson]

--индекс lesson по id_group
CREATE NONCLUSTERED INDEX [IX_lesson_id_group] ON [dbo].[lesson]
(
	[id_group] ASC
)
--удаление
DROP INDEX [IX_lesson_id_group] ON [dbo].[lesson]

--индекс lesson по date
CREATE NONCLUSTERED INDEX [IX_lesson_date] ON [dbo].[lesson]
(
	[date] ASC
)
--удаление
DROP INDEX [IX_lesson_date] ON [dbo].[lesson]

--индекс mark по id_student и id_lesson
CREATE NONCLUSTERED INDEX [IX_mark_id_student_id_lesson] ON [dbo].[mark]
(
	[id_student] ASC,
	[id_lesson] ASC
)
--удаление
DROP INDEX [IX_mark_id_student_id_lesson] ON [dbo].[mark]

--индекс mark по id_lesson
CREATE NONCLUSTERED INDEX [IX_mark_id_lesson] ON [dbo].[mark]
(
	[id_lesson] ASC
)
--удаление
DROP INDEX [IX_mark_id_lesson] ON [dbo].[mark]

--индекс mark по id_student
CREATE NONCLUSTERED INDEX [IX_mark_id_student] ON [dbo].[mark]
(
	[id_student] ASC
)
--удаление
DROP INDEX [IX_mark_id_student] ON [dbo].[mark]

--индекс mark по mark
CREATE NONCLUSTERED INDEX [IX_mark_mark] ON [dbo].[mark]
(
	[mark] ASC
)
--удаление
DROP INDEX [IX_mark_mark] ON [dbo].[mark]

--индекс student по id_group 
CREATE NONCLUSTERED INDEX [IX_student_id_group] ON [dbo].[student]
(
	[id_group] ASC
)
--удаление
DROP INDEX [IX_student_id_group] ON [dbo].[student]

--индекс group по name
CREATE NONCLUSTERED INDEX [IX_group_name] ON [dbo].[group]
(
	[name] ASC
)
--удаление
DROP INDEX [IX_group_name] ON [dbo].[group]