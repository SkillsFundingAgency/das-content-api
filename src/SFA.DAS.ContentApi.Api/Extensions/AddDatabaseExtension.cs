using System;
using System.Data;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SFA.DAS.ContentApi.Configuration;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.Api.Extensions
{
    public static class AddDatabaseExtension
    {
        public static void AddDatabaseRegistration(this IServiceCollection services, IConfiguration configuration, bool isDevelopment)
        {
            var databaseConnectionString = configuration.GetSection(ContentApiConfigurationKeys.ContentApi).Get<ContentApiSettings>().DatabaseConnectionString;

            if (isDevelopment)
            {   
                services.AddDbContext<ContentApiDbContext>(options => options.UseSqlServer(databaseConnectionString), ServiceLifetime.Transient);
            }
            else
            {
                services.AddSingleton(new AzureServiceTokenProvider());
                //services.AddDbContext<ContentApiDbContext>(options => options.UseSqlServer(databaseConnectionString), ServiceLifetime.Transient);
                services.AddDbContext<ContentApiDbContext>(ServiceLifetime.Transient);
            }

            var optionsBuilder = new DbContextOptionsBuilder<ContentApiDbContext>();
             //.UseSqlServer(databaseConnectionString)
             //.ConfigureWarnings(w => w.Throw(RelationalEventId.QueryClientEvaluationWarning));
            
            var dbContext = new ContentApiDbContext(configuration, optionsBuilder.Options, new AzureServiceTokenProvider());

            //services.AddTransient<IContentApiDbContextFactory, DbContextWithNewTransactionFactory>(c => c.GetService<DbContextWithNewTransactionFactory>());            
            //services.AddTransient(c => new Lazy<ContentApiDbContext>(c.GetService<ContentApiDbContext>()));
        }
    }
}
