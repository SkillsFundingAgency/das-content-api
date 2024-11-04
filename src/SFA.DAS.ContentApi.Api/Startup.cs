using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Extensions.Logging.ApplicationInsights;
using Microsoft.OpenApi.Models;
using SFA.DAS.ContentApi.Api.Extensions;
using SFA.DAS.ContentApi.Api.ServiceRegistrations;
using SFA.DAS.ContentApi.Application.Queries.GetContentQuery;
using SFA.DAS.ContentApi.Extensions;

namespace SFA.DAS.ContentApi.Api;

public class Startup
{
    private readonly IConfiguration _configuration;
    private readonly IHostEnvironment _environment;

    public Startup(IConfiguration configuration, IHostEnvironment environment)
    {
        _configuration = configuration.BuildDasConfiguration();
        _environment = environment;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddLogging(builder =>
        {
            builder.AddFilter<ApplicationInsightsLoggerProvider>(string.Empty, LogLevel.Information);
            builder.AddFilter<ApplicationInsightsLoggerProvider>("Microsoft", LogLevel.Information);
        });

        services.AddSingleton(new AzureServiceTokenProvider());
        services.AddActiveDirectoryAuthentication(_configuration);
        services.AddControllersWithViews();

        services.AddConfigurationOptions(_configuration);

        services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblyContaining<GetContentQueryHandler>());

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

    public void Configure(IApplicationBuilder app, IHostEnvironment env)
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

        app.Use(async (context, next) =>
        {
            context.Response.OnStarting(() =>
            {
                if (context.Response.Headers.ContainsKey("X-Powered-By"))
                {
                    context.Response.Headers.Remove("X-Powered-By");
                }
             
                return Task.CompletedTask;
            });

            await next();
        });

        app.UseRouting();
        app.UseAuthentication();
        app.UseAuthorization();
        app.UseEndpoints(endpoints => { endpoints.MapDefaultControllerRoute(); });
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