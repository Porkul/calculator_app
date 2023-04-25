import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/controllers/calculator_controller.dart';
import '/models/calculation_model.dart';

class HistoryScreen extends StatefulWidget {
  final CalculatorController controller;

  const HistoryScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Calculation>> _futureCalculations;

  @override
  void initState() {
    super.initState();
    _loadCalculations();
  }

  Future<void> _loadCalculations() async {
    _futureCalculations = widget.controller.getAllCalculations;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Calculation>>(
      future: _futureCalculations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading calculations.'),
          );
        } else {
          final List<Calculation> calculations = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('History'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Clear history',
                  onPressed: () async {
                    await widget.controller.clearHistory;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('History cleared.')),
                    );
                    setState(() {
                      // Trigger a rebuild of the widget after the calculations have been cleared.
                      _loadCalculations();
                    });
                  },
                ),
              ],
            ),
            body: (snapshot.hasData && snapshot.data!.isEmpty)
                ? const Center(
                    child: Text('No calculations yet.'),
                  )
                : ListView.separated(
                    itemCount: calculations.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final calculation = calculations[index];
                      final date = DateFormat('yyyy-MM-dd HH:mm')
                          .format(calculation.date);

                      return ListTile(
                        title: Text(calculation.formatEquation()),
                        subtitle: Text(date),
                      );
                    },
                  ),
          );
        }
      },
    );
  }
}
