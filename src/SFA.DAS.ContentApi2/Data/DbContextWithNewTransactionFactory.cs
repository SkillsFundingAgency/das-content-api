using System.Data.Common;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using SFA.DAS.AutoConfiguration;

namespace SFA.DAS.ContentApi.Data
{
    public class DbContextWithNewTransactionFactory : IContentApiDbContextFactory
    {
        private readonly DbConnection _dbConnection;
        private readonly IEnvironmentService _environmentService;
        private readonly ILoggerFactory _loggerFactory;

        public DbContextWithNewTransactionFactory(DbConnection dbConnection, IEnvironmentService environmentService, ILoggerFactory loggerFactory)
        {
            _dbConnection = dbConnection;
            _environmentService = environmentService;
            _loggerFactory = loggerFactory;
        }

        public ContentApiDbContext CreateDbContext()
        {
            var optionsBuilder = new DbContextOptionsBuilder<ContentApiDbContext>()
                .UseSqlServer(_dbConnection);

            if (_environmentService.IsCurrent(DasEnv.LOCAL))
            {
                optionsBuilder.UseLoggerFactory(_loggerFactory);
            }

            var dbContext = new ContentApiDbContext(optionsBuilder.Options);

            return dbContext;
        }
    }
}