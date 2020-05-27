using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data
{
    public class ContentApiDbContext : DbContext
    {
        public DbSet<Models.Application> Application { get; set; }
        public  DbSet<ApplicationContent> ApplicationContent { get; set; }
        public DbSet<Content> Content { get; set; }
        public DbSet<ContentType> ContentType { get; set; }

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
            modelBuilder.ApplyConfiguration(new ApplicationConfiguration());
            modelBuilder.ApplyConfiguration(new ContentConfiguration());
            modelBuilder.ApplyConfiguration(new ContentTypeConfiguration());
            modelBuilder.ApplyConfiguration(new ApplicationContentConfiguration());
        }
    }
}