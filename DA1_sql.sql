use da1;

# The First-Mile Warehouse SLA Leak
SELECT 
    Warehouse,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(AVG(Hours_to_Dispatch), 1) AS Avg_Dispatch_Hours,
    SUM(CASE WHEN Hours_to_Dispatch > 24 THEN 1 ELSE 0 END) AS Total_SLA_Breaches,
    ROUND((SUM(CASE WHEN Hours_to_Dispatch > 24 THEN 1 ELSE 0 END) * 100.0 / COUNT(Order_ID)), 1) AS Breach_Rate_Percent
FROM da1.clean_ecommerce_fulfillment_data as i
GROUP BY Warehouse
ORDER BY Avg_Dispatch_Hours DESC;

# The Last-Mile Return (RTO) Leak
SELECT 
    Customer_City,
    Payment_Method,
    COUNT(Order_ID) AS Total_Orders,
    SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) AS Total_Returns,
    ROUND((SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(Order_ID)), 1) AS Return_Rate_Percent,
    ROUND(SUM(CASE WHEN Order_Status = 'Returned' THEN Order_Value_INR ELSE 0 END), 2) AS Revenue_Stuck_In_RTO
FROM da1.clean_ecommerce_fulfillment_data
GROUP BY Customer_City, Payment_Method
HAVING Return_Rate_Percent > 20
ORDER BY Return_Rate_Percent DESC;

# Product Category & Brand "Money Pit" Analysis
SELECT 
    Product_Category,
    Brand_Name,
    COUNT(Order_ID) AS Total_Orders,
    SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) AS Total_Returns,
    ROUND((SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(Order_ID)), 1) AS Return_Rate_Percent,
    ROUND(SUM(CASE WHEN Order_Status = 'Returned' THEN Order_Value_INR ELSE 0 END), 0) AS Wasted_GMV_INR
FROM da1.clean_ecommerce_fulfillment_data
GROUP BY Product_Category, Brand_Name
ORDER BY Wasted_GMV_INR DESC;