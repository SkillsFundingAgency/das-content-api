﻿SET NOCOUNT ON;

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

	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 5)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 5, 2, '<hr class="govuk-section-break govuk-section-break--l govuk-section-break--visible">
        <section class="govuk-!-margin-bottom-8">
            <h2 class="govuk-heading-l govuk-!-margin-bottom-2">Coronavirus (COVID-19)</h2>
            <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response" target="_blank" class="govuk-link">read our updated guidance</a>.</p>
        </section>'		
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 5, 1, 5
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'Covid 19 section entry added';
	END	
	ELSE
	BEGIN
	UPDATE [dbo].[Content]
	SET [Data]='<hr class="govuk-section-break govuk-section-break--l govuk-section-break--visible">
        <section class="govuk-!-margin-bottom-8">
            <h2 class="govuk-heading-l govuk-!-margin-bottom-2">Coronavirus (COVID-19)</h2>
            <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response" target="_blank" class="govuk-link">read our updated guidance</a>.</p>
        </section>'	
	WHERE Id = 5
	PRINT 'Covid 19 section entry updated';
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
                <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response" target="_blank">read our updated guidance</a>.</p>
            </section>'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 6, 2, 6
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
