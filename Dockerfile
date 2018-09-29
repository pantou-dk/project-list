FROM alpine:latest
COPY site /site/
ENTRYPOINT ["cp", "-Rf", "/site/.", "/var/www/data/"]
