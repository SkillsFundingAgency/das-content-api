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
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;

namespace SFA.DAS.ContentApi.Api.UnitTests.Controllers.ContentControllerUnitTests
{
    [TestFixture]
    [Parallelizable]
    public class GetTests
    {
        [Test, DomainAutoData]
        public async Task WhenValidParametersAreSupplied_ThenShouldReturnContentResult(
            [Frozen] Mock<IMediator> mediator,
            ContentController controller,
            GetContentQueryResult content,
            string type,
            string clientId)
        {
            //arrange
            mediator.Setup(m => m.Send(It.Is<GetContentQuery>(q => q.Type == type && q.ClientId == clientId), It.IsAny<CancellationToken>()))
                .ReturnsAsync(content);

            //act
            var query = new GetContentQuery
            {
                Type = type,
                ClientId = clientId
            };

            var result = await controller.Get(query, new CancellationToken());

            //assert
            result.Should().BeOfType<ContentResult>();
            ((ContentResult) result).Content.Should().Be(content.Content);
        }
    }
}
