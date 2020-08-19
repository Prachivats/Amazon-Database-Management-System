-- Procedure 1: Rating_update

-- Rating_update procedure is created to update the rating of the product, as the user gives reviwes,this procedure collects 
-- reviews and calculate rating for a particular product. This procedure
-- is executed after every 30 days. It collects reviews in cursor and then accordingly updates rating for
-- all the products whose reviews have popped up in the past 30 days.


create or replace PROCEDURE Rating_Upadte AS
thisProdReview%ROWTYPE;
thisratingNumber :=0;
count Number :=0 ;
CURSOR ReviewProd IS
SELECT Product_id, sum(rating) as rating , count(*) as counter FROM Reviews R, Product P
WHERE P.Product_id = R.Product_id AND R.Date> Today()- 30 group by Product_id;
FOR UPDATE;
BEGIN
OPEN ReviewProd;
LOOP
 FETCH ReviewProd INTO thisProd;
 EXIT WHEN (ReviewProd%NOTFOUND);
 --dbms_output.put_line(thisEmployee.Salary);
thisrating = thisrating + thisprod ;
 UPDATE Product SET Rating = rating / counter
 WHERE CURRENT OF ReviewProd;
END LOOP;
CLOSE ReviewProd;
END;

-- Procedure 2: Order_history
-- Order_History procedure is created to display the history of orders of the particular user. Whenever
-- User wants to access order history related to account, user clicks order history button and he gets to see all the orders that he has ordered in the past. -- This procedure displays all the information of
-- orders that has been done in the past.

create or replace PROCEDURE Order_history(Personid IN User.Person_id%TYPE) AS
thisOrderOrders%ROWTYPE;
CURSOR History IS
SELECT O.* FROM Orders O WHERE O.Person_id=Personid;
BEGIN
OPEN History;
LOOP
 FETCH History INTO thisOrder;
 EXIT WHEN (History%NOTFOUND);
dbms_output.put_line(thisOrder.Order_id || thisOrder.Date || thisOrder.DeliveryDate ||
thisOrder.ShippingTotal);
END LOOP;
CLOSE History;
END;