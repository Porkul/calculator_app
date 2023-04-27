import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/controllers/persistence/persistence.dart';
import '/models/calculation_model.dart';

class SqlPersistence extends Persistence {
  static final SqlPersistence _instance = SqlPersistence.internal();

  static Database? _db;

  static SqlPersistence get instance => _instance;
  SqlPersistence.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDB("calculation.db");
    return _db!;
  }

  @override
  Future<int> clearHistory() async {
    final db = await _instance.db;
    int result = await db.rawDelete('DELETE FROM $calculationTable');
    return result;
  }

  Future close() async {
    final db = await _instance.db;
    db!.close();
  }

  @override
  Future<Calculation> createCalculation(Calculation calculation) async {
    final db = await _instance.db;
    await db!.insert(calculationTable, calculation.toMap());
    return calculation;
  }

  @override
  Future<List<Calculation>> getAllCalculations() async {
    final db = await _instance.db;
    final result = await db!
        .query(calculationTable, orderBy: '${CalculationFields.date} DESC');
    return result.map((e) {
      return Calculation(
        date: DateTime.parse(e['date'] as String),
        expression: e['expression'] as String,
        result: double.parse(e['result'] as String),
      );
    }).toList();
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $calculationTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          ${CalculationFields.date} TEXT, 
          ${CalculationFields.expression} TEXT, 
          ${CalculationFields.result} TEXT
    )''');
  }

  Future<Database> _initDB(String filename) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filename);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
}
