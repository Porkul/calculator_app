import 'package:calc_app/controllers/persistence/persistence.dart';
import 'package:calc_app/firebase_options.dart';
import 'package:calc_app/models/calculation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebasePersistence extends Persistence {
  FirebaseApp? _firebaseApp;
  late FirebaseFirestore db;

  @override
  Future<void> clearHistory() async {
    try {
      await init();
      final snapshot = await db.collection("calculations").get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      print("Calculations deleted successfully");
    } catch (error) {
      print("Failed to clear Calculations history: $error");
      rethrow;
    }
  }

  @override
  Future<void> createCalculation(Calculation calculation) async {
    try {
      await init();
      await db.collection("calculations").add(calculation.toMap());
      print("New Calculation added");
    } catch (error) {
      print("Failed to add Calculation: $error");
      rethrow;
    }
  }

  @override
  Future<List<Calculation>> getAllCalculations() async {
    try {
      await init();
      List<Calculation> calculations = [];
      var results = await db.collection('calculations').get();
      for (var element in results.docs) {
        if (element.data().isNotEmpty) {
          Calculation calculation = Calculation(
              expression: element.data()['expression'],
              result: element.data()['result'],
              date: DateTime.parse(element.data()['date']));
          calculations.add(calculation);
        }
      }
      return calculations;
    } catch (error) {
      print("Failed to get all Calculations: $error");
      rethrow;
    }
  }

  Future<void> init() async {
    try {
      if (_firebaseApp == null) {
        _firebaseApp = await Firebase.initializeApp(
          name: 'Calc',
          options: DefaultFirebaseOptions.currentPlatform,
        );
        db = FirebaseFirestore.instance;
        print("completedAppInitialize");
      }
    } catch (error) {
      print('Error initializing Firebase: $error');
      rethrow;
    }
  }
}
