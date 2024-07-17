import 'package:auth/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  @override
  void initState(){
    sendVerifylink();
    super.initState();
  }

  bool isLoading = false;

  sendVerifylink() async{
    setState(() {
      isLoading = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification().then((value)=> {
        Get.snackbar("Link Sent", "A verification link has been sent to your email", margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM)
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code, margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM);
    }
    setState(() {
      isLoading = false;
    });
  }

  reload() async{
    await FirebaseAuth.instance.currentUser!.reload().then((value) => {
      Get.offAll(Wrapper())
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
        backgroundColor: Colors.grey[300],
        toolbarHeight: 50.0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Verify Your Email",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Verify your user by clicking on the link provided in your registered email. Then refresh the page by clicking on the refresh button below.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: reload,
                        child: Text('Refresh'),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: reload,
      //   child: Icon(Icons.restart_alt_rounded),
      // ),
    );
  }
}
