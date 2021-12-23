SET NOCOUNT ON;

PRINT 'Update Covid 19 banner entry with employer incentives closing dates';

BEGIN TRAN;
BEGIN TRY
	-- new govuk design styling which is shown on CDN views
	UPDATE [dbo].[Content]
	SET [Data]='<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">Applications for Incentive payments for hiring a new apprentice now open</p>
			<p class="govuk-body">Employers can now apply for a payment of £3,000 for new apprentices with an employment start date of 1 October 2021 to 31 January 2022. These apprentices must also have an apprenticeship start date of 1 October 2021 to 31 March 2022.</p>
			<p class="govuk-body">Applications close 15 May 2022.</p>
		</div>
	</div>'
	WHERE [Id] =1 

	-- new govuk design styling which is shown on non-CDN views with local stylesheets
	UPDATE [dbo].[Content]
	SET [Data]='<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">Applications for Incentive payments for hiring a new apprentice now open</p>
			<p class="govuk-body">Employers can now apply for a payment of £3,000 for new apprentices with an employment start date of 1 October 2021 to 31 January 2022. These apprentices must also have an apprenticeship start date of 1 October 2021 to 31 March 2022.</p>
			<p class="govuk-body">Applications close 15 May 2022.</p>
		</div>
	</div>'
	WHERE [Id] =2
			
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Banner entry NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
