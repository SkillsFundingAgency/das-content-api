CREATE TABLE [dbo].[ClientScope]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [ContentId] INT NOT NULL, 
    [ClientId] INT NOT NULL,
    CONSTRAINT [FK_ClientScope_Content] FOREIGN KEY ([ContentId]) REFERENCES [Content]([Id]),
    CONSTRAINT [FK_ClientScope_Client] FOREIGN KEY ([ClientId]) REFERENCES [Client]([Id])
)
