package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
	"main.go/golang/controllers"
)

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/signup", controllers.Signup).Methods("POST")

	handler := cors.Default().Handler(r)
	fmt.Println("Server is getting ready...")
	log.Fatal(http.ListenAndServe("172.30.160.1:8000", handler))
}
