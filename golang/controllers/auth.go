package controllers

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"regexp"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo/options"
	"golang.org/x/crypto/bcrypt"
	"main.go/golang/database"
	"main.go/golang/models"
)

// function to check numeric value
func containsNumericValue(firstname string) bool {
	// Regex pattern to check for numeric values
	re := regexp.MustCompile(`[0-9]`)
	return re.MatchString(firstname)
}

// validate password function
func validatePassword(password string) bool {
	hasNumber := regexp.MustCompile(`[0-9]`).MatchString(password)
	hasUpper := regexp.MustCompile(`[A-Z]`).MatchString(password)
	hasLower := regexp.MustCompile(`[a-z]`).MatchString(password)
	hasSpecial := regexp.MustCompile(`[!@#~$%^&*()+|_.,?]`).MatchString(password)

	return hasNumber && hasUpper && hasLower && hasSpecial
}

// Function to check if a string contains only numeric values
func isNumeric(s string) bool {
	for _, char := range s {
		if char < '0' || char > '9' {
			return false
		}
	}
	return true
}

func Signup(w http.ResponseWriter, r *http.Request) {
	if database.DBcollection == nil {
		http.Error(w, "Database connection is not initialized", http.StatusInternalServerError)
		log.Fatal("MongoDB collection is not initialized")
		return
	}
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	// Log the incoming request
	fmt.Println("Received signup request")
	// Parse the form data
	err := r.ParseForm()
	if err != nil {
		http.Error(w, "Error parsing form data", http.StatusBadRequest)
		return
	}

	firstname := r.FormValue("firstname")
	lastname := r.FormValue("lastname")
	mobile := r.FormValue("mobile")
	email := r.FormValue("email")
	password := r.FormValue("password")
	address := r.FormValue("address")
	location := r.FormValue("location")
	city := r.FormValue("city")
	state := r.FormValue("state")
	country := r.FormValue("country")

	//validation to the Form values
	if containsNumericValue(firstname) || containsNumericValue(lastname) || containsNumericValue(country) {
		http.Error(w, "FirstName, LastName or country should not contain numeric value", http.StatusBadRequest)
		return
	}

	if firstname == "" || lastname == "" || mobile == "" || email == "" || len(password) < 6 || address == "" || location == "" || city == "" || state == "" || country == "" {
		http.Error(w, "All fields are required.", http.StatusBadRequest)
		return
	}

	if !validatePassword(password) {
		http.Error(w, "Password should contain numeric values, special characters, atleast one uppercase and one lowercase character", http.StatusBadRequest)
		return
	}

	if !isNumeric(mobile) {
		http.Error(w, "Mobile number should contains only numeric values", http.StatusBadRequest)
		return
	}

	//check if email already exists
	emailFilter := bson.M{"email": email}
	var existingUserbyEmail models.User
	err = database.DBcollection.FindOne(context.TODO(), emailFilter).Decode(&existingUserbyEmail)
	if err == nil {
		http.Error(w, "Email already exists", http.StatusConflict)
		return
	}

	//check if password already exits
	findOptions := options.Find()
	cur, err := database.DBcollection.Find(context.TODO(), bson.D{}, findOptions)
	if err != nil {
		http.Error(w, "Error fetching users", http.StatusInternalServerError)
		return
	}
	defer cur.Close(context.TODO())

	var users []models.User
	if err = cur.All(context.TODO(), &users); err != nil {
		http.Error(w, "Error fetching data", http.StatusInternalServerError)
		return
	}

	// Iterate through all users and compare passwords
	for _, user := range users {
		err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))
		if err == nil {
			http.Error(w, "Password already exists", http.StatusConflict)
			return
		}
	}

	//Hashing user password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), 10)
	if err != nil {
		http.Error(w, "Server Error during Hashing", http.StatusInternalServerError)
		return
	}

	fmt.Printf("FirstName: %s\nLastName: %s\nEmail: %s\nMobile: %s\nAddress: %s\nLocation: %s\nCity: %s\nState: %s\nCountry: %s\n", firstname, lastname, email, mobile, address, location, city, state, country)

	//Creating user
	user := models.User{
		FirstName:    firstname,
		LastName:     lastname,
		MobileNumber: mobile,
		Email:        email,
		Password:     string(hashedPassword),
		Address:      address,
		Location:     location,
		City:         city,
		State:        state,
		Country:      country,
	}

	database.DBcollection.InsertOne(context.Background(), user)
	// Set response header to application/json
	w.Header().Set("Content-Type", "application/x-www-form-urlencoded")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{
		"Status": "User registered successfully",
	})
}
