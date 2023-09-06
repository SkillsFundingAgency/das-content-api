using System;
using AutoFixture;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.UnitTests.AutoFixture
{
    public class ContentDbCustomizations : ICustomization
    {
        public void Customize(IFixture fixture)
        {
            var perTestDatabaseName = Guid.NewGuid();
            fixture.Register(() => CreateInMemoryProviderDb(perTestDatabaseName));
            fixture.Register(CreateMappings);
        }

        private IConfigurationProvider CreateMappings()
        {
            return new MapperConfiguration(c =>
            {
            });
        }

        private ContentApiDbContext CreateInMemoryProviderDb(Guid databaseGuid)
        {
            return new ContentApiDbContext(
                    new DbContextOptionsBuilder<ContentApiDbContext>().
                    UseInMemoryDatabase(databaseGuid.ToString()).Options);
        }
    }
}
