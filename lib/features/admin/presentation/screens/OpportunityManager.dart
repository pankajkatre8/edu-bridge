// lib/features/admin/presentation/screens/OpportunityManager.dart
import 'package:flutter/material.dart';

class OpportunityManager extends StatefulWidget {
  const OpportunityManager({super.key});

  @override
  State<OpportunityManager> createState() => _OpportunityManagerState();
}

class _OpportunityManagerState extends State<OpportunityManager> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const List<Map<String, String>> opportunities = [
    {'title': 'Flutter UI Challenge', 'type': 'Hackathon'},
    {'title': 'Data Science Internship', 'type': 'Internship'},
    {'title': 'Nanocert: Flutter Basics', 'type': 'Certification'},
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Hackathon':
        return Colors.purple;
      case 'Internship':
        return Colors.blue;
      case 'Certification':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Opportunity Orchestrator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new opportunity logic
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ListView.builder(
              itemCount: opportunities.length,
              itemBuilder: (context, index) {
                final opportunity = opportunities[index];
                return FadeTransition(
                  opacity: _animation,
                  child: SlideTransition(
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
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              _getTypeColor(opportunity['type']!).withOpacity(0.2),
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            opportunity['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Chip(
                              label: Text(
                                opportunity['type']!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: _getTypeColor(opportunity['type']!),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            // Add new opportunity logic
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}