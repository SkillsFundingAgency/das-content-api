namespace SFA.DAS.ContentApi.Configuration;

public record ContentApiSettings 
{
    public string DatabaseConnectionString { get; set; }

    public string RedisConnectionString { get; set; }
}