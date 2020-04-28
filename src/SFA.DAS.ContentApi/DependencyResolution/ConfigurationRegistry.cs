using Microsoft.Extensions.Configuration;
using SFA.DAS.AutoConfiguration.DependencyResolution;
using SFA.DAS.ContentApi.Configuration;
using StructureMap;

namespace SFA.DAS.ContentApi.DependencyResolution
{
    public class ConfigurationRegistry : Registry
    {
        public ConfigurationRegistry()
        {
            IncludeRegistry<AutoConfigurationRegistry>();
            AddConfiguration<ActiveDirectorySettings>(ContentApiConfigurationKeys.ActiveDirectorySettings);
            AddConfiguration<ContentApiSettings>(ContentApiConfigurationKeys.ContentApi);
            AddConfiguration<NServiceBusSettings>(ContentApiConfigurationKeys.NServiceBusSettings);
        }

        private void AddConfiguration<T>(string key) where T : class
        {
            For<T>().Use(c => GetConfiguration<T>(c, key)).Singleton();
        }

        private T GetConfiguration<T>(IContext context, string name)
        {
            var configuration = context.GetInstance<IConfiguration>();
            var section = configuration.GetSection(name);
            var value = section.Get<T>();

            return value;
        }
    }
}