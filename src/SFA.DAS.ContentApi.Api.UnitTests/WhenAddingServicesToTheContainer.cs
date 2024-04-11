using FluentAssertions;
using MediatR;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.Memory;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Moq;
using NUnit.Framework;
using SFA.DAS.ContentApi.Api.Controllers;
using SFA.DAS.ContentApi.Api.Extensions;
using SFA.DAS.ContentApi.Api.ServiceRegistrations;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

namespace SFA.DAS.ContentApi.Api.UnitTests;

public class WhenAddingServicesToTheContainer
{
    [TestCase(typeof(ContentController))]
    [TestCase(typeof(IRequestHandler<GetContentQuery, GetContentQueryResult>))]
    public void Then_The_Dependencies_Are_Correctly_Resolved(Type toResolve)
    {
        RunTestForType(toResolve);
    }

    private static void RunTestForType(Type toResolve)
    {
        var services = new ServiceCollection();

        SetupServiceCollection(services);

        var provider = services.BuildServiceProvider();
        var type = provider.GetService(toResolve);

        type.Should().NotBeNull();
    }

    private static void SetupServiceCollection(IServiceCollection services)
    {
        var mockHostEnvironment = new Mock<IHostEnvironment>();
        mockHostEnvironment.Setup(x => x.EnvironmentName).Returns(Environments.Development);

        var stubConfiguration = GenerateStubConfiguration();

        services.AddHttpClient();
        services.AddDatabaseRegistration(stubConfiguration, true);
        services.AddSingleton<IConfiguration>(stubConfiguration);
        services.AddHttpContextAccessor();
        services.AddMediatR(x => x.RegisterServicesFromAssemblyContaining<GetContentQueryHandler>());

        services.AddTransient<ContentController>();

        services.AddConfigurationOptions(stubConfiguration);
    }

    private static IConfigurationRoot GenerateStubConfiguration()
    {
        var configSource = new MemoryConfigurationSource
        {
            InitialData = new List<KeyValuePair<string, string>>
            {
                
                new("SFA.DAS.ContentApi:ConfigNames", "SFA.DAS.ContentApi"),
                new("SFA.DAS.ContentApi:APPINSIGHTS_INSTRUMENTATIONKEY", "test"),

                new("SFA.DAS.ContentApi:DatabaseConnectionString", "Data Source=(localDB)\\MSSQLLocalDB;Database=SFA.DAS.ContentApi.Database;Integrated Security = true;Trusted_Connection=True;Pooling=False;Connect Timeout=30;MultipleActiveResultSets=True;ConnectRetryCount=3;ConnectRetryInterval=2"),
                
                new("SFA.DAS.ContentApi:ActiveDirectorySettings:Tenant", "https://test.com/"),
                new("SFA.DAS.ContentApi:AuthenticationSettings:IdentifierUri", "https://test.com/"),
                new("SFA.DAS.ContentApi:AuthenticationSettings:AppId", "TEST"),
            }
        };

        var provider = new MemoryConfigurationProvider(configSource);

        return new ConfigurationRoot(new List<IConfigurationProvider> { provider });
    }
}