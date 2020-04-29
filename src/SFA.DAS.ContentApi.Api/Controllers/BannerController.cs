using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using SFA.DAS.ContentApi.Application.Queries.GetBannerQuery;

namespace SFA.DAS.ContentApi.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BannerController : ControllerBase
    {
        private readonly IMediator _mediator;

        public BannerController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<ActionResult> Get(CancellationToken cancellationToken)
        {
            var result = await _mediator.Send(new GetBannerQuery(), cancellationToken);

            return Ok(result.Banner);
        }
    }
}