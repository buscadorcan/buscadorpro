# Imagen base para ejecución (más pesada, pero con PowerShell completo)
FROM mcr.microsoft.com/dotnet/aspnet:8.0-windowsservercore-ltsc2019 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Imagen para build
FROM mcr.microsoft.com/dotnet/sdk:8.0-windowsservercore-ltsc2019 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

COPY ["WebApp/WebApp.csproj", "WebApp/"]
COPY ["Core/Core.csproj", "Core/"]
COPY ["DataAccess/DataAccess.csproj", "DataAccess/"]
COPY ["SharedApp/SharedApp.csproj", "SharedApp/"]

RUN dotnet restore "./WebApp/WebApp.csproj"

COPY . .
WORKDIR "/src/WebApp"
RUN dotnet build "./WebApp.csproj" -c %BUILD_CONFIGURATION% -o /app/build

# Publicar
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./WebApp.csproj" -c %BUILD_CONFIGURATION% -o /app/publish /p:UseAppHost=false

# Ejecutar script PowerShell antes de mover a final
COPY SetPermissions.ps1 .
RUN powershell -ExecutionPolicy Bypass -File SetPermissions.ps1

# Imagen final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApp.dll"]
