CREATE PROCEDURE [Staging].[GetUniqueColumns]
	@ExtractionId INT
AS
BEGIN
	SELECT	ColumnName
	FROM	PSA.UniqueColumns
	WHERE	ExtractionId = @ExtractionId
END
