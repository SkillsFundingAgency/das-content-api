using NServiceBus;

namespace SFA.DAS.ContentApi.Extensions
{
    public static class NServiceBusExtensions
    {
        private const string NotificationsMessageHandler = "SFA.DAS.Notifications.MessageHandlers";
        public static void AddRouting(this RoutingSettings routingSettings)
        {
        }
    }
}