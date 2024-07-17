// package main

// import (
// 	"errors"
// 	"fmt"
// )

// func divide(a, b float64) (float64, error) {
// 	if b == 0 {
// 		return 0, errors.New("division by zero")
// 	}
// 	return a / b, nil
// }

// func main() {
// 	result, err := divide(4, 2)
// 	if err != nil {
// 		fmt.Println("Error", err)
// 	}
// 	fmt.Println("Result", result)
// }

// // we can create our custom error
// package main

// import "fmt"

// type DivideError struct {
// 	dividend, divisor float64
// }

// func (e *DivideError) Error() string {
// 	return fmt.Sprintf("can't divide %f by %f", e.dividend, e.divisor)
// }

// func divide(a, b float64) (float64, error) {
// 	if b == 0 {
// 		return 0, &DivideError{a, b}
// 	}
// 	return a / b, nil
// }

// func main() {
// 	result, err := divide(4, 0)
// 	if err != nil {
// 		fmt.Println("Error", err)
// 	}
// 	fmt.Println("Result", result)
// }

//reading a file

package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func readFile(filename string) (string, error) {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

func main() {
	content, err := readFile("example.txt")
	if err != nil {
		if os.IsNotExist(err) {
			fmt.Println("File doesnot exist")
		} else {
			fmt.Println("Error reading file", err)
		}

	}
	fmt.Println("File Content", content)
}
