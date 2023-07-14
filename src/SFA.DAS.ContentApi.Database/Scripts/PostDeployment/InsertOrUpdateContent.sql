/*
	Insert or Update each of the [Content] values.

	NOTES:

	1) This script uses a temporary table, insert or update the values in the temporary table to apply changes; removed values will
	not take affect (by design); values which are removed should also be written into the DeleteContent.sql script to remove
	manually any dependencies, but they must also be removed from the temporary table.

    2) It is recommended that content is set Active = 0 when not required to preserve the formatting markup in the script
*/
CREATE TABLE #Content(
	[Id] BIGINT NOT NULL, 
    [ContentTypeId] BIGINT NOT NULL, 
    [Data] VARCHAR(MAX) NULL, 
    [StartDate] DATETIME NULL, 
    [EndDate] DATETIME NULL, 
    [Active] BIT NOT NULL DEFAULT 1
) 

INSERT #Content VALUES (1, 1, '<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
    <div class="govuk-notification-banner__header">
        <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
    </div>
    <div class="govuk-notification-banner__content">
        <p class="govuk-notification-banner__heading"></p>
        <p class="govuk-body"></p>
    </div>
</div>', NULL, NULL, 0)


INSERT #Content VALUES (2, 1, '<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
    <div class="govuk-notification-banner__header">
        <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
    </div>
    <div class="govuk-notification-banner__content">
        <p class="govuk-notification-banner__heading"></p>
        <p class="govuk-body"></p>
    </div>
</div>', NULL, NULL, 0)

INSERT #Content VALUES (3, 1, '<div class="info-summary" tabindex="-1">
    <span class="heading-small">
    </span>
</div>', NULL, NULL, 0)

INSERT #Content VALUES (4, 1, '<div class="info-summary" tabindex="-1">
    <span class="heading-small">
    </span>
</div>', NULL, NULL, 0)

INSERT #Content VALUES (5, 2, '<hr class="govuk-section-break govuk-section-break--l govuk-section-break--visible">
<section class="govuk-!-margin-bottom-8">
    <h2 class="govuk-heading-l govuk-!-margin-bottom-2">Coronavirus (COVID-19)</h2>
    <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response" target="_blank" class="govuk-link">read our updated guidance</a>.</p>
</section>', NULL, NULL, 1)

INSERT #Content VALUES (6, 2, '<section class="dashboard-section">
    <div class="grid-row">
        <div class="column-two-thirds">
            <h2 class="section-heading heading-large">Coronavirus (COVID-19)</h2>
        </div>
    </div>
    <p>To find out how we can support you, including changes we’re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response" target="_blank">read our updated guidance</a>.</p>
</section>', NULL, NULL, 1)

INSERT #Content VALUES (7, 2, '<div class="grid-row">
    <div class="column-two-thirds">
        <hr />
        <h3 class="heading-medium">Coronavirus (COVID-19)</h3>
        <p>To find out how we can support you, including changes we''re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank">read our updated guidance</a>.</p>
    </div>
</div>', NULL, NULL, 1)

INSERT #Content VALUES (8, 2, '<div class="grid-row">
    <div class="column-two-thirds">
        <hr />
        <h3 class="heading-medium">Coronavirus (COVID-19)</h3>
        <p>To find out how we can support you, including changes we''re making to help your apprentices continue learning, <a href="https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response?es_c=7B651DDC6B6986102E8BBB7918A20DDF&es_cl=53BFD9FD1669BCDAEBD12D5CDF1D9AB8&es_id=9d%c2%a3o3C" target="_blank">read our updated guidance</a>.</p>
    </div>
</div>', NULL, NULL, 1)
    
INSERT #Content VALUES (9, 1,
    '<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
    <div class="govuk-notification-banner__header">
        <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
    </div>
    <div class="govuk-notification-banner__content">
        <p class="govuk-notification-banner__heading">From 3rd July, you will need a GOV.UK One Login to access this service.</p>
        <p class="govuk-body">You’ll automatically be directed to create a GOV.UK One Login when you sign in after this date. When you create your GOV.UK One Login, you must use the same email address you currently use for this account.</p>
        <p class="govuk-body">If you can’t access the email address connected to this account, you’ll need to change your account’s email address before 3rd July. You can change your email address in your account settings.</p>
    </div>
</div>'   , NULL, null, 0)    
 
    
INSERT #Content VALUES (10, 1,
    '<div class="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title" data-module="govuk-notification-banner">
    <div class="govuk-notification-banner__header">
        <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">Important</h2>
    </div>
    <div class="govuk-notification-banner__content">
        <p class="govuk-notification-banner__heading">This service will switch to GOV.UK One Login soon.</p>
        <p class="govuk-body">After the switch, you’ll automatically be directed to create a GOV.UK One Login. You must create your GOV.UK One Login with the same email address you currently use for this account.</p>
        <p class="govuk-body">If you can’t access the email address linked to this account, you need to change your email address in your account settings.</p>
        <p class="govuk-body">A date for the switch to GOV.UK One Login will be announced soon.</p>
    </div>
</div>'   , NULL, null, 0)

SET IDENTITY_INSERT [dbo].[Content] ON 

MERGE [Content] [Target] USING #Content [Source]
ON ([Source].Id = [Target].Id)
WHEN MATCHED
    THEN UPDATE SET 
        [Target].[ContentTypeId] = [Source].[ContentTypeId],
		[Target].[Data] = [Source].[Data],
        [Target].[StartDate] = [Source].[StartDate],
        [Target].[EndDate] = [Source].[EndDate],
        [Target].[Active] = [Source].[Active]

WHEN NOT MATCHED BY TARGET 
    THEN INSERT ([Id], [ContentTypeId], [Data], [StartDate], [EndDate], [Active])
         VALUES ([Source].[Id], [Source].[ContentTypeId], [Source].[Data], [Source].[StartDate], [Source].[EndDate], [Source].[Active]);

SET IDENTITY_INSERT [dbo].[Content] OFF
