namespace SFA.DAS.ContentApi.Models;

public record Application 
{
    public long Id { get; set; }

    public string Description { get; set; }

    public string Identity { get; set; }

    public ICollection<ApplicationContent> ApplicationContent { get; set; }
}