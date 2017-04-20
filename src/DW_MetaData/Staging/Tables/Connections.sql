CREATE TABLE [Staging].[Connections]
(
	[ConnectionId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Staging_Connections PRIMARY KEY,
	ConnectionName VARCHAR(255) NOT NULL CONSTRAINT UQ_Staging_Connections_ConnectionName UNIQUE,
	ConnectionString VARCHAR(MAX) NOT NULL
)
