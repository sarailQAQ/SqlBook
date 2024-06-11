FROM ubuntu:latest AS Builder
LABEL authors="sarail"

RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list && \
    apt update && apt -y install golang-go ca-certificates git make cmake

COPY darkdb /workspace/src/darkdb

WORKDIR /workspace/src/

#RUN git clone https://github.com/sarailQAQ/darkdb
RUN cd darkdb && make -j8 release && \
    chmod 755 build/release/duckdb

COPY *go* /workspace/src/

RUN export GOPROXY=goproxy.cn && go build -o darkdb-server main.go && chmod 755 darkdb-server

FROM ubuntu:latest AS Runner

COPY --from=Builder /workspace/src/darkdb/build/release/duckdb /usr/bin/duckdb
COPY --from=Builder /workspace/src/darkdb-server /app/darkdb-server

EXPOSE 8080

ENTRYPOINT "/app/darkdb-server"