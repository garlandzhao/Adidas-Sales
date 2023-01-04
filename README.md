# Adidas-Sales

This project queries and visualizes the Adidas Sales dataset found on kaggle. The dataset is queried to answer common business questions. The queried results are displayed in a dynamic dashboard.

Dataset: https://www.kaggle.com/datasets/heemalichaudhari/adidas-sales-dataset

Created with: 
- SQL
- SSMS
- Tableau Public

## SQL Queries

Here are some examples of the statements used to query the Adidas Sales dataset. There are more queries located within the SQL file.
1. Display all invoices made in 2021
    ```
    SELECT *
    FROM dbo.[Adidas Sales]
    WHERE YEAR([Invoice Date]) = 2021;
    ```
2. Display the sales and operating profit over time by day
    ```
    SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales' , SUM([Operating Profit]) AS 'Operating Profit'
    FROM dbo.[Adidas Sales]
    GROUP BY [Invoice Date]
    ORDER BY [Invoice Date];
    ```
3. Display the products sold in New York, NY
    ```
    SELECT  [State], [City], [Product], SUM([Units Sold]) AS 'Total Units Sold'
    FROM dbo.[Adidas Sales]
    WHERE [State] = 'New York' AND [City] = 'New York'
    GROUP BY [State], [City], [Product]
    ORDER BY 'Total Units Sold' DESC;
    ```
4. Display the day with the highest recorded sales
    ```
    SELECT TOP 1 *
    FROM(
      SELECT [Invoice Date], COUNT(*) AS 'Count', SUM([Total Sales]) AS 'Total Sales'
      FROM dbo.[Adidas Sales]
      GROUP BY [Invoice Date]
    ) AS subq
    ORDER BY 'Total Sales' DESC;
    ```
5. Display retailers who made a profit of over $10,000,000 in 2020
    ```
    SELECT [Retailer], YEAR([Invoice Date]) AS 'Year' , SUM([Operating Profit]) AS 'Operating Profit'
    FROM dbo.[Adidas Sales]
    WHERE YEAR([Invoice Date]) = 2020
    GROUP BY YEAR([Invoice Date]), [Retailer]
    HAVING SUM([Operating Profit]) >= 10000000
    ORDER BY YEAR([Invoice Date]);
    ```
## Adidas Sales Dashboard (Tableau)
![Adidas Sales Dashboard](https://github.com/garlandzhao/Adidas-Sales/blob/419360c5611c8a1375836290e5c422f590cf4cd0/Adidas%20Sales%20Project%20Files/Images/Adidas%20Sales%20Dashboard.png)



[Tableau Dashboard](https://public.tableau.com/app/profile/garland.zhao/viz/AdidasSales_16727656258960/Dashboard1)

The image above is a screenshot of the Adidas Sales Dashboard. The Dashboard displays monthly sales information. The dashboard is automatically updated when different years and months are selected. The dashboard shows a variety of information such as sales by retailers, monthly total sales, monthly profit, and more.
