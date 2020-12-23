FROM alpine:3.12

RUN apk add git curl
COPY ./daily-git-report.sh /

CMD ./daily-git-report.sh
