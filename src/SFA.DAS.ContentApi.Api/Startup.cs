using System.Reflection;
using Microsoft.OpenApi.Models;
using SFA.DAS.ContentApi.Api.Extensions;
using SFA.DAS.ContentApi.Api.ServiceRegistrations;
using SFA.DAS.ContentApi.Extensions;

namespace SFA.DAS.ContentApi.Api;

public class Startup
{
    private readonly IConfiguration _configuration;
    private readonly IWebHostEnvironment _environment;
    
    public Startup(IConfiguration configuration, IWebHostEnvironment environment)
    {
        _configuration = configuration;
        _environment = environment;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddActiveDirectoryAuthentication(_configuration);
        services.AddControllersWithViews();

        services.AddApplicationServices();
        services.AddConfigurationOptions(_configuration);

        services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblies(Assembly.GetExecutingAssembly()));
        
        services.AddDasDistributedMemoryCache(_configuration, _environment.IsDevelopment());

        services.AddDatabaseRegistration(_configuration, _environment.IsDevelopment());

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
}