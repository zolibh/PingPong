## Makefile

.DEFAULT_GOAL := build

GOOS ?= $(call lc, $(shell uname -s))
GOARCH ?= amd64

SOURCES = $(wildcard */main.go)
PROJECTS = $(foreach p, $(dir $(SOURCES)), $(p:/=))
BINARIES = $(foreach p, $(PROJECTS), $(p)/$(p))

build: $(BINARIES)

$(BINARIES):
	export PROJECT=$(firstword $(subst /, ,$(@))) && \
		docker run --rm -t -v "$(shell pwd)/$${PROJECT}":/src -w /src \
		golang:1.11 sh -c "\
			CGO_ENABLED=0 \
			GOOS=$(GOOS) \
			GOARCH=$(GOOARCH) \
			go build -a --installsuffix cgo --ldflags="-s" -o $${PROJECT}/$${PROJECT}"

clean:
	@rm -vf $(BINARIES)

.PHONY: build clean $(BINARIES)
