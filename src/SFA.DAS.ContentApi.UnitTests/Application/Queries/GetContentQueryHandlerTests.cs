using System.Threading;
using System.Threading.Tasks;
using FluentAssertions;
using NUnit.Framework;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;
using SFA.DAS.ContentApi.Data;
using SFA.DAS.ContentApi.UnitTests.AutoFixture;

namespace SFA.DAS.ContentApi.UnitTests.Application.Queries
{
    [TestFixture]
    [Parallelizable]
    class GetContentQueryHandlerTests
    {
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnAContentString(
            ContentApiDbContext setupContext,
            GetContentQueryHandler handler,
            string type,
            string applicationId
        )
        {
            //arrange
            var query = new GetContentQuery
            {
                Type = type,
                ApplicationId = applicationId
            };

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Should().NotBeNull();
        }
    }
}
