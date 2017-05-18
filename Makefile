ifndef
	GOPATH = ~/go
endif
GO = GOPATH=$(GOPATH) go

PKG = .
BIN = nsqd-prometheus-exporter

VERSION = $(shell ./$(BIN) --version | cut -d" " -f 3)

.PHONY: %

default: fmt deps test build

all: build
build: fmt
	$(GO) build -a -o $(BIN) $(PKG)
lint: vet
vet: deps
	$(GO) get code.google.com/p/go.tools/cmd/vet
	$(GO) vet $(PKG)
fmt:
	$(GO) fmt $(PKG)
test: test-deps
	$(GO) test $(PKG)
cover: test-deps
	$(GO) test -cover $(PKG)
clean:
	$(GO) clean -i $(PKG)
clean-all:
	$(GO) clean -i -r $(PKG)
deps:
	curl -s https://raw.githubusercontent.com/pote/gpm/master/bin/gpm > gpm.sh
	chmod 755 gpm.sh
	GOPATH=$(GOPATH) ./gpm.sh
	rm gpm.sh
test-deps:
	$(GO) get -d -t $(PKG)
	$(GO) test -a -i $(PKG)
install:
	$(GO) install
run: all
	./$(BIN)
