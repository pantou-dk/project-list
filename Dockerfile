FROM alpine:latest
COPY site /
ENTRYPOINT ["cp", "-rf", "/site/*", "/var/www/data"]
