import 'package:math_expressions/math_expressions.dart';
import '/models/calculator_model.dart';
import '/constants/calculator_buttons.dart';

class CalculatorController {
  final CalculatorModel model;

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

  void clear() {
    model.equation = "0";
    model.result = "0";
  }

  void backspace() {
    if (model.equation.length > 1) {
      model.equation = model.equation.substring(0, model.equation.length - 1);
    } else {
      model.equation = "0";
    }
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

  void evaluate() {
    String expression = model.equation;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      model.result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      model.equation = model.result;
    } catch (e) {
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
