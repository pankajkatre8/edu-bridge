import 'package:flutter/material.dart';
import 'skill_swap_page.dart';

class PersonalizedLearningPage extends StatefulWidget {
  const PersonalizedLearningPage({super.key});

  @override
  _PersonalizedLearningPageState createState() => _PersonalizedLearningPageState();
}

class _PersonalizedLearningPageState extends State<PersonalizedLearningPage> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedGoal;
  final List<String> _selectedInterests = [];
  String? _selectedEducationLevel;

  final List<Map<String, dynamic>> interests = [
    {
      'title': 'Coding & Tech',
      'icon': Icons.computer,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Business & Finance',
      'icon': Icons.business,
      'color': Color(0xFF2196F3),
    },
    {
      'title': 'Arts & Design',
      'icon': Icons.palette,
      'color': Color(0xFFE91E63),
    },
    {
      'title': 'Science & Engineering',
      'icon': Icons.science,
      'color': Color(0xFF9C27B0),
    },
    {
      'title': 'Language & Communication',
      'icon': Icons.translate,
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'Vocational Skills',
      'icon': Icons.build,
      'color': Color(0xFF795548),
    },
  ];

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
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Step 2 of 6',
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
            value: 2 / 6,
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
                _buildLearningGoalSection(),
                const SizedBox(height: 32),
                _buildInterestsSection(),
                const SizedBox(height: 32),
                _buildEducationSection(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildNavigationButtons(),
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select up to 3 areas of interest',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: interests.length,
          itemBuilder: (context, index) {
            return _buildInterestCard(
              interests[index]['title'],
              interests[index]['icon'],
              interests[index]['color'],
              index,
            );
          },
        ),
        if (_selectedInterests.length >= 3)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Maximum 3 interests selected',
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInterestCard(String title, IconData icon, Color color, int index) {
    bool isSelected = _selectedInterests.contains(title);
    
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 200 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedInterests.remove(title);
                    } else if (_selectedInterests.length < 3) {
                      _selectedInterests.add(title);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isSelected 
                          ? [color, color.withOpacity(0.8)]
                          : [Colors.white, Colors.white],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(isSelected ? 0.3 : 0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected ? color : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 32,
                        color: isSelected ? Colors.white : color,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
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
  }

  // ... rest of the code remains the same (learning goal, education section, etc.)
  
  Widget _buildLearningGoalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is your primary learning goal?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildRadioCard('Learn new skills'),
        _buildRadioCard('Teach others'),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is your education level?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            value: _selectedEducationLevel,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            items: [
              'School Student',
              'College Student',
              'Graduate',
              'Working Professional',
              'Other',
            ].map((level) => DropdownMenuItem(
              value: level,
              child: Text(level),
            )).toList(),
            onChanged: (value) {
              setState(() {
                _selectedEducationLevel = value;
              });
            },
            hint: const Text('Select your education level'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildRadioCard(String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title),
        value: title,
        groupValue: _selectedGoal,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (value) {
          setState(() {
            _selectedGoal = value;
          });
        },
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
                  MaterialPageRoute(builder: (context) => SkillSwapPage()),
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