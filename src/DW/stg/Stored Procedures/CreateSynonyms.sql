CREATE PROCEDURE [stg].[CreateSynonyms]
	@UsePSA BIT
AS
BEGIN
	DECLARE @DBName sysname

	IF @UsePSA = 1 
		SET @DBName = 'DW_PSA'
	ELSE IF @UsePSA = 0
		SET @DBName = 'DW_Staging'	
	

	DECLARE @SqlStatement VARCHAR(MAX) = ''

	SELECT	@SqlStatement += 'IF OBJECT_ID(''[' + E.TargetSchema + '].[' + E.TargetTableName + ']'') IS NOT NULL DROP SYNONYM [' + E.TargetSchema + '].[' + E.TargetTableName + '];' + 
			'CREATE SYNONYM [' + E.TargetSchema + '].[' + E.TargetTableName + '] FOR [' + @DBName + '].[' + E.TargetSchema + '].[' + E.TargetTableName + '];'
	FROM	[$(DW_MetaData)].[Staging].[Extractions] AS E
	
	EXEC (@SqlStatement)
END
