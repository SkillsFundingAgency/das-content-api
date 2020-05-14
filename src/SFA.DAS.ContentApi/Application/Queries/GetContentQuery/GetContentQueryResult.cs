namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery
{
    public class GetContentQueryResult
    {
        public GetContentQueryResult(string content)
        {
            Content = content;
        }

        public string Content { get; }
    }
}
