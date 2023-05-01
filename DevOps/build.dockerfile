FROM mcr.microsoft.com/dotnet/sdk:7.0 as base

WORKDIR ../

RUN dotnet build