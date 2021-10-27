CREATE DATABASE bEJibun
USE bEJibun

-- DROP DATABASE bEJibun

-- create master customer table
CREATE TABLE MsCustomer(
    CustomerID CHAR(5) NOT NULL,
    CustomerName VARCHAR(MAX) NOT NULL,
    CustomerGender VARCHAR(20) NOT NULL,
    CustomerPhone CHAR(12) NOT NULL,
    CustomerDOB DATE NOT NULL,

    CONSTRAINT CustomerPK PRIMARY KEY(CustomerID),

    CONSTRAINT CustomerID_check CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
    CONSTRAINT CustomerGender_check CHECK(CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female'),
    CONSTRAINT CustomerPhone_check CHECK(ISNUMERIC(CustomerPhone) = 1 AND CustomerPhone LIKE '08%'),
    -- date format: mm-dd-yyyy
    CONSTRAINT CustomerDOB_check CHECK(DATEDIFF(DAY, '01-01-1990', CustomerDOB) > 0 AND
									   DATEDIFF(DAY, GETDATE(), CustomerDOB) < 0)
)

-- create master staff table
CREATE TABLE MsStaff (
    StaffID CHAR(5) NOT NULL,
    StaffName VARCHAR(MAX) NOT NULL,
    StaffGender VARCHAR(20) NOT NULL,
    StaffPhone CHAR(12) NOT NULL,
    StaffSalary INTEGER NOT null,

    CONSTRAINT staffID_pk PRIMARY KEY(StaffID),

    CONSTRAINT StaffID_check CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]'),
    CONSTRAINT StaffGender_check CHECK(StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),
    CONSTRAINT StaffPhone_check CHECK(ISNUMERIC(staffPhone) = 1 AND StaffPhone LIKE '08%'),
    CONSTRAINT StaffSalary_check CHECK(StaffSalary > 0)
)

-- create master vendor table
CREATE TABLE MsVendor (
    VendorID CHAR(5) NOT NULL,
    VendorName VARCHAR(MAX) NOT NULL,
    VendorPhone CHAR(12) NOT NULL,
    VendorAddress VARCHAR(MAX) NOT NULL,
    VendorEmail VARCHAR(MAX) NOT NULL,

    CONSTRAINT VendorID_pk PRIMARY KEY(VendorID),

    constraint VendorID_check CHECK(VendorID LIKE 'VE[0-9][0-9][0-9]'),
    CONSTRAINT VendorPhone_check CHECK(ISNUMERIC(VendorPhone) = 1 AND VendorPhone LIKE '08%'),
    CONSTRAINT VendorAddress_check CHECK(VendorAddress LIKE '% Street'),
    --CONSTRAINT VendorEmail_check CHECK(VendorEmail LIKE '%.com' AND VendorEmail NOT LIKE '@%' AND VendorEmail LIKE '%@%' AND VendorEmail NOT LIKE '%@.com%')
	CONSTRAINT VendorEmail_check CHECK(CHARINDEX('@', VendorEmail) > 1 AND 
									   CHARINDEX('moc.', REVERSE(VendorEmail)) = 1 AND
									   CHARINDEX('.com', VendorEmail) - CHARINDEX('@', VendorEmail) >= 2)
)

-- create master item type table
CREATE TABLE MsItemType(
    ItemTypeID CHAR(5) NOT NULL,
    ItemTypeName VARCHAR(MAX) NOT NULL,
    
    CONSTRAINT ItemTypeID_pk PRIMARY KEY(ItemTypeID),

    CONSTRAINT ItemTypeID_check CHECK(ItemTypeID LIKE 'IP[0-9][0-9][0-9]'),
	CONSTRAINT ItemTypeName_check CHECK(LEN(ItemTypeName) >= 4)
)

-- create master item table
CREATE TABLE MsItem (
    ItemID CHAR(5) NOT NULL,
    ItemName VARCHAR(MAX) NOT NULL,
    ItemPrice INTEGER NOT NULL,
    MinimumItemPurchase INTEGER NOT NULL,
    ItemTypeID CHAR(5) NOT NULL,

    CONSTRAINT ItemID_pk PRIMARY KEY(ItemID),
    CONSTRAINT ItemTypeID_fk FOREIGN KEY(ItemTypeID) REFERENCES MsItemType(ItemTypeID) ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT ItemID_check CHECK(ItemID LIKE 'IT[0-9][0-9][0-9]'),
    CONSTRAINT ItemPrice_check CHECK(ItemPrice > 0),
    CONSTRAINT MinimumItemPurchase_check CHECK(MinimumItemPurchase > 0)
)

-- create header sales
CREATE TABLE HeaderSalesTransaction(
	SalesTransactionID CHAR(5) NOT NULL PRIMARY KEY,
	StaffID CHAR(5) REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID CHAR(5) REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	SalesTransactionDate DATE NOT NULL,

	CONSTRAINT SalesTransactionID_Check CHECK(SalesTransactionID LIKE 'SA[0-9][0-9][0-9]'),
)

-- create detail sales
CREATE TABLE DetailSalesTransaction(
	SalesTransactionID CHAR(5) REFERENCES HeaderSalesTransaction(SalesTransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ItemID CHAR(5) REFERENCES MsItem(ItemID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ItemQuantity INT NOT NULL

	CONSTRAINT PK_DetailSales PRIMARY KEY(SalesTransactionID, ItemID)
)

-- create header purchase
CREATE TABLE HeaderPurchaseTransaction(
	PurchaseTransactionID CHAR(5) NOT NULL PRIMARY KEY,
	StaffID CHAR(5) REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	VendorID CHAR(5) REFERENCES MsVendor(VendorID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PurchaseTransactionDate DATE NOT NULL,
	ArrivalDate DATE,

	CONSTRAINT PurchaseTransactionID_Check CHECK(PurchaseTransactionID LIKE 'PH[0-9][0-9][0-9]'),
)

-- create detail purchase
CREATE TABLE DetailPurchaseTransaction(
	PurchaseTransactionID CHAR(5) NOT NULL,
	ItemID CHAR(5) REFERENCES MsItem(ItemID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ItemQuantity INT NOT NULL

	CONSTRAINT PK_DetailPurchase PRIMARY KEY(PurchaseTransactionID, ItemID)
)