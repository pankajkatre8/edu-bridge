import 'package:flutter/material.dart';
import 'community_impact_page.dart'; // Ensure this import is correct

class SkillSwapPage extends StatefulWidget {
  const SkillSwapPage({super.key});

  @override
  State<SkillSwapPage> createState() => _SkillSwapPageState();
}

class _SkillSwapPageState extends State<SkillSwapPage> {
  final TextEditingController _teachController = TextEditingController();
  final TextEditingController _learnController = TextEditingController();
  String? _selectedExchangePreference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Step 3 of 6',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 2,
            child: LinearProgressIndicator(
              value: 3 / 6,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What would you like to\nexchange?',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Share your skills and learn from others',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _teachController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Skills you can teach',
                    hintText: 'Enter the skills you\'re proficient in',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _learnController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Skills you want to learn',
                    hintText: 'Enter the skills you\'re interested in learning',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Preferred exchange method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: const Text('In-person (local meetups)'),
                        value: 'In-person',
                        groupValue: _selectedExchangePreference,
                        onChanged: (value) {
                          setState(() {
                            _selectedExchangePreference = value as String;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[300]),
                      RadioListTile(
                        title: const Text('Online (video calls)'),
                        value: 'Online',
                        groupValue: _selectedExchangePreference,
                        onChanged: (value) {
                          setState(() {
                            _selectedExchangePreference = value as String;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[300]),
                      RadioListTile(
                        title: const Text('Hybrid (both)'),
                        value: 'Hybrid',
                        groupValue: _selectedExchangePreference,
                        onChanged: (value) {
                          setState(() {
                            _selectedExchangePreference = value as String;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.grey[400]!),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommunityImpactPage(), // Use const if constructor is const
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}