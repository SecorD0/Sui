FROM ubuntu:20.04

LABEL creator="SecorD >> 1package"
LABEL url="📦 All in https://t.me/OnePackage"

WORKDIR root

COPY entrypoint.sh .

RUN apt update && \
    apt upgrade -y && \
    apt install wget jq -y; \
    apt clean; \
    chmod +x entrypoint.sh

EXPOSE 8080 9000 9184

ENTRYPOINT ["./entrypoint.sh"]
