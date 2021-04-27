
/*Receipts table*/

SELECT [receipt_id]
      ,[bonusPointsEarned]
      ,[bonusPointsEarnedReason]
      ,[created_date]
      ,[scanned_date]
      ,[finished_date]
      ,[modified_date]
      ,[pointsAwarded_date]
      ,[pointsEarned]
      ,[purchase_date]
      ,[purchasedItemCount]
      ,[rewardsReceiptStatus]
      ,[totalSpent]
      ,[userId]
  FROM [fetchdb].[dbo].[receipts]

/*Users table*/
  SELECT [user_id]
      ,[created_date]
      ,[state]
      ,[active]
      ,[signUpSource]
      ,[lasLogin_date]
  FROM [fetchdb].[dbo].[users]

/* Brands table*/

SELECT [brand_id]
	  ,[barcode]
      ,[category]
      ,[categoryCode]
      ,[name]
      ,[topBrand]
      ,[cpg_id_oid]
      ,[cpg_ref]
      ,[brandCode]
  FROM [fetchdb].[dbo].[brands]

/*Adding receiptID as a primary key to our table*/
Alter Table receiptItemList Add receiptitem_id int identity not null;


/*Selecting only the values relevant from the receiptItemList table to new table, for the data model based on my current understanding of the data*/
Select * 
into receiptItemListNew
from (
Select b.[brand_id] as brandid
	  ,[receiptitem_id]
	  ,r.[barcode]
      ,[description]
      ,[finalPrice]
      ,[itemPrice]
      ,[id_oid] as receipt_id
      
from [receiptItemList] r
left join [brands] b
on r.[barcode] = b.[barcode]) t


