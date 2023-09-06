using System.Threading;
using System.Threading.Tasks;
using FluentAssertions;
using NUnit.Framework;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;
using SFA.DAS.ContentApi.Data;
using SFA.DAS.ContentApi.UnitTests.AutoFixture;
using System;
using AutoFixture;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using SFA.DAS.ContentApi.Models;


namespace SFA.DAS.ContentApi.UnitTests.Application.Queries
{
    [TestFixture]
    [Parallelizable]
    class GetContentQueryHandlerTests
    {
        private readonly string type = "covid_section";
        private readonly string applicationId = "das-employeraccounts-web";
        private Lazy<ContentApiDbContext> _context;
        private GetContentQueryHandler handler;

        [SetUp]
        public async Task Arrange()
        {
            var databaseGuid = Guid.NewGuid();
            var dbContext = new ContentApiDbContext(
                new DbContextOptionsBuilder<ContentApiDbContext>().
                UseInMemoryDatabase(databaseGuid.ToString()).Options
            );
            await dbContext.Application.AddAsync(new Models.Application
            {
                Id = 1,
                Description = "Employer Apprenticeship Service",
                Identity = applicationId
            });
            await dbContext.SaveChangesAsync();
            await dbContext.Content.AddAsync(new Content
            {
                Id = 1,
                Data = "test",
                Active = true,
                ContentType = new ContentType
                {
                    Id = 1,
                    Value = type
                }
            });
            await dbContext.SaveChangesAsync();
            await dbContext.ApplicationContent.AddAsync(new ApplicationContent
            {
                Id = 1,
                ApplicationId = 1,
                ContentId = 1,
            });
            await dbContext.SaveChangesAsync();

            _context = new Lazy<ContentApiDbContext>(dbContext);
            handler = new GetContentQueryHandler(_context);
        }
        [Test]
        public async Task Handle_WhenHandlingGetContentQuery_ThenShouldReturnAContentString()
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
