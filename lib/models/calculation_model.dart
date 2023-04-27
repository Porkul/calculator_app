import 'package:uuid/uuid.dart';

const String calculationTable = "calculations";

class Calculation {
  late String id;
  final String expression;
  final double result;
  final DateTime date;

  Calculation({
    required this.expression,
    required this.result,
    required this.date,
  }) {
    id = Uuid().v4();
  }

  String formatEquation() {
    final RegExp regExp = RegExp(r'([-+*/=])(\d|\.)');

    final formattedExpression = expression.replaceAllMapped(
        regExp, (match) => ' ${match.group(1)} ${match.group(2)}');
    final formattedResult = result == result.toInt()
        ? result.toInt().toString()
        : result.toStringAsFixed(2).replaceAll('.', ',');

    return '$formattedExpression = $formattedResult';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["expression"] = expression;
    map["result"] = result;
    map["date"] = date.toString();
    return map;
  }
}

class CalculationFields {
  static const String expression = 'expression';
  static const String result = 'result';
  static const String date = 'date';
}
