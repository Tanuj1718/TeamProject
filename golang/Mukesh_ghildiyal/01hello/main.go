// //hello world
// package main

// import "fmt"

// func main() {
// 	fmt.Println("Hello from go lang")
// }

// //variables

// package main

// import "fmt"

// func main() {
// 	var name = "Mukesh"
// 	fmt.Println("Variables")
// 	fmt.Println(name)
// 	fmt.Printf("that's my Name %v", name)
// }

// // to read input
// package main

// import "fmt"

// func main() {
// 	var name string
// 	fmt.Println("to read input")
// 	fmt.Scan(&name)
// 	fmt.Println("to print the given name", name)
// }

// //comma ok syntax
// package main

// import (
// 	"bufio"
// 	"fmt"
// 	"os"
// )

// func main() {
// 	reader := bufio.NewReader(os.Stdin)
// 	fmt.Println("Enter the rating of our coding")

// 	input, _ := reader.ReadString('\n')
// 	fmt.Println("Thanks for rating", input)
// 	fmt.Printf("type of th rating is %T", input)
// }

//if-else loop

// package main

// import "fmt"

// func main() {
// 	logic := 12
// 	var result string
// 	if logic < 5 {
// 		fmt.Println("ts less than 5", result)
// 	} else if logic > 10 {
// 		fmt.Println("its greater than 10", result)
// 	}

// 	if num := 3; num < 10 {
// 		fmt.Println("num is leass than 10")
// 	} else {
// 		fmt.Println("greater than 10")
// 	}

// }

//switch case

// package main

// import (
// 	"fmt"
// 	"math/rand"
// 	"time"
// )

// func main() {
// 	fmt.Println("switch and case is going")

// 	rand.Seed(time.Now().UnixNano())
// 	diceNumber := rand.Intn(6) + 1
// 	fmt.Println("Value of dice is", diceNumber)

// 	switch diceNumber {
// 	case 1:
// 		fmt.Println("run 1 step")

// 	case 2:
// 		fmt.Println("run 2 step")

// 	case 3:
// 		fmt.Println("run 3 step")

// 	case 4:
// 		fmt.Println("run 4 step")

// 	case 5:
// 		fmt.Println("run 5 step")

// 	case 6:
// 		fmt.Println("run 6 step")

// 	default:
// 		fmt.Println("wht was that")

// 	}
// }

//array

// package main

// import (
// 	"fmt"
// )

// func main() {
// 	var arr1 = [3]int{1, 2, 3}
// 	arr2 := [5]int{4, 5, 6, 7, 8}

// 	fmt.Println(arr1)
// 	fmt.Println(arr2)
// }

// package main

// import (
// 	"fmt"
// )

// func main() {
// 	var arr1 = [...]int{1, 2, 3}
// 	arr2 := [...]int{4, 5, 6, 7, 8}

// 	fmt.Println(arr1)
// 	fmt.Println(arr2)
// }

//loop

// package main

// import (
// 	"fmt"
// )

// func main() {
// 	for i := 0; i < 5; i++ {
// 		fmt.Println(i)
// 	}
// }

//struct

// package main
// import ("fmt")

// type Person struct {
//   name string
//   age int
//   job string
//   salary int
// }

// func main() {
//   var pers1 Person
//   var pers2 Person

//   // Pers1 specification
//   pers1.name = "Hege"
//   pers1.age = 45
//   pers1.job = "Teacher"
//   pers1.salary = 6000

//   // Pers2 specification
//   pers2.name = "Cecilie"
//   pers2.age = 24
//   pers2.job = "Marketing"
//   pers2.salary = 4500

//   // Access and print Pers1 info
//   fmt.Println("Name: ", pers1.name)
//   fmt.Println("Age: ", pers1.age)
//   fmt.Println("Job: ", pers1.job)
//   fmt.Println("Salary: ", pers1.salary)

//   // Access and print Pers2 info
//   fmt.Println("Name: ", pers2.name)
//   fmt.Println("Age: ", pers2.age)
//   fmt.Println("Job: ", pers2.job)
//   fmt.Println("Salary: ", pers2.salary)
// }

//map

package main

import (
	"fmt"
)

func main() {
	var a = map[string]string{"brand": "Ford", "model": "Mustang", "year": "1964"}
	b := map[string]int{"Oslo": 1, "Bergen": 2, "Trondheim": 3, "Stavanger": 4}

	fmt.Printf("a\t%v\n", a)
	fmt.Printf("b\t%v\n", b)
}
