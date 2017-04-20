CREATE PROCEDURE PSA.[GetConnections]
AS
BEGIN
	SELECT	ConnectionName,
			ConnectionString
	FROM	PSA.Connections
END
