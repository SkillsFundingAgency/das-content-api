SET NOCOUNT ON;

PRINT 'Update Covid 19 banner entry with employer incentives closing dates';

BEGIN TRAN;
BEGIN TRY
	UPDATE [dbo].[Content]
	SET [Data]='
	<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
		<div class="govuk-notification-banner__header">
			<h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">Applications open on 11 January 2022</p>
			<p class="govuk-body">For apprentices with an employment start date from 1 October 2021 to 31 January 2022, applications open on 11 January 2022 and close on 15 May 2022.</p>
			<p class="govuk-body">They must also have an apprenticeship start date from 1 October 2021 to 31 March 2022.</p>
		</div>
		<div class="govuk-notification-banner__content">
			<p class="govuk-notification-banner__heading">Coronavirus(COVID-19): to find out how we can support you, including changes we’re making to help your apprentices continue learning,
				<a class="govuk-notification-banner__link" href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank">read our updated guidance</a>.
			</p>
		</div>
	</div>'
	WHERE [Id] =1 

	UPDATE [dbo].[Content]
	SET [Data]='
	<div class="info-summary">
		<h2 class="heading-medium">Applications open on 11 January 2022</h2>
		<p>For apprentices with an employment start date from 1 October 2021 to 31 January 2022, applications open on 11 January 2022 and close on 15 May 2022.</p>
		<p>They must also have an apprenticeship start date from 1 October 2021 to 31 March 2022.</p>
		<h2 class="heading-medium">Coronavirus (COVID-19): to find out how we can support you, including changes we’re making to help your apprentices continue learning,
			<a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank" class="govuk-link">read our updated guidance</a>.
		</h2>
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
