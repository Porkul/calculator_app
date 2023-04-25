import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'screens/converter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      routes: {
        '/': (context) => const CalculatorScreen(),
        '/converter-screen': (context) => const ConverterScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: const CalculatorScreen(),
    );
  }
}
