package models

type User struct{
	Id string `bson:"_id,omitempty"`
	FirstName string `bson:"firstname"`
	LastName string `bson:"lastname"`
	MobileNumber int `bson:"mobilenumber"`
	Email string `bson:"email"`
	Address string `bson:"address"`
	Location string `bson:"location"`
	City string `bson:"city"`
	State string `bson:"state"`
	Country string `bson:"country"`
}