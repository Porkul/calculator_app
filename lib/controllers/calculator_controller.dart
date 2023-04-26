import 'package:math_expressions/math_expressions.dart';

import '/constants/calculator_buttons.dart';
import '/models/calculation_model.dart';
import '/models/calculator_model.dart';
import 'persistence/firebase_persistance.dart';
import 'persistence/persistence.dart';
// import 'persistence/sql_persistence.dart';

class CalculatorController {
  final CalculatorModel model;

  Persistence persistence = FirebasePersistence();

  CalculatorController(this.model);

  void buttonPressed(String buttonText) {
    switch (buttonText) {
      case CalculatorButtons.clear:
        clear();
        break;
      case CalculatorButtons.backspace:
        backspace();
        break;
      case CalculatorButtons.answer:
        appendAnswer();
        break;
      case CalculatorButtons.equals:
        evaluate();
        break;
      default:
        append(buttonText);
    }
  }

  Future<List<Calculation>> get getAllCalculations {
    return persistence.getAllCalculations();
  }

  Future<void> get clearHistory {
    return persistence.clearHistory();
  }

  void clear() {
    model.equation = "0";
    model.result = "0";
  }

  void backspace() {
    model.equation = (model.equation.length > 1)
        ? model.equation.substring(0, model.equation.length - 1)
        : "0";
  }

  void appendAnswer() {
    if (model.equation.endsWith('+') ||
        model.equation.endsWith('-') ||
        model.equation.endsWith('*') ||
        model.equation.endsWith('/')) {
      model.equation += model.result;
    } else {
      model.equation = model.result;
    }
  }

  void evaluate() async {
    String expression = model.equation;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    if (!RegExp(r'[-+*/]').hasMatch(expression)) {
      return;
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      model.result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      model.equation = model.result;

      Calculation calculation = Calculation(
        expression: expression,
        result: double.parse(model.result),
        date: DateTime.now(),
      );

      // await SqlPersistence.instance.createCalculation(calculation);
      await persistence.createCalculation(calculation);
    } catch (e) {
      print("error message");
      print(e);
      model.result = "Error";
    }
  }

  void append(buttonText) {
    if (model.equation == "0") {
      model.equation = buttonText;
    } else {
      model.equation += buttonText;
    }
  }
}
