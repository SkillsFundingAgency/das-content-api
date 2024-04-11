using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SFA.DAS.ContentApi.Data;

public class ApplicationConfiguration : IEntityTypeConfiguration<Models.Application>
{
    public void Configure(EntityTypeBuilder<Models.Application> builder)
    {
        builder.Property(a => a.Id).ValueGeneratedNever();
        builder.Property(a => a.Description).HasColumnType("varchar(100)");
        builder.Property(a => a.Identity).IsRequired().HasColumnType("varchar(50)");
    }
}