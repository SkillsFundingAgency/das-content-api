SET NOCOUNT ON;

PRINT 'Update Covid 19 banner entry with employer incentives';

BEGIN TRAN;
BEGIN TRY
	UPDATE [dbo].[Content]
	SET [Data]='<div class="das-notification"><p class="das-notification__heading govuk-!-margin-bottom-0 govuk-!-font-weight-bold">There is still time to apply for the hire a new apprentice payment.</p>
	<p class="das-notification__heading govuk-!-margin-bottom-0">If you’ve taken on new apprentices from 1 April 2021 to 30 September 2021, <a href="https://employer-incentives.manage-apprenticeships.service.gov.uk/hire-new-apprentice-payment"
	target="_blank" class="govuk-link">you need to apply before 30 November 2021.</a></p>
	<p>You will be able to apply for apprentices you have hired from 1 October 2021 to 31 January 2022 <a href="https://www.gov.uk/guidance/incentive-payments-for-hiring-a-new-apprentice"
	target="_blank" class="govuk-link">once applications open in January 2022.</a></p></div>' + [Data]
	WHERE [Id] =1 

	UPDATE [dbo].[Content]
	SET [Data]='<div class="info-summary"><h2 class="heading-medium"><p class="font-weight--bold">There is still time to apply for the hire a new apprentice payment.</p>
	<p>If you’ve taken on new apprentices from 1 April 2021 to 30 September 2021, <a href="https://employer-incentives.manage-apprenticeships.service.gov.uk/hire-new-apprentice-payment"
	target="_blank" class="govuk-link">you need to apply before 30 November 2021.</a></p>
	<p>You will be able to apply for apprentices you have hired from 1 October 2021 to 31 January 2022 <a href="https://www.gov.uk/guidance/incentive-payments-for-hiring-a-new-apprentice"
	target="_blank" class="govuk-link">once applications open in January 2022.</a></p>
	</h2></div>' + [Data]
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
