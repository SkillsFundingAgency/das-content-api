using MediatR;
using Microsoft.EntityFrameworkCore;
using SFA.DAS.ContentApi.Data;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

public class GetContentQueryHandler(Lazy<ContentApiDbContext> db) : IRequestHandler<GetContentQuery, GetContentQueryResult>
{
    public async Task<GetContentQueryResult> Handle(GetContentQuery request, CancellationToken cancellationToken)
    {
        var contents = await db.Value.Application
            .Where(application => application.Identity == request.ApplicationId.ToLower())
            .SelectMany(c => c.ApplicationContent)
            .Where(content =>
                content.Content.ContentType.Value == request.Type.ToLower() &&
                content.Content.Active &&
                (!content.Content.StartDate.HasValue || content.Content.StartDate.Value < DateTime.Now) &&
                (!content.Content.EndDate.HasValue || content.Content.EndDate.Value > DateTime.Now))
            .OrderByDescending(a => a.ContentId)
            .Select(ac => ac.Content)
            .FirstOrDefaultAsync(cancellationToken);

        return new GetContentQueryResult(contents != null ? contents.Data : string.Empty);
    }
}