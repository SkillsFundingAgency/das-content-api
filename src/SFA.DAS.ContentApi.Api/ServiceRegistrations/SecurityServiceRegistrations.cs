﻿using Microsoft.AspNetCore.Authentication.JwtBearer;
using SFA.DAS.ContentApi.Configuration;

namespace SFA.DAS.ContentApi.Api.ServiceRegistrations;

public static class SecurityServiceRegistrations
{
    public static void AddActiveDirectoryAuthentication(this IServiceCollection services, IConfiguration configuration)
    {
        var activeDirectorySettings = configuration.GetSection(ContentApiConfigurationKeys.ActiveDirectorySettings).Get<ActiveDirectorySettings>();

        services.AddAuthorizationBuilder()
            .AddPolicy("default", policy =>
            {
                policy.RequireAuthenticatedUser();
                policy.RequireRole("Default");
            });

        services.AddAuthentication(auth =>
        {
            auth.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
        }).AddJwtBearer(auth =>
        {
            auth.Authority = $"https://login.microsoftonline.com/{activeDirectorySettings?.Tenant}";
            auth.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
            {
                ValidAudiences = activeDirectorySettings?.IdentifierUri.Split(','),
            };
        });
    }
}