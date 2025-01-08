using AutoFixture;
using AutoFixture.AutoMoq;

namespace SFA.DAS.ContentApi.Api.UnitTests.AutoFixture;

public class DomainCustomizations() : CompositeCustomization(new AutoMoqCustomization { ConfigureMembers = true });