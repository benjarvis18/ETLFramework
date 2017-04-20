CREATE PROCEDURE Staging.[GetConnections]
AS
BEGIN
	SELECT	ConnectionName,
			ConnectionString
	FROM	Staging.Connections
END
