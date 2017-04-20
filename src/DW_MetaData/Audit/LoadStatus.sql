CREATE TABLE [Audit].[LoadStatus]
(
	[LoadStatusId] INT NOT NULL CONSTRAINT PK_Audit_LoadStatus PRIMARY KEY,
	[LoadStatusName] VARCHAR(255) NOT NULL CONSTRAINT UQ_Audit_LoadStatus_LoadStatusName UNIQUE
)
