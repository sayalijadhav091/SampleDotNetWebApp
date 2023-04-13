FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["SampleDotNetWebapp.csproj", ""]
RUN dotnet restore "./SampleDotNetWebapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "SampleDotNetWebapp.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "SampleDotNetWebapp.csproj" -c Release -o /app/publish
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SampleDotNetWebapp.dll"]

