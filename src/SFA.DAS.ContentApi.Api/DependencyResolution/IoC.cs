using SFA.DAS.ContentApi.DependencyResolution;
using StructureMap;

namespace SFA.DAS.ContentApi.Api.DependencyResolution
{
    public static class IoC
    {
        public static void Initialize(Registry registry)
        {
            registry.IncludeRegistry<ConfigurationRegistry>();
            registry.IncludeRegistry<MediatorRegistry>(); 
            //registry.IncludeRegistry<DataRegistry>();
            registry.IncludeRegistry<MapperRegistry>();
            registry.IncludeRegistry<DefaultRegistry>();
        }
    }
}