FROM alpine:3.12

RUN apk add git curl tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" >  /etc/timezone

COPY ./daily-git-report.sh /

CMD ./daily-git-report.sh
