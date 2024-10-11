ARG VERSION
FROM caddy:${VERSION}

ARG TZ
ENV TZ=${TZ}

ENV APK_ADD="tzdata nss-tools curl"

RUN apk add --update --no-cache ${APK_ADD} \
 && mkdir /etc/caddy/sites-enabled

COPY /etc/caddy/Caddyfile /etc/caddy/Caddyfile
