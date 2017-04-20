CREATE TABLE [Audit].[Load]
(
	[LoadId] INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Audit_Load PRIMARY KEY,
	[LoadTypeId] INT NOT NULL CONSTRAINT FK_Audit_Load_Audit_LoadType FOREIGN KEY REFERENCES [Audit].[LoadType](LoadTypeId),
	[LoadStatusId] INT NOT NULL CONSTRAINT FK_Audit_Load_Audit_LoadStatus FOREIGN KEY REFERENCES [Audit].[LoadStatus](LoadStatusId),
	[PointInTimeValue] DATETIME2 NOT NULL,
	[StartDateTime] DATETIME2 NULL,
	[EndDateTime] DATETIME2 NULL,
	CONSTRAINT CK_Audit_Load_EndDateTime_GreaterThanOrEqualTo_StartDateTime CHECK (EndDateTime >= StartDateTime)
)
