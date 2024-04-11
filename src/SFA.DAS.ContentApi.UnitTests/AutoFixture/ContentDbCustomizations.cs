using AutoFixture;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.UnitTests.AutoFixture;

public class ContentDbCustomizations : ICustomization
{
    public void Customize(IFixture fixture)
    {
        var perTestDatabaseName = Guid.NewGuid();
        fixture.Register(() => CreateInMemoryProviderDb(perTestDatabaseName));
    }

    private static ContentApiDbContext CreateInMemoryProviderDb(Guid databaseGuid)
    {
        return new ContentApiDbContext(configuration: null,
            new DbContextOptionsBuilder<ContentApiDbContext>().UseInMemoryDatabase(databaseGuid.ToString()).Options,
            azureServiceTokenProvider: null
        );
    }
}