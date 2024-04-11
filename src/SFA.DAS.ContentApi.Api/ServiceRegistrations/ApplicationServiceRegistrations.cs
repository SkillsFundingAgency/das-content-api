using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.Api.ServiceRegistrations;

public static class ApplicationServiceRegistrations
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddTransient<IContentApiDbContextFactory, DbContextWithNewTransactionFactory>();
        
        return services;
    }
}