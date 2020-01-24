.PHONY: build
build:
	go build -o ./bin/simple ./cmd/simple/main.go

.PHONY: migrate-build
migrate-build:
	go build -o ./bin/migrate migration/main.go

.PHONY: migrate-status
migrate-status:
	go run migration/main.go -c 'status'

.PHONY: migrate-up
migrate-up:
	go run migration/main.go -c 'up'

.PHONY: migrate-down
migrate-down:
	go run migration/main.go -c 'down'

.PHONY: migrate-version
migrate-version:
	go run migration/main.go -c 'version'

.PHONY: install-goose
install-goose:
ifeq ($(wildcard $(GOOSE_BIN)),)
	go get -d github.com/pressly/goose/cmd/goose
	$ go build -i -o bin/goose github.com/pressly/goose/cmd/goose
	go mod tidy
GOOSE_BIN:=bin/goose
endif
