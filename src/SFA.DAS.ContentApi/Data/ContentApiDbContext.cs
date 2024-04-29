using System.Data.SqlClient;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Configuration;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data;

public class ContentApiDbContext(ContentApiSettings? configuration, DbContextOptions options, AzureServiceTokenProvider? azureServiceTokenProvider)
    : DbContext(options)
{
    private const string AzureResource = "https://database.windows.net/";
    public DbSet<Models.Application> Application { get; set; }
    public DbSet<ApplicationContent> ApplicationContent { get; set; }
    public DbSet<Content> Content { get; set; }
    public DbSet<ContentType> ContentType { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (configuration == null || azureServiceTokenProvider == null)
        {
            return;
        }

        var connection = new SqlConnection
        {
            ConnectionString = configuration.DatabaseConnectionString,
            AccessToken = azureServiceTokenProvider.GetAccessTokenAsync(AzureResource).Result,
        };

        optionsBuilder.UseSqlServer(connection, options =>
            options.EnableRetryOnFailure(
                5,
                TimeSpan.FromSeconds(20),
                null
            ));
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ContentApiDbContext).Assembly);
    }
}