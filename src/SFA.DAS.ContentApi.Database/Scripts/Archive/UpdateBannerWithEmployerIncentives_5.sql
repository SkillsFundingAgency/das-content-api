SET NOCOUNT ON;

PRINT 'Update banner entry with employer incentives closing dates';

BEGIN TRAN;
BEGIN TRY
	-- new govuk design styling which is shown on CDN views
	UPDATE [dbo].[Content]
	SET [Data]='<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">Applications for incentive payments close 20 May 2022</p>
			<p class="govuk-body">You must submit applications for incentive payments for hiring a new apprentice by 20 May 2022. Training providers can''t apply on your behalf.</p>
			<p class="govuk-body">Employers can apply for a payment of £3000 for a new apprentice with an employment start date of 1 October 2021 to 31 January 2022. These apprentices must also have an apprenticeship start date of 1 October 2021 to 31 March 2022 registered on your account.</p>
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
			<p class="govuk-notification-banner__heading">Applications for incentive payments close 20 May 2022</p>
			<p class="govuk-body">You must submit applications for incentive payments for hiring a new apprentice by 20 May 2022. Training providers can''t apply on your behalf.</p>
			<p class="govuk-body">Employers can apply for a payment of £3000 for a new apprentice with an employment start date of 1 October 2021 to 31 January 2022. These apprentices must also have an apprenticeship start date of 1 October 2021 to 31 March 2022 registered on your account.</p>
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
