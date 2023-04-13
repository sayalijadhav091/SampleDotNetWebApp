 FROM mcr.microsoft.com/dotnet/core/aspnet:5.0-buster-slim AS base
 WORKDIR /app
 EXPOSE 80
 FROM mcr.microsoft.com/dotnet/core/sdk:5.0-buster AS build
 WORKDIR /src
 COPY ["SampleDotNetWebapp.csproj", ""]
 RUN dotnet restore "./SampleDotNetWebapp.csproj"
 COPY . .
 WORKDIR "/src/."
 RUN dotnet build "SampleDotNetWebapp.csproj" -c Release -o /app/build
 FROM build AS publish
 RUN dotnet publish "SampleDotNetWebapp.csproj" -c Release -o /app/publish
 FROM base AS final
 WORKDIR /app
 COPY --from=publish /app/publish .
 ENTRYPOINT ["dotnet", "SampleDotNetWebapp.dll"]
