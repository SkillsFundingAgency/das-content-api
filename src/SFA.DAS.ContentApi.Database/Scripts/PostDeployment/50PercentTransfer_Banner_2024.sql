SET NOCOUNT ON;

PRINT 'Update Transfer Allowance to 50% banner entry';

BEGIN TRAN;

DECLARE @StartDate  DATETIME =   '2024-04-15';
DECLARE @EndDate    DATETIME =   '2024-04-29';
DECLARE @Content    VARCHAR(MAX) = N'<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
    <div class="govuk-notification-banner__header">
        <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
    </div>
    <div class="govuk-notification-banner__content">
        <p class="govuk-body govuk-!-font-weight-bold">From 22 April, the amount of funds apprenticeship levy-paying employers can share with other businesses will increase to 50%. <a href="https://www.gov.uk/guidance/transferring-your-apprenticeship-levy-to-another-business" target="_blank">Learn more about sharing levy funds</a>.</p>
    </div>
</div>';


BEGIN TRY  
	
	IF NOT EXISTS(SELECT ID FROM [dbo].[Content] WHERE Id = 1)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Content] ON
		
        INSERT INTO [dbo].[Content] ([Id], [ContentTypeId], [Data], [StartDate], [EndDate])
        SELECT 1, 1, @Content, @StartDate, @EndDate
        
        SET IDENTITY_INSERT [dbo].[Content] OFF 
    
        SET IDENTITY_INSERT [dbo].[ApplicationContent] ON
                                                       
        INSERT INTO [dbo].[ApplicationContent] ([Id], [ApplicationId], [ContentId]) 
        SELECT 1, 1, 1
            
        SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF

        PRINT 'Update Transfer Allowance to 50% banner entry added';
	END
	ELSE
	BEGIN
        UPDATE [dbo].[Content]
        SET 
            [Data] = @Content
            ,Active = 1
            ,StartDate = @StartDate
            ,EndDate = @EndDate
        WHERE [Id] = 1 
	END
	
	PRINT 'Update Transfer Allowance to 50% banner entry updated';
COMMIT TRAN;

END TRY
BEGIN CATCH
	
	PRINT Error_message();
	PRINT 'Update Transfer Allowance to 50% banner entry NOT updated see above error';
	PRINT 'Rolling back transaction';
	
	ROLLBACK TRAN;

	THROW;

END CATCH;