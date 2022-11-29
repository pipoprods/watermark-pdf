# watermark-pdf

This repository hosts a simple PDF watermarking Web application.

The application is made of a static HTML page that POSTs to a bash CGI script.

The Web server is [mini_httpd](https://acme.com/software/mini_httpd/).

The POST arguments parsing is made through [cgibashopts](https://github.com/ColasNahaboo/cgibashopts).

The watermarking itself depends on:

- imagemagick
- pdftk
- other common dependencies (see Dockerfile for details)

## Run your own

You can run the image I built:

```sh
docker run --rm -t -p 8080:80 pipoprods/watermark-pdf
```

## Build and run your own

You can build your own image and run it:

```sh
docker build . -t watermark-pdf
docker run --rm -t -p 8080:80 watermark-pdf
```
