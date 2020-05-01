CREATE TABLE [dbo].[Content]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [ContentTypeId] INT NOT NULL, 
    [Content] TEXT NULL, 
    [StartDate] DATETIME NOT NULL, 
    [EndDate] DATETIME NOT NULL, 
    CONSTRAINT [FK_Content_ContentType] FOREIGN KEY ([ContentTypeId]) REFERENCES [ContentType]([Id])
)
