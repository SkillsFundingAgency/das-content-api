CREATE TABLE [dbo].[Application]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Description] VARCHAR(50) NULL, 
    [Identity] VARCHAR(20) NOT NULL, 
    CONSTRAINT [UQ_Application_Identity] UNIQUE ([Identity])
)

GO
