FROM alpine:latest
COPY site /
COPY copy-site.sh /
RUN chmod 755 /copy-site.sh
ENTRYPOINT ["/copy-site.sh"]
