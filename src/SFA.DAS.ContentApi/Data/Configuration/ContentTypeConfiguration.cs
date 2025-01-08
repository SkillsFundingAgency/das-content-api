using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data.Configuration;

public class ContentTypeConfiguration : IEntityTypeConfiguration<ContentType>
{
    public void Configure(EntityTypeBuilder<ContentType> builder)
    {
        builder.Property(ct => ct.Id).ValueGeneratedNever();
        builder.Property(ct => ct.Value).IsRequired().HasColumnType("varchar(20)");
    }
}