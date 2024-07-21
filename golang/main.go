package main

import (
	"fmt"
	"log"
	"net/http"

	"main.go/golang/router"
)

func main() {
	r := router.Router()

	fmt.Println("Server is getting ready...")
	log.Fatal(http.ListenAndServe(":8000", r))
}
