const String calculationTable = "calculations";

class Calculation {
  final String expression;
  final double result;
  final DateTime date;

  Calculation({
    required this.expression,
    required this.result,
    required this.date,
  });

  String formatEquation() {
    final RegExp regExp = RegExp(r'([-+*/=])(\d|\.)');

    final formattedExpression = expression.replaceAllMapped(
        regExp, (match) => ' ${match.group(1)} ${match.group(2)}');
    final formattedResult = result == result.toInt()
        ? result.toInt().toString()
        : result.toStringAsFixed(2).replaceAll('.', ',');

    return '$formattedExpression = $formattedResult';
  }

  Map<String, Object?> toJson() => {
        'expression': expression,
        'result': result,
        'date': date.toIso8601String(),
      };

  static Calculation fromJson(Map<String, Object?> json) => Calculation(
        expression: json['expression'] as String,
        result: double.parse(json['result'] as String),
        date: DateTime.parse(json['date'] as String),
      );
}

class CalculationFields {
  static const String expression = 'expression';
  static const String result = 'result';
  static const String date = 'date';
}
