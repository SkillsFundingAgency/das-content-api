using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using NServiceBus.Persistence;
using SFA.DAS.AutoConfiguration;
using SFA.DAS.NServiceBus.SqlServer.Data;
using SFA.DAS.UnitOfWork.Context;

namespace SFA.DAS.ContentApi.Data
{
    public class DbContextWithNServiceBusTransactionFactory : IContentApiDbContextFactory
    {
        private readonly IEnvironmentService _environmentService;
        private readonly IUnitOfWorkContext _unitOfWorkContext;
        private readonly ILoggerFactory _loggerFactory;

        public DbContextWithNServiceBusTransactionFactory(IEnvironmentService environmentService, IUnitOfWorkContext unitOfWorkContext, ILoggerFactory loggerFactory)
        {
            _environmentService = environmentService;
            _unitOfWorkContext = unitOfWorkContext;
            _loggerFactory = loggerFactory;
        }

        public ContentApiDbContext CreateDbContext()
        {
            var synchronizedStorageSession = _unitOfWorkContext.Find<SynchronizedStorageSession>();
            var sqlStorageSession = synchronizedStorageSession.GetSqlStorageSession();

            var optionsBuilder = new DbContextOptionsBuilder<ContentApiDbContext>()
                .UseSqlServer(sqlStorageSession.Connection)
                .ConfigureWarnings(w => w.Throw(RelationalEventId.QueryClientEvaluationWarning));

            if (_environmentService.IsCurrent(DasEnv.LOCAL))
            {
                optionsBuilder.UseLoggerFactory(_loggerFactory);
            }

            var dbContext = new ContentApiDbContext(optionsBuilder.Options);

            dbContext.Database.UseTransaction(sqlStorageSession.Transaction);

            return dbContext;
        }
    }
}