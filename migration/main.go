package main

import (
	"flag"
	"log"
	"os"
	"os/exec"
)

func main() {
	command := flag.String("c", "up", "command")
	dir := flag.String("mgt-dir", "/migration_db", "migration dir")
	if command == nil {
		log.Fatal("validation error")
	}
	dsn := "postgres://test:111@simple_db_1:5432/simple?sslmode=disable"
	cmd := exec.Command("goose", "postgres", dsn, *command)
	cmd.Env = os.Environ()
	cmd.Dir = *dir
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		log.Fatal(err)
	}
}
