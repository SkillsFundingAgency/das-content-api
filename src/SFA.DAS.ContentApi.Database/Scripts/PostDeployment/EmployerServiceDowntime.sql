SET NOCOUNT ON;

PRINT 'Update Employer Agreement service downtime banner 19/10';

BEGIN TRAN;
BEGIN TRY
	UPDATE [dbo].[Content]
	SET Active = 0
	WHERE [Id] = 1;

    UPDATE [dbo].[Content]
	SET [Data]= '<p></p>
        <div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
            <div class="govuk-notification-banner__header">
                <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">
                    Important notice
                </h2>
            </div>          
            <div class="govuk-notification-banner__content">
                <p class="govuk-body">
                    Please note that the Manage Apprenticeships website will be unavailable for all users on <b>31/10/23 between 7am and 9am</b> due to essential maintenance work. We apologise for any inconvenience this may cause.                
				</p>
            </div>
        </div>'
        , Active = 1
	WHERE [Id] = 2
COMMIT TRAN;

END TRY
BEGIN CATCH

	PRINT Error_message();
	PRINT 'Employer Agreement service downtime banner NOT updated see above error';
	PRINT 'Rolling back transaction';

	ROLLBACK TRAN;

	THROW;

END CATCH;