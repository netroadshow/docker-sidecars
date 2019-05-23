FROM netroadshow/aspnet
COPY --from=netroadshow/nginx-sidecar / /
COPY --from=mcr.microsoft.com/dotnet/core/samples:aspnetapp-stretch /app /app
ENV DOTNET_DLL "aspnetapp.dll"
ENV PROXY_URL "http://localhost:80"
