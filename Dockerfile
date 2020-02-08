FROM golang:1.13.6-alpine AS goose

ENV CGO_ENABLED=0
RUN apk update
RUN apk add --no-cache git gcc
RUN go get -u github.com/pressly/goose/cmd/goose

FROM golang:1.13.6-alpine AS build
RUN mkdir /app
ADD . /app/
WORKDIR /app

RUN go build -o /bin/simple cmd/simple/main.go
RUN go build -o /bin/migrate migration/main.go

FROM alpine:latest
COPY --from=build /bin/simple /bin/simple
COPY --from=build /bin/migrate /bin/migrate
COPY --from=goose /go/bin/goose /usr/bin/goose
COPY migration/migrations migration_db

CMD ["/bin/simple"]