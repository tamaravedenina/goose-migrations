FROM golang:1.13.6-alpine AS goose
RUN apk update
RUN apk add --no-cache git gcc
RUN go get -u github.com/pressly/goose/cmd/goose

FROM golang:1.13.6-alpine AS build
RUN mkdir /app
ADD . /app/
WORKDIR /app

RUN go mod download
RUN go build -o main ./bin

FROM alpine:latest
COPY --from=build /app/main /app/main
COPY --from=goose /go/bin/goose goose
#COPY migration.sh migration
COPY migrations migrations

CMD ["/app/main"]