FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["Jellyfin.Server/Jellyfin.Server.csproj", "Jellyfin.Server/"]
COPY ["src/Jellyfin.Drawing/Jellyfin.Drawing.csproj", "Jellyfin.Drawing/"]
COPY ["MediaBrowser.Model/MediaBrowser.Model.csproj", "MediaBrowser.Model/"]
COPY ["Jellyfin.Data/Jellyfin.Data.csproj", "Jellyfin.Data/"]
COPY ["src/Jellyfin.Extensions/Jellyfin.Extensions.csproj", "Jellyfin.Extensions/"]
COPY ["MediaBrowser.Controller/MediaBrowser.Controller.csproj", "MediaBrowser.Controller/"]
COPY ["Emby.Naming/Emby.Naming.csproj", "Emby.Naming/"]
COPY ["MediaBrowser.Common/MediaBrowser.Common.csproj", "MediaBrowser.Common/"]
COPY ["Emby.Server.Implementations/Emby.Server.Implementations.csproj", "Emby.Server.Implementations/"]
COPY ["Jellyfin.Api/Jellyfin.Api.csproj", "Jellyfin.Api/"]
COPY ["Emby.Dlna/Emby.Dlna.csproj", "Emby.Dlna/"]
COPY ["RSSDP/RSSDP.csproj", "RSSDP/"]
COPY ["Jellyfin.Networking/Jellyfin.Networking.csproj", "Jellyfin.Networking/"]
COPY ["MediaBrowser.MediaEncoding/MediaBrowser.MediaEncoding.csproj", "MediaBrowser.MediaEncoding/"]
COPY ["src/Jellyfin.MediaEncoding.Hls/Jellyfin.MediaEncoding.Hls.csproj", "Jellyfin.MediaEncoding.Hls/"]
COPY ["src/Jellyfin.MediaEncoding.Keyframes/Jellyfin.MediaEncoding.Keyframes.csproj", "Jellyfin.MediaEncoding.Keyframes/"]
COPY ["Jellyfin.Server.Implementations/Jellyfin.Server.Implementations.csproj", "Jellyfin.Server.Implementations/"]
COPY ["MediaBrowser.Providers/MediaBrowser.Providers.csproj", "MediaBrowser.Providers/"]
COPY ["MediaBrowser.XbmcMetadata/MediaBrowser.XbmcMetadata.csproj", "MediaBrowser.XbmcMetadata/"]
COPY ["MediaBrowser.LocalMetadata/MediaBrowser.LocalMetadata.csproj", "MediaBrowser.LocalMetadata/"]
COPY ["Emby.Photos/Emby.Photos.csproj", "Emby.Photos/"]
COPY ["src/Jellyfin.Drawing.Skia/Jellyfin.Drawing.Skia.csproj", "Jellyfin.Drawing.Skia/"]
RUN dotnet restore "Jellyfin.Server/Jellyfin.Server.csproj"
COPY . .
WORKDIR "/src/Jellyfin.Server"
RUN dotnet build "Jellyfin.Server.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Jellyfin.Server.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "jellyfin.dll"]
