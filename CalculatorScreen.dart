import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  String operand = "";
  double num1 = 0;
  double num2 = 0;
  bool shouldClear = false;

  void buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        display = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
        shouldClear = false;  //reset everything to default as a 0
      } else if (text == "+" || text == "-" || text == "×" || text == "÷") {
        num1 = double.tryParse(display) ?? 0;
        operand = text;  //perform operator
        shouldClear = true; //clear the screen for next op
      } else if (text == "=") {
        num2 = double.tryParse(display) ?? 0;
        double result = 0;

        switch (operand) {
          case "+":
            result = num1 + num2;
            break;
          case "-":
            result = num1 - num2;
            break;
          case "×":
            result = num1 * num2;
            break;
          case "÷":
            result = num2 != 0 ? num1 / num2 : double.nan;
            break;
        }
        display = result.isNaN ? "Error" : result.toString();
        operand = "";
      }
      else if (text == "⌫") {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        }
      } else {
        if (shouldClear) {
          display = text;
          shouldClear = false;
        } else {
          display = display == "0" ? text : display + text;
        }
      }
    });
  }

  Widget buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.deepPurple.shade100,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (   //basic layout
      appBar: AppBar(
        title: const Text("Mini Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24.0),
              color: Colors.deepPurple.shade50,
              child: Text(
                display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", color: Colors.red.shade200),
                  buildButton("⌫", color: Colors.orange.shade200),
                  buildButton("÷", color: Colors.purple.shade200),
                ],
              ),
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("×", color: Colors.purple.shade200),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-", color: Colors.purple.shade200),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+", color: Colors.purple.shade200),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("."),
                  buildButton("=", color: Colors.green.shade300),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
