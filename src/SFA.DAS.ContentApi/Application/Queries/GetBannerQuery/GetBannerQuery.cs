using MediatR;

namespace SFA.DAS.ContentApi.Application.Queries.GetBannerQuery
{
    public class GetBannerQuery : IRequest<GetBannerQueryResult>
    {
        public GetBannerQuery(bool useLegacyStyles)
        {
            UseLegacyStyle = useLegacyStyles;
        }

        public bool UseLegacyStyle { get; set; }
    }
}
