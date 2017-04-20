﻿/*
Deployment script for DW_PSA

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DW_Staging "DW_Staging"
:setvar DatabaseName "DW_PSA"
:setvar DefaultFilePrefix "DW_PSA"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Altering [stg].[AdventureWorks_Sales_SalesOrderDetail]...';


GO
		
ALTER VIEW [stg].[AdventureWorks_Sales_SalesOrderDetail]
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
PRINT N'Altering [stg].[AdventureWorks_Sales_SalesOrderHeader]...';


GO



ALTER VIEW [stg].[AdventureWorks_Sales_SalesOrderHeader]
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
PRINT N'Creating [psa].[Load_AdventureWorks_Sales_SalesOrderDetail]...';


GO
CREATE PROCEDURE psa.[Load_AdventureWorks_Sales_SalesOrderDetail]
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

			UPDATE	PSA
			SET		PSA.RowIsCurrent = 0,
					PSA.RowEndDateTime = L.ExtractDate			
			FROM	[psa].[AdventureWorks_Sales_SalesOrderDetail] AS PSA
					INNER JOIN loading.[AdventureWorks_Sales_SalesOrderDetail] AS L ON L.SalesOrderDetailID = PSA.SalesOrderDetailID AND L.SalesOrderID = PSA.SalesOrderID			
			WHERE	PSA.RowIsCurrent = 1
					AND 
					(
						PSA.[CarrierTrackingNumber] <> L.[CarrierTrackingNumber]
						OR PSA.[OrderQty] <> L.[OrderQty]
						OR PSA.[ProductID] <> L.[ProductID]
						OR PSA.[SpecialOfferID] <> L.[SpecialOfferID]
						OR PSA.[UnitPrice] <> L.[UnitPrice]
						OR PSA.[UnitPriceDiscount] <> L.[UnitPriceDiscount]
						OR PSA.[LineTotal] <> L.[LineTotal]
						OR PSA.[rowguid] <> L.[rowguid]
						OR PSA.[ModifiedDate] <> L.[ModifiedDate]
						OR PSA.[ExtractDate] <> L.[ExtractDate]
						)
					

			INSERT INTO [psa].[AdventureWorks_Sales_SalesOrderDetail]
				(	
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
					[ExtractDate],
					RowStartDateTime ,
					RowEndDateTime ,
					RowIsCurrent
				)
			SELECT	L.[SalesOrderID],
					L.[SalesOrderDetailID],
					L.[CarrierTrackingNumber],
					L.[OrderQty],
					L.[ProductID],
					L.[SpecialOfferID],
					L.[UnitPrice],
					L.[UnitPriceDiscount],
					L.[LineTotal],
					L.[rowguid],
					L.[ModifiedDate],
					L.[ExtractDate],
					L.ExtractDate AS RowStartDateTime,
					'9999-12-31' AS RowEndDateTime,
					1 AS RowIsCurrent
			FROM	loading.[AdventureWorks_Sales_SalesOrderDetail] AS L

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRAN
	
	    DECLARE @ErrorMessage NVARCHAR(4000);
	    DECLARE @ErrorSeverity INT;
	    DECLARE @ErrorState INT;
	
	    SELECT 	@ErrorMessage = ERROR_MESSAGE() ,
		        @ErrorSeverity = ERROR_SEVERITY() ,
		        @ErrorState = ERROR_STATE();
	
	    RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState );
	END CATCH
END
GO
PRINT N'Creating [psa].[Load_AdventureWorks_Sales_SalesOrderHeader]...';


GO



CREATE PROCEDURE psa.[Load_AdventureWorks_Sales_SalesOrderHeader]
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

			UPDATE	PSA
			SET		PSA.RowIsCurrent = 0,
					PSA.RowEndDateTime = L.ExtractDate			
			FROM	[psa].[AdventureWorks_Sales_SalesOrderHeader] AS PSA
					INNER JOIN loading.[AdventureWorks_Sales_SalesOrderHeader] AS L ON L.SalesOrderID = PSA.SalesOrderID			
			WHERE	PSA.RowIsCurrent = 1
					AND 
					(
						PSA.[RevisionNumber] <> L.[RevisionNumber]
						OR PSA.[OrderDate] <> L.[OrderDate]
						OR PSA.[DueDate] <> L.[DueDate]
						OR PSA.[ShipDate] <> L.[ShipDate]
						OR PSA.[Status] <> L.[Status]
						OR PSA.[OnlineOrderFlag] <> L.[OnlineOrderFlag]
						OR PSA.[SalesOrderNumber] <> L.[SalesOrderNumber]
						OR PSA.[PurchaseOrderNumber] <> L.[PurchaseOrderNumber]
						OR PSA.[AccountNumber] <> L.[AccountNumber]
						OR PSA.[CustomerID] <> L.[CustomerID]
						OR PSA.[SalesPersonID] <> L.[SalesPersonID]
						OR PSA.[TerritoryID] <> L.[TerritoryID]
						OR PSA.[BillToAddressID] <> L.[BillToAddressID]
						OR PSA.[ShipToAddressID] <> L.[ShipToAddressID]
						OR PSA.[ShipMethodID] <> L.[ShipMethodID]
						OR PSA.[CreditCardID] <> L.[CreditCardID]
						OR PSA.[CreditCardApprovalCode] <> L.[CreditCardApprovalCode]
						OR PSA.[CurrencyRateID] <> L.[CurrencyRateID]
						OR PSA.[SubTotal] <> L.[SubTotal]
						OR PSA.[TaxAmt] <> L.[TaxAmt]
						OR PSA.[Freight] <> L.[Freight]
						OR PSA.[TotalDue] <> L.[TotalDue]
						OR PSA.[Comment] <> L.[Comment]
						OR PSA.[rowguid] <> L.[rowguid]
						OR PSA.[ModifiedDate] <> L.[ModifiedDate]
						OR PSA.[ExtractDate] <> L.[ExtractDate]
						)
					

			INSERT INTO [psa].[AdventureWorks_Sales_SalesOrderHeader]
				(	
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
					[ExtractDate],
					RowStartDateTime ,
					RowEndDateTime ,
					RowIsCurrent
				)
			SELECT	L.[SalesOrderID],
					L.[RevisionNumber],
					L.[OrderDate],
					L.[DueDate],
					L.[ShipDate],
					L.[Status],
					L.[OnlineOrderFlag],
					L.[SalesOrderNumber],
					L.[PurchaseOrderNumber],
					L.[AccountNumber],
					L.[CustomerID],
					L.[SalesPersonID],
					L.[TerritoryID],
					L.[BillToAddressID],
					L.[ShipToAddressID],
					L.[ShipMethodID],
					L.[CreditCardID],
					L.[CreditCardApprovalCode],
					L.[CurrencyRateID],
					L.[SubTotal],
					L.[TaxAmt],
					L.[Freight],
					L.[TotalDue],
					L.[Comment],
					L.[rowguid],
					L.[ModifiedDate],
					L.[ExtractDate],
					L.ExtractDate AS RowStartDateTime,
					'9999-12-31' AS RowEndDateTime,
					1 AS RowIsCurrent
			FROM	loading.[AdventureWorks_Sales_SalesOrderHeader] AS L

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRAN
	
	    DECLARE @ErrorMessage NVARCHAR(4000);
	    DECLARE @ErrorSeverity INT;
	    DECLARE @ErrorState INT;
	
	    SELECT 	@ErrorMessage = ERROR_MESSAGE() ,
		        @ErrorSeverity = ERROR_SEVERITY() ,
		        @ErrorState = ERROR_STATE();
	
	    RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState );
	END CATCH
END
GO
PRINT N'Update complete.';


GO
