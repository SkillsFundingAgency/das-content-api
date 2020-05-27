CREATE TABLE [dbo].[Content]
(
	[Id] BIGINT NOT NULL IDENTITY, 
    [ContentTypeId] BIGINT NOT NULL, 
    [Data] VARCHAR(MAX) NULL, 
    [StartDate] DATETIME NULL, 
    [EndDate] DATETIME NULL, 
    [Active] BIT NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Content_ContentType] FOREIGN KEY ([ContentTypeId]) REFERENCES [ContentType]([Id])
)
