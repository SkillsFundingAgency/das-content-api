using MediatR;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery
{
    public class GetContentQuery : IRequest<GetContentQueryResult>
    {
        public string Type { get; set; }

        public string ClientId { get; set; }
    }
}
