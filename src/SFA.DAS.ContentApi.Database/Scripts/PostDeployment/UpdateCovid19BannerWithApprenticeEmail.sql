SET NOCOUNT ON;

PRINT 'Update Covid 19 banner entry (for Legacy) with Email notice';

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
                    Coronavirus (COVID-19): to find out how we can support you, including changes we''re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank">read our updated guidance</a>.
                </p>
            </div>

            <div class="govuk-notification-banner__content">
                <p class="govuk-notification-banner__heading">
                    From 9 September, you or the training provider must add a unique email address for each apprentice you add. The apprentice will then receive an email invitation to create a ''My apprenticeship'' account.
                </p>
            </div>
        </div>'
	WHERE [Id] = 4
			
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Covid 19 entry update with email NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
