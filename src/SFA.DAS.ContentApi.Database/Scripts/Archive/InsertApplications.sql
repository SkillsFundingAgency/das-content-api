SET NOCOUNT ON;

PRINT 'Add application(s) entry';

BEGIN TRAN;
BEGIN TRY

	IF OBJECT_ID('dbo.Application') IS NULL
	BEGIN;
		THROW 50000, 'The application could not be added as the dbo.Application table does not exist', 1;
	END;

	IF NOT EXISTS(SELECT ID FROM [dbo].[Application] WHERE Id = 1)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Application] ON
		INSERT INTO [dbo].[Application] ([Id], [Description], [Identity]) SELECT 1, 'Employer Apprenticeship Service', 'das-employeraccounts-web'
		SET IDENTITY_INSERT [dbo].[Application] OFF
		
		PRINT 'Employer Apprenticeship Service application entry added';
	END	

	IF NOT EXISTS(SELECT ID FROM [dbo].[Application] WHERE Id = 2)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Application] ON
		INSERT INTO [dbo].[Application] ([Id], [Description], [Identity]) SELECT 2, 'Employer Apprenticeship Service (Legacy)', 'das-employeraccounts-web-legacy'
		SET IDENTITY_INSERT [dbo].[Application] OFF

		PRINT 'Employer Apprenticeship Service (Legacy) application entry added';
	END

	IF NOT EXISTS(SELECT ID FROM [dbo].[Application] WHERE Id = 3)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Application] ON
		INSERT INTO [dbo].[Application] ([Id], [Description], [Identity]) SELECT 3, 'Provider Apprenticeship Service', 'das-providerapprenticeshipsservice-web'
		SET IDENTITY_INSERT [dbo].[Application] OFF

		PRINT 'Provider Apprenticeship Service application entry added';
	END
	
	IF NOT EXISTS(SELECT ID FROM [dbo].[Application] WHERE Id = 4)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Application] ON
		INSERT INTO [dbo].[Application] ([Id], [Description], [Identity]) SELECT 4, 'Provider Apprenticeship Service (Legacy)', 'das-providerapprenticeshipsservice-web-legacy'
		SET IDENTITY_INSERT [dbo].[Application] OFF

		PRINT 'Provider Apprenticeship Service (Legacy) application entry added';
	END	
	
	COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Application entry NOT added see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
