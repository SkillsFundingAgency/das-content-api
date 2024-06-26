﻿namespace SFA.DAS.ContentApi.Configuration;

public record ActiveDirectorySettings
{
    public string Tenant { get; set; }
    public string IdentifierUri { get; set; }
    public string AppId { get; set; }
}