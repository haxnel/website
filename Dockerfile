FROM nginx:stable-alpine

RUN apk add ca-certificates && rm -rf /var/cache/apk* && update-ca-certificates

ADD . var/www/html

RUN mkdir -p /run/nginx

ADD config/nginx.conf /etc/nginx/conf.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \ && ln -sf /dev/stderr /var/log/nginx/error.log

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'