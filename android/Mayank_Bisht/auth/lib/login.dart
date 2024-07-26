import 'package:auth/forgot.dart';
import 'package:auth/signup.dart';
import 'package:auth/signupdemo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
      Get.snackbar("Successful", "Login Successfully", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code, margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.grey[300],
        toolbarHeight: 50.0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Login Here",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "Enter email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: "Enter password",
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: signIn,
                        child: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50), // Make the button fill the width
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Get.to(Signup()),
                        child: const Text('SignUp'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50), // Make the button fill the width
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Get.to(Forgot()),
                        child: const Text('Forgot Password'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50), // Make the button fill the width
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
