﻿CREATE TABLE [dbo].[ContentType]
(
	[Id] BIGINT NOT NULL IDENTITY, 
    [Value] VARCHAR(20) NOT NULL,
	CONSTRAINT [PK_ContentType] PRIMARY KEY CLUSTERED ([Id] ASC)
)
