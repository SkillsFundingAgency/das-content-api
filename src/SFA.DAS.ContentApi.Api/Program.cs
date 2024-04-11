using Microsoft.AspNetCore;
using NLog;
using NLog.Web;
using SFA.DAS.Configuration.AzureTableStorage;
using SFA.DAS.ContentApi.Configuration;
using StructureMap.AspNetCore;

namespace SFA.DAS.ContentApi.Api;

public class Program
{
    public static void Main(string[] args)
    {
        var logger = LogManager.Setup().LoadConfigurationFromFile("nlog.config").GetCurrentClassLogger();
        logger.Info("Starting up host");

        CreateWebHostBuilder(args).Build().Run();
    }

    private static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
        WebHost.CreateDefaultBuilder(args)
            .ConfigureAppConfiguration(c => c.AddAzureTableStorage(ContentApiConfigurationKeys.ContentApi))
            .UseNLog()
            .UseStructureMap()
            .UseStartup<Startup>();
}