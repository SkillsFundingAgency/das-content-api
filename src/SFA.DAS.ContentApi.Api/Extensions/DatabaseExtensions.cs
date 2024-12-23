using System.Data.Common;
using Azure.Core;
using Azure.Identity;
using Microsoft.Data.SqlClient;

namespace SFA.DAS.ContentApi.Api.Extensions;

public static class DatabaseExtensions
{
    private const string AzureResource = "https://database.windows.net/";

    // Take advantage of ChainedTokenCredential's built-in caching
    private static readonly ChainedTokenCredential AzureServiceTokenProvider = new(
        new ManagedIdentityCredential(),
        new AzureCliCredential(),
        new VisualStudioCodeCredential(),
        new VisualStudioCredential());

    public static DbConnection GetSqlConnection(string? connectionString)
    {
        ArgumentNullException.ThrowIfNull(connectionString);

        var connectionStringBuilder = new SqlConnectionStringBuilder(connectionString);
        var useManagedIdentity = !connectionStringBuilder.IntegratedSecurity && string.IsNullOrEmpty(connectionStringBuilder.UserID);

        if (!useManagedIdentity)
        {
            return new SqlConnection(connectionString);
        }

        return new SqlConnection
        {
            ConnectionString = connectionString,
            AccessToken = AzureServiceTokenProvider.GetToken(new TokenRequestContext(scopes: [AzureResource])).Token
        };
    }
}