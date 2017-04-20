CREATE TABLE [PSA].[UniqueColumns]
(
	[UniqueColumnId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PSA_UniqueColumns PRIMARY KEY,
	[ExtractionId] INT NOT NULL CONSTRAINT FK_PSA_UniqueColumns_PSA_Extractions FOREIGN KEY REFERENCES PSA.Extractions(ExtractionId),
	[ColumnName] sysname NOT NULL,
	CONSTRAINT UQ_PSA_UniqueColumns_ExtractionId_ColumnName UNIQUE (ExtractionId, ColumnName)
)
