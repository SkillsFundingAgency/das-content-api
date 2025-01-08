using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using NUnit.Framework;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;
using SFA.DAS.ContentApi.Data;
using SFA.DAS.ContentApi.Models;
using SFA.DAS.ContentApi.UnitTests.AutoFixture;

namespace SFA.DAS.ContentApi.UnitTests.Application.Queries;

[TestFixture]
[Parallelizable]
public class GetContentQueryHandlerTests
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
        const string htmlData = "<h1>a banner</h1>";
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData);

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

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
        const string htmlData = "<h1>a banner</h1>";
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: false, htmlData);

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

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
        const string htmlData = "<h1>a banner</h1>";
        var startDate = DateTime.Now.AddDays(-1);
        var endDate = DateTime.Now.AddDays(1);
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, startDate: startDate, endDate: endDate);

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

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
        const string htmlData = "<h1>a banner</h1>";
        var startDate = DateTime.Now.AddDays(-1);
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, startDate: startDate);

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

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
        const string htmlData = "<h1>a banner</h1>";
        var endDate = DateTime.Now.AddDays(1);
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, endDate: endDate);

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

        //assert
        result.Should().NotBeNull();
        result.Content.Should().Be(htmlData);
    }

    [Test, ContentAutoData]
    public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnEmptyContent_ForInactiveContent_EvenWithinDates(
        ContentApiDbContext setupContext,
        GetContentQueryHandler handler,
        string type,
        string applicationIdentity
    )
    {
        //arrange
        const string htmlData = "<h1>a banner</h1>";
        var startDate = DateTime.Now.AddDays(-1);
        var endDate = DateTime.Now.AddDays(1);
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: false, htmlData, startDate: startDate, endDate: endDate);

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

        //assert
        result.Should().NotBeNull();
        result.Content.Should().Be(string.Empty);
    }

    [Test, ContentAutoData]
    public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnCorrectContent_WhenContentTypes_AppliesToMultipleApplications(
        ContentApiDbContext setupContext,
        GetContentQueryHandler handler,
        string type,
        string applicationIdentity,
        long contentId
    )
    {
        //arrange
        const string htmlData = "<h1>a banner</h1>";
        var startDate = DateTime.Now.AddDays(-1);
        var endDate = DateTime.Now.AddDays(1);
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, contentId, startDate, endDate);
        await SetupAdditionalApplicationForContent(setupContext, contentId, 222, "some-other-identity");

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

        //assert
        result.Should().NotBeNull();
        result.Content.Should().Be(htmlData);
    }

    [Test, ContentAutoData]
    public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnCorrectContentType_WhenMultipleActiveTypes_ForOneApplication(
        ContentApiDbContext setupContext,
        GetContentQueryHandler handler,
        string type,
        string applicationIdentity,
        long contentId
    )
    {
        //arrange
        const string htmlData = "<h1>a banner</h1>";
        var startDate = DateTime.Now.AddDays(-1);
        var endDate = DateTime.Now.AddDays(1);
        await SetupApplicationContent(setupContext, applicationIdentity, type, isActive: true, htmlData, contentId, startDate, endDate);
        await SetupAdditionalContentForApplication(setupContext, applicationIdentity, 777, "<h2>some wrong content</h2>");

        var query = new GetContentQuery
        {
            Type = type,
            ApplicationId = applicationIdentity
        };

        //act
        var result = await handler.Handle(query, CancellationToken.None);

        //assert
        result.Should().NotBeNull();
        result.Content.Should().Be(htmlData);
    }

    private static async Task SetupAdditionalContentForApplication(ContentApiDbContext setupContext, string applicationIdentity, long contentId, string htmlData)
    {
        var existingApplication = await setupContext.Application.SingleOrDefaultAsync(a => a.Identity.Equals(applicationIdentity.ToLowerInvariant()));
        existingApplication!.ApplicationContent.Add(new()
        {
            Id = 222,
            Content = new()
            {
                Id = contentId,
                ContentType = new ContentType
                {
                    Id = 100,
                    Value = "not-a-banner"
                },
                Active = true,
                Data = htmlData
            }
        });

        await setupContext.SaveChangesAsync();
    }

    private static async Task SetupAdditionalApplicationForContent(ContentApiDbContext setupContext, long contentId, long applicationId, string applicationIdentity)
    {
        var existingContent = await setupContext.Content.FindAsync(contentId);
        existingContent!.ApplicationContent.Add(new()
        {
            Id = 222,
            Application = new()
            {
                Id = applicationId,
                Identity = applicationIdentity,
                Description = "some-description"
            }
        });

        await setupContext.SaveChangesAsync();
    }

    private static async Task SetupApplicationContent(
        ContentApiDbContext setupContext,
        string applicationIdentity,
        string type,
        bool isActive,
        string htmlData,
        long contentId = 666,
        DateTime? startDate = null,
        DateTime? endDate = null)
    {
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