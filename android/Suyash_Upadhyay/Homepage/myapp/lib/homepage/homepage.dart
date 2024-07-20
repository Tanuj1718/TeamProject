import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class myhomepage extends StatelessWidget {
  const myhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          top(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          Container(
            height: 220,
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              children: [
                _gridview(Icons.airport_shuttle, "Explore"),
                _gridview(Icons.add_shopping_cart, "Cart"),
                _gridview(Icons.arrow_drop_down_circle, "Birthday"),
                _gridview(Icons.bluetooth_searching, "Bluetooth"),
                _gridview(Icons.add_location, "Location"),
                _gridview(Icons.arrow_drop_down_circle, "Birthday")
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Latest",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
          _carditem1(),
          _carditem2(),
        ],
      ),
    );
  }

  _carditem1() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://imgs.search.brave.com/mML6dnUa35rdF3LhSbR4bnUzHDA3WeIOKFryI1fa0hw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9sYXN0/Zm0uZnJlZXRscy5m/YXN0bHkubmV0L2kv/dS9hdmF0YXIxNzBz/LzgwOGEzZjMwZGUx/MDMwMTA3YWY4MjBl/MmU0OGRhZGY4")),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Drake:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text("Family Matters")
            ],
          )
        ],
      ),
    );
  }

  _carditem2() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://imgs.search.brave.com/TUKf6VaG8Y_QQIDifeJ1w_pwdMXHhQ1K_FNaNkKc3Ig/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YWNlc2hvd2Jpei5j/b20vaW1hZ2VzL3Bo/b3RvL2tlbmRyaWNr/X2xhbWFyLmpwZw")),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kendrick Lamar:",
                style: TextStyle(fontSize: 20),
              ),
              Text("Not Like Us")
            ],
          )
        ],
      ),
    );
  }

  _gridview(icon, text) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
          radius: 25,
        ),
        SizedBox(
          height: 10,
        ),
        Text(text)
      ],
    );
  }

  top() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1720475376136-bf9bf6c0c782?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  radius: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Hi, Suyash",
                    style: TextStyle(color: Colors.black, fontSize: 20))
              ]),
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Search",
                fillColor: Color.fromARGB(255, 240, 239, 239),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black)),
                suffixIcon: Icon(Icons.filter_list),
                suffixIconColor: Colors.grey),
          ),
        ],
      ),
    );
  }
}
