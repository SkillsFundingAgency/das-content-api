using System.Threading;
using System.Threading.Tasks;
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
            if (string.IsNullOrWhiteSpace(query.Type))
            {
                ModelState.AddModelError(nameof(query.Type), "An invalid content type was supplied");
            }

            if (string.IsNullOrWhiteSpace(query.ClientId))
            {
                ModelState.AddModelError(nameof(query.ClientId), "An invalid client id was supplied");
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _mediator.Send(query, cancellationToken);
            return Content(result.Content);
        }
    }
}