import 'package:flutter/material.dart';
import '/controllers/calculator_controller.dart';
import '/models/calculator_model.dart';
import '/constants/colors.dart' as colors;

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController _controller =
      CalculatorController(CalculatorModel());

  static const double equationFontSize = 38.0;
  static const double resultFontSize = 48.0;
  static const Color cyanSecond = colors.cyanSecond;

  Widget _buildButton(
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
        onPressed: () {
          _controller.buttonPressed(buttonText);
          setState(() {});
        },
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calculate, size: equationFontSize),
            onPressed: () {
              Navigator.pushNamed(context, '/converter-screen');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              _controller.model.equation,
              style: const TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              _controller.model.result,
              style: const TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      _buildButton("C", 1, Colors.cyan),
                      _buildButton("⌫", 1, cyanSecond),
                      _buildButton("÷", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      _buildButton("7", 1, Colors.blueGrey),
                      _buildButton("8", 1, Colors.blueGrey),
                      _buildButton("9", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      _buildButton("4", 1, Colors.blueGrey),
                      _buildButton("5", 1, Colors.blueGrey),
                      _buildButton("6", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      _buildButton("1", 1, Colors.blueGrey),
                      _buildButton("2", 1, Colors.blueGrey),
                      _buildButton("3", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      _buildButton(".", 1, Colors.blueGrey),
                      _buildButton("0", 1, Colors.blueGrey),
                      _buildButton("ANS", 1, Colors.blueGrey),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      _buildButton("×", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      _buildButton("-", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      _buildButton("+", 1, cyanSecond),
                    ]),
                    TableRow(children: [
                      _buildButton("=", 2, Colors.cyan),
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
