SET NOCOUNT ON;

PRINT 'Update PAS banner to blank to not display';

BEGIN TRAN;
BEGIN TRY
	UPDATE [dbo].[Content]
	SET [Data]= ''
	WHERE [Id] = 3		
	
	UPDATE [dbo].[Content]
	SET [Data]= ''
	WHERE [Id] = 4	
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'PAS Banner not removed, see error info';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
