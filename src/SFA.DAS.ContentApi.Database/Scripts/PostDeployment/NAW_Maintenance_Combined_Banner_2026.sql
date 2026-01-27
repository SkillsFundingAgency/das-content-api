SET NOCOUNT ON;

PRINT 'Update combined NAW and Maintenance banner entry for 2026 (19 Jan - 30 Jan)';

BEGIN TRAN;

BEGIN TRY  
	
	-- EAS - new govuk design styling which is shown on CDN views
	-- Combined banner with both NAW and Maintenance notices
	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 2)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data], [StartDate], [EndDate])
		SELECT 2,1,
               N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title-naw" data-module="govuk-notification-banner">
                                     <div class="govuk-notification-banner__header">
                                         <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title-naw">Important notice</h2>
                                     </div>
                                     <div class="govuk-notification-banner__content">
                                         <h1 class="govuk-notification-banner__heading">National Apprenticeship Week 2026</h1>
                                         <p class="govuk-body">National Apprenticeship Week is 9 to 15 February 2026.</p>
                                         <p class="govuk-body">Get involved and download the toolkit from the <a href="https://naw.appawards.co.uk/" class="govuk-link" target="_blank" rel="noreferrer">National Apprenticeship Week website.</a></p>
                                     </div>
                                 </div>
                                 <div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title-maintenance" data-module="govuk-notification-banner">
                                     <div class="govuk-notification-banner__header">
                                         <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title-maintenance">Important notice</h2>
                                     </div>
                                     <div class="govuk-notification-banner__content">
                                         <h1 class="govuk-notification-banner__heading">Planned maintenance downtime</h1>
                                         <p class="govuk-body">You will not be able to access your employer account on <strong>30 January 2026</strong>, from <strong>7am to 9am</strong>.</p>
                                         <p class="govuk-body">This is due to planned maintenance. We''re sorry for any inconvenience.</p>
                                     </div>
                                 </div>','2026-01-19','2026-01-30'
		SET IDENTITY_INSERT [dbo].[Content] OFF

		PRINT 'Combined NAW and Maintenance 2026 banner entry added';
	END
	ELSE
	BEGIN
	UPDATE [dbo].[Content]
	SET [Data]=N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title-naw" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title-naw">Important notice</h2>
            </div>
            <div class="govuk-notification-banner__content">
                <h1 class="govuk-notification-banner__heading">National Apprenticeship Week 2026</h1>
                <p class="govuk-body">National Apprenticeship Week is 9 to 15 February 2026.</p>
                <p class="govuk-body">Get involved and download the toolkit from the <a href="https://naw.appawards.co.uk/" class="govuk-link" target="_blank" rel="noreferrer">National Apprenticeship Week website.</a></p>
            </div>
        </div>
        <div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title-maintenance" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title-maintenance">Important notice</h2>
            </div>
            <div class="govuk-notification-banner__content">
                <h1 class="govuk-notification-banner__heading">Planned maintenance downtime</h1>
                <p class="govuk-body">You will not be able to access your employer account on <strong>30 January 2026</strong>, from <strong>7am to 9am</strong>.</p>
                <p class="govuk-body">This is due to planned maintenance. We''re sorry for any inconvenience.</p>
            </div>
        </div>',Active = 1, StartDate = '2026-01-19', EndDate = '2026-01-30'
	WHERE [Id] = 2 
	END
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Combined NAW and Maintenance 2026 entry update NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
