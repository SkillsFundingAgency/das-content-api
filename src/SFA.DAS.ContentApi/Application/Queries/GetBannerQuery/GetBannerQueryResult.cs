using SFA.DAS.ContentApi.Types;

namespace SFA.DAS.ContentApi.Application.Queries.GetBannerQuery
{
    public class GetBannerQueryResult
    {
        public GetBannerQueryResult(BannerDto banner)
        {
            Banner = banner;
        }

        public BannerDto Banner { get; }
    }
}
