using System.Threading;
using System.Threading.Tasks;
using FluentAssertions;
using NUnit.Framework;
using SFA.DAS.ContentApi.Application.Queries.GetBannerQuery;
using SFA.DAS.ContentApi.Data;
using SFA.DAS.ContentApi.UnitTests.AutoFixture;

namespace SFA.DAS.ContentApi.UnitTests.Application.Queries
{
    [TestFixture]
    [Parallelizable]
    class GetBannerQueryHandlerTests
    {
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetBannerQuery_ThenShouldReturnGetBannerQueryResult(
            ContentApiDbContext setupContext,
            GetBannerQueryHandler handler,
            bool useLegacyStyles
        )
        {
            //arrange
            var query = new GetBannerQuery(useLegacyStyles);

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Banner.Should().NotBeNull();
        }
    }
}
