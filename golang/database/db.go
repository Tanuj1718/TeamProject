package database

import (
	"context"
	"fmt"
	"os"

	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var DBcollection *mongo.Collection

func init() {
	err := godotenv.Load()
	if err != nil {
		fmt.Println("Error while loading .env file")
		panic(err)
	}

	mongourl := os.Getenv("MONGODB_URI")
	const dbName = "MegaProject"
	const colName = "Users"

	//client option is necessary step because it helps to communicate with the server, w/o it you can't
	clientOption := options.Client().ApplyURI(mongourl)

	//connect to mongodb
	client, err := mongo.Connect(context.TODO(), clientOption)
	if err != nil {
		fmt.Println("Error while connecting to Database")
		panic(err)
	}

	fmt.Println("MongoDB connection success...")
	DBcollection = client.Database(dbName).Collection(colName)
}
