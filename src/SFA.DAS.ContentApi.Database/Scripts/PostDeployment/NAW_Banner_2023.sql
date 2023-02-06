SET NOCOUNT ON;

PRINT 'Update NAW banner entry (for Legacy) with Email notice';

BEGIN TRAN;


BEGIN TRY
	-- Insert PAS Legacy banner
	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 4)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 4, 1, '<p></p>
        <div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">
                    Reminder
                </h2>
            </div>
            <div class="govuk-notification-banner__content">
                <p class="govuk-notification-banner__heading">
                    National Apprenticeship Week: 6 to 12 February 2023
                </p>
                <p>Time to celebrate apprenticeships. Get involved with <a href="https://naw.appawards.co.uk/" target="_blank">National Apprenticeship Week</a>.</p>
            </div>
        </div>'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 4, 4, 4
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'NAW legacy banner Provider Apprenticeship Service (Legacy) entry added';
	END
	ELSE
	BEGIN
    -- Update PAS Legacy banner
	UPDATE [dbo].[Content]
	SET [Data]= '<p></p>
        <div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">
                    Reminder
                </h2>
            </div>
            <div class="govuk-notification-banner__content">
                <p class="govuk-notification-banner__heading">
                    National Apprenticeship Week: 6 to 12 February 2023
                </p>
                <p>Time to celebrate apprenticeships. Get involved with <a href="https://naw.appawards.co.uk/" target="_blank">National Apprenticeship Week</a>.</p>
            </div>
        </div>', Active = 1
	WHERE [Id] = 4
	END
	
	
	----!!! NO PAS BANNER LOCATION FOR CDN STYLE !!!----

    
	
	-- EAS - new govuk design styling which is shown on CDN views
	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 1)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 1, 1, '<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Reminder</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">National Apprenticeship Week: 6 to 12 February 2023</p>
			<p class="govuk-body">Time to celebrate apprenticeships. Get involved with <a href="https://naw.appawards.co.uk/" target="_blank">National Apprenticeship Week</a>.</p>
		</div>
	</div>'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 1, 1, 1
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'NAW 2023 banner entry added';
	END
	ELSE
	BEGIN
	UPDATE [dbo].[Content]
	SET [Data]='<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Reminder</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">National Apprenticeship Week: 6 to 12 February 2023</p>
			<p class="govuk-body">Time to celebrate apprenticeships. Get involved with <a href="https://naw.appawards.co.uk/" target="_blank">National Apprenticeship Week</a>.</p>
		</div>
	</div>', Active = 1
	WHERE [Id] = 1 
	END

	-- EAS - new govuk design styling which is shown on non-CDN views with local stylesheets
	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 2)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
		SELECT 2, 1, '<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Reminder</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">National Apprenticeship Week: 6 to 12 February 2023</p>
			<p class="govuk-body">Time to celebrate apprenticeships. Get involved with <a href="https://naw.appawards.co.uk/" target="_blank">National Apprenticeship Week</a>.</p>
		</div>
	</div>'
		SET IDENTITY_INSERT [dbo].[Content] OFF
		
		SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
		INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 2, 2, 2
		SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'NAW 2023 legacy banner entry added';
	END
	ELSE
	BEGIN
	UPDATE [dbo].[Content]
	SET [Data]='<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Reminder</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">National Apprenticeship Week: 6 to 12 February 2023</p>
			<p class="govuk-body">Time to celebrate apprenticeships. Get involved with <a href="https://naw.appawards.co.uk/" target="_blank">National Apprenticeship Week</a>.</p>
		</div>
	</div>', Active = 1
	WHERE [Id] = 2
	END
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'NAW entry update with email NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;