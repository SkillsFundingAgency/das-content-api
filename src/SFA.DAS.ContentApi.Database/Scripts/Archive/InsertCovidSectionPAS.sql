SET NOCOUNT ON;

PRINT 'Add Covid 19 content entry';

BEGIN TRAN;
BEGIN TRY

	IF OBJECT_ID('dbo.Content') IS NULL
	BEGIN;
		THROW 50000, 'The covid content could not be added as the dbo.Content table does not exist', 1;
	END;

	IF OBJECT_ID('dbo.ApplicationContent') IS NULL
	BEGIN;
		THROW 50000, 'The Covid 19 content could not be added as the dbo.ApplicationContent table does not exist', 1;
	END;

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 7)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 7, 2, '<div class="grid-row">
						<div class="column-two-thirds">
							<hr />
							<h3 class="heading-medium">Coronavirus (COVID-19)</h3>
							<p>To find out how we can support you, including changes we''re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank">read our updated guidance</a>.</p>
						</div>
					</div>'		
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 7, 3, 7
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 section entry added';
	END	

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 8)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 8, 2, '<div class="grid-row">
						<div class="column-two-thirds">
							<hr />
							<h3 class="heading-medium">Coronavirus (COVID-19)</h3>
							<p>To find out how we can support you, including changes we''re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank">read our updated guidance</a>.</p>
						</div>
					</div>'		
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 8, 4, 8
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 section legacy banner entry added';
	END
    
	
	COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Covid 19 text entry NOT added see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
