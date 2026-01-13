SET NOCOUNT ON;

PRINT 'Update NAW banner entry for 2026';

BEGIN TRAN;

BEGIN TRY  
	
	-- EAS - new govuk design styling which is shown on CDN views
	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 1)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data], [StartDate], [EndDate])
		SELECT 1,1,
               N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
                                     <div class="govuk-notification-banner__header">
                                         <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important notice</h2>
                                     </div>
                                     <div class="govuk-notification-banner__content">
                                         <h1 class="govuk-notification-banner__heading">National Apprenticeship Week 2026</h1>
                                         <p class="govuk-body">National Apprenticeship Week is 9 - 15 February 2026.</p>
                                         <p class="govuk-body">Get involved and download the toolkit from the <a href="https://naw.appawards.co.uk/" class="govuk-link" target="_blank" rel="noreferrer">National Apprenticeship Week website.</a></p>
                                     </div>
                                 </div>','2026-01-09','2026-02-16'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 1, 1, 1
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'NAW 2026 banner entry added';
	END
	ELSE
	BEGIN
	UPDATE [dbo].[Content]
	SET [Data]=N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important notice</h2>
            </div>
            <div class="govuk-notification-banner__content">
                <h1 class="govuk-notification-banner__heading">National Apprenticeship Week 2026</h1>
                <p class="govuk-body">National Apprenticeship Week is 9 - 15 February 2026.</p>
                <p class="govuk-body">Get involved and download the toolkit from the <a href="https://naw.appawards.co.uk/" class="govuk-link" target="_blank" rel="noreferrer">National Apprenticeship Week website.</a></p>
            </div>
        </div>',Active = 1, StartDate = '2026-01-09', EndDate = '2026-02-16'
	WHERE [Id] = 1 
	END
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'NAW 2026 entry update NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
