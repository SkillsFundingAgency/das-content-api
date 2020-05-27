using System.Collections.Generic;

namespace SFA.DAS.ContentApi.Models
{
    public class Application : Entity
    {
        public long Id { get; set; }

        public string Description { get; set; }

        public string Identity { get; set; }

        public ICollection<ApplicationContent> ApplicationContent { get; set; }
    }
}
