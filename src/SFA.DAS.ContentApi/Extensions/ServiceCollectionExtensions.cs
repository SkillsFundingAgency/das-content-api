using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SFA.DAS.ContentApi.Configuration;

namespace SFA.DAS.ContentApi.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddDasDistributedMemoryCache(this IServiceCollection services, IConfiguration configuration, bool isDevelopment)
    {
        if (isDevelopment)
        {
            services.AddDistributedMemoryCache();
        }
        else
        {
            var redisConnectionString = configuration.GetSection(ContentApiConfigurationKeys.ContentApi)
                .Get<ContentApiSettings>()!
                .RedisConnectionString;

            services.AddStackExchangeRedisCache(o => o.Configuration = redisConnectionString);
        }

        return services;
    }
}