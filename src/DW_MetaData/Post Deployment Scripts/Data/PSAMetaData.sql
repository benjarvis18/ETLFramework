TRUNCATE TABLE PSA.UniqueColumns

-- Connections
MERGE PSA.Connections AS target 
USING 
	(
		SELECT	'Target_PSADatabase' AS ConnectionName,
				'Data Source=(local);Persist Security Info=true;Integrated Security=SSPI;Initial Catalog=DW_PSA' AS ConnectionString

		UNION ALL

		SELECT	'Source_StagingDatabase' AS ConnectionName,
				'Data Source=(local);Persist Security Info=true;Integrated Security=SSPI;Initial Catalog=DW_Staging' AS ConnectionString
	) AS source ON source.ConnectionName = target.ConnectionName
WHEN MATCHED THEN 
	UPDATE SET target.ConnectionString = source.ConnectionString
WHEN NOT MATCHED THEN
	INSERT (ConnectionName, ConnectionString)
	VALUES (source.ConnectionName, source.ConnectionString)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
;

-- Extractions
DECLARE @SourceConnectionId INT = ( SELECT ConnectionId FROM PSA.Connections AS C WHERE C.ConnectionName = 'Source_StagingDatabase' )
DECLARE @TargetConnectionId INT = ( SELECT ConnectionId FROM PSA.Connections AS C WHERE C.ConnectionName = 'Target_PSADatabase' )

MERGE PSA.Extractions AS target 
USING 
	(
		SELECT	@SourceConnectionId AS SourceConnectionId,
				E.TargetSchema AS SourceSchema,
				E.TargetTableName AS SourceTableName,		
				@TargetConnectionId AS TargetConnectionId,
				'psa' AS TargetSchema,
				E.TargetTableName AS TargetTableName
		FROM	Staging.Extractions AS E
				INNER JOIN Staging.Connections AS C ON C.ConnectionId = E.TargetConnectionId
	) AS source ON source.SourceConnectionId = target.SourceConnectionId
					AND source.SourceSchema = target.SourceSchema
					AND source.SourceTableName = target.TargetTableName
WHEN MATCHED THEN 
	UPDATE SET	target.TargetConnectionId = source.TargetConnectionId,
				target.TargetSchema = source.TargetSchema,
				target.TargetTableName = source.TargetTableName				
WHEN NOT MATCHED THEN
	INSERT (SourceConnectionId, SourceSchema, SourceTableName, TargetConnectionId, TargetSchema, TargetTableName)
	VALUES (source.SourceConnectionId, source.SourceSchema, source.SourceTableName, source.TargetConnectionId, source.TargetSchema, source.TargetTableName)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
;

INSERT INTO PSA.UniqueColumns
        ( ExtractionId, ColumnName )
	SELECT	PSA.ExtractionId,
			UC.ColumnName
	FROM	PSA.Extractions AS PSA
			INNER JOIN Staging.Extractions AS Staging ON PSA.SourceSchema = Staging.TargetSchema 
															AND PSA.SourceTableName = Staging.TargetTableName
			INNER JOIN Staging.UniqueColumns AS UC ON UC.ExtractionId = Staging.ExtractionId

GO

