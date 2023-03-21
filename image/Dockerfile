FROM azul/zulu-openjdk-alpine:8u192

RUN apk upgrade --update && \
    apk add --update --no-cache bash curl busybox-extras net-tools iputils nfs-utils nss curl netcat-openbsd lftp openssh-client openssh-server jq && \
    rm -rf /var/cache/apk/*


WORKDIR /app

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

CMD ["entrypoint.sh"]
