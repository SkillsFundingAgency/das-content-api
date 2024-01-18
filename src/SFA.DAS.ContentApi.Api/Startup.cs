using SFA.DAS.ContentApi.Api.DependencyResolution;
using SFA.DAS.ContentApi.Api.Extensions;
using SFA.DAS.ContentApi.Extensions;
using StructureMap;
using System.Reflection;
using Microsoft.OpenApi.Models;

namespace SFA.DAS.ContentApi.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration, IWebHostEnvironment environment)
        {
            Configuration = configuration;
            Environment = environment;
        }

        public IConfiguration Configuration { get; }
        public IWebHostEnvironment Environment { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddActiveDirectoryAuthentication(Configuration);
            services.AddControllersWithViews();

            services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblies(Assembly.GetExecutingAssembly()));

            services.AddDasDistributedMemoryCache(Configuration, Environment.IsDevelopment());

            services.AddDatabaseRegistration(Configuration, Environment.IsDevelopment());

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Version = "v1",
                    Title = "Content API"
                });
            });

            services.AddMemoryCache();
            services.AddHealthChecks();
            services.AddApplicationInsightsTelemetry();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
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

            app.UseRouting();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
            app.UseHttpsRedirection();
            app.UseHealthChecks("/health");

            app.UseSwagger()
                .UseSwaggerUI(c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Content API");
                    c.RoutePrefix = string.Empty;
                });
        }

        public void ConfigureContainer(Registry registry)
        {
            IoC.Initialize(registry);
        }
    }
}
