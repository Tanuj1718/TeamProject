import 'dart:convert';
import 'package:auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    print("First Name: ${_firstNameController.text}");
    print("Last Name: ${_lastNameController.text}");
    print("Mobile: ${_mobileController.text}");
    print("Email: ${_emailController.text}");
    print("Address: ${_addressController.text}");
    print("City: ${_cityController.text}");
    print("State: ${_stateController.text}");
    print("Country: ${_countryController.text}");

    final url = 'http://192.168.3.48:8000/signup';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'mobile': _mobileController.text,
        'email': _emailController.text,
        'address': _addressController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'country': _countryController.text,
        'password': _passwordController.text,
        'location': "hi",
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseBody['Status'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${response.body}')),
      );
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
          _isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildGridTextFields(),
                            SizedBox(height: 15),
                            buildTextField(_addressController, "Address", Icons.home),
                            SizedBox(height: 15),
                            buildTextField(_countryController, "Country", Icons.flag),
                            SizedBox(height: 15),
                            buildTextField(_mobileController, "Mobile", Icons.phone),
                            SizedBox(height: 15),
                            buildTextField(_emailController, "Email", Icons.email, validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              String emailPattern =
                                  r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                              RegExp regExp = RegExp(emailPattern);
                              if (!regExp.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            }),
                            SizedBox(height: 15),
                            buildPasswordField(),
                            SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: _signup,
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
            Expanded(child: buildTextField(_firstNameController, "First Name", Icons.person)),
            SizedBox(width: 15),
            Expanded(child: buildTextField(_lastNameController, "Last Name", Icons.person)),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: buildTextField(_cityController, "City", Icons.location_city)),
            SizedBox(width: 15),
            Expanded(child: buildTextField(_stateController, "State", Icons.map)),
          ],
        ),
      ],
    );
  }

  TextFormField buildTextField(TextEditingController controller, String hintText, IconData icon, {FormFieldValidator<String>? validator, bool obscureText = false}) {
    return TextFormField(
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
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        String pattern = r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,}$';
        RegExp regExp = RegExp(pattern);
        if (!regExp.hasMatch(value)) {
          if (value.length < 8) {
            return 'Length of the password must be greater than or equal to 8';
          }
          return 'Password must contain at least 1 uppercase letter, 1 special character, and 1 number';
        }
        return null;
      },
    );
  }
}
