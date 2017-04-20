-- LoadType
MERGE [Audit].[LoadType] AS target 
USING 
	(
		
		SELECT 1 AS LoadTypeId, 'Initial Load' AS LoadTypeName

		UNION ALL

		SELECT 2 AS LoadTypeId, 'Incremental Load' AS LoadTypeName	

	) AS source ON source.LoadTypeId = target.LoadTypeId
WHEN MATCHED THEN 
	UPDATE SET target.LoadTypeName = source.LoadTypeName
WHEN NOT MATCHED THEN
	INSERT (LoadTypeId, LoadTypeName)
	VALUES (source.LoadTypeId, source.LoadTypeName)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
;

-- LoadStatus
MERGE [Audit].[LoadStatus] AS target 
USING 
	(
		
		SELECT 1 AS LoadStatusId, 'Pending' AS LoadStatusName

		UNION ALL

		SELECT 2 AS LoadStatusId, 'In Progress' AS LoadStatusName		
		
		UNION ALL

		SELECT 3 AS LoadStatusId, 'Cancelled' AS LoadStatusName		
		
		UNION ALL

		SELECT 4 AS LoadStatusId, 'Failed' AS LoadStatusName		
		
		UNION ALL

		SELECT 5 AS LoadStatusId, 'Completed' AS LoadStatusName			
		
		UNION ALL

		SELECT 6 AS LoadStatusId, 'Completed with Errors' AS LoadStatusName			
		
		UNION ALL

		SELECT 7 AS LoadStatusId, 'Not Required' AS LoadStatusName	
				
	) AS source ON source.LoadStatusId = target.LoadStatusId
WHEN MATCHED THEN 
	UPDATE SET target.LoadStatusName = source.LoadStatusName
WHEN NOT MATCHED THEN
	INSERT (LoadStatusId, LoadStatusName)
	VALUES (source.LoadTypeId, source.LoadTypeName)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
;