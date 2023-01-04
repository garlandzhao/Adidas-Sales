--Display all invoices
SELECT *
FROM dbo.[Adidas Sales];

--Display invoices made in 2021
SELECT *
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021;

--Display the sales and profit for Dec 2021
SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 12
GROUP BY [Invoice Date]
ORDER BY [Invoice Date];

--Display the distribution of sale methods
SELECT [Sales Method], COUNT(*) AS 'Count'
FROM dbo.[Adidas Sales]
GROUP BY [Sales Method];

--Displays all retailers and their location
SELECT DISTINCT [Retailer], [Region], [State], [City]
FROM dbo.[Adidas Sales];

--Displays the total sales and operating profit from each region
SELECT [Region], SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
GROUP BY [Region];

--Display the number of invoices by retailers
SELECT [Retailer], Count(*) AS 'Invoices'
FROM dbo.[Adidas Sales]
GROUP BY [Retailer];

--Display all of the retailers and their sales history
SELECT YEAR([Invoice Date]) AS 'Year' , MONTH([Invoice Date]) AS 'Month', [Retailer], SUM([Total Sales]) AS 'Total Sales'
FROM dbo.[Adidas Sales]
GROUP BY [Retailer], YEAR([Invoice Date]), Month([Invoice Date])
ORDER BY YEAR([Invoice Date]), MONTH([Invoice Date]);


--Display the retailers and their profits and sales for Dec 2021
SELECT [Retailer], SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 12
GROUP BY [Retailer], Month([Invoice Date]);

--Display retailers who made a profit of over $10,000,000 in 2020
SELECT [Retailer], YEAR([Invoice Date]) AS 'Year' , SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2020
GROUP BY YEAR([Invoice Date]), [Retailer]
HAVING SUM([Operating Profit]) >= 10000000
ORDER BY YEAR([Invoice Date]);

--Display the sales made from each city
SELECT YEAR([Invoice Date]) AS 'Year' , MONTH([Invoice Date]) AS 'Month', [State], [City], SUM([Total Sales]) AS 'Total Sales'
FROM dbo.[Adidas Sales]
GROUP BY [State], [City], YEAR([Invoice Date]), Month([Invoice Date])
ORDER BY YEAR([Invoice Date]), MONTH([Invoice Date]);


--Display the top 5 most profitable cities 
SELECT TOP 5 [State], [City], SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
GROUP BY [State], [City]
ORDER BY [Operating Profit] DESC;

--Display the top 5 cities with the most sales for Dec 2021
SELECT TOP 5 [State], [City], SUM([Total Sales]) AS 'Total Sales' 
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 12
GROUP BY [State], [City], Month([Invoice Date])
ORDER BY SUM([Total Sales]) DESC;

--Display the products sold in New York,NY
SELECT  [State], [City], [Product], SUM([Units Sold]) AS 'Total Units Sold'
FROM dbo.[Adidas Sales]
WHERE [State] = 'New York' AND [City] = 'New York'
GROUP BY [State], [City], [Product]
ORDER BY 'Total Units Sold' DESC;

--Display the total units sold by each product line
SELECT [Product], SUM([Units Sold]) AS 'Total Units Sold'
FROM dbo.[Adidas Sales]
GROUP BY [Product];

--Display the units sold per product line by date
SELECT YEAR([Invoice Date]) AS 'Year' , MONTH([Invoice Date]) AS 'Month', [Product], SUM([Units Sold]) AS 'Total Units Sold'
FROM dbo.[Adidas Sales]
GROUP BY YEAR([Invoice Date]), MONTH([Invoice Date]), [Product]
ORDER BY YEAR([Invoice Date]), MONTH([Invoice Date]);

--Display the sales per product line for Dec 2021
SELECT [Product], SUM([Total Sales]) AS 'Total Sales' 
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 12
GROUP BY [Product]
ORDER BY SUM([Total Sales]) DESC;

--Display the average price per unit for each product line
SELECT [Product], AVG([Price per Unit]) AS 'AVG Price Per Unit'
FROM dbo.[Adidas Sales]
GROUP BY [Product];

--Display the operating margin of the different product lines
SELECT [Product], SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit', SUM([Operating Profit]) / SUM([Total Sales])AS 'Operating Margin'
FROM dbo.[Adidas Sales]
GROUP BY [Product];

--Display the sales and operating profit over time by day
SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
GROUP BY [Invoice Date]
ORDER BY [Invoice Date];

--Display sales over time by month
SELECT YEAR([Invoice Date]) AS 'Year' , MONTH([Invoice Date]) AS 'Month', COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales'
FROM dbo.[Adidas Sales]
GROUP BY YEAR ([Invoice Date]), MONTH([Invoice Date])
ORDER BY YEAR ([Invoice Date]), MONTH([Invoice Date]);

--Display the difference in sales by month
SELECT YEAR([Invoice Date]) AS 'Year' , MONTH([Invoice Date]) AS 'Month', SUM([Total Sales]) AS 'Total Sales' ,
	SUM([Total Sales]) - LAG(SUM([Total Sales])) OVER (ORDER BY YEAR ([Invoice Date]), MONTH([Invoice Date])) AS 'Difference'
FROM dbo.[Adidas Sales]
GROUP BY YEAR ([Invoice Date]), MONTH([Invoice Date])
ORDER BY YEAR ([Invoice Date]), MONTH([Invoice Date]);

--Display the sales and profit made everyday in 2021
SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit'
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY [Invoice Date]
ORDER BY [Invoice Date];

--Display total sales for the entire year of 2021
SELECT YEAR([Invoice Date]) AS 'Year', SUM([Total Sales]) AS 'Total Sales' 
FROM dbo.[Adidas Sales]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY YEAR([Invoice Date]);

--Compare the profit made in 2020 vs 2021
SELECT YEAR([Invoice Date]) AS 'Year', SUM([Operating Profit]) AS 'Proft',
	SUM([Operating Profit]) - LAG(SUM([Operating Profit])) OVER (ORDER BY YEAR([Invoice Date])) AS 'Difference'
FROM dbo.[Adidas Sales]
GROUP BY YEAR([Invoice Date])
ORDER BY YEAR([Invoice Date]);

--Displays the days in which there were over 50 invoices
SELECT [Invoice Date], COUNT(*) AS 'Count'
FROM dbo.[Adidas Sales]
GROUP BY [Invoice Date]
HAVING COUNT(*) >= 50;

--Display the day with the highest recorded sales
SELECT TOP 1 *
FROM(
	SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales'
	FROM dbo.[Adidas Sales]
	GROUP BY [Invoice Date]
) AS subq
ORDER BY 'Total Sales' DESC;

--Displays the lowest sales made in a single day
SELECT TOP 1 *
FROM(
	SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales'
	FROM dbo.[Adidas Sales]
	GROUP BY [Invoice Date]
) AS subq
ORDER BY 'Total Sales' ASC;




