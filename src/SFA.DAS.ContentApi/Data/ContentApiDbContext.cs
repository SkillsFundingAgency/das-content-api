using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data
{
    public class ContentApiDbContext : DbContext
    {
        public ContentApiDbContext(DbContextOptions<ContentApiDbContext> options) : base(options)
        {
        }

        protected ContentApiDbContext()
        {
        }

        public virtual Task ExecuteSqlCommandAsync(string sql, params object[] parameters)
        {
            return Database.ExecuteSqlCommandAsync(sql, parameters);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }
    }
}