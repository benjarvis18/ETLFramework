CREATE TABLE PSA.[Extractions]
(
	[ExtractionId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PSA_Extractions PRIMARY KEY,
	[SourceConnectionId] INT NOT NULL CONSTRAINT FK_PSA_Extractions_PSA_Connections_SourceConnectionId FOREIGN KEY REFERENCES PSA.Connections(ConnectionId),
	[SourceSchema] sysname NULL,
	[SourceTableName] sysname NULL,
	[SourceSqlQuery] VARCHAR(MAX) NULL,
	[TargetConnectionId] INT NOT NULL CONSTRAINT FK_PSA_Extractions_PSA_Connections_TargetConnectionId FOREIGN KEY REFERENCES PSA.Connections(ConnectionId),
	[TargetSchema] sysname NOT NULL,
	[TargetTableName] sysname NOT NULL,	
	CONSTRAINT CK_PSA_Extractions_TableOrQuerySpecified CHECK ( (SourceSchema IS NOT NULL AND SourceTableName IS NOT NULL ) OR SourceSqlQuery IS NOT NULL),
	CONSTRAINT UQ_PSA_Extractions_SourceConnectionId_SourceSchema_SourceTableName UNIQUE (SourceConnectionId, SourceSchema, SourceTableName)
)
