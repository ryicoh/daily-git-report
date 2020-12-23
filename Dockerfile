FROM alpine:3.12

apk add -u git curl

COPY ./daily-git-report /

CMD ./daily-git-report.sh
