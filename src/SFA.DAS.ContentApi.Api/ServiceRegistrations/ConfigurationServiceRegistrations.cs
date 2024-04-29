using SFA.DAS.ContentApi.Configuration;

namespace SFA.DAS.ContentApi.Api.ServiceRegistrations;

public static class ConfigurationServiceRegistrations
{
    public static IServiceCollection AddConfigurationOptions(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddOptions();
        
        services.AddConfigurationFor<ActiveDirectorySettings>(configuration, ContentApiConfigurationKeys.ActiveDirectorySettings);
        services.AddConfigurationFor<ContentApiSettings>(configuration, ContentApiConfigurationKeys.ContentApi);

        return services;
    }
    
    private static void AddConfigurationFor<T>(this IServiceCollection services, IConfiguration configuration,
        string key) where T : class => services.AddSingleton(GetConfigurationFor<T>(configuration, key));

    private static T? GetConfigurationFor<T>(IConfiguration configuration, string name)
    {
        var section = configuration.GetSection(name);
        return section.Get<T>();
    }
}