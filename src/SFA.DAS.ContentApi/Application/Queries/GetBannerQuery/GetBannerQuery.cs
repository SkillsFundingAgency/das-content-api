using MediatR;

namespace SFA.DAS.ContentApi.Application.Queries.GetBannerQuery
{
    public class GetBannerQuery : IRequest<GetBannerQueryResult>
    {
        public GetBannerQuery(bool useLegacyStyles)
        {
            UseLegacyStyles = useLegacyStyles;
        }

        public bool UseLegacyStyles { get; set; }
    }
}
