namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

public record GetContentQueryResult
{
    public GetContentQueryResult(string content)
    {
            Content = content;
        }

    public string Content { get; }
}