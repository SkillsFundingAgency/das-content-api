using MediatR;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery
{
    public class GetContentQuery : IRequest<string>
    {
        public string Type { get; set; }

        public string ClientId { get; set; }
    }
}
