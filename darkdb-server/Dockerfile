FROM ubuntu:latest AS Builder
LABEL authors="sarail"


RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list && \
    apt update && apt -y install golang-go ca-certificates git make cmake

COPY darkdb /workspace/darkdb

WORKDIR /workspace

#RUN git clone https://github.com/sarailQAQ/darkdb
RUN cd darkdb && make -j8 release && \
    chmod 755 build/release/duckdb && cp build/release/duckdb /usr/bin/duckdb


COPY *go* /workspace/

ENV CGO_ENABLED=1 GOPROXY=goproxy.cn
RUN go build -o duckdb-server main.go && chmod 755 duckdb-server

EXPOSE 8080

ENTRYPOINT "/workspace/duckdb-server"