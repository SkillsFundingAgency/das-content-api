﻿using AutoMapper;
using StructureMap;

namespace SFA.DAS.ContentApi.DependencyResolution
{
    public class MapperRegistry : Registry
    {
        public MapperRegistry()
        {
            For<IConfigurationProvider>().Use(c => new MapperConfiguration(cfg => cfg.AddMaps(AppDomain.CurrentDomain.GetAssemblies().Where(a => a.FullName.StartsWith("SFA.DAS"))))).Singleton();
            For<IMapper>().Use(c => c.GetInstance<IConfigurationProvider>().CreateMapper()).Singleton();
        }
    }
}