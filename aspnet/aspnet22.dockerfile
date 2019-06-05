FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim
RUN useradd nginx && \
    touch /var/log/dotnet.log
COPY --from=netroadshow/nginx-sidecar / /
COPY fs/ /

# This is typically the default for ASP.NET Core applications, but a path to a .sock file would work too
ENV PROXY_URL "localhost:5000"
ENV DOTNET_DLL "Service.dll"

EXPOSE 443

#Start all services
CMD ["/etc/start.d/monit.sh"]
