using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SFA.DAS.ContentApi.Api.DependencyResolution;
using SFA.DAS.ContentApi.Api.Extensions;
using SFA.DAS.ContentApi.Extensions;
using StructureMap;

namespace SFA.DAS.ContentApi.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration, IHostingEnvironment environment)
        {
            Configuration = configuration;
            Environment = environment;
        }

        public IConfiguration Configuration { get; }
        public IHostingEnvironment Environment { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddActiveDirectoryAuthentication(Configuration);
            services.AddMvc(options =>
            {
                if (!Environment.IsDevelopment())
                {
                    options.Filters.Add(new AuthorizeFilter("default"));
                }
            }).SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddDasDistributedMemoryCache(Configuration, Environment.IsDevelopment());

            services.AddDatabaseRegistration(Configuration, Environment.IsDevelopment());

            services.AddMemoryCache();
            services.AddHealthChecks();
            services.AddApplicationInsightsTelemetry();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
                app.UseAuthentication();
            }

            app.UseHttpsRedirection();
            app.UseMvc();
            app.UseHealthChecks("/health");
        }

        public void ConfigureContainer(Registry registry)
        {
            IoC.Initialize(registry);
        }
    }
}
