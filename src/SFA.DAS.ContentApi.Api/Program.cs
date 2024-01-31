using Microsoft.AspNetCore;
using NLog.Web;
using SFA.DAS.Configuration.AzureTableStorage;
using SFA.DAS.ContentApi.Configuration;
using StructureMap.AspNetCore;

namespace SFA.DAS.ContentApi.Api
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var logger = NLogBuilder.ConfigureNLog("nlog.config").GetCurrentClassLogger();
            logger.Info("Starting up host");

            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration(c => c.AddAzureTableStorage(ContentApiConfigurationKeys.ContentApi))
                .UseNLog()
                .UseStructureMap()
                .UseStartup<Startup>();
    }
}
