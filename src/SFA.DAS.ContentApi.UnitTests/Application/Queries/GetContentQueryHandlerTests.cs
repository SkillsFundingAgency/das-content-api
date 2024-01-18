using FluentAssertions;
using NUnit.Framework;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;
using SFA.DAS.ContentApi.Data;
using SFA.DAS.ContentApi.Models;
using SFA.DAS.ContentApi.UnitTests.AutoFixture;

namespace SFA.DAS.ContentApi.UnitTests.Application.Queries
{
    [TestFixture]
    [Parallelizable]
    class GetContentQueryHandlerTests
    {
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnAContentString_ForActiveContent(
            ContentApiDbContext setupContext,
            GetContentQueryHandler handler,
            string type,
            string applicationIdentity
        )
        {
            //arrange
            var htmlData = "<h1>a banner</h1>";
            await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData);

            var query = new GetContentQuery
            {
                Type = type,
                ApplicationId = applicationIdentity
            };

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Should().NotBeNull();
            result.Content.Should().Be(htmlData);
        }
        
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnEmpty_WhenNoActiveContent(
            ContentApiDbContext setupContext,
            GetContentQueryHandler handler,
            string type,
            string applicationIdentity
        )
        {
            //arrange
            var htmlData = "<h1>a banner</h1>";
            await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: false, htmlData);

            var query = new GetContentQuery
            {
                Type = type,
                ApplicationId = applicationIdentity
            };

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Should().NotBeNull();
            result.Content.Should().Be(string.Empty);
        }
        
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnAContentString_ForActiveContentWithinDates(
            ContentApiDbContext setupContext,
            GetContentQueryHandler handler,
            string type,
            string applicationIdentity
        )
        {
            //arrange
            var htmlData = "<h1>a banner</h1>";
            var startDate = DateTime.Now.AddDays(-1);
            var endDate = DateTime.Now.AddDays(1);
            await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, startDate, endDate);

            var query = new GetContentQuery
            {
                Type = type,
                ApplicationId = applicationIdentity
            };

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Should().NotBeNull();
            result.Content.Should().Be(htmlData);
        }
        
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnAContentString_ForActiveContent_AfterStartDate_NoEndDate(
            ContentApiDbContext setupContext,
            GetContentQueryHandler handler,
            string type,
            string applicationIdentity
        )
        {
            //arrange
            var htmlData = "<h1>a banner</h1>";
            var startDate = DateTime.Now.AddDays(-1);
            await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, startDate);

            var query = new GetContentQuery
            {
                Type = type,
                ApplicationId = applicationIdentity
            };

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Should().NotBeNull();
            result.Content.Should().Be(htmlData);
        }
        
        [Test, ContentAutoData]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnAContentString_ForActiveContent_NoStartDate_BeforeEndDate(
            ContentApiDbContext setupContext,
            GetContentQueryHandler handler,
            string type,
            string applicationIdentity
        )
        {
            //arrange
            var htmlData = "<h1>a banner</h1>";
            var endDate = DateTime.Now.AddDays(1);
            await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, endDate: endDate);

            var query = new GetContentQuery
            {
                Type = type,
                ApplicationId = applicationIdentity
            };

            //act
            var result = await handler.Handle(query, new CancellationToken());

            //assert
            result.Should().NotBeNull();
            result.Content.Should().Be(htmlData);
        }

        private static async Task SetupApplicationContent(
            ContentApiDbContext setupContext,
            string applicationIdentity,
            string type,
            bool isActive,
            string htmlData,
            DateTime? startDate = null,
            DateTime? endDate = null)
        {
            var contentId = 666;
            setupContext.Application.Add(new Models.Application
            {
                Id = 1,
                Identity = applicationIdentity.ToLowerInvariant(),
                Description = "an_application",
                ApplicationContent = new List<ApplicationContent>
                {
                    new()
                    {
                        Id = 111,
                        ApplicationId = 1,
                        ContentId = contentId,
                        Content = new()
                        {
                            Id = contentId,
                            Active = isActive,
                            Data = htmlData,
                            StartDate = startDate,
                            EndDate = endDate,
                            ContentType = new()
                            {
                                Id = 1,
                                Value = type.ToLower()
                            }
                        }
                    }
                }
            });

            await setupContext.SaveChangesAsync();
        }
    }
}