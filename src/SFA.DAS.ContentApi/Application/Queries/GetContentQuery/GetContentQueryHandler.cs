using MediatR;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery
{
    public class GetContentQueryHandler : IRequestHandler<GetContentQuery, GetContentQueryResult>
    {
        private readonly Lazy<ContentApiDbContext> _db;

        public GetContentQueryHandler(Lazy<ContentApiDbContext> db)
        {
            _db = db;
        }

        public async Task<GetContentQueryResult> Handle(GetContentQuery request, CancellationToken cancellationToken)
        {
            var contents = await _db.Value.Application
                .Where(a => a.Identity == request.ApplicationId.ToLower())
                .SelectMany(c => c.ApplicationContent)
                .Where(ac => 
                    ac.Content.ContentType.Value == request.Type.ToLower() &&
                    ac.Content.Active &&
                    (!ac.Content.StartDate.HasValue || ac.Content.StartDate.Value < DateTime.Now) &&
                    (!ac.Content.EndDate.HasValue || ac.Content.EndDate.Value > DateTime.Now))
                .OrderByDescending(a => a.ContentId)
                .Select(ac => ac.Content)
                .FirstOrDefaultAsync(cancellationToken);

            return new GetContentQueryResult(contents != null ? contents.Data : string.Empty);
        }
    }
}
