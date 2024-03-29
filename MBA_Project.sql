-- DESCRIPTION

Select Top 30 
	[Transaction], Item 
From
	MBA.dbo.bread_basket

-- SELECT THE TRANSACTIONS HAVING AT LEAST TWO DIFFERENT ITEMS 

Select 
	[Transaction], COUNT(Item) as Number_Of_Products
From 
	MBA.dbo.bread_basket
Group By 
	[Transaction] 
Having COUNT(Item) >= 2

--LIST OUT THE TRANSACTION AND ITEM OF ORDERS HAVING AT LEAST TWO ITEMS

SELECT
	OrderList.[Transaction],
	BrB.Item
FROM
	(Select 
	[Transaction], COUNT(Item) as Number_Of_Products
From 
	MBA.dbo.bread_basket
Group By 
	[Transaction] 
Having COUNT(Item) >= 2) AS OrderList
JOIN MBA.dbo.bread_basket AS BrB 
ON OrderList.[Transaction] = BrB.[Transaction];

--CREATE COMBINATIONS OF TWO ITEMS IN THE SAME TRANSACTION

With Info AS (
SELECT
	OrderList.[Transaction],
	BrB.Item
FROM
	(Select 
	[Transaction], COUNT(Item) as Number_Of_Products
From 
	MBA.dbo.bread_basket
Group By 
	[Transaction] 
Having COUNT(Item) >= 2) AS OrderList
JOIN MBA.dbo.bread_basket AS BrB 
ON OrderList.[Transaction] = BrB.[Transaction])

Select 
	Info1.[Transaction],
	Info1.Item AS Item1,
	Info2.Item AS Item2
FROM 
	Info AS Info1
	JOIN Info AS Info2 ON Info1.[Transaction] = Info2.[Transaction]
WHERE Info1.Item != Info2.Item 
AND Info1.Item > Info2.Item

-- CALCULATE THE FREQUENCY OF A PAIR OF TWO ITEMS

With Info AS (
SELECT
	OrderList.[Transaction],
	BrB.Item
FROM
	(Select 
	[Transaction], COUNT(Item) as Number_Of_Products
From 
	MBA.dbo.bread_basket
Group By 
	[Transaction] 
Having COUNT(Item) >= 2) AS OrderList
JOIN MBA.dbo.bread_basket AS BrB 
ON OrderList.[Transaction] = BrB.[Transaction])

Select 
	Info1.Item AS Item1,
	Info2.Item AS Item2,
	Count (*) AS Frequency
FROM 
	Info AS Info1
	JOIN Info AS Info2 ON Info1.[Transaction] = Info2.[Transaction]
WHERE Info1.Item != Info2.Item 
AND Info1.Item > Info2.Item
GROUP BY 
	Info1.Item,
	Info2.Item 
ORDER BY COUNT(*) DESC



















