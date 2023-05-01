FROM mcr.microsoft.com/dotnet/sdk:7.0 as base

# RUN apt-get update && apt-get install -y git
# RUN git clone https://github.com/BartekBanas/jellyfin

WORKDIR /jellyfin

RUN dotnet build