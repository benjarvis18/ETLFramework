CREATE TABLE [Staging].[UniqueColumns]
(
	[UniqueColumnId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Staging_UniqueColumns PRIMARY KEY,
	[ExtractionId] INT NOT NULL CONSTRAINT FK_Staging_UniqueColumns_Staging_Extractions FOREIGN KEY REFERENCES Staging.Extractions(ExtractionId),
	[ColumnName] sysname NOT NULL,
	CONSTRAINT UQ_Staging_UniqueColumns_ExtractionId_ColumnName UNIQUE (ExtractionId, ColumnName)
)
