using AutoFixture;
using AutoFixture.AutoMoq;

namespace SFA.DAS.ContentApi.UnitTests.AutoFixture
{
    public class DomainCustomizations : CompositeCustomization
    {
        public DomainCustomizations() : base(
            new AutoMoqCustomization { ConfigureMembers = true },
            new ContentDbCustomizations())
        {
        }
    }
}
