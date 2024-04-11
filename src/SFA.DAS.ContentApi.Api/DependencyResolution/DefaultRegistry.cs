using SFA.DAS.ContentApi.Data;
using StructureMap;

namespace SFA.DAS.ContentApi.Api.DependencyResolution;

public class DefaultRegistry : Registry
{
    private const string ServiceName = "SFA.DAS.ContentApi";

    public DefaultRegistry()
    {
        Scan(
            scan =>
            {
                scan.AssembliesFromApplicationBaseDirectory(a => a.GetName().Name.StartsWith(ServiceName));
                scan.RegisterConcreteTypesAgainstTheFirstInterface();
            });

        For<IContentApiDbContextFactory>().Use<DbContextWithNewTransactionFactory>();
    }
}