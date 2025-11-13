FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY ["Hu.Api/Hu.Api.csproj", "Hu.Api/"]
COPY ["Hu.Application/Hu.Application.csproj", "Hu.Application/"]
COPY ["Hu.Domain/Hu.Domain.csproj", "Hu.Domain/"]
COPY ["Hu.Infrastructure/Hu.Infrastructure.csproj", "Hu.Infrastructure/"]

WORKDIR /src/Hu.Api
RUN dotnet restore "Hu.Api.csproj"

COPY . .

RUN dotnet publish "Hu.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "Hu.Api.dll"]
