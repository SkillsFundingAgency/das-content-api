SET NOCOUNT ON;

PRINT 'Update NASA banner entry';

DECLARE @startDate      DATETIME = '2026-05-15';
DECLARE @endDate        DATETIME = '2026-05-29';
-- EAS - new govuk design styling which is shown on CDN views
DECLARE @bannerContent  VARCHAR(MAX) = 
        N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
            </div>
            <div class="govuk-notification-banner__content">
                <h1 class="govuk-notification-banner__heading">National Apprenticeship and Skills Awards 2026</h1>
                <p class="govuk-body">
                    The National Apprenticeship and Skills Awards 2026 are open for applications until 22 May 2026. 
                    <a href="https://apprenticeshipandskillsawards.co.uk/" target="_blank" rel="noreferrer">Enter or make a nomination.</a>
                </p>
            </div>
        </div>';

BEGIN TRAN;

BEGIN TRY


IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 8)
BEGIN
	    SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data], [StartDate], [EndDate])
        SELECT  8,
                1,
                @bannerContent,
                @startDate,
                @endDate 
        SET IDENTITY_INSERT [dbo].[Content] OFF

        SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
        INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 10, 1, 8 
        INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) SELECT 11, 2, 8 
        SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'NASA 2026 banner entry added';
END
ELSE
BEGIN
    UPDATE [dbo].[Content]
    SET [Data]=@bannerContent, Active = 1, StartDate = @startDate, EndDate = @endDate
    WHERE [Id] = 8
END

COMMIT TRAN;

END TRY
BEGIN CATCH

PRINT Error_message();
PRINT 'NASA 2026 entry update NOT updated see above error';
PRINT 'Rolling back transaction';

ROLLBACK TRAN;

THROW;

END CATCH;