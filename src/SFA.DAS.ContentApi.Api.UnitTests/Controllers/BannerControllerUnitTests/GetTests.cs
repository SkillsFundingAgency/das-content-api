using System.Threading;
using System.Threading.Tasks;
using AutoFixture.NUnit3;
using FluentAssertions;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Moq;
using NUnit.Framework;
using SFA.DAS.ContentApi.Api.Controllers;
using SFA.DAS.ContentApi.Api.UnitTests.AutoFixture;
using SFA.DAS.ContentApi.Application.Queries.GetBannerQuery;
using SFA.DAS.ContentApi.Types;

namespace SFA.DAS.ContentApi.Api.UnitTests.Controllers.BannerControllerUnitTests
{
    [TestFixture]
    [Parallelizable]
    public class GetTests
    {
        [Test, DomainAutoData]
        public async Task WhenValidParametersAreSupplied_ThenShouldReturnBannerFromQuery(
            [Frozen] Mock<IMediator> mediator,
            BannerController controller,
            GetBannerQueryResult queryResult,
            bool useLegacyStyle)
        {
            //arrange
            mediator.Setup(m => m.Send(It.Is<GetBannerQuery>(q => q.UseLegacyStyle == useLegacyStyle), It.IsAny<CancellationToken>()))
                .ReturnsAsync(queryResult);

            //act
            var result = await controller.Get(useLegacyStyle, new CancellationToken());

            //assert
            result.Should().BeOfType<OkObjectResult>()
                .Which.Value.Should().BeOfType<BannerDto>()
                .Which.Should().BeEquivalentTo(queryResult.Banner);
        }
    }
}
