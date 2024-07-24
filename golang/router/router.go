package router

import (
	"github.com/gorilla/mux"
	"main.go/golang/controllers"
)

func Router() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/signup", controllers.Signup).Methods("POST")
	return router
}