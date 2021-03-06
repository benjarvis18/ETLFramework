


CREATE VIEW [stg].[AdventureWorks_Sales_SalesOrderHeader]
AS
	SELECT	
		[SalesOrderID],	
		[RevisionNumber],	
		[OrderDate],	
		[DueDate],	
		[ShipDate],	
		[Status],	
		[OnlineOrderFlag],	
		[SalesOrderNumber],	
		[PurchaseOrderNumber],	
		[AccountNumber],	
		[CustomerID],	
		[SalesPersonID],	
		[TerritoryID],	
		[BillToAddressID],	
		[ShipToAddressID],	
		[ShipMethodID],	
		[CreditCardID],	
		[CreditCardApprovalCode],	
		[CurrencyRateID],	
		[SubTotal],	
		[TaxAmt],	
		[Freight],	
		[TotalDue],	
		[Comment],	
		[rowguid],	
		[ModifiedDate],	
		[ExtractDate]
	FROM	[psa].[AdventureWorks_Sales_SalesOrderHeader] PSA
			CROSS JOIN [stg].[PointInTime] PIT
	WHERE	PIT.CurrentPointInTime >= PSA.RowStartDateTime
			AND PIT.CurrentPointInTime < PSA.RowEndDateTime

GO
		
CREATE VIEW [stg].[AdventureWorks_Sales_SalesOrderDetail]
AS
	SELECT	
		[SalesOrderID],	
		[SalesOrderDetailID],	
		[CarrierTrackingNumber],	
		[OrderQty],	
		[ProductID],	
		[SpecialOfferID],	
		[UnitPrice],	
		[UnitPriceDiscount],	
		[LineTotal],	
		[rowguid],	
		[ModifiedDate],	
		[ExtractDate]
	FROM	[psa].[AdventureWorks_Sales_SalesOrderDetail] PSA
			CROSS JOIN [stg].[PointInTime] PIT
	WHERE	PIT.CurrentPointInTime >= PSA.RowStartDateTime
			AND PIT.CurrentPointInTime < PSA.RowEndDateTime

GO
		
