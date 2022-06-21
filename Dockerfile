FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /app
#Copy csproj and restore as distinct layers
Copy *.csproj ./
RUN dotnet restore
#copy everything else and build 
COPY . ./
RUN dotnet publish -c Release -o out
#Build runtime image
FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "demoapplicationwebapi.dll"]