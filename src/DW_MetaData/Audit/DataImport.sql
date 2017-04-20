CREATE TABLE [Audit].[DataImport]
(
	[DataImportId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Audit_DataImport PRIMARY KEY,
	[LoadId] INT NOT NULL CONSTRAINT FK_Audit_DataImport_Audit_Load FOREIGN KEY REFERENCES [Audit].[Load](LoadId),

)
