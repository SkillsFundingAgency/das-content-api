SET NOCOUNT ON;

PRINT 'Update EI Closing banner entry';

DECLARE @startDate      DATETIME = '2025-03-10';
DECLARE @endDate        DATETIME = '2025-04-30';
-- EAS - new govuk design styling which is shown on CDN views
DECLARE @bannerContent  VARCHAR(MAX) = 
        N'<div class="govuk-grid-row">
                <div class="govuk-grid-column-two-thirds">
                    <div class="govuk-notification-banner" role="region"
                        aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
                        <div class="govuk-notification-banner__header">
                            <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
                        </div>
                        <div class="govuk-notification-banner__content">
                            <p class="govuk-notification-banner__heading">
                            Your hire a new apprentice payments section will be removed after <span class="das-no-wrap">31 March 2025.</span>
			                Applications for these payments closed in 2022.                            
                            </p>                            
                        </div>
                    </div>
                </div>
            </div>';

BEGIN TRAN;

BEGIN TRY


IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 1)
BEGIN
	    SET IDENTITY_INSERT [dbo].[Content] ON
		INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data], [StartDate], [EndDate])
        SELECT  1,
                1,
                @bannerContent,
                @startDate,
                @endDate SET IDENTITY_INSERT [dbo].[Content] OFF


SET IDENTITY_INSERT [dbo].[ApplicationContent] ON

INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId])
SELECT 1,
       1,
       1 SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

		PRINT 'EI Closing 2025 banner entry added';
END
ELSE
BEGIN
    UPDATE [dbo].[Content]
    SET [Data]=@bannerContent, Active = 1, StartDate = @startDate, EndDate = @endDate
    WHERE [Id] = 1
END

COMMIT TRAN;

END TRY
BEGIN CATCH

PRINT Error_message();
PRINT 'EI Closing entry update NOT updated see above error';
PRINT 'Rolling back transaction';

ROLLBACK TRAN;

THROW;

END CATCH;