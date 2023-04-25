import 'package:flutter/material.dart';
import '/constants/colors.dart' as colors;

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  late final TextEditingController _kilometerController;
  late final TextEditingController _mileController;

  @override
  void initState() {
    super.initState();
    _kilometerController = TextEditingController(text: '0');
    _mileController = TextEditingController(text: '0');
  }

  void _convertKilometerToMile() {
    double km = double.parse(_kilometerController.text);
    double mile = km / 1.609;
    _mileController.text = mile.toStringAsFixed(2);
  }

  void _convertMileToKilometer() {
    double mile = double.parse(_mileController.text);
    double km = mile * 1.609;
    _kilometerController.text = km.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Converter')),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: TextField(
                      controller: _kilometerController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Kilometer',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: Center(
                    child: TextField(
                      controller: _mileController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Mile',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _convertKilometerToMile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.cyanSecond,
                    fixedSize: const Size(330, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
                  ),
                  child: const Text('Convert to Mile'),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _convertMileToKilometer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.cyanSecond,
                    fixedSize: const Size(330, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                  child: const Text('Convert to Kilometer'),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _kilometerController.text = '0';
                    _mileController.text = '0';
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    fixedSize: const Size(330, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
                  ),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
