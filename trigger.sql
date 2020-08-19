--Triggers:


-- Trigger 1: Restock
-- Trigger Restock is triggered when the order placed by the user is Successful to reduce the product quantity from the Product Table.

Create trigger Restock
After Insert on Return
For Each ROW
Update product
SET StockSize = Old.StockSize + New.Qty
Where ProductID = New.ProductID
And New.Status = “Success”


-- Trigger 2: ValidateReturn

-- Trigger ValidateReturn is triggered when a user initiates a return. This trigger validates if the user has
-- asked for a return within 30 days of order date. This trigger is created to throw error when return date is greater than 30 days of order date. 

Create trigger ValidateReturn
After Insert on RETURN
For each row
Update RETURN
set Status= "Failed.Return date greater than 30 days"
where datediff(day,(select date from Order where Returnid=new.Returnid),Return.DATE) <= 30

-- Trigger 3: ReduceStock
-- Trigger ReduceStock is triggered when the order returned by the user is Successful to increase the product quantity in the Product Table.

Create trigger ReduceStock
After Insert on Return
For Each ROW
Update product
SET StockSize = Old.StockSize - New.Qty
Where ProductID = New.ProductID
And New.Status = “Success”
