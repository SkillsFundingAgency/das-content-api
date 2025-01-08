using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SFA.DAS.ContentApi.Models;

namespace SFA.DAS.ContentApi.Data.Configuration;

public class ApplicationContentConfiguration : IEntityTypeConfiguration<ApplicationContent>
{
    public void Configure(EntityTypeBuilder<ApplicationContent> builder)
    {
        builder.Property(ac => ac.Id).ValueGeneratedNever();

        builder.HasKey(ac => new {ac.ApplicationId, ac.ContentId});

        builder.HasOne<Content>(ac => ac.Content)
            .WithMany(c => c.ApplicationContent)
            .HasForeignKey(ac => ac.ContentId);

        builder.HasOne<Models.Application>(ac => ac.Application)
            .WithMany(a => a.ApplicationContent)
            .HasForeignKey(ac => ac.ApplicationId);
    }
}