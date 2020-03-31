-- обновить один атрибут в таблице equipment
UPDATE [dbo].[equipment] 
SET [id_type] = 2 
WHERE [price] >= 40000

UPDATE [dbo].[equipment] 
SET [id_type] = 1 
WHERE [price] < 40000

-- обновить несколько атрибутов в таблице equipment
UPDATE [dbo].[equipment]  
SET [id_type] = 2, [price] = 41000
WHERE [id_equipment] = 3