CREATE TABLE [dbo].[ApplicationContent]
(
	[Id] BIGINT NOT NULL IDENTITY, 
    [ContentId] BIGINT NOT NULL, 
    [ApplicationId] BIGINT NOT NULL,
    CONSTRAINT [PK_ApplicationContent] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ApplicationContent_Content] FOREIGN KEY ([ContentId]) REFERENCES [Content]([Id]),
    CONSTRAINT [FK_ApplicationContent_Application] FOREIGN KEY ([ApplicationId]) REFERENCES [Application]([Id]),
    CONSTRAINT [UQ_ApplicationContent_ContentApplication] UNIQUE ([ContentId], [ApplicationId])
)
