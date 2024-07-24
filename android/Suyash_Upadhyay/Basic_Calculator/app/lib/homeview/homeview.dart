import 'package:app/homeview/calculator_view.dart';
import 'package:flutter/material.dart';

class homeview extends StatelessWidget {
  const homeview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[200],
        body: SafeArea(
          child: CalculatorView(),
        ));
  }
}
