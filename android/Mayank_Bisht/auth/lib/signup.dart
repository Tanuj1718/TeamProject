import 'dart:convert';

import 'package:auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  bool isLoading = false;
  bool _obscureText = true;

  bool validateEmail(String email) {
    String emailPattern =
        r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  bool allFieldsFilled() {
    return email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        mobile.text.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty &&
        state.text.isNotEmpty &&
        country.text.isNotEmpty;
  }

  Future<void> signUp() async {
    if (!allFieldsFilled()) {
      Get.snackbar("Error", "All fields are compulsory", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!validateEmail(email.text)) {
      Get.snackbar("Error", "Enter a valid email address", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!validatePassword(password.text)) {
      if(password.text.length < 8){
        Get.snackbar("Error", "Length of the password must grater than or equals to 8", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
        return;
      }
      Get.snackbar("Error", "Password must contain at least 1 uppercase letter, 1 special character, and 1 number ", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() {
      isLoading = true;
    });

    print("First Name: ${firstName.text}");
    print("Last Name: ${lastName.text}");
    print("Mobile: ${mobile.text}");
    print("Email: ${email.text}");
    print("Address: ${address.text}");
    print("City: ${city.text}");
    print("State: ${state.text}");
    print("Country: ${country.text}");

    final url = 'http://172.30.160.1:8000/signup';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName.text,
        'lastName': lastName.text,
        'mobile': mobile.text,
        'email': email.text,
        'address': address.text,
        'city': city.text,
        'state': state.text,
        'country': country.text,
        'password': password.text,
        'location': "hi",
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Get.offAll(Wrapper());
      Get.snackbar("Successful", "Signup Successfully", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Failed to sign up", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        title: Text("SignUp"),
        backgroundColor: Colors.blue[800],
        toolbarHeight: 50.0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        elevation: 20,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.0,),
                  Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height:15),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildGridTextFields(),
                          SizedBox(height: 15),
                          buildTextField(address, "Address", Icons.home),
                          SizedBox(height: 15),
                          buildTextField(country, "Country", Icons.flag),
                          SizedBox(height: 15),
                          buildTextField(mobile, "Mobile", Icons.phone),
                          SizedBox(height: 15),
                          buildTextField(email, "Email", Icons.email),
                          SizedBox(height: 15),
                          buildPasswordField(),
                          SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: signUp,
                            child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              minimumSize: Size(double.infinity, 50), // Make the button fill the width
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridTextFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: buildTextField(firstName, "First Name", Icons.person)),
            SizedBox(width: 15),
            Expanded(child: buildTextField(lastName, "Last Name", Icons.person)),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: buildTextField(city, "City", Icons.location_city)),
            SizedBox(width: 15),
            Expanded(child: buildTextField(state, "State", Icons.map)),
          ],
        ),
      ],
    );
  }

  TextField buildTextField(TextEditingController controller, String hintText, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      obscureText: obscureText,
    );
  }

  TextField buildPasswordField() {
    return TextField(
      controller: password,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.teal),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.teal,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      obscureText: _obscureText,
    );
  }
}
