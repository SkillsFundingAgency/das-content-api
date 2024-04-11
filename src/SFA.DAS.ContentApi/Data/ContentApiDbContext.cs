using System.Data.SqlClient;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Configuration;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data;

public class ContentApiDbContext : DbContext
{
    private const string AzureResource = "https://database.windows.net/";
    public DbSet<Models.Application> Application { get; set; }
    public DbSet<ApplicationContent> ApplicationContent { get; set; }
    public DbSet<Content> Content { get; set; }
    public DbSet<ContentType> ContentType { get; set; }

    private readonly ContentApiSettings _configuration;
    private readonly AzureServiceTokenProvider _azureServiceTokenProvider;

    public ContentApiDbContext(ContentApiSettings configuration, DbContextOptions options, AzureServiceTokenProvider azureServiceTokenProvider) : base(options)
    {
        _configuration = configuration;
        _azureServiceTokenProvider = azureServiceTokenProvider;
    }

    public virtual Task ExecuteSqlCommandAsync(string sql, params object[] parameters)
    {
        return Database.ExecuteSqlRawAsync(sql, parameters);
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (_configuration == null || _azureServiceTokenProvider == null)
        {
            return;
        }

        var connection = new SqlConnection
        {
            ConnectionString = _configuration.DatabaseConnectionString,
            AccessToken = _azureServiceTokenProvider.GetAccessTokenAsync(AzureResource).Result,
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