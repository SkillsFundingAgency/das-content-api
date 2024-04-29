using System.ComponentModel.DataAnnotations;
using MediatR;

namespace SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

public record GetContentQuery : IRequest<GetContentQueryResult>
{
    [Required]
    public string Type { get; set; }

    [Required]
    public string ApplicationId { get; set; }
}