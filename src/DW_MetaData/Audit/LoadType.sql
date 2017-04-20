CREATE TABLE [Audit].[LoadType]
(
	[LoadTypeId] INT NOT NULL CONSTRAINT PK_Audit_LoadType PRIMARY KEY,
	[LoadTypeName] VARCHAR(255) NOT NULL CONSTRAINT UQ_Audit_LoadType_LoadTypeName UNIQUE
)
