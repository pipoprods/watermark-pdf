FROM alpine:latest

RUN apk add --update mini_httpd bash grep sed coreutils moreutils poppler-utils imagemagick ghostscript ttf-dejavu openjdk17
COPY mini-httpd.conf /etc/mini_httpd.conf

# https://gitlab.com/pdftk-java/pdftk/-/releases
COPY pdftk/pdftk /usr/local/bin/
COPY pdftk/pdftk-all.jar /usr/local/share/

COPY watermark-pdf.sh /usr/local/bin
COPY app/ /var/www/

EXPOSE 80

CMD [ "mini_httpd", "-C", "/etc/mini_httpd.conf", "-D" ]
