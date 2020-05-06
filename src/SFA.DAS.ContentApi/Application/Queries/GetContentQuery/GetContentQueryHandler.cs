﻿using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery
{
    public class GetContentQueryHandler : IRequestHandler<GetContentQuery, GetContentQueryResult>
    {
        private readonly Lazy<ContentApiDbContext> _db;

        public GetContentQueryHandler(Lazy<ContentApiDbContext> db)
        {
            _db = db;
        }

        public Task<GetContentQueryResult> Handle(GetContentQuery request, CancellationToken cancellationToken)
        {
            var content = string.Empty;

            switch (request.ApplicationId.ToLower())
            {
                case "das-employeraccounts-web":
                {
                    content = @"<div class=""das-notification"">
                                <p class=""das-notification__heading govuk-!-margin-bottom-0"">
                                Coronavirus(COVID-19): 
                                <a href = ""https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response/coronavirus-covid-19-guidance-for-apprentices-employers-training-providers-end-point-assessment-organisations-and-external-quality-assurance-pro"" target=""_blank"" class=""govuk-link"">read our guidance</a> 
                                on the changes we're making to help your apprentices continue learning or 
                                <a href=""https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/360009509360-Pause-or-stop-an-apprenticeship"" target=""_blank"" class=""govuk-link"">find out how you can pause your apprenticeships</a>.
                                </p>
                                </div>";

                    break;
                }

                case "das-employeraccounts-web-legacy":
                {
                    content = @"<div class=""info-summary"">
                                <h2 class=""heading-medium"">
                                Coronavirus (COVID-19): 
                                <a href=""https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response/coronavirus-covid-19-guidance-for-apprentices-employers-training-providers-end-point-assessment-organisations-and-external-quality-assurance-pro"" target=""_blank"">read our guidance</a> 
                                on the changes we're making to help your apprentices continue learning or 
                                <a href=""https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/360009509360-Pause-or-stop-an-apprenticeship"" target=""_blank"">find out how you can pause your apprenticeships</a>.
                                </h2>
                                </div>";

                    break;
                }
            }

            return Task.FromResult(new GetContentQueryResult(content));
        }
    }
}
