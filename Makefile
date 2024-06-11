.PHONY: sever
server:
	cd darkdb-server && \
	sudo docker build -t ccr.ccs.tencentyun.com/dase314/duckdb-server:latest .

