CREATE TABLE PSA.[Connections]
(
	[ConnectionId] INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PSA_Connections PRIMARY KEY,
	ConnectionName VARCHAR(255) NOT NULL CONSTRAINT UQ_PSA_Connections_ConnectionName UNIQUE,
	ConnectionString VARCHAR(MAX) NOT NULL
)
