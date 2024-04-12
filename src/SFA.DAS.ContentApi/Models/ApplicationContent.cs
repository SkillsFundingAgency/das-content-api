namespace SFA.DAS.ContentApi.Models;

public record ApplicationContent
{
    public long Id { get; set; }

    public long ApplicationId { get; set; }

    public Application Application { get; set; }

    public long ContentId { get; set; }

    public Content Content { get; set; }
}