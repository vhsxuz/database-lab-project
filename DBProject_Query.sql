--1
SELECT mi.ItemName, mi.ItemPrice, SUM(dpt.ItemQuantity) [ItemTotal]
FROM DetailPurchaseTransaction dpt
JOIN HeaderPurchaseTransaction hpt ON dpt.PurchaseTransactionID = hpt.PurchaseTransactionID
JOIN MsItem mi ON mi.ItemID = dpt.ItemID
WHERE hpt.ArrivalDate IS NULL
GROUP BY mi.ItemName, mi.ItemPrice
HAVING SUM(dpt.ItemQuantity) > 100
ORDER BY ItemTotal DESC

--2
SELECT VendorName,
    SUBSTRING(VendorEmail, CHARINDEX('@', VendorEmail) + 1, LEN(VendorEmail)) AS [Domain Name],
    AVG(ItemQuantity) AS [Average Purchased Item]
FROM MsVendor AS v
JOIN HeaderPurchaseTransaction AS ht ON ht.VendorID = v.VendorID
JOIN DetailPurchaseTransaction AS dt ON dt.PurchaseTransactionID = ht.PurchaseTransactionID
WHERE SUBSTRING(VendorEmail, CHARINDEX('@', VendorEmail) + 1, LEN(VendorEmail)) != 'gmail.com' AND
    v.VendorAddress LIKE '%Food Street%'
GROUP BY v.VendorName, v.VendorEmail, dt.ItemQuantity

-- 3
SELECT MONTH(hst.SalesTransactionDate) AS MONTH
FROM HeaderSalesTransaction AS hst
JOIN DetailSalesTransaction AS dst ON dst.SalesTransactionID = hst.SalesTransactionID
JOIN MsItem AS i ON i.ItemID = dst.ItemID
JOIN MsItemType AS mi ON mi.ItemTypeID = i.ItemTypeID
WHERE YEAR(hst.SalesTransactionDate) = 2019 AND
    mi.ItemTypeName = 'Food' OR mi.ItemTypeName = 'Drink'

--4
SELECT
	[Staff Number] = REPLACE(ms.StaffID, 'ST', 'Staff '),
	StaffName,
	[Salary] = 'Rp. ' + CAST(StaffSalary AS VARCHAR),
	[Sales Count] = COUNT(hst.SalesTransactionID),
	[Average Sales Quantity] = AVG(dst.ItemQuantity)
FROM
	MsStaff ms JOIN HeaderSalesTransaction hst ON
	ms.StaffID = hst.StaffID JOIN DetailSalesTransaction dst ON 
	hst.SalesTransactionID = dst.SalesTransactionID JOIN MsCustomer mc ON
	hst.CustomerID = mc.CustomerID
WHERE
	mc.CustomerGender != ms.StaffGender AND MONTH(hst.SalesTransactionDate) = 2
GROUP BY
	ms.StaffID,
	StaffName,
	StaffSalary

-- 5
SELECT UPPER(CONCAT(SUBSTRING(c.CustomerName, 1, 1), SUBSTRING(c.CustomerName, LEN(c.CustomerName), 1))) AS [Customer Initial],
    hst.SalesTransactionDate,
    dst.ItemQuantity
FROM MsCustomer AS c,
    HeaderSalesTransaction AS hst,
    DetailSalesTransaction AS dst,
    (SELECT AVG(ItemQuantity) AS [Average]
    FROM DetailSalesTransaction) AS [Average Quantity]
WHERE c.CustomerGender = 'Female' AND ItemQuantity > [Average Quantity].Average

--6
SELECT
	[ID] = LOWER(mv.VendorID),
	VendorName,
	[Phone Number] = STUFF(VendorPhone, 1, 1, '+62')
FROM
	MsVendor mv JOIN HeaderPurchaseTransaction hpt ON
	mv.VendorID = hpt.VendorID JOIN DetailPurchaseTransaction dpt ON
	hpt.PurchaseTransactionID = dpt.PurchaseTransactionID, 
	(
		SELECT
			MIN(ItemQuantity) AS MinQuantity
		FROM
			DetailPurchaseTransaction
	) x
WHERE
	ItemQuantity > x.MinQuantity AND CAST(RIGHT(dpt.ItemID, 3) AS INT) % 2 = 1
GROUP BY
	mv.VendorID,
	VendorName,
	VendorPhone

--7
SELECT
	StaffName,
	VendorName,
	[PurchaseID] = hpt.PurchaseTransactionID,
	[Total Purchased Quantity] = SUM(ItemQuantity),
	[Ordered Day] = CAST(DATEDIFF(DAY, PurchaseTransactionDate, GETDATE()) AS VARCHAR) + ' Days ago'
FROM
	HeaderPurchaseTransaction hpt JOIN MsStaff ms ON
	hpt.StaffID = ms.StaffID JOIN MsVendor mv ON
	hpt.VendorID = mv.VendorID JOIN DetailPurchaseTransaction dpt ON
	hpt.PurchaseTransactionID = dpt.PurchaseTransactionID,
	(
		SELECT
			MAX(ItemQuantity) AS MaxQuantity
		FROM
			HeaderPurchaseTransaction hpt JOIN DetailPurchaseTransaction dpt
			ON hpt.PurchaseTransactionID = dpt.PurchaseTransactionID
		WHERE
			DATEDIFF(DAY, PurchaseTransactionDate, ArrivalDate) < 7
	) X
GROUP BY
	StaffName,
	VendorName,
	hpt.PurchaseTransactionID,
	PurchaseTransactionDate,
	X.MaxQuantity
HAVING
	SUM(ItemQuantity) > X.MaxQuantity

--8
SELECT TOP 2 DATENAME(WEEKDAY, hst.SalesTransactionDate) [Day], COUNT(dst.ItemID) [Item Sales Amount] 
FROM HeaderSalesTransaction hst
JOIN DetailSalesTransaction dst ON hst.SalesTransactionID = dst.SalesTransactionID
JOIN MsItem mi ON dst.ItemID = mi.ItemID, (
	SELECT AVG(mi.ItemPrice) [AvgPrice]
	FROM MsItem mi JOIN MsItemType mit ON mi.ItemTypeID = mit.ItemTypeID
	WHERE mit.ItemTypeName = 'Electronic' OR mit.ItemTypeName = 'Gadgets'
) AS x
WHERE mi.ItemPrice < x.AvgPrice
GROUP BY DATENAME(WEEKDAY, hst.SalesTransactionDate)
ORDER BY [Item Sales Amount] ASC

--9
GO
CREATE VIEW [Customer Statistic By Gender] AS
SELECT mc.CustomerGender, MAX(dst.ItemQuantity) [Maximum Sales], MIN(dst.ItemQuantity) [Minimum Sales]
FROM HeaderSalesTransaction hst
JOIN DetailSalesTransaction dst ON hst.SalesTransactionID = dst.SalesTransactionID
JOIN MsCustomer mc ON mc.CustomerID = hst.CustomerID
WHERE dst.ItemQuantity BETWEEN 10 AND 50 AND
	mc.CustomerDOB BETWEEN '01-01-1998' AND '12-31-1999'
GROUP BY mc.CustomerGender

--10
GO
CREATE VIEW [Item Type Statistic] AS
SELECT UPPER(mit.ItemTypeName) [ItemType], AVG(mi.ItemPrice) [Average Price],
		COUNT(mi.ItemID) [Number of Item Variety]
FROM MsItem mi JOIN MsItemType mit ON mi.ItemTypeID = mit.ItemTypeID
WHERE LEFT(mit.ItemTypeName, 1) = 'F' AND mi.MinimumItemPurchase > 5
GROUP BY mit.ItemTypeName