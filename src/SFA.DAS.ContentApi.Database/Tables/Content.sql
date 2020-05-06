CREATE TABLE [dbo].[Content]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [ContentTypeId] INT NOT NULL, 
    [Content] VARCHAR(MAX) NULL, 
    [StartDate] DATETIME NOT NULL, 
    [EndDate] DATETIME NOT NULL, 
    [Active] BIT NOT NULL DEFAULT 1, 
    CONSTRAINT [FK_Content_ContentType] FOREIGN KEY ([ContentTypeId]) REFERENCES [ContentType]([Id])
)
