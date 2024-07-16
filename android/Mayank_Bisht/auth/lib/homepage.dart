import 'package:auth/emoji.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;
  int _page = 0;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                signout();
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.blue[800],
          toolbarHeight: 50.0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          elevation: 20,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.blue[800],
          color: Colors.blue,
          animationDuration: const Duration(microseconds: 300),
          items: const <Widget>[
            Icon(Icons.home, size: 26, color: Colors.white),
            Icon(Icons.message, size: 26, color: Colors.white),
            Icon(Icons.add, size: 26, color: Colors.white),
            Icon(Icons.notifications, size: 26, color: Colors.white),
            Icon(Icons.person, size: 26, color: Colors.white)
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 42,
                      backgroundImage: AssetImage("assets/user.jpeg"),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'User Name',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.update),
                title: const Text("Updates"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text("Favourites"),
                onTap: () {},
              ),
              const Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text("Privacy Policy"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.interpreter_mode_sharp),
                title: const Text("T&C"),
                onTap: () {},
              ),
              const Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Logout"),
                onTap: _showLogoutDialog,
              )
            ],
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi User !",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "11 July 2024",
                        style: TextStyle(
                          color: Colors.blue[200],
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //search bar
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Search Here !",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "How do you feel ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Emojis(
                        emojiface: "😌",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Bad",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Emojis(
                        emojiface: "🙂",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Fine",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Emojis(
                        emojiface: "😀",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Well",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Emojis(
                        emojiface: "🤗",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Excellent",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
              child: Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)), color: Colors.white),
            padding: EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercises",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: Icon(
                        Icons.favorite,
                        size: 40,
                        color: Colors.orange,
                      ),
                      title: Text("Speaking Skills"),
                      subtitle: Text("15 Exercises "),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: Icon(
                        Icons.favorite,
                        size: 40,
                        color: Colors.orange,
                      ),
                      title: Text("Speaking Skills"),
                      subtitle: Text("15 Exercises "),
                    ),
                  ),

                ],
              ),
            ),
          ))
        ]))
        // Center(
        //   child: Text("Page ${(_page+1).toString()}"+" ${user!.email}"),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _showLogoutDialog,
        //   child: Icon(Icons.logout_rounded),
        // ),
        );
  }
}
