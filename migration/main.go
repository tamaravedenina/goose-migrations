package main

import (
	"database/sql"
	"flag"
	"log"

	_ "simple/migration/migrations"

	_ "github.com/lib/pq"
	"github.com/pressly/goose"
)

func main() {
	command := flag.String("c", "status", "command")
	dir := flag.String("dir", "./migration/migrations", "migration dir")
	flag.Parse()

	dsn := "postgres://test:111@simple_db_1:5432/simple?sslmode=disable"
	db, err := sql.Open("postgres", dsn)
	if err != nil {
		log.Fatalf("-dbstring=%q: %v\n", dsn, err)
	}

	if err := goose.SetDialect("postgres"); err != nil {
		log.Fatal(err)
	}

	if err := goose.Run(*command, db, *dir); err != nil {
		log.Fatalf("goose run: %v", err)
	}
}
