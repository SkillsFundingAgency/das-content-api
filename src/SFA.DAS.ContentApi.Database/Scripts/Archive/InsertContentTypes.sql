SET NOCOUNT ON;

PRINT 'Add content type(s) entry';

BEGIN TRAN;
BEGIN TRY

	IF OBJECT_ID('dbo.ContentType') IS NULL
	BEGIN;
		THROW 50000, 'The content type could not be added as the dbo.ContentType table does not exist', 1;
	END;

	IF NOT EXISTS(SELECT ID FROM [dbo].[ContentType] WHERE Id = 1)
	BEGIN
		SET IDENTITY_INSERT [dbo].[ContentType] ON
		INSERT INTO [dbo].[ContentType] ([Id], [Value])	SELECT 1, 'banner'
		SET IDENTITY_INSERT [dbo].[ContentType] OFF
		
		PRINT 'Banner content type entry added';
	END	

	IF NOT EXISTS(SELECT ID FROM [dbo].[ContentType] WHERE Id = 2)
	BEGIN
		SET IDENTITY_INSERT [dbo].[ContentType] ON
		INSERT INTO [dbo].[ContentType] ([Id], [Value])	SELECT 2, 'covid_section'
		SET IDENTITY_INSERT [dbo].[ContentType] OFF

		PRINT 'Covid Section content type entry added';
	END	

	COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Content type entry NOT added see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
