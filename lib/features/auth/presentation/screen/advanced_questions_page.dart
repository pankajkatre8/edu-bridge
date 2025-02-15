import 'package:flutter/material.dart';
import 'fun_questions_page.dart';

class AdvancedQuestionsPage extends StatefulWidget {
  const AdvancedQuestionsPage({super.key});

  @override
  State<AdvancedQuestionsPage> createState() => _AdvancedQuestionsPageState();
}

class _AdvancedQuestionsPageState extends State<AdvancedQuestionsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedTimeDedication;
  String? _selectedExperienceLevel;
  String? _selectedCareerGuidance;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Updated AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Step 5 of 6',
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
              value: 5 / 6,
              backgroundColor: Colors.grey[300],
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Optional Questions'),
                const SizedBox(height: 24),
                _buildTimeDedicationSection(),
                const SizedBox(height: 32),
                _buildExperienceLevelSection(),
                const SizedBox(height: 32),
                _buildCareerGuidanceSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildNavigationButtons(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildTimeDedicationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How much time can you dedicate to learning each week?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildRadioCard(
          'Less than 1 hour',
          'Less than 1 hour',
          _selectedTimeDedication,
          (value) => setState(() => _selectedTimeDedication = value),
        ),
        _buildRadioCard(
          '1-3 hours',
          '1-3 hours',
          _selectedTimeDedication,
          (value) => setState(() => _selectedTimeDedication = value),
        ),
        _buildRadioCard(
          '3-5 hours',
          '3-5 hours',
          _selectedTimeDedication,
          (value) => setState(() => _selectedTimeDedication = value),
        ),
        _buildRadioCard(
          'More than 5 hours',
          'More than 5 hours',
          _selectedTimeDedication,
          (value) => setState(() => _selectedTimeDedication = value),
        ),
      ],
    );
  }

  Widget _buildExperienceLevelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you have any prior experience in your areas of interest?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            value: _selectedExperienceLevel,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            items: [
              'Beginner',
              'Intermediate',
              'Advanced',
            ]
                .map((level) => DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedExperienceLevel = value;
              });
            },
            hint: const Text('Select your experience level'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildCareerGuidanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Would you like to receive personalized career guidance?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildRadioCard(
          'Yes, please!',
          'Yes',
          _selectedCareerGuidance,
          (value) => setState(() => _selectedCareerGuidance = value),
        ),
        _buildRadioCard(
          'Not right now.',
          'No',
          _selectedCareerGuidance,
          (value) => setState(() => _selectedCareerGuidance = value),
        ),
      ],
    );
  }

  Widget _buildRadioCard(
    String title,
    String value,
    String? groupValue,
    ValueChanged<String?> onChanged,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title),
        value: value,
        groupValue: groupValue,
        activeColor: Theme.of(context).primaryColor,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
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
                    builder: (context) => FunQuestionsPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
