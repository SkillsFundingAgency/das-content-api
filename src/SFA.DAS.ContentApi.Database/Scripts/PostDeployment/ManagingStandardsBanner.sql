SET NOCOUNT ON;

PRINT 'Update Managing standards banner entry (for Legacy)';

BEGIN TRAN;
BEGIN TRY
	UPDATE [dbo].[Content]
	SET [Data]= '<p></p>
        <div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">
                    Important
                </h2>
            </div>          
            <div class="govuk-notification-banner__content">
                <p class="govuk-notification-banner__heading">
                    You can now manage your standards and training venues here. Click on Your standards and training venues in the menu or from the link at the bottom of this page.
                </p>
            </div>
        </div>'
	WHERE [Id] = 4	
    AND Active = 1
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Managing standards entry update with email NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
