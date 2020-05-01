CREATE TABLE [dbo].[Client]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Description] VARCHAR(50) NULL, 
    [Identity] NVARCHAR(20) NOT NULL, 
    CONSTRAINT [IX_Client_Code] UNIQUE ([Identity])
)

GO
