using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Api.Extensions;
using SFA.DAS.ContentApi.Configuration;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.Api.ServiceRegistrations;

public static class DatabaseServiceRegistrations
{
    public static void AddDatabaseRegistration(this IServiceCollection services, IConfiguration configuration, bool isDevelopment)
    {
        var databaseConnectionString = configuration.GetSection(ContentApiConfigurationKeys.ContentApi).Get<ContentApiSettings>()?.DatabaseConnectionString;

        if (isDevelopment)
        {
            services.AddDbContext<ContentApiDbContext>(options => options.UseSqlServer(databaseConnectionString));
        }
        else
        {
            services.AddSingleton(new AzureServiceTokenProvider());
            services.AddDbContext<ContentApiDbContext>(builder =>
            {
                var connection = DatabaseExtensions.GetSqlConnection(databaseConnectionString);
                builder.UseSqlServer(connection);
            });
        }

        services.AddScoped(c => new Lazy<ContentApiDbContext?>(c.GetService<ContentApiDbContext>()));
    }
}