using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data;

public class ContentConfiguration : IEntityTypeConfiguration<Content>
{
    public void Configure(EntityTypeBuilder<Content> builder)
    {
        builder.Property(c => c.Id).ValueGeneratedNever(); 
        builder.Property(c => c.Data).HasColumnType("varchar(MAX)");
        builder.Property(c => c.StartDate).HasColumnType("datetime");
        builder.Property(c => c.EndDate).HasColumnType("datetime");
        builder.Property(c => c.Active).IsRequired().HasColumnType("bit");
    }
}