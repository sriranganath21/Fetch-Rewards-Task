/*What are the top 5 brands by receipts scanned for most recent month?*/

/* Here as there are no records for th most recent months of MArch and Feb 2021, I'm considering January 2021*/
/*more explaination is data quality check*/
with month_cte as ( 
Select r.receipt_id as id from receipts r where DATEPART(m, r.scanned_date) = 1 and DATEPART(year, r.scanned_date) = 2021 )

Select top 5 b.name as brand_name,
count(ri.receipt_id) as count_receipt
from [dbo].[receiptItemListNew] ri
inner join [dbo].[brands] b on b.brand_id = ri.brandid
inner join month_cte m on m.id = ri.receipt_id
group by ri.receipt_id, b.name
order by count_receipt desc


/*When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?*/

Select  rewardsReceiptStatus, avg(totalSpent) as Average_spend
from [dbo].[receipts]
where rewardsReceiptStatus = 'Finished' or rewardsReceiptStatus = 'Rejected'
group by rewardsReceiptStatus


/*When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?*/

Select rewardsReceiptStatus, sum(purchasedItemCount) as item_count
from [dbo].[receipts]
where rewardsReceiptStatus = 'Finished' or rewardsReceiptStatus = 'Rejected'
group by rewardsReceiptStatus


/*Which brand has the most spend among users who were created within the past 6 months?*/
/* Again this query didn't return any results as there are no brand IDs common among the table, this is because of the data quality issue with the barcode explained in the data quality check section */
with sixmonths_cte as
(SELECT user_id as id FROM users
where created_date >= Dateadd(Month, Datediff(Month, 0, DATEADD(m, -6,
current_timestamp)), 0))

Select top 1 b.name as brand_name, sum(ri.itemPrice) as total_spent
from [dbo].[receiptItemListNew] ri 
inner join brands b on b.brand_id = ri.brandid
inner join receipts r on r.receipt_id = ri.receipt_id
inner join sixmonths_cte s  on s.id = r.userId
group by  b.name
order by total_spent desc
