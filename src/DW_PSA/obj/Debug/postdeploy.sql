﻿IF NOT EXISTS ( SELECT 1 FROM stg.PointInTime )
	INSERT INTO stg.PointInTime
	VALUES ( GETDATE() )
GO