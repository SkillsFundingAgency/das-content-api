namespace SFA.DAS.ContentApi.Data
{
    public interface IContentApiDbContextFactory
    {
        ContentApiDbContext CreateDbContext();
    }
}