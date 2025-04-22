FROM alpine:3.19 AS builder

RUN apk add --no-cache gcc libc-dev make openssl-dev pcre-dev zlib-dev linux-headers
ARG NGINX_VERSION=1.25.4
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" && \
    tar -zxf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure \
        --with-stream \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-http_ssl_module \
        --prefix=/usr/local/nginx && \
    make && make install

FROM alpine:3.19
COPY --from=builder /usr/local/nginx /usr/local/nginx
RUN apk add --no-cache pcre zlib openssl certbot curl && \
    curl -sSL https://github.com/hairyhenderson/gomplate/releases/download/v4.3.1/gomplate_linux-amd64 -o /usr/local/bin/gomplate && \
    chmod +x /usr/local/bin/gomplate 
RUN mkdir -p /var/www/html && \
    chmod -R 755 /var/www/html && \
    chown -R nobody:nobody /var/www/html

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
