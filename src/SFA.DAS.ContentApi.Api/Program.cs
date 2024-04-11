using NLog;
using NLog.Web;
using SFA.DAS.Configuration.AzureTableStorage;
using SFA.DAS.ContentApi.Configuration;

namespace SFA.DAS.ContentApi.Api;

public class Program
{
    public static void Main(string[] args)
    {
        var logger = LogManager.Setup().LoadConfigurationFromFile("nlog.config").GetCurrentClassLogger();
        logger.Info("Starting up host");

        CreateHostBuilder(args).Build().Run();
    }

    private static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureAppConfiguration(c => c.AddAzureTableStorage(ContentApiConfigurationKeys.ContentApi))
            .ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseStartup<Startup>();
                webBuilder.UseNLog();
            });
}