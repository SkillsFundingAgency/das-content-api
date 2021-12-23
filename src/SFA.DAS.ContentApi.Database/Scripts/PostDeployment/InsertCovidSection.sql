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

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 5)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 5, 2, '<section class="dashboard-section">
                <div class="grid-row">
                    <div class="column-two-thirds">
                        <h2 class="section-heading heading-large">Coronavirus (COVID-19)</h2>
                    </div>
                </div>
                <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response">read our updated guidance.</a></p>
            </section>'		
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 5, 1, 5
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 text entry added';
	END	

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 6)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 6, 2, '<section class="dashboard-section">
                <div class="grid-row">
                    <div class="column-two-thirds">
                        <h2 class="section-heading heading-large">Coronavirus (COVID-19)</h2>
                    </div>
                </div>
                <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response">read our updated guidance.</a></p>
            </section>'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 6, 2, 6
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 text legacy banner entry added';
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
