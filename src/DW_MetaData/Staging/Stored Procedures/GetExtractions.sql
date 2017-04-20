CREATE PROCEDURE Staging.[GetExtractions]
AS
BEGIN
	SELECT	E.ExtractionId,
			SourceConnection.ConnectionName AS SourceConnectionName ,
			SourceConnection.ConnectionString AS SourceConnectionString,
			E.SourceSchema ,
			E.SourceTableName ,
			E.SourceSqlQuery,
			TargetConnection.ConnectionName AS TargetConnectionName ,
			TargetConnection.ConnectionString AS TargetConnectionString,
			E.TargetSchema ,
			E.TargetTableName
	FROM	Staging.Extractions AS E 
			INNER JOIN Staging.Connections AS SourceConnection ON SourceConnection.ConnectionId = E.SourceConnectionId
			INNER JOIN Staging.Connections AS TargetConnection ON TargetConnection.ConnectionId = E.TargetConnectionId
END
