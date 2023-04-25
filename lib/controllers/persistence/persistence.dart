import '/models/calculation_model.dart';

abstract class Persistence {
  Future<Calculation> createCalculation(Calculation calculation);
  Future<List<Calculation>> getAllCalculations();
  Future<void> clearHistory();
}
