FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Hu.Api/Hu.Api.csproj", "Hu.Api/"]
COPY ["Hu.Application/Hu.Application.csproj", "Hu.Application/"]
COPY ["Hu.Domain/Hu.Domain.csproj", "Hu.Domain/"]
COPY ["Hu.Infrastructure/Hu.Infrastructure.csproj", "Hu.Infrastructure/"]
RUN dotnet restore "Hu.Api/Hu.Api.csproj"
COPY . .
WORKDIR "/src/Hu.Api"
RUN dotnet build "./Hu.Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Hu.Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Hu.Api.dll"]
