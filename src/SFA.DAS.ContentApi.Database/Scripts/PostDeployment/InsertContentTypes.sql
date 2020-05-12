/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

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

		COMMIT TRAN;
		PRINT 'Banner content type entry added';
	END	

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Content type entry NOT added see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
