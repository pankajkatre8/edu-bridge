import 'package:flutter/material.dart';
import 'advanced_questions_page.dart';

class CommunityImpactPage extends StatefulWidget {
  const CommunityImpactPage({Key? key}) : super(key: key);

  @override
  State<CommunityImpactPage> createState() => _CommunityImpactPageState();
}

class _CommunityImpactPageState extends State<CommunityImpactPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedInterest;
  final List<String> _selectedChallenges = [];
  String? _selectedCommunityPreference;

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
      appBar: AppBar( // Replaced the original AppBar with the desired one
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Step 4 of 6',
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
              value: 4 / 6,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
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
                _buildSectionHeader('Join the Community'),
                const SizedBox(height: 16),
                _buildInterestSection(),
                const SizedBox(height: 32),
                _buildChallengesSection(),
                const SizedBox(height: 32),
                _buildCommunityPreferenceSection(),
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

  Widget _buildInterestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Are you interested in solving real-world problems?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildRadioCard(
          'Yes, I want to contribute to social causes.',
          'Yes',
          _selectedInterest,
          (value) => setState(() => _selectedInterest = value),
        ),
        _buildRadioCard(
          'Maybe, I’d like to learn more.',
          'Maybe',
          _selectedInterest,
          (value) => setState(() => _selectedInterest = value),
        ),
        _buildRadioCard(
          'Not right now.',
          'No',
          _selectedInterest,
          (value) => setState(() => _selectedInterest = value),
        ),
      ],
    );
  }

  Widget _buildChallengesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What global challenges are you passionate about?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            'Climate Change',
            'Education for All',
            'Clean Water & Sanitation',
            'Gender Equality',
            'Renewable Energy',
          ].map((challenge) => _buildChallengeChip(challenge)).toList(),
        ),
      ],
    );
  }

  Widget _buildChallengeChip(String challenge) {
    return FilterChip(
      label: Text(challenge),
      selected: _selectedChallenges.contains(challenge),
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedChallenges.add(challenge);
          } else {
            _selectedChallenges.remove(challenge);
          }
        });
      },
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      backgroundColor: Colors.grey[200],
      checkmarkColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: _selectedChallenges.contains(challenge)
            ? Theme.of(context).primaryColor
            : Colors.black87,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildCommunityPreferenceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Would you like to join community learning hubs?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildRadioCard(
          'Yes, I’d love to!',
          'Yes',
          _selectedCommunityPreference,
          (value) => setState(() => _selectedCommunityPreference = value),
        ),
        _buildRadioCard(
          'Maybe later.',
          'Maybe',
          _selectedCommunityPreference,
          (value) => setState(() => _selectedCommunityPreference = value),
        ),
        _buildRadioCard(
          'No, I prefer online learning.',
          'No',
          _selectedCommunityPreference,
          (value) => setState(() => _selectedCommunityPreference = value),
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
                    builder: (context) => const AdvancedQuestionsPage(),
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
