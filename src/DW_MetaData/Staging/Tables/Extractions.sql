CREATE TABLE [Staging].[Extractions]
(
	[ExtractionId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Staging_Extractions PRIMARY KEY,
	[SourceConnectionId] INT NOT NULL CONSTRAINT FK_Staging_Extractions_Staging_Connections_SourceConnectionId FOREIGN KEY REFERENCES Staging.Connections(ConnectionId),
	[SourceSchema] sysname NULL,
	[SourceTableName] sysname NULL,
	[SourceSqlQuery] VARCHAR(MAX) NULL,
	[TargetConnectionId] INT NOT NULL CONSTRAINT FK_Staging_Extractions_Staging_Connections_TargetConnectionId FOREIGN KEY REFERENCES Staging.Connections(ConnectionId),
	[TargetSchema] sysname NOT NULL,
	[TargetTableName] sysname NOT NULL,
	CONSTRAINT CK_Staging_Extractions_TableOrQuerySpecified CHECK ( (SourceSchema IS NOT NULL AND SourceTableName IS NOT NULL ) OR SourceSqlQuery IS NOT NULL),
	CONSTRAINT UQ_Staging_Extractions_SourceConnectionId_SourceSchema_SourceTableName UNIQUE (SourceConnectionId, SourceSchema, SourceTableName)
)
