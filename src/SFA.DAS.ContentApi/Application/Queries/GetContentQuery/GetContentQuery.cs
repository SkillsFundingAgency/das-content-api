using System.ComponentModel.DataAnnotations;
using MediatR;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

public class GetContentQuery : IRequest<GetContentQueryResult>
{
    [Required]
    public string Type { get; set; }

    [Required]
    public string ApplicationId { get; set; }
}