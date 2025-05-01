SET NOCOUNT ON;

PRINT 'Update Forecasting decommission banner';

DECLARE @forecastingBannerContent  VARCHAR(MAX) = 
N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
    <div class="govuk-notification-banner__header">
        <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
    </div>
    <div class="govuk-notification-banner__content">
        <p class="govuk-notification-banner__heading">Your Finance section is changing</p>
        <p class="govuk-body">From 31 May 2025 you will no longer see the funding projection page and other features in the Finance section of your employer account. <a href="https://example.com/faq" target="_blank">Find out what''s changing on our FAQ page.</a></p>
    </div>
</div>';

BEGIN TRAN;

BEGIN TRY
    IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 2)
    BEGIN
        SET IDENTITY_INSERT [dbo].[Content] ON
        INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data])
        SELECT 2, 1, @forecastingBannerContent
        SET IDENTITY_INSERT [dbo].[Content] OFF
        PRINT 'EAS Forecasting decommission banner entry added';
    END
    ELSE
    BEGIN
        UPDATE [dbo].[Content]
        SET [Data]=@forecastingBannerContent, Active = 1, StartDate = NULL, EndDate = NULL
        WHERE [Id] = 2
        PRINT 'EAS Forecasting decommission banner entry updated';
    END

    -- Link the banner to the Employer Finance - Levy application only
    IF NOT EXISTS(SELECT 1 FROM [dbo].[ApplicationContent] WHERE [ApplicationId] = 5 AND [ContentId] = 2)
    BEGIN
        SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
        INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId])
        SELECT 8, 5, 2
        SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF
        PRINT 'EAS Forecasting decommission banner linked to Employer Finance - Levy application';
    END

    COMMIT TRAN;
END TRY
BEGIN CATCH
    PRINT Error_message();
    PRINT 'EAS Forecasting decommission banner entry update NOT updated see above error';
    PRINT 'Rolling back transaction';
    ROLLBACK TRAN;
    THROW;
END CATCH; 