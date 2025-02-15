// lib/features/admin/presentation/screens/AdminSettings.dart
import 'package:flutter/material.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  bool isDarkMode = false;
  bool enableVoiceVoyage = false;
  String selectedRadius = '10 km';
  bool enableAutoModeration = false;
  bool enableNotifications = true;
  String defaultUserRole = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edu Bridge Architect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable dark theme across the app'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) => setState(() => isDarkMode = value),
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.record_voice_over),
                title: const Text('Enable Voice Voyage'),
                subtitle: const Text('Voice-based navigation features'),
                trailing: Switch(
                  value: enableVoiceVoyage,
                  onChanged: (value) => setState(() => enableVoiceVoyage = value),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Community Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Geogigs Radius'),
                subtitle: const Text('Set location range for opportunities'),
                trailing: DropdownButton<String>(
                  value: selectedRadius,
                  items: ['5 km', '10 km', '15 km', '20 km'].map((String radius) {
                    return DropdownMenuItem<String>(
                      value: radius,
                      child: Text(radius),
                    );
                  }).toList(),
                  onChanged: (String? newRadius) {
                    if (newRadius != null) {
                      setState(() => selectedRadius = newRadius);
                    }
                  },
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Auto Moderation'),
                subtitle: const Text('AI-powered content moderation'),
                trailing: Switch(
                  value: enableAutoModeration,
                  onChanged: (value) => setState(() => enableAutoModeration = value),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'User Management',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Default User Role'),
                subtitle: const Text('Set role for new registrations'),
                trailing: DropdownButton<String>(
                  value: defaultUserRole,
                  items: ['Student', 'Mentor'].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newRole) {
                    if (newRole != null) {
                      setState(() => defaultUserRole = newRole);
                    }
                  },
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Push Notifications'),
                subtitle: const Text('Enable system notifications'),
                trailing: Switch(
                  value: enableNotifications,
                  onChanged: (value) => setState(() => enableNotifications = value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}