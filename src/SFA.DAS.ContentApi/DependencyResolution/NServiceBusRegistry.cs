using System.Data.SqlClient;
using NServiceBus;
using SFA.DAS.AutoConfiguration;
using SFA.DAS.ContentApi.Configuration;
using SFA.DAS.ContentApi.Extensions;
using SFA.DAS.NServiceBus.Configuration;
using SFA.DAS.NServiceBus.Configuration.AzureServiceBus;
using SFA.DAS.NServiceBus.Configuration.NewtonsoftJsonSerializer;
using SFA.DAS.NServiceBus.Configuration.NLog;
using SFA.DAS.NServiceBus.SqlServer.Configuration;
using SFA.DAS.UnitOfWork.NServiceBus.Configuration;
using StructureMap;

namespace SFA.DAS.ContentApi.DependencyResolution
{
    public class NServiceBusRegistry : Registry
    {
        private const string ServiceName = "SFA.DAS.ContentApi";

        public NServiceBusRegistry()
        {
            For<IMessageSession>().Singleton().Use(s => StartNServiceBus(s));
        }

        private IMessageSession StartNServiceBus(IContext context)
        {
            var nServiceBusSettings = context.GetInstance<NServiceBusSettings>();
            var providerSettings = context.GetInstance<ContentApiSettings>();
            var environmentService = context.GetInstance<IEnvironmentService>();

            var endpointName = "SFA.DAS.ContentApi";
            var endpointConfiguration = new EndpointConfiguration(endpointName)
                .UseErrorQueue($"{endpointName}-errors")
                .UseInstallers()
                .UseLicense(nServiceBusSettings.NServiceBusLicense)
                .UseMessageConventions()
                .UseNLogFactory()
                .UseNewtonsoftJsonSerializer()
                .UseOutbox(true)
                .UseSqlServerPersistence(() => new SqlConnection(providerSettings.DatabaseConnectionString))
                .UseUnitOfWork()
                .UseSendOnly();

            if (environmentService.IsCurrent(DasEnv.LOCAL))
            {
                endpointConfiguration.UseLearningTransport(r => r.AddRouting());
            }
            else
            {
                endpointConfiguration.UseAzureServiceBusTransport(nServiceBusSettings.ServiceBusConnectionString, r => r.AddRouting());
            }
            
            var endpoint = Endpoint.Start(endpointConfiguration).GetAwaiter().GetResult();
            return endpoint;
        }
    }
}
