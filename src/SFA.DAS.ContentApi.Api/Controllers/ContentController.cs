using MediatR;
using Microsoft.AspNetCore.Mvc;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

namespace SFA.DAS.ContentApi.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ContentController : ControllerBase
    {
        private readonly IMediator _mediator;

        public ContentController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<ActionResult> Get([FromQuery] GetContentQuery query, CancellationToken cancellationToken)
        {
            var result = await _mediator.Send(query, cancellationToken);
            return Content(result.Content);
        }
    }
}
