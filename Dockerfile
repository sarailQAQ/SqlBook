FROM docker.io/library/rust:latest AS Builder
LABEL authors="sarail"

COPY src  /workspace/src
COPY examples /workspace/examples
COPY Cargo* /workspace

RUN mkdir -vp ${CARGO_HOME:-$HOME/.cargo} && \
    cd /workspace/ && \
    cargo build --release

FROM ubuntu:latest AS Runner

COPY --from=ccr.ccs.tencentyun.com/dase314/darkdb-server:latest /usr/bin/duckdb /usr/bin/duckdb
COPY --from=ccr.ccs.tencentyun.com/dase314/darkdb-server:latest /app/darkdb-server /app/darkdb-server

COPY --from=Builder --chmod=755 /workspace/target/release/mdbook /app/mdbook

COPY sql_book /app/sql_book

COPY scripts/entrypoont_cmd.sh /app/cmd.sh

WORKDIR /app

ENTRYPOINT ["bash", "cmd.sh"]