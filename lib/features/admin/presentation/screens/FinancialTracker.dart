// lib/features/admin/presentation/screens/FinancialTracker.dart
import 'package:flutter/material.dart';

class FinancialTracker extends StatefulWidget {
  const FinancialTracker({super.key});

  @override
  State<FinancialTracker> createState() => _FinancialTrackerState();
}

class _FinancialTrackerState extends State<FinancialTracker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> transactions = [
    {'date': '2023-12-01', 'description': 'Course Purchase', 'amount': 299.99, 'type': 'Income'},
    {'date': '2023-12-02', 'description': 'Platform Fee', 'amount': -50.00, 'type': 'Expense'},
    {'date': '2023-12-03', 'description': 'Mentorship Session', 'amount': 150.00, 'type': 'Income'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getTransactionColor(String type) {
    return type == 'Income' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    double totalRevenue = transactions
        .map((t) => t['amount'] as double)
        .fold(0, (prev, amount) => prev + amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EarnWise Controller',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Export financial report logic
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FadeTransition(
              opacity: _animation,
              child: Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Revenue', 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${totalRevenue.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction Logs',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: _controller,
                                curve: Interval(
                                  index * 0.2,
                                  1.0,
                                  curve: Curves.easeOut,
                                ),
                              )),
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _getTransactionColor(transaction['type']),
                                    child: Icon(
                                      transaction['type'] == 'Income' 
                                          ? Icons.arrow_upward 
                                          : Icons.arrow_downward,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(transaction['description']),
                                  subtitle: Text(transaction['date']),
                                  trailing: Text(
                                    '${transaction['type'] == 'Income' ? '+' : '-'}\$${transaction['amount'].abs().toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: _getTransactionColor(transaction['type']),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            // Add new transaction logic
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}