CREATE TABLE [dbo].[ApplicationContent]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [ContentId] INT NOT NULL, 
    [ApplicationId] INT NOT NULL,
    CONSTRAINT [FK_ApplicationContent_Content] FOREIGN KEY ([ContentId]) REFERENCES [Content]([Id]),
    CONSTRAINT [FK_ApplicationContent_Application] FOREIGN KEY ([ApplicationId]) REFERENCES [Application]([Id]),
    CONSTRAINT [UQ_ApplicationContent_ContentApplication] UNIQUE ([ContentId],[ApplicationId])
)
