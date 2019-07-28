# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=main

all: clean build package shipit
build:
	cd src && $(GOGET) ./...
	cd src && $(GOBUILD) -o $(BINARY_NAME)
package:
	cd src && zip main.zip $(BINARY_NAME)
test:
	$(GOTEST) -v ./...
clean:
	rm -f src/$(BINARY_NAME)
	rm -f src/$(BINARY_NAME).zip
shipit:
	# Don't do this at home
	terraform apply -auto-approve
