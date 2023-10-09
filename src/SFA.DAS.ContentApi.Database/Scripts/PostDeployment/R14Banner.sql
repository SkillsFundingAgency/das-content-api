SET NOCOUNT ON;

PRINT 'Update R14 provider banner entry (for Legacy)';

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
                <p class="govuk-body">
                    Due to high volumes of ILR submissions, you may experience a <a href="https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/14129491200530-Short-delay-between-submitting-ILR-and-data-locks">short delay between submitting your ILR and data locks being generated.</a> Please submit your files as early as possible.
                </p>
	            <p class="govuk-body">
	                You must submit your final ILR for the 2022 to 2023 academic year (R14) by 6pm on Thursday 19th October 2023. Check that all apprentice data is correct before you submit.
	            </p>
            </div>
        </div>'
        , Active = 1
	WHERE [Id] = 4
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'R14 provider banner NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
