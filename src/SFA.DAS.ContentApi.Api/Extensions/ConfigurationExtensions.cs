﻿using SFA.DAS.Configuration.AzureTableStorage;

namespace SFA.DAS.ContentApi.Api.Extensions;

public static class ConfigurationExtensions
{
    public static IConfiguration BuildDasConfiguration(this IConfiguration configuration)
    {
        var config = new ConfigurationBuilder()
            .AddConfiguration(configuration)
            .SetBasePath(Directory.GetCurrentDirectory());

#if DEBUG
        config.AddJsonFile("appsettings.json", false)
            .AddJsonFile("appsettings.Development.json", true);

#endif

        config.AddEnvironmentVariables();

        config.AddAzureTableStorage(options =>
            {
                options.ConfigurationKeys = configuration["ConfigNames"]?.Split(",");
                options.StorageConnectionString = configuration["ConfigurationStorageConnectionString"];
                options.EnvironmentName = configuration["EnvironmentName"];
                options.PreFixConfigurationKeys = true;
            }
        );

        return config.Build();
    }
}