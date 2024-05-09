SQL PARTITION BY Clause overview 

 

This article will cover the SQL PARTITION BY clause and the difference with GROUP BY in a select statement. We will also explore various use cases of SQL PARTITION BY. 

We use SQL PARTITION BY to divide the result set into partitions and perform computation on each subset of partitioned data. 

Preparing Sample Data 

Let us create an Orders table in my sample database SQLShackDemo and insert records to write further queries. 

1 

2 

3 

4 

5 

Use SQLShackDemo 

Go 

CREATE TABLE [dbo].[Orders] 

( 

    [orderid] INT, 

    [Orderdate] DATE, 

    [CustomerName] VARCHAR(100), 

    [Customercity] VARCHAR(100),  

    [Orderamount] MONEY 

) 

 

 

I use ApexSQL Generate to insert sample data into this article. Right click on the Orders table and Generate test data. 

Generate Text data using ApexSQL Generate 

It launches the ApexSQL Generate. I generated a script to insert data into the Orders table. Execute this script to insert 100 records in the Orders table. 

1 

2 

3 

4 

5 

USE [SQLShackDemo] 

GO 

INSERT [dbo].[Orders]  VALUES (216090, CAST(N'1826-12-19' AS Date), N'Edward', N'Phoenix', 4713.8900) 

GO 

INSERT [dbo].[Orders]  VALUES (508220, CAST(N'1826-12-09' AS Date), N'Aria', N'San Francisco', 9832.7200) 

GO 

… 

Once we execute insert statements, we can see the data in the Orders table in the following image. 

Sample data 

We use SQL GROUP BY clause to group results by specified column and use aggregate functions such as Avg(), Min(), Max() to calculate required values. 

Group By function syntax 

1 

2 

SELECT expression, aggregate function () 

FROM tables 

WHERE conditions 

GROUP BY expression 

 

Suppose we want to find the following values in the Orders table 

Minimum order value in a city 

Maximum order value in a city 

Average order value in a city 

Execute the following query with GROUP BY clause to calculate these values. 

1 

2 

3 

4 

5 

6 

SELECT Customercity,  

       AVG(Orderamount) AS AvgOrderAmount,  

       MIN(OrderAmount) AS MinOrderAmount,  

       SUM(Orderamount) TotalOrderAmount 

FROM [dbo].[Orders] 

GROUP BY Customercity; 

In the following screenshot, we can see Average, Minimum and maximum values grouped by CustomerCity. 

Output of SQL Group By clause 

Now, we want to add CustomerName and OrderAmount column as well in the output. Let’s add these columns in the select statement and execute the following code. 

1 

2 

3 

4 

5 

6 

SELECT Customercity, CustomerName ,OrderAmount, 

       AVG(Orderamount) AS AvgOrderAmount,  

       MIN(OrderAmount) AS MinOrderAmount,  

       SUM(Orderamount) TotalOrderAmount 

FROM [dbo].[Orders] 

GROUP BY Customercity; 

Once we execute this query, we get an error message. In the SQL GROUP BY clause, we can use a column in the select statement if it is used in Group by clause as well. It does not allow any column in the select clause that is not part of GROUP BY clause. 

Error in output of SQL Group By clause. 

We can use the SQL PARTITION BY clause to resolve this issue. Let us explore it further in the next section. 

SQL PARTITION BY 

We can use the SQL PARTITION BY clause with the OVER clause to specify the column on which we need to perform aggregation. In the previous example, we used Group By with CustomerCity column and calculated average, minimum and maximum values. 

Let us rerun this scenario with the SQL PARTITION BY clause using the following query. 

1 

2 

3 

4 

5 

SELECT Customercity,  

 

       AVG(Orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount,  

       MIN(OrderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount,  

       SUM(Orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount 

 

FROM [dbo].[Orders]; 

In the output, we get aggregated values similar to a GROUP By clause. You might notice a difference in output of the SQL PARTITION BY and GROUP BY clause output. 

Example of SQL PARTITION BY clause 

 

Group By 

SQL PARTITION BY 

We get a limited number of records using the Group By clause 

We get all records in a table using the PARTITION BY clause. 

It gives one row per group in result set. For example, we get a result for each group of CustomerCity in the GROUP BY clause. 

It gives aggregated columns with each record in the specified table. 

We have 15 records in the Orders table. In the query output of SQL	 PARTITION BY, we also get 15 rows along with Min, Max and average values. 

In the previous example, we get an error message if we try to add a column that is not a part of the GROUP BY clause. 

We can add required columns in a select statement with the SQL PARTITION BY clause. Let us add CustomerName and OrderAmount columns and execute the following query. 

1 

2 

3 

4 

5 

6 

7 

SELECT Customercity,  

       CustomerName,  

       OrderAmount,  

 

       AVG(Orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount,  

       MIN(OrderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount,  

       SUM(Orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount 

 

FROM [dbo].[Orders]; 

We get CustomerName and OrderAmount column along with the output of the aggregated function. We also get all rows available in the Orders table. 

Example of SQL PARTITION BY 

In the following screenshot, you can for CustomerCity Chicago, it performs aggregations (Avg, Min and Max) and gives values in respective columns. 

Examples for Average,Min and Max values 

Similarly, we can use other aggregate functions such as count to find out total no of orders in a particular city with the SQL PARTITION BY clause. 

1 

2 

3 

4 

5 

6 

7 

8 

SELECT Customercity,  

       CustomerName,  

       OrderAmount,  

 

       COUNT(OrderID) OVER(PARTITION BY Customercity) AS CountOfOrders,  

       AVG(Orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount,  

       MIN(OrderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount,  

       SUM(Orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount 

 

FROM [dbo].[Orders]; 

We can see order counts for a particular city. For example, we have two orders from Austin city therefore; it shows value 2 in CountofOrders column. 

Count of Orders example 

PARTITION BY clause with ROW_NUMBER() 

We can use the SQL PARTITION BY clause with ROW_NUMBER() function to have a row number of each row. We define the following parameters to use ROW_NUMBER with the SQL PARTITION BY clause. 

PARTITION BY column – In this example, we want to partition data on CustomerCity column 

Order By: In the ORDER BY column, we define a column or condition that defines row number. In this example, we want to sort data on the OrderAmount column 

1 

2 

3 

4 

5 

6 

7 

8 

9 

10 

SELECT Customercity,  

       CustomerName,  

       ROW_NUMBER() OVER(PARTITION BY Customercity 

       ORDER BY OrderAmount DESC) AS "Row Number",  

       OrderAmount,  

 

       COUNT(OrderID) OVER(PARTITION BY Customercity) AS CountOfOrders,  

       AVG(Orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount,  

       MIN(OrderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount,  

       SUM(Orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount 

 

FROM [dbo].[Orders]; 

In the following screenshot, we get see for CustomerCity Chicago, we have Row number 1 for order with highest amount 7577.90. it provides row number with descending OrderAmount. 

ROW Number using SQL PARTITION BY 

PARTITION BY clause with Cumulative total value 

Suppose we want to get a cumulative total for the orders in a partition. Cumulative total should be of the current row and the following row in the partition. 

Cumulative total value example 

 

 

 

 

For example, in Chicago city, we have four orders. 

CustomerCity 

CustomerName 

Rank 

OrderAmount 

Cumulative Total Rows 

Cumulative Total 

Chicago 

Marvin 

1 

7577.9 

Rank 1 +2 

14777.51 

Chicago 

Lawrence 

2 

7199.61 

Rank 2+3 

14047.21 

Chicago 

Alex 

3 

6847.66 

Rank 3+4 

8691.49 

Chicago 

Jerome 

4 

1843.83 

Rank 4 

1843.83 

In the following query, we the specified ROWS clause to select the current row (using CURRENT ROW) and next row (using 1 FOLLOWING). It further calculates sum on those rows using sum(Orderamount) with a partition on CustomerCity ( using OVER(PARTITION BY Customercity ORDER BY OrderAmount DESC). 

1 

2 

3 

4 

5 

6 

7 

 

SELECT Customercity,  

       CustomerName,  

       OrderAmount,  

 

       ROW_NUMBER() OVER(PARTITION BY Customercity 

 

       ORDER BY OrderAmount DESC) AS "Row Number",  

       CONVERT(VARCHAR(20), SUM(orderamount) OVER(PARTITION BY Customercity 

       ORDER BY OrderAmount DESC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING), 1)  

 

AS CumulativeTotal, 

 

Cumulative average value examples 

Similarly, we can calculate the cumulative average using the following query with the SQL PARTITION BY clause. 

1 

2 

3 

4 

5 

6 

7 

SELECT Customercity,  

       CustomerName,  

       OrderAmount,  

 

       ROW_NUMBER() OVER(PARTITION BY Customercity 

       ORDER BY OrderAmount DESC) AS "Row Number",  

       CONVERT(VARCHAR(20), AVG(orderamount) OVER(PARTITION BY Customercity 

       ORDER BY OrderAmount DESC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING), 1)  

 

AS CumulativeAVG 

 

cumulative average example 

ROWS UNBOUNDED PRECEDING with the PARTITION BY clause 

We can use ROWS UNBOUNDED PRECEDING with the SQL PARTITION BY clause to select a row in a partition before the current row and the highest value row after current row. 

In the following table, we can see for row 1; it does not have any row with a high value in this partition. Therefore, Cumulative average value is the same as of row 1 OrderAmount. 

For Row2, It looks for current row value (7199.61) and highest value row 1(7577.9). It calculates the average for these two amounts. 

For Row 3, it looks for current value (6847.66) and higher amount value than this value that is 7199.61 and 7577.90. It calculates the average of these and returns. 

 

 

 

CustomerCity 

CustomerName 

Rank 

OrderAmount 

Cumulative Average Rows 

Cumulative Average 

Chicago 

Marvin 

1 

7577.9 

Rank 1 

7577.90 

Chicago 

Lawrence 

2 

7199.61 

Rank 1+2 

7388.76 

Chicago 

Alex 

3 

6847.66 

Rank 1+2+3 

7208.39 

Chicago 

Jerome 

4 

1843.83 

Rank 1+2+3+4 

5867.25 

Execute the following query to get this result with our sample data. 

1 

2 

3 

4 

5 

6 

7 

8 

SELECT Customercity,  

       CustomerName,  

       OrderAmount,  

 

       ROW_NUMBER() OVER(PARTITION BY Customercity 

       ORDER BY OrderAmount DESC) AS "Row Number",  

       CONVERT(VARCHAR(20), AVG(orderamount) OVER(PARTITION BY Customercity 

       ORDER BY OrderAmount DESC ROWS UNBOUNDED PRECEDING), 1) AS CumulativeAvg 

 

FROM [dbo].[Orders]; 

 

ROWS UNBOUNDED PRECEDING example 

Conclusion 

In this article, we explored the SQL PARTIION BY clause and its comparison with GROUP BY clause. We also learned its usage with a few examples. I hope you find this article useful and feel free to ask any questions in the comments below 

 