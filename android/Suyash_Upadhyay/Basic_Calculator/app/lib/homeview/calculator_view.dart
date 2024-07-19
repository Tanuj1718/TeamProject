import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int x = 0;
  int y = 0;
  num z = 0;
  final first_controller = TextEditingController();
  final second_controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    first_controller.text = x.toString();
    second_controller.text = y.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          display(
            hint: "Enter First Number",
            controller: first_controller,
          ),
          SizedBox(height: 30),
          display(
            hint: "Enter Second Number",
            controller: second_controller,
          ),
          SizedBox(height: 30),
          Text(
            z.toString(),
            style: TextStyle(
                color: Colors.cyan, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(first_controller.text)! +
                        num.tryParse(second_controller.text)!;
                  });
                },
                child: Icon(CupertinoIcons.add),
                backgroundColor: Color.fromARGB(255, 234, 182, 243),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(first_controller.text)! -
                        num.tryParse(second_controller.text)!;
                  });
                },
                child: Icon(CupertinoIcons.minus),
                backgroundColor: Color.fromARGB(255, 234, 182, 243),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(first_controller.text)! *
                        num.tryParse(second_controller.text)!;
                  });
                },
                child: Icon(CupertinoIcons.multiply),
                backgroundColor: Color.fromARGB(255, 234, 182, 243),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(first_controller.text)! /
                        num.tryParse(second_controller.text)!;
                  });
                },
                child: Icon(CupertinoIcons.divide),
                backgroundColor: Color.fromARGB(255, 234, 182, 243),
              ),
            ],
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                x = 0;
                y = 0;
                z = 0;
                first_controller.clear();
                second_controller.clear();
              });
            },
            child: Text("Clear"),
          )
        ],
      ),
    );
  }
}

class display extends StatelessWidget {
  const display(
      {super.key, this.hint = "Enter a Number", required this.controller});
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.purple),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.cyan,
                width: 3,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.cyan,
                width: 3,
              ))),
    );
  }
}
