GOCMD=go
GOFMT=goreturns
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GODOC=$(GOCMD) doc
GOGET=$(GOCMD) get
BINARY=fastcp

all: build test cover bench doc
ci: build test cover bench
doc:
	$(GODOC) -all .
fmt:
	$(GOFMT) -l -w .
build:
	$(GOCMD) build -v -o $(BINARY)
test:
	$(GOTEST) -race -v
bench:
	$(GOTEST) -parallel=4 -run="none" -benchtime="2s" -benchmem -bench=.
cover:
	$(GOTEST) -race -cover -covermode=atomic -coverprofile=coverage.out
run: build
	time ./$(BINARY)
