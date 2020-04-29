using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using SFA.DAS.ContentApi.Data;
using SFA.DAS.ContentApi.Types;

namespace SFA.DAS.ContentApi.Application.Queries.GetBannerQuery
{
    public class GetBannerQueryHandler : IRequestHandler<GetBannerQuery, GetBannerQueryResult>
    {
        private readonly Lazy<ContentApiDbContext> _db;

        public GetBannerQueryHandler(Lazy<ContentApiDbContext> db)
        {
            _db = db;
        }

        public async Task<GetBannerQueryResult> Handle(GetBannerQuery request, CancellationToken cancellationToken)
        {
            await Task.Delay(0, cancellationToken);

            var banner = new BannerDto
            {
                Content = request.UseLegacyStyle 
                    ? @"<div class=""info-summary"">
                            <h2 class=""heading-medium"">
                                Coronavirus (COVID-19): 
                                <a href=""https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response/coronavirus-covid-19-guidance-for-apprentices-employers-training-providers-end-point-assessment-organisations-and-external-quality-assurance-pro"" target=""_blank"">read our guidance</a> 
                                on the changes we're making to help your apprentices continue learning or 
                                <a href=""https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/360009509360-Pause-or-stop-an-apprenticeship"" target=""_blank"">find out how you can pause your apprenticeships</a>.
                            </h2>
                        </div>"
                    : @"<div class=""das-notification"">
                            <p class=""das-notification__heading govuk-!-margin-bottom-0"">
                                Coronavirus(COVID-19): 
                                <a href = ""https://www.gov.uk/government/publications/coronavirus-covid-19-apprenticeship-programme-response/coronavirus-covid-19-guidance-for-apprentices-employers-training-providers-end-point-assessment-organisations-and-external-quality-assurance-pro"" target=""_blank"" class=""govuk-link"">read our guidance</a> 
                                on the changes we're making to help your apprentices continue learning or 
                                <a href=""https://help.apprenticeships.education.gov.uk/hc/en-gb/articles/360009509360-Pause-or-stop-an-apprenticeship"" target=""_blank"" class=""govuk-link"">find out how you can pause your apprenticeships</a>.
                            </p>
                        </div>"
            };

            return new GetBannerQueryResult(banner);
        }
    }
}
