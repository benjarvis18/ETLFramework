CREATE PROCEDURE stg.[SetCurrentPointInTime]
	@PointInTime DATETIME2
AS
BEGIN
	UPDATE	stg.PointInTime
	SET		CurrentPointInTime = @PointInTime
END
