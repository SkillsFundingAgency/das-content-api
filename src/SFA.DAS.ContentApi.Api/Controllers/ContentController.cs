using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

namespace SFA.DAS.ContentApi.Api.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class ContentController(IMediator mediator) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult> Get([FromQuery] GetContentQuery query, CancellationToken cancellationToken)
    {
        var result = await mediator.Send(query, cancellationToken);
        return Content(result.Content);
    }
}