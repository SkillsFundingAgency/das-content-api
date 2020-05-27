CREATE TABLE [dbo].[Application]
(
	[Id] BIGINT NOT NULL IDENTITY, 
    [Description] VARCHAR(100) NULL, 
    [Identity] VARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Application] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_Application_Identity] UNIQUE ([Identity])
)

GO
