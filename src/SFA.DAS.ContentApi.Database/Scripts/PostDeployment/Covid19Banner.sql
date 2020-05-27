SET NOCOUNT ON;

PRINT 'Add Covid 19 banner entry';

BEGIN TRAN;
BEGIN TRY

	IF OBJECT_ID('dbo.Content') IS NULL
	BEGIN;
		THROW 50000, 'The banner could not be added as the dbo.Content table does not exist', 1;
	END;

	IF OBJECT_ID('dbo.ApplicationContent') IS NULL
	BEGIN;
		THROW 50000, 'The banner could not be added as the dbo.ApplicationContent table does not exist', 1;
	END;

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 1)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 1, 1, '<div class="das-notification"><p class="das-notification__heading govuk-!-margin-bottom-0">Coronavirus(COVID-19): <a href = "https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response/coronavirus-covid-19-guidance-for-apprentices-employers-training-providers-end-point-assessment-organisations-and-external-quality-assurance-pro" target="_blank" class="govuk-link">read our guidance</a> on the changes we''re making to help your apprentices continue learning or <a href="https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/360009509360-Pause-or-stop-an-apprenticeship" target="_blank" class="govuk-link">find out how you can pause your apprenticeships</a>.</p></div>'		
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 1, 1, 1
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 banner entry added';
	END	

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 2)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 2, 1, '<div class="info-summary"><h2 class="heading-medium">Coronavirus (COVID-19): <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response/coronavirus-covid-19-guidance-for-apprentices-employers-training-providers-end-point-assessment-organisations-and-external-quality-assurance-pro" target="_blank">read our guidance</a> on the changes we''re making to help your apprentices continue learning or <a href="https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/360009509360-Pause-or-stop-an-apprenticeship" target="_blank">find out how you can pause your apprenticeships</a>.</h2></div>'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 2, 2, 2
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 legacy banner entry added';
	END	
	
	COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Covid 19 entry NOT added see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
