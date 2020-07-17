SET NOCOUNT ON;

PRINT 'Update Covid 19 banner entry';

BEGIN TRAN;
BEGIN TRY
	UPDATE [dbo].[Content]
	SET [Data]='<p class="das-notification__heading govuk-!-margin-bottom-0">Coronavirus(COVID-19): to find out how we can support you, 
	including changes we’re making to help your apprentices continue learning,
	<a href ="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" 
	target="_blank" class="govuk-link">read our updated guidance</a>.</p></div>'
	WHERE [Id] =1 

	UPDATE [dbo].[Content]
	SET [Data]='<div class="info-summary"><h2 class="heading-medium">Coronavirus (COVID-19): to find out how we can support you, 
	including changes we’re making to help your apprentices continue learning,
	<a href ="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" 
	target="_blank" class="govuk-link">read our updated guidance</a>.</h2></div>'
	WHERE [Id] =2
			
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Covid 19 entry NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;
