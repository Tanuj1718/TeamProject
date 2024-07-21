package models

type User struct{
	Id string `bson:"_id,omitempty"`
	FirstName string `bson:"firstname"`
	LastName string `bson:"lastname"`
	MobileNumber string `bson:"mobilenumber"`
	Email string `bson:"email"`
	Password string `bson:"password"`
	Address string `bson:"address"`
	Location string `bson:"location"`
	City string `bson:"city"`
	State string `bson:"state"`
	Country string `bson:"country"`
}