import 'package:calc_app/controllers/persistence/persistence.dart';
import 'package:calc_app/firebase_options.dart';
import 'package:calc_app/models/calculation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebasePersistence extends Persistence {
  FirebaseApp? _firebaseApp;
  late FirebaseFirestore db;

  Future<void> init() async {
    if (_firebaseApp == null) {
      _firebaseApp = await Firebase.initializeApp(
        name: 'Calc',
        options: DefaultFirebaseOptions.currentPlatform,
      ).whenComplete(() => print("completedAppInitialize"));
      db = FirebaseFirestore.instance;
    }
  }

  @override
  Future<Calculation> createCalculation(Calculation calculation) async {
    await init();
    final docRef =
        await db.collection("calculations").add(calculation.toJson());
    final doc = await docRef.get();
    return Calculation.fromJson(doc.data()!);
  }

  @override
  Future<List<Calculation>> getAllCalculations() async {
    await init();
    var querySnapshot = await db.collection('calculations').get();

    return querySnapshot.docs.map((doc) {
      String resultString = doc
          .data()['result']
          .toString(); // convert the 'result' value to a string
      double result = double.tryParse(resultString) ??
          0.0; // parse the string value as a double, and set default value to 0.0 if parsing fails
      return Calculation(
        expression: doc.data()['expression'],
        result: result,
        date: DateTime.parse(doc.data()['date']),
      );
    }).toList();

    // await init();
    // List<Calculation> calculations = [];
    // var results = (await db.collection('calculations').get()).docs;
    // for (var element in results) {
    //   if (element.data().isNotEmpty) {
    //     Calculation calculation = Calculation();
    //     calculation.expression = element.data()['expression'];
    //     calculation.result = element.data()['result'];
    //     calculation.date = DateTime.parse(element.data()['date']);
    //     calculations.add(calculation);
    //   }
    // }
    // return calculations;
  }

  @override
  Future<void> clearHistory() async {
    await init();
    final snapshot = await db.collection("calculations").get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
