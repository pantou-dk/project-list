FROM alpine:latest
COPY site /site/
ENTRYPOINT ["cp", "-rf", "/site/*", "/var/www/data"]
