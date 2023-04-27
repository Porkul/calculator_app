import '/models/calculation_model.dart';

abstract class Persistence {
  Future<void> clearHistory();
  Future<void> createCalculation(Calculation calculation);
  Future<List<Calculation>> getAllCalculations();
}
