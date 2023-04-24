import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 20),
            side: const BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        onPressed: null,
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String equation = "5";
    String result = "10";
    double equationFontSize = 38.0;
    double resultFontSize = 48.0;
    Color cyanSecond = const Color.fromARGB(255, 18, 150, 168);

    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.cyan),
                      buildButton("⌫", 1, cyanSecond),
                      buildButton("÷", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.blueGrey),
                      buildButton("8", 1, Colors.blueGrey),
                      buildButton("9", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.blueGrey),
                      buildButton("5", 1, Colors.blueGrey),
                      buildButton("6", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.blueGrey),
                      buildButton("2", 1, Colors.blueGrey),
                      buildButton("3", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.blueGrey),
                      buildButton("0", 1, Colors.blueGrey),
                      buildButton("00", 1, Colors.blueGrey),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.cyan),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
