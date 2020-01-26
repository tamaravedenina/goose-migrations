package main

import (
	"encoding/json"
	"net/http"
	"os"
	"time"

	"github.com/go-pg/pg"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
)

func main() {
	r := mux.NewRouter()

	r.Handle("/", NotImplemented).Methods("GET")
	r.Handle("/status", StatusHandler).Methods("GET")
	r.Handle("/products", ProductHandler).Methods("GET")

	http.ListenAndServe(":3000", handlers.LoggingHandler(os.Stdout, r))
}

var NotImplemented = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Not Implemented"))
})

type Product struct {
	tableName   struct{}  `sql:"product"`
	Id          int       `sql:"id"`
	Name        string    `sql:"name"`
	Price       string    `sql:"price"`
	Brand       string    `sql:"brand"`
	Description string    `sql:"description"`
	Rating      float64   `sql:"rating"`
	CreatedAt   time.Time `sql:"created_at"`
	UpdatedAt   time.Time `sql:"updated_at"`
}

var StatusHandler = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("API is up and running"))
})

var ProductHandler = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
	db := pg.Connect(&pg.Options{
		User:     "test",
		Password: "111",
		Database: "simple",
		Addr:     "simple_db_1:5432",

	})
	defer db.Close()

	var products []Product
	db.Model(&products).Select()
	payload, _ := json.Marshal(products)

	w.Header().Set("Content-Type", "application/json")
	w.Write(payload)
})
