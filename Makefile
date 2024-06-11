.PHONY: sever
server:
	cd darkdb-server && \
	git submodule init && git submodule update && \
	podman build -t ccr.ccs.tencentyun.com/dase314/darkdb-server:latest . && \
	echo "build darkdb-server finished"

.PHONY: book
book: server
	podman build --http-proxy=false --network=host -t ccr.ccs.tencentyun.com/dase314/sql-book:latest . && \
	echo "build book finished"

.PHONY: push
push: book
	podman push ccr.ccs.tencentyun.com/dase314/darkdb-server:latest && \
	podman push ccr.ccs.tencentyun.com/dase314/sql-book:latest