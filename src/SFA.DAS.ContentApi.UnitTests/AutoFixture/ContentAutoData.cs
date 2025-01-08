using AutoFixture;
using AutoFixture.NUnit3;

namespace SFA.DAS.ContentApi.UnitTests.AutoFixture;

public class ContentAutoDataAttribute() : AutoDataAttribute(() => new Fixture().Customize(new DomainCustomizations()));