


CREATE TABLE [psa].[AdventureWorks_Sales_SalesOrderHeader]
(
	RowId INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_psa_AdventureWorks_Sales_SalesOrderHeader PRIMARY KEY,
		[SalesOrderID] int NOT NULL,	
		[RevisionNumber] tinyint NOT NULL,	
		[OrderDate] datetime NOT NULL,	
		[DueDate] datetime NOT NULL,	
		[ShipDate] datetime NULL,	
		[Status] tinyint NOT NULL,	
		[OnlineOrderFlag] bit NOT NULL,	
		[SalesOrderNumber] nvarchar(25) NOT NULL,	
		[PurchaseOrderNumber] nvarchar(25) NULL,	
		[AccountNumber] nvarchar(15) NULL,	
		[CustomerID] int NOT NULL,	
		[SalesPersonID] int NULL,	
		[TerritoryID] int NULL,	
		[BillToAddressID] int NOT NULL,	
		[ShipToAddressID] int NOT NULL,	
		[ShipMethodID] int NOT NULL,	
		[CreditCardID] int NULL,	
		[CreditCardApprovalCode] varchar(15) NULL,	
		[CurrencyRateID] int NULL,	
		[SubTotal] money NOT NULL,	
		[TaxAmt] money NOT NULL,	
		[Freight] money NOT NULL,	
		[TotalDue] money NOT NULL,	
		[Comment] nvarchar(128) NULL,	
		[rowguid] uniqueidentifier NOT NULL,	
		[ModifiedDate] datetime NOT NULL,	
		[ExtractDate] datetime2(7) NOT NULL,	
		[RowStartDateTime] DATETIME2 NOT NULL,
	[RowEndDateTime] DATETIME2 NOT NULL,
	[RowIsCurrent] BIT NOT NULL
)
GO
		
CREATE TABLE [psa].[AdventureWorks_Sales_SalesOrderDetail]
(
	RowId INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_psa_AdventureWorks_Sales_SalesOrderDetail PRIMARY KEY,
		[SalesOrderID] int NOT NULL,	
		[SalesOrderDetailID] int NOT NULL,	
		[CarrierTrackingNumber] nvarchar(25) NULL,	
		[OrderQty] smallint NOT NULL,	
		[ProductID] int NOT NULL,	
		[SpecialOfferID] int NOT NULL,	
		[UnitPrice] money NOT NULL,	
		[UnitPriceDiscount] money NOT NULL,	
		[LineTotal] numeric(38,6) NOT NULL,	
		[rowguid] uniqueidentifier NOT NULL,	
		[ModifiedDate] datetime NOT NULL,	
		[ExtractDate] datetime2(7) NOT NULL,	
		[RowStartDateTime] DATETIME2 NOT NULL,
	[RowEndDateTime] DATETIME2 NOT NULL,
	[RowIsCurrent] BIT NOT NULL
)
GO
		
