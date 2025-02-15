// lib/admin_main.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'features/admin/presentation/screens/AdminDashboard.dart';
import 'features/admin/presentation/screens/UserManagement.dart';
import 'features/admin/presentation/screens/OpportunityManager.dart';
import 'features/admin/presentation/screens/ProjectModeration.dart';
import 'features/admin/presentation/screens/FinancialTracker.dart';
import 'features/admin/presentation/screens/AdminSettings.dart';

void main() {
  runApp(AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu Bridge Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminPanel(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;

  // List of admin screens
  final List<Widget> _adminScreens = [
    AdminDashboard(),
    UserManagement(),
    OpportunityManager(),
    ProjectModeration(),
    FinancialTracker(),
    AdminSettings(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.dashboard_outlined,
      'activeIcon': Icons.dashboard,
      'label': 'Dashboard',
      'tooltip': 'Admin Dashboard',
      'animation': 'assets/animations/dashboard.json'
    },
    {
      'icon': Icons.people_outline,
      'activeIcon': Icons.people,
      'label': 'Users',
      'tooltip': 'User Management',
      'animation': 'assets/animations/users.json'
    },
    {
      'icon': Icons.work_outline,
      'activeIcon': Icons.work,
      'label': 'Opportunities',
      'tooltip': 'Opportunity Manager',
      'animation': 'assets/animations/opportunities.json'
    },
    {
      'icon': Icons.assignment_outlined,
      'activeIcon': Icons.assignment,
      'label': 'Projects',
      'tooltip': 'Project Moderation',
      'animation': 'assets/animations/projects.json'
    },
    {
      'icon': Icons.attach_money,
      'activeIcon': Icons.money,
      'label': 'Finance',
      'tooltip': 'Financial Tracker',
      'animation': 'assets/animations/finance.json'
    },
    {
      'icon': Icons.settings_outlined,
      'activeIcon': Icons.settings,
      'label': 'Settings',
      'tooltip': 'Admin Settings',
      'animation': 'assets/animations/settings.json'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 8),
              child: Lottie.asset(
                'assets/animations/admin_logo.png',
                repeat: true,
                animate: true,
                fit: BoxFit.contain,
              ),
            ),
            Text('Edu Bridge Admin Panel'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add logout logic
            },
          )
        ],
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _adminScreens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade600,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 16,
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          showUnselectedLabels: true,
          items: _navItems
              .map((item) => BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Tooltip(
                          message: item['tooltip'],
                          child: _selectedIndex == _navItems.indexOf(item)
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Lottie.asset(
                                    item['animation'],
                                    repeat: true,
                                    animate: true,
                                  ),
                                )
                              : Icon(item['icon']),
                        ),
                        if (_selectedIndex == _navItems.indexOf(item))
                          Container(
                            width: 20,
                            height: 2,
                            margin: EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                      ],
                    ),
                    activeIcon: Icon(item['activeIcon']),
                    label: item['label'],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
