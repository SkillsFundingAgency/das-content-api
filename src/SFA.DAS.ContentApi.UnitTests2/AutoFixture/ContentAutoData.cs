using AutoFixture;
using AutoFixture.NUnit3;

namespace SFA.DAS.ContentApi.UnitTests.AutoFixture
{
    public class ContentAutoDataAttribute : AutoDataAttribute
    {
        public ContentAutoDataAttribute() : base(() => new Fixture().Customize(new DomainCustomizations()))
        {
        }
    }
}
