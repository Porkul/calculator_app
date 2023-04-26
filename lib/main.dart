import 'package:flutter/material.dart';

import 'controllers/calculator_controller.dart';
import 'models/calculator_model.dart';
import 'screens/calculator_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/history_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CalculatorController controller =
      CalculatorController(CalculatorModel());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      routes: {
        '/': (context) => const CalculatorScreen(),
        '/converter-screen': (context) => const ConverterScreen(),
        '/history-screen': (context) => HistoryScreen(
              controller: controller,
            ),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}
