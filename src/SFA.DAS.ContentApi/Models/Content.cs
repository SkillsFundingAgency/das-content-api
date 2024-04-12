namespace SFA.DAS.ContentApi.Models;

public record Content
{
    public long Id { get; set; }

    public ContentType ContentType { get; set; }

    public string Data { get; set; }

    public DateTime? StartDate { get; set; }

    public DateTime? EndDate { get; set; }

    public bool Active { get; set; }

    public ICollection<ApplicationContent> ApplicationContent { get; set; }
}