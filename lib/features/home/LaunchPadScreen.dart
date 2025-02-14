import 'package:flutter/material.dart';

class LaunchPadScreen extends StatelessWidget {
  const LaunchPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch Pad'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Build your Future',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Find opportunities that match your skills and interests',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),

              // Main Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildCard(
                      icon: Icons.rocket_launch,
                      title: 'Hackathons',
                      description: 'Global competitions with prizes',
                      color: Colors.blue,
                      onTap: () {
                        _navigateToSection(context, 'hackathons');
                      },
                    ),
                    _buildCard(
                      icon: Icons.code,
                      title: 'Projects',
                      description: 'Collaborate and earn',
                      color: Colors.purple,
                      onTap: () {
                        _navigateToSection(context, 'projects');
                      },
                    ),
                    _buildCard(
                      icon: Icons.book,
                      title: 'Internships',
                      description: 'Learn from experts',
                      color: Colors.green,
                      onTap: () {
                        _navigateToSection(context, 'internships');
                      },
                    ),
                    _buildCard(
                      icon: Icons.star,
                      title: 'Challenges',
                      description: 'Quick coding tasks',
                      color: Colors.orange,
                      onTap: () {
                        _navigateToSection(context, 'challenges');
                      },
                    ),
                  ],
                ),
              ),

              // My Collaborations Section
              Card(
                margin: EdgeInsets.only(top: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'My Collaborations',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Track your ongoing projects',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 12),
                      // Added: Sample collaborations list
                      _buildCollaborationItem(
                        'Flutter UI Challenge',
                        'In progress - 3 days left',
                        0.7,
                      ),
                      SizedBox(height: 8),
                      _buildCollaborationItem(
                        'Data Visualization Hackathon',
                        'Completed',
                        1.0,
                      ),
                    ],
                  ),
                ),
              ),

              // Continue Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToSection(context, 'next-page');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Explore More Opportunities',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New method to handle navigation
  void _navigateToSection(BuildContext context, String section) {
    // Using a placeholder screen to avoid navigation to splash screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceholderScreen(title: section),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New widget for collaboration items
  Widget _buildCollaborationItem(String title, String status, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress == 1.0 ? Colors.green : Colors.blue,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: progress == 1.0 ? Colors.green : Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Placeholder screen to handle navigation
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Capitalize the first letter of the title
    String displayTitle = title.substring(0, 1).toUpperCase() + title.substring(1);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(displayTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForSection(title),
              size: 72,
              color: _getColorForSection(title),
            ),
            SizedBox(height: 24),
            Text(
              'Coming Soon!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'We\'re working on exciting $displayTitle features for you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForSection(String section) {
    switch (section) {
      case 'hackathons':
        return Icons.rocket_launch;
      case 'projects':
        return Icons.code;
      case 'internships':
        return Icons.book;
      case 'challenges':
        return Icons.star;
      case 'next-page':
        return Icons.explore;
      default:
        return Icons.info;
    }
  }

  Color _getColorForSection(String section) {
    switch (section) {
      case 'hackathons':
        return Colors.blue;
      case 'projects':
        return Colors.purple;
      case 'internships':
        return Colors.green;
      case 'challenges':
        return Colors.orange;
      case 'next-page':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}